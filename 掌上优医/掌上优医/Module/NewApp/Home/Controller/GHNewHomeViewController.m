//
//  GHNewHomeViewController.m
//  掌上优医
//
//  Created by apple on 2019/7/31.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewHomeViewController.h"

//#import "GHHomeTopCollectionReusableView.h"

#import "GHSearchViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "GHHomeLocationViewController.h"
#import "GHNewNInformationViewController.h"//推荐咨询

#import "GHHomeBannerModel.h"

#import <MapKit/MapKit.h>

#import "GHChoiceModel.h"
#import "GHMyCommentsDetailViewController.h"
#import "GHNoticeMessageSystemViewController.h"

#import "GHSegmentTitleView.h"

#import "GHNewHomeHeaderView.h"
#import "GHBottomTableViewCell.h"
#import "GHNewReviewController.h"
#import "GHPageContentView.h"

#import "GHNweMainTableView.h"
#import "GHMustUpdate.h"
#import "GHHomeCasesView.h"

@interface GHNewHomeViewController ()<AMapLocationManagerDelegate, GHHomeLocationViewControllerDelegate, UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,GHSegmentTitleViewDelegate,GHPageContentViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) GHBottomTableViewCell *contentCell;

/**
 tableview的headerview
 */
@property (nonatomic , strong)GHNewHomeHeaderView *headerView;

/**
 高德定位Manager 如果不引用,则会出现请求权限框闪现或每次打开APP都会出现
 */
@property (nonatomic, strong) AMapLocationManager *locationManager;

/**
 定位按钮
 */
@property (nonatomic, strong) UIButton *locationButton;

@property (nonatomic, strong) UIView *navigationView;

@property (nonatomic, strong) CLGeocoder *geoCoder;

@property (nonatomic, assign) BOOL isCanUseSideBack;  // 手势是否启动

@property (nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic, strong) GHNweMainTableView *homeTableview;

@property (nonatomic, strong) GHSegmentTitleView *titleView;

@property (nonatomic, strong) GHHomeCasesView *secondview;

@property (nonatomic, strong)GHNewReviewController *jingxuan;



@property (nonatomic, strong)GHNewNInformationViewController *jingxuanzixun;

///**
// <#Description#>
// */
//@property (nonatomic, strong) GHHomeTopCollectionReusableView *headerView;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *badgeLabel;

@property (nonatomic, assign) NSUInteger likeTotalPage;

@property (nonatomic, assign) NSUInteger likeCurrentPage;

@property (nonatomic, assign) NSUInteger likePageSize;

@property (nonatomic, assign) BOOL canScroll;
@end

@implementation GHNewHomeViewController


- (CLGeocoder *)geoCoder{
    if (!_geoCoder) {
        _geoCoder = [[CLGeocoder alloc] init];
    }
    return _geoCoder;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationView.hidden = false;
    self.navigationController.navigationBar.hidden = YES;
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self setupNavigationStyle:GHNavigationBarStyleWhite];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    //
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.navigationView.hidden = true;

    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;

    
    //    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setShadowImage:nil];
    
    //    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
    //    [self hideLeftButton];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[GHUserModelTool shareInstance] loadUserDefaultToSandBox];
    
    [[GHUserModelTool shareInstance] kApiAddEquipmentCode];
    
    self.canScroll = YES;
    [self setupNavigationBar];
    [self setupUI];
    [self getHomeDataAction];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAMapAction) name:kNotificationWillEnterForeground object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];
    [self setupAmapSDK];
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)) {
        
        //定位功能可用
        [GHUserModelTool shareInstance].isHaveLocation = true;
        
    } else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        
        //定位不能用
        [GHUserModelTool shareInstance].isHaveLocation = false;
        
    }
    
    [self checkUpdate];//[JFTools shortVersion]
}
- (void)checkUpdate
{
    NSMutableDictionary *parmas = [@{
                                     @"verCode":[JFTools shortVersion],
                                     @"verType":@(1)
                                     }copy];
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiCompareVerstatus withParameter:parmas withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            if ([response[@"data"][@"isUpgrade"] boolValue]) {

                GHMustUpdate *updata = [[GHMustUpdate alloc]init];
                
                [updata show];
            
            }
         
        }
    }];
    
    
}
/**
 首次获取首页数据
 先从缓存中加载, 然后再从网络上加载并刷新页面, 保存到缓存中
 */
- (void)getHomeDataAction {
    
    
    if (self.contentCell.pageContentView.contentViewCurrentIndex ==0) {
        [self.jingxuanzixun  requsetData];


    }
    else
    {
        [self.jingxuan reloadRequest];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        YYCache *cache = [YYCache cacheWithName:kCacheName];
        [cache removeObjectForKey:kApiInfoSlideshows];
        NSArray *cacheBannerArray = (NSArray *)[cache objectForKey:kApiInfoSlideshows];
        
        if (cacheBannerArray.count) {
            [self.headerView setupScrollViewWithModelArray:cacheBannerArray];
        }
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"displayPosition"] = @(1);
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiInfoSlideshows withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            [self.homeTableview.mj_header endRefreshing];
            [SVProgressHUD dismiss];
            if (isSuccess) {
                
                NSMutableArray *dataArray = [[NSMutableArray alloc] init];
                
                for (NSDictionary *dic in response[@"data"][@"postList"]) {
                    
                    GHHomeBannerModel *model = [[GHHomeBannerModel alloc] initWithDictionary:dic error:nil];
                    
                    if (model == nil) {
                        continue;
                    }
                    
                    [dataArray addObject:model];
                    
                }
                
//                [cache setObject:[dataArray copy] forKey:kApiInfoSlideshows];
                
                [self.headerView setupScrollViewWithModelArray:dataArray];
                
            }
            
        }];
        
    });
    
    return;
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self requsetData];
//    });
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"verSeq"] = [JFTools shortVersion];
        
        params[@"termType"] = @(1);
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSystemparamVerStatus withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            if (isSuccess) {
                
                if ([response[@"currentVer"][@"status"] intValue] == 1) {
                    [GHUserModelTool shareInstance].isZheng = false;
                } else if ([response[@"currentVer"][@"status"] intValue] == 2) {
                    [GHUserModelTool shareInstance].isZheng = true;
                } else if ([response[@"currentVer"][@"status"] intValue] == 3) {
                    [GHUserModelTool shareInstance].isZheng = false;
                }
                
                NSString *currentVer = response[@"currentVer"][@"verSeq"];
                NSString *lastVer = response[@"lastVer"][@"verSeq"];
                
                if ([currentVer compare:lastVer options:NSNumericSearch] == NSOrderedAscending) {
                    
                    if ([response[@"lastVer"][@"updateFlag"] integerValue] == 1) {
                        
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的APP版本过低,请您将APP升级至最新版本" preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            
                            NSString *itunesurl = kAppStoreItunesurl;
                            
                            if (@available(iOS 10.0, *)) {
                                /// 10及其以上系统
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunesurl] options:@{} completionHandler:nil];
                            } else {
                                /// 10以下系统
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunesurl]];
                            }
                            
                            [self presentViewController:alertController animated:true completion:nil];
                            
                        }];
                        
                        [alertController addAction:confirmAction];
                        
                        [self presentViewController:alertController animated:true completion:nil];
                        
                    }
                    
                }
                
            }
            
        }];
        
    });
    
    
    
}


#pragma mark notify
- (void)changeScrollStatus//改变主视图的状态
{
    self.canScroll = YES;
    self.contentCell.cellCanScroll = NO;
}

- (void)setupSubViews
{
    self.canScroll = YES;
//    self.homeTableview.backgroundColor = [UIColor whiteColor];
//    __weak typeof(self) weakSelf = self;
//    [self.homeTableview addPullToRefreshWithActionHandler:^{
        [self insertRowAtTop];
//    }];
}

- (void)insertRowAtTop
{
    NSArray *sortTitles = @[@"精选点评",@"推荐咨询"];
    self.contentCell.currentTagStr = sortTitles[self.titleView.selectIndex];
    self.contentCell.isRefresh = YES;
}

- (void)setupUI {
    
    [self.view addSubview:self.homeTableview];
    self.homeTableview.tableHeaderView = self.headerView;
    
}

- (void)setupAmapSDK{
    
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    [AMapServices sharedServices].apiKey = kAMapAppKey;
    AMapLocationManager *mangaer = [[AMapLocationManager alloc] init];
    self.locationManager = mangaer;
    [mangaer setDelegate:self];
    
    //设置期望定位精度
    [mangaer setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //设置不允许系统暂停定位
    [mangaer setPausesLocationUpdatesAutomatically:NO];
    //设置允许在后台定位
    [mangaer setAllowsBackgroundLocationUpdates:NO];
    //设置定位超时时间
    [mangaer setLocationTimeout:10];
    //设置逆地理超时时间
    [mangaer setReGeocodeTimeout:5];
    
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [mangaer requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            [self.locationButton setTitle:@"全国" forState:UIControlStateNormal];
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
            
        }
        
        NSLog(@"location:%@", location);
        
        if (regeocode)
        {
            [GHUserModelTool shareInstance].locationprovince = regeocode.province;
            //设置默认地区
            if (regeocode.city.length > 0) {
                
                NSString *city;
                
                city = regeocode.city;
                
                [self.locationButton setTitle:[NSString stringWithFormat:@"%@", ISNIL(city)] forState:UIControlStateNormal];
                
                [GHUserModelTool shareInstance].locationCity = ISNIL(city);
                [GHUserModelTool shareInstance].locationCityCode = regeocode.adcode.length > 4 ? [regeocode.adcode substringToIndex:4] : @"";
//                [GHUserModelTool shareInstance].locationCityArea = regeocode.district;
                
                [GHUserModelTool shareInstance].locationLongitude = location.coordinate.longitude;
                [GHUserModelTool shareInstance].locationLatitude = location.coordinate.latitude;
                
            }
            
            NSLog(@"reGeocode:%@", regeocode);
            
        }
    }];
    
}

- (void)updateAMapAction {
    
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            [self.locationButton setTitle:@"全国" forState:UIControlStateNormal];
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
            
        }
        
        NSLog(@"location:%@", location);
        
        if (regeocode)
        {
            //设置默认地区
            if (regeocode.city.length > 0) {
                
                NSString *city;
                
                city = regeocode.city;
                
                [self.locationButton setTitle:[NSString stringWithFormat:@"%@", ISNIL(city)] forState:UIControlStateNormal];
                
                [GHUserModelTool shareInstance].locationCity = ISNIL(city);
                [GHUserModelTool shareInstance].locationCityCode = regeocode.adcode.length > 4 ? [regeocode.adcode substringToIndex:4] : @"";
                
                [GHUserModelTool shareInstance].locationLongitude = location.coordinate.longitude;
                [GHUserModelTool shareInstance].locationLatitude = location.coordinate.latitude;
                
            }
            
            NSLog(@"reGeocode:%@", regeocode);
            
        }
    }];
    
    [self setupBadgeStatus];
    
}

- (void)setupNavigationBar {
    
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREENWIDTH, Height_NavBar )];
    navigationView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0];
    [self.view addSubview:navigationView];
    
    
    
    UIImageView *backimage = [[UIImageView alloc]init];
    backimage.image = [UIImage imageNamed:@"矩形 13"];
    [navigationView addSubview:backimage];
    [backimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(navigationView);
    }];
    
    self.navigationView = navigationView;
    
    UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    locationButton.titleLabel.font = H15;
    locationButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [locationButton setTitle:@"正在定位" forState:UIControlStateNormal];
    [locationButton setImage:[UIImage imageNamed:@"new_home_arrow_down"] forState:UIControlStateNormal];
    [locationButton setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    [locationButton addTarget:self action:@selector(clickLocationAction) forControlEvents:UIControlEventTouchUpInside];
    locationButton.transform = CGAffineTransformMakeScale(-1, 1);
    locationButton.titleLabel.transform = CGAffineTransformMakeScale(-1, 1);
    locationButton.imageView.transform = CGAffineTransformMakeScale(-1, 1);
    [locationButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
    [navigationView addSubview:locationButton];
    
    [locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Height_StatusBar);
        make.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(80);
    }];
    
    
    
    self.locationButton = locationButton;
    
    UITextField *searchTextField = [[UITextField alloc] init];
    searchTextField.backgroundColor = [UIColor whiteColor];
    searchTextField.layer.cornerRadius = 17.5;
    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchTextField.font = H14;
    searchTextField.textColor = kDefaultBlackTextColor;
//    searchTextField.placeholder = @"搜索疾病、医生、医院、资讯";
    searchTextField.userInteractionEnabled = false;
    searchTextField.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    searchTextField.layer.shadowOffset = CGSizeMake(0,2);
    searchTextField.layer.shadowOpacity = 1;
    searchTextField.layer.shadowRadius = 4;
//    [searchTextField setValue:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.7] forKeyPath:@"_placeholderLabel.textColor"];
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"搜索疾病、医生、医院、资讯"];
    [placeholder addAttribute:NSForegroundColorAttributeName
                            value:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.7]
                            range:NSMakeRange(0, 13)];
    
    searchTextField.attributedPlaceholder = placeholder;
    searchTextField.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.2];

    [navigationView addSubview:searchTextField];
    
    UIView *leftview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 36, 35)];
    
    UIImageView *searchIconImageView = [[UIImageView alloc] init];
    searchIconImageView.contentMode = UIViewContentModeCenter;
    searchIconImageView.image = [UIImage imageNamed:@"new_home_search"];
    searchIconImageView.size = CGSizeMake(35, 35);
    //    searchIconImageView.size = CGSizeMake(Height_NavBar - Height_StatusBar - 10, Height_NavBar - Height_StatusBar - 10);
    [leftview addSubview:searchIconImageView];

    searchTextField.leftView = leftview;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(locationButton.mas_right).offset(6);
        make.top.mas_equalTo(4.5 + Height_StatusBar);
        make.height.mas_equalTo(35);
//        make.centerY.mas_equalTo(navigationView);
        make.right.mas_equalTo(-54);
    }];
    
    UIView *tapView = [[UIView alloc] init];
    [navigationView addSubview:tapView];
    
    [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(searchTextField);
    }];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSearchAction)];
    [tapView addGestureRecognizer:tapGR];
    
    
    UIButton *noticeMessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [noticeMessageButton setImage:[UIImage imageNamed:@"ic_shouye_xiaoxi"] forState:UIControlStateNormal];
    [navigationView addSubview:noticeMessageButton];
    
    [noticeMessageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Height_StatusBar);
        make.bottom.right.mas_equalTo(0);
        make.left.mas_equalTo(searchTextField.mas_right);
    }];
    
    [noticeMessageButton addTarget:self action:@selector(clickNoticeAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *badgeLabel = [[UILabel alloc] init];
    badgeLabel.font = H12;
    badgeLabel.textAlignment = NSTextAlignmentCenter;
    badgeLabel.textColor = [UIColor whiteColor];
    badgeLabel.layer.cornerRadius = 8;
    badgeLabel.layer.masksToBounds = true;
    badgeLabel.backgroundColor = [UIColor redColor];
    [navigationView addSubview:badgeLabel];
    
    [badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16);
        make.right.mas_equalTo(-9);
        make.top.mas_equalTo(5+Height_StatusBar);
        make.width.mas_equalTo(16);
    }];
    self.badgeLabel = badgeLabel;
    
    //    [self hideLeftButton];
    
    //    UIView *tapLocationView = [[UIView alloc] init];
    //    [navigationView addSubview:tapLocationView];
    //
    //    [tapLocationView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.bottom.top.mas_equalTo(locationButton);
    //    }];
    //
    //    UITapGestureRecognizer *tapLocationGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLocationAction)];
    //    [tapLocationView addGestureRecognizer:tapLocationGR];
    
}

- (void)clickNoticeAction {
    
    [self setupBadgeStatus];
    
    GHNoticeMessageSystemViewController *vc = [[GHNoticeMessageSystemViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
    
}
- (void)setupBadgeStatus {
    
    NSInteger badge = [[UIApplication sharedApplication] applicationIconBadgeNumber];
    if (badge == 0) {
        self.badgeLabel.hidden = true;
    } else {
        self.badgeLabel.hidden = false;
        self.badgeLabel.text = [NSString stringWithFormat:@"%ld", badge];
        
        if (badge > 99) {
            self.badgeLabel.text = @"...";
            [self.badgeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-4);
                make.width.mas_equalTo(24);
            }];
        } else if (badge > 9) {
            [self.badgeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-4);
                make.width.mas_equalTo(24);
            }];
        } else {
            [self.badgeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-9);
                make.width.mas_equalTo(16);
            }];
        }
    }
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self cancelSideBack];
    [self setupBadgeStatus];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self startSideBack];
}


/**
 * 关闭ios右滑返回
 */
-(void)cancelSideBack{
    self.isCanUseSideBack = NO;
    
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}
/*
 开启ios右滑返回
 */
- (void)startSideBack {
    self.isCanUseSideBack=YES;
    
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

/**
 在根控制器禁止右滑返回手势,否则可能造成程序假死
 
 @param gestureRecognizer gestureRecognizer description
 @return return value description
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    return self.isCanUseSideBack;
}


- (void)clickSearchAction {
    
    [MobClick event:@"Home_Search"];
    
    GHSearchViewController *vc = [[GHSearchViewController alloc] init];
    [self.navigationController pushViewController:vc animated:false];
    
}

/**
 点击定位
 */
- (void)clickLocationAction {
    
    GHHomeLocationViewController *vc = [[GHHomeLocationViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:false];
    
}
#pragma mark -  GHHomeLocationViewControllerDelegate
// 城市定位以及编码
- (void)chooseFinishWithCity:(NSString *)city withCode:(NSString *)code{
    
    if (city.length > 0) {
        
        [self.locationButton setTitle:[NSString stringWithFormat:@"%@", ISNIL(city)] forState:UIControlStateNormal];
        
        [GHUserModelTool shareInstance].locationCity = ISNIL(city);
        [GHUserModelTool shareInstance].locationCityCode = ISNIL(code);
        
        [GHUserModelTool shareInstance].locationCityArea = @"";
        [GHUserModelTool shareInstance].locationCityAreaCode = @"";
        
    }
    
}
#pragma  mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _contentCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!_contentCell) {
        _contentCell = [[GHBottomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        NSArray *titles = @[@"医疗头条",@"医院评价",@"医生评价"];
        NSMutableArray *contentVCs = [NSMutableArray array];
        for (NSString *title in titles) {
            
            if ([title isEqualToString:@"医院评价"]) {
                self.jingxuan = [[GHNewReviewController alloc]init];
                self.jingxuan.title = title;
                self.jingxuan.str = title;
                [contentVCs addObject:self.jingxuan];
            }
            else if ([title isEqualToString:@"医生评价"])
            {
                self.jingxuan = [[GHNewReviewController alloc]init];
                self.jingxuan.title = title;
                self.jingxuan.str = title;
                [contentVCs addObject:self.jingxuan];
            }
            else
            {
                self.jingxuanzixun = [[GHNewNInformationViewController alloc]init];
                self.jingxuanzixun.title = title;
                self.jingxuanzixun.str = title;
                [contentVCs addObject:self.jingxuanzixun];
            }
            
        }
        _contentCell.viewControllers = contentVCs;
        _contentCell.pageContentView = [[GHPageContentView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - Height_TabBar - Height_NavBar) childVCs:contentVCs parentVC:self delegate:self];
        _contentCell.pageContentView.contentViewCanScroll = NO;
        [_contentCell.contentView addSubview:_contentCell.pageContentView];
    }
    return _contentCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREENHEIGHT - Height_TabBar - Height_NavBar;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    return 50;
    return 44;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.secondview;
//    self.titleView = [[GHSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 50) titles:@[@"精选点评"/*,@"推荐咨询"*/] delegate:self indicatorType:FSIndicatorTypeEqualTitle];
//    self.titleView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
//    self.titleView.titleNormalColor = [UIColor colorWithHexString:@"333333"];
//    self.titleView.titleSelectColor = [UIColor colorWithHexString:@"6A70FD"];
//    self.titleView.indicatorColor = [UIColor colorWithHexString:@"6A70FD"];
//    self.titleView.titleSelectFont = [UIFont boldSystemFontOfSize:17];
//    self.titleView.titleFont = [UIFont systemFontOfSize:17];
//    return self.titleView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - GHSegmentTitleViewDelegate

- (void)FSSegmentTitleView:(GHSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
   self.contentCell.pageContentView.contentViewCurrentIndex = endIndex;
    NSLog(@"点击了%ld",endIndex);
}
#pragma  mark - GHPageContentViewDelegate
- (void)FSContenViewDidEndDecelerating:(GHPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.titleView.selectIndex = endIndex;
    self.secondview.selectBtnTag = endIndex;
    self.homeTableview.scrollEnabled =YES;//此处其实是监测scrollview滚动，pageView滚动结束主tableview可以滑动，或者通过手势监听或者kvo，这里只是提供一种实现方式
}

- (void)FSContentViewDidScroll:(GHPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress
{
    self.homeTableview.scrollEnabled = NO;//pageView开始滚动主tableview禁止滑动
}

#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (scrollView.contentOffset.y < 0) {
        self.homeTableview.contentOffset = CGPointMake(0, 0);
    }
    
    
    CGFloat bottomCellOffset = [self.homeTableview rectForSection:0].origin.y;

    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            self.contentCell.cellCanScroll = YES;
        }
    }
    else{
        if (!self.canScroll) {//子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
    self.homeTableview.showsVerticalScrollIndicator = _canScroll?YES:NO;
}



- (GHNewHomeHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[GHNewHomeHeaderView alloc]initWithFrame:CGRectMake(0, Height_NavBar - Height_StatusBar, SCREENWIDTH, HScaleHeight(552))];
    }
    return _headerView;
}


- (GHHomeCasesView *)secondview
{
    if (!_secondview) {
        _secondview = [[GHHomeCasesView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
        _secondview.backgroundColor = [UIColor whiteColor];
        _secondview.titleArry = [NSMutableArray arrayWithArray:@[@"医疗头条",@"医院评价",@"医生评价"]];
        __weak typeof(self) weakself = self;
        _secondview.clickTypeBlock = ^(NSString * _Nonnull clickTitle) {
            if ([clickTitle isEqualToString:@"医疗头条"]) {
                weakself.contentCell.pageContentView.contentViewCurrentIndex = 0;
            }
            else if ([clickTitle isEqualToString:@"医院评价"])
            {
                weakself.contentCell.pageContentView.contentViewCurrentIndex = 1;
            }
            else
            {
                weakself.contentCell.pageContentView.contentViewCurrentIndex = 2;
            }
        };
    }
    return _secondview;
}

- (GHNweMainTableView *)homeTableview
{
    if (!_homeTableview) {
        _homeTableview = [[GHNweMainTableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, SCREENWIDTH, SCREENHEIGHT - Height_TabBar - Height_NavBar) style:UITableViewStylePlain];
        _homeTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getHomeDataAction)];
        _homeTableview.delegate = self;
        _homeTableview.dataSource = self;
        _homeTableview.showsVerticalScrollIndicator = NO;
        _homeTableview.showsHorizontalScrollIndicator = NO;
        _homeTableview.backgroundColor = [UIColor whiteColor];
    }
    return _homeTableview;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

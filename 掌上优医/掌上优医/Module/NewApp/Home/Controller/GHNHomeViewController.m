//
//  GHNHomeViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/18.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNHomeViewController.h"

#import "GHHomeTopCollectionReusableView.h"

#import "GHSearchViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "GHHomeLocationViewController.h"

#import "GHHomeBannerModel.h"

#import <MapKit/MapKit.h>

#import "LMHWaterFallLayout.h"
#import "GHHomeCommentsCollectionViewCell.h"

#import "GHChoiceModel.h"
#import "GHMyCommentsDetailViewController.h"
#import "GHNoticeMessageSystemViewController.h"

#import "GHHospitalCommentDetailViewController.h"


@interface GHNHomeViewController ()<AMapLocationManagerDelegate, GHHomeLocationViewControllerDelegate, UIGestureRecognizerDelegate, LMHWaterFallLayoutDeleaget, UICollectionViewDelegate, UICollectionViewDataSource>

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

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSUInteger totalPage;

@property (nonatomic, assign) NSUInteger currentPage;

@property (nonatomic, assign) NSUInteger pageSize;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHHomeTopCollectionReusableView *headerView;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *badgeLabel;

@property (nonatomic, assign) NSUInteger likeTotalPage;

@property (nonatomic, assign) NSUInteger likeCurrentPage;

@property (nonatomic, assign) NSUInteger likePageSize;


@end

@implementation GHNHomeViewController

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
    
}

- (CLGeocoder *)geoCoder{
    if (!_geoCoder) {
        _geoCoder = [[CLGeocoder alloc] init];
    }
    return _geoCoder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessGetUserInfoAction) name:kNotificationLoginSuccess object:nil];
 
    [self setupNavigationBar];
    [self setupUI];
    [self setupAmapSDK];
    
    [self setupConfig];
    
    [self getHomeDataAction];
    
    [GHNetworkTool detectNetworkAction];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAMapAction) name:kNotificationWillEnterForeground object:nil];
    // Do any additional setup after loading the view.
    
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)) {
        
        //定位功能可用
        [GHUserModelTool shareInstance].isHaveLocation = true;
        
    } else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        
        //定位不能用
        [GHUserModelTool shareInstance].isHaveLocation = false;
        
    }
}

- (void)loginSuccessGetUserInfoAction {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getUserInfoData];
    });
    
}

- (void)setupConfig {
    self.currentPage = 0;
    self.totalPage = 1;
    self.pageSize = 10;
}

- (void)refreshData{
    self.currentPage = 0;
    self.totalPage = 1;
    [self requsetData];
}

- (void)getMoreData{
    self.currentPage += self.pageSize;
    [self requsetData];
}

/**
 设置高德地图SDK
 
 [self.locationButton setTitle:[NSString stringWithFormat:@"广州"] forState:UIControlStateNormal];
 
 [GHUserModelTool shareInstance].locationCity = @"广州";
 [GHUserModelTool shareInstance].locationLongitude = 113.2643600000;
 [GHUserModelTool shareInstance].locationLatitude = 23.1290800000;
 
 return;
 */
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
    
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, Height_NavBar - Height_StatusBar)];
    navigationView.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:navigationView];
    
    self.navigationView = navigationView;
    
    UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    locationButton.titleLabel.font = H15;
    locationButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [locationButton setTitle:@"正在定位" forState:UIControlStateNormal];
    [locationButton setImage:[UIImage imageNamed:@"home_arrow_down"] forState:UIControlStateNormal];
    [locationButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    [locationButton addTarget:self action:@selector(clickLocationAction) forControlEvents:UIControlEventTouchUpInside];
    locationButton.transform = CGAffineTransformMakeScale(-1, 1);
    locationButton.titleLabel.transform = CGAffineTransformMakeScale(-1, 1);
    locationButton.imageView.transform = CGAffineTransformMakeScale(-1, 1);
    [locationButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
    [navigationView addSubview:locationButton];
    
    [locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(80);
    }];
    
 
    
    self.locationButton = locationButton;
    
    UITextField *searchTextField = [[UITextField alloc] init];
    searchTextField.backgroundColor = [UIColor whiteColor];
    searchTextField.layer.cornerRadius = 17.5;
    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchTextField.font = H14;
    searchTextField.textColor = kDefaultBlackTextColor;
    searchTextField.placeholder = @"搜索疾病、医生、医院、资讯";
    searchTextField.userInteractionEnabled = false;
    searchTextField.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    searchTextField.layer.shadowOffset = CGSizeMake(0,2);
    searchTextField.layer.shadowOpacity = 1;
    searchTextField.layer.shadowRadius = 4;
    
    if (!kiOS10Later) {
        searchTextField.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.11];
    }
    
    [navigationView addSubview:searchTextField];
    
    UIImageView *searchIconImageView = [[UIImageView alloc] init];
    searchIconImageView.contentMode = UIViewContentModeCenter;
    searchIconImageView.image = [UIImage imageNamed:@"home_search"];
    searchIconImageView.size = CGSizeMake(35, 35);
//    searchIconImageView.size = CGSizeMake(Height_NavBar - Height_StatusBar - 10, Height_NavBar - Height_StatusBar - 10);
    
    searchTextField.leftView = searchIconImageView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(locationButton.mas_right).offset(6);
        make.height.mas_equalTo(35);
        make.centerY.mas_equalTo(navigationView);
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
    [noticeMessageButton setImage:[UIImage imageNamed:@"home_notice"] forState:UIControlStateNormal];
    [navigationView addSubview:noticeMessageButton];
    
    [noticeMessageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
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
        make.top.mas_equalTo(5);
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

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationView.hidden = false;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self setupNavigationStyle:GHNavigationBarStyleWhite];
    
//
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationView.hidden = true;
    
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
    
//    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
//    [self hideLeftButton];
    
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


- (void)setupUI {
    
    // 创建布局
    LMHWaterFallLayout * waterFallLayout = [[LMHWaterFallLayout alloc]init];
    waterFallLayout.fallDelegate = self;
    waterFallLayout.headerReferenceSize = CGSizeMake(SCREENWIDTH, HScaleHeight(350));
    
//    UICollectionViewFlowLayout *waterFallLayout = [[UICollectionViewFlowLayout alloc] init];
    
//    waterFallLayout.headerReferenceSize = CGSizeMake(SCREENWIDTH, HScaleHeight(350));
    
    // 创建collectionView
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - Height_TabBar - Height_NavBar) collectionViewLayout:waterFallLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    self.collectionView = collectionView;
    
    [self.collectionView registerClass:[GHHomeCommentsCollectionViewCell class] forCellWithReuseIdentifier:@"GHHomeCommentsCollectionViewCell"];
    
    //注册头视图
    [self.collectionView registerClass:[GHHomeTopCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GHHomeTopCollectionReusableView"];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHomeDataAction)];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
}

#pragma mark  - <LMHWaterFallLayoutDeleaget>
- (CGFloat)waterFallLayout:(LMHWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth{
    
    GHChoiceModel *model = [self.dataArray objectOrNilAtIndex:indexPath];
    
    return [model.shouldHeight floatValue] + 4;
}

- (CGFloat)rowMarginInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout {
    
    return 8;
    
}

- (CGFloat)columnMarginInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout {
    
    return 8;
    
}

- (NSUInteger)columnCountInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout{
    
    return 2;
    
}

- (UIEdgeInsets)edgeInsetdInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout {
    
    return UIEdgeInsetsMake(HScaleHeight(350), 16, 16, 16);
    
}


#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GHHomeCommentsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GHHomeCommentsCollectionViewCell" forIndexPath:indexPath];

    cell.backgroundColor = [UIColor whiteColor];
    
    cell.model = [self.dataArray objectOrNilAtIndex:indexPath.row];

    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREENWIDTH, HScaleHeight(350));
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        GHHomeTopCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"GHHomeTopCollectionReusableView" forIndexPath:indexPath];
        self.headerView = header;
        return header;
        
    }
    
    return nil;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.view endEditing:true];
    
    [MobClick event:@"Home_Choice"];

    
    GHChoiceModel *model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    if ([model.commentObjType integerValue] == 1) {
        
        GHMyCommentsDetailViewController *vc = [[GHMyCommentsDetailViewController alloc] init];
        
        vc.model = [[GHMyCommentsModel alloc] initWithDictionary:[model toDictionary] error:nil];
        [self.navigationController pushViewController:vc animated:true];
        
    } else if ([model.commentObjType integerValue] == 2) {
        
        GHHospitalCommentDetailViewController *vc = [[GHHospitalCommentDetailViewController alloc] init];
        
        vc.model = [[GHMyCommentsModel alloc] initWithDictionary:[model toDictionary] error:nil];
        [self.navigationController pushViewController:vc animated:true];
        
    }
    
    if (![[GHSaveDataTool shareInstance].readCommentIdArray containsObject:model.modelId]) {
        [[GHSaveDataTool shareInstance].readCommentIdArray addObject:model.modelId];
    }
    
    model.visitCount = [NSString stringWithFormat:@"%ld", [model.visitCount integerValue] + 1];
    
    [self.collectionView reloadData]; 
//    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
}



- (void)getUserInfoData {
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiUserMe withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
            [GHUserModelTool shareInstance].userInfoModel = [[GHUserInfoModel alloc] initWithDictionary:response error:nil];
            
            // 如果该用户的状态为冻结或用户详情为空, 则 修改用户登录状态为未登录
            if ([GHUserModelTool shareInstance].userInfoModel == nil || [[GHUserModelTool shareInstance].userInfoModel.status intValue] == 2) {
                
                [[GHUserModelTool shareInstance] removeAllProperty];
                
                [GHUserModelTool shareInstance].isLogin = false;
                
                [[GHUserModelTool shareInstance] saveUserDefaultToSandBox];
                
                [[GHSaveDataTool shareInstance] userLogoutRemoveAllNotice];
                
            }
            
            
        } else {
            
            
        }
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.likeCurrentPage = 0;
        self.likeTotalPage = 1;
        self.likePageSize = 1000;

        [self getLikeDataAction];
        
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self bindingPushDevAction];
    });
    
}



/**
 无论设备 ID 上报是否成功, 都去进行绑定操作, 如果绑定失败, 则先进行 设备 ID 与用户的解绑操作, 然后再重新绑定一次, 以保证绑定成功
 */
- (void)bindingPushDevAction {
    
    
    if ([GHUserModelTool shareInstance].registerId.length) {
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"devId"] = [GHUserModelTool shareInstance].registerId;
        
        // 上报设备 ID
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiPushDev withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            //            if (isSuccess) {
            
            
            
            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiPushDevUser withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
                
                if (isSuccess) {
                    
                    NSLog(@"设备 ID 绑定成功");
                    
                } else {
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_DELETE withUrl:kApiPushDevUser withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                            
                            if (isSuccess) {
                                
                                [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiPushDevUser withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                                    
                                    if (isSuccess) {
                                        NSLog(@"设备 ID 绑定成功");
                                    }
                                    
                                }];
                                
                            }
                            
                        }];
                        
                    });
                    
                }
                
            }];
            
            //            }
            
        }];
        
    }
    
}

/**
 刷新首页数据
 */
- (void)refreshHomeDataAction {
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"playPosition"] = @(1);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiInfoSlideshows withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.collectionView.mj_header endRefreshing];
        
        if (isSuccess) {
            
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dic in response) {
                
                GHHomeBannerModel *model = [[GHHomeBannerModel alloc] initWithDictionary:dic error:nil];
                
                if (model == nil) {
                    continue;
                }
                
                [dataArray addObject:model];
                
            }
            
            [self.headerView setupScrollViewWithModelArray:dataArray];
            
        }
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self refreshData];
    });
    
}


/**
 首次获取首页数据
 先从缓存中加载, 然后再从网络上加载并刷新页面, 保存到缓存中
 */
- (void)getHomeDataAction {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        YYCache *cache = [YYCache cacheWithName:kCacheName];
        
        NSArray *cacheBannerArray = (NSArray *)[cache objectForKey:kApiInfoSlideshows];
        
        if (cacheBannerArray.count) {
            [self.headerView setupScrollViewWithModelArray:cacheBannerArray];
        }
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"playPosition"] = @(1);
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiInfoSlideshows withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            [self.collectionView.mj_header endRefreshing];
            
            if (isSuccess) {
                
                NSMutableArray *dataArray = [[NSMutableArray alloc] init];
                
                for (NSDictionary *dic in response) {
                    
                    GHHomeBannerModel *model = [[GHHomeBannerModel alloc] initWithDictionary:dic error:nil];
                    
                    if (model == nil) {
                        continue;
                    }
                    
                    [dataArray addObject:model];
                    
                }
                
                [cache setObject:[dataArray copy] forKey:kApiInfoSlideshows];
                
                [self.headerView setupScrollViewWithModelArray:dataArray];
                
            }
            
        }];
        
    });
    

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self requsetData];
    });
    

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

- (void)requsetData {
    
    if (self.currentPage > self.totalPage) {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        return;
    }

//    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"pageSize"] = @(self.pageSize);
    params[@"from"] = @(self.currentPage);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiCommentsChoice withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            if (self.currentPage == 0) {
                
                [self.dataArray removeAllObjects];
                
            }
            
            for (NSDictionary *dicInfo in response) {
                
                GHChoiceModel *model = [[GHChoiceModel alloc] initWithDictionary:dicInfo error:nil];
                
                if (model == nil) {
                    continue;
                }
                
                CGFloat shouldHeight = 8;
                
                NSArray *array = [model.pictures jsonValueDecoded];
                
                if (array.count) {
                    
                    for (NSDictionary *dic in array) {
                        
                        if ([ISNIL(model.firstPicture) isEqualToString:ISNIL(dic[@"url"])]) {
                            
                            CGFloat imageWidth = [dic[@"width"] floatValue];
                            CGFloat imageHeight = [dic[@"height"] floatValue];
                            
                            shouldHeight += (((SCREENWIDTH - 32 - 8) * .5) / imageWidth) * imageHeight;
                            
                            model.imageHeight = [NSString stringWithFormat:@"%.2f", shouldHeight - 8];
                            
                        }
                        
                    }
                     
                }
                
                
//                shouldHeight += [model.comment heightForFont:HM14 width:((SCREENWIDTH - 32 - 8) * .5) - 15];
                
                
                CGFloat contentHeight = [model.comment heightForFont:HM13 width:((SCREENWIDTH - 32 - 8) * .5) - 15];
               
                if (model.comment.length) {
                    
                    if (contentHeight < 25) {
                        shouldHeight += 17;
                    } else {
                        shouldHeight += 34;
                    }
                    
                }
                
                shouldHeight += 42 - 3;
                
                
                model.shouldHeight = [NSString stringWithFormat:@"%.2f", shouldHeight];
                
                [self.dataArray addObject:model];
                
            }

            if (((NSArray *)response).count >= self.pageSize) {
                self.totalPage = self.dataArray.count + 1;
            } else {
                self.totalPage = self.currentPage;
            }

            [self.collectionView reloadData];
            
            
        }
        
    }];
    
    
}


- (void)getMoreLikeData{
    self.likeCurrentPage += self.likePageSize;
    [self getLikeDataAction];
}


- (void)getLikeDataAction {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"pageSize"] = @(self.likePageSize);
    params[@"from"] = @(self.likeCurrentPage);

    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiLikeMy withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        
        if (isSuccess) {
            
            NSLog(@"%@", params);
            
            if (self.likeCurrentPage == 0) {
                [[GHZoneLikeManager shareInstance].systemCommentLikeIdArray removeAllObjects];
            }
            
            for (NSDictionary *dicInfo in response) {
                
                if ([dicInfo[@"userId"] longValue] == [[GHUserModelTool shareInstance].userInfoModel.modelId longValue]) {
                    
                    if ([dicInfo[@"likeContentType"] integerValue] == 4) {
                        // 帖子
                        [[GHZoneLikeManager shareInstance].systemCommentLikeIdArray addObject:[NSString stringWithFormat:@"%ld", [dicInfo[@"likeContentId"] longValue]]];
                    }
                    
                }
                
            }
            
            if (((NSArray *)response).count >= self.likePageSize) {
                [self getMoreLikeData];
            }
            
        }

    }];
    
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

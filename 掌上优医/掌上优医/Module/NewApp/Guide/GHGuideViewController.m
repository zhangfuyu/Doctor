//
//  GHGuideViewController.m
//  掌上优医
//
//  Created by GH on 2018/10/24.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHGuideViewController.h"
#import "GHNLoginViewController.h"

#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface GHGuideViewController ()<UIScrollViewDelegate, AMapLocationManagerDelegate>

@property (nonatomic, strong) UIScrollView *pagingScrollView;

@property (nonatomic, strong) UIButton *enterButton;

@property (nonatomic, strong) UIPageControl *pageControl;

/**
 高德定位Manager 如果不引用,则会出现请求权限框闪现或每次打开APP都会出现
 */
@property (nonatomic, strong) AMapLocationManager *locationManager;

@end

@implementation GHGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
    [self setupAmapSDK];
    
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
    
    
    
}

/**
 设置高德地图SDK
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
    [mangaer setLocationTimeout:5];
    //设置逆地理超时时间
    [mangaer setReGeocodeTimeout:5];
    
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [mangaer requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);

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

                [GHUserModelTool shareInstance].locationCity = ISNIL(city);
                [GHUserModelTool shareInstance].locationCityCode = regeocode.adcode.length > 4 ? [regeocode.adcode substringToIndex:4] : @"";
            
            }
            
            NSLog(@"reGeocode:%@", regeocode);
            
        }
    }];
}

- (void)setupUI {
    

    
    [super viewDidLoad];
    
    NSArray *backgroundImageNames = @[@"bng_chajibing", @"bng_zhaoyisheng", @"bng_zhaoyiyuan",  @"bng_youyijiangtang"];
    NSArray *titleArrays = @[@"查疾病", @"找医生", @"找医院",  @"星医讲堂"];
    NSArray *descArrays = @[@"轻松查询 全面疾病健康", @"智能推荐 海量优质医生", @"精准多维 全国医院信息",  @"轻松易懂 精选内容专题"];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(SCREENWIDTH * backgroundImageNames.count, SCREENHEIGHT);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    scrollView.delegate = self;

    for (int i = 0; i<backgroundImageNames.count; i++) {
        
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(i*SCREENWIDTH, -Height_StatusBar, SCREENWIDTH, SCREENHEIGHT);
        view.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:view];
        
        UIImageView *imageview =[[UIImageView alloc] init];
        imageview.backgroundColor = [UIColor whiteColor];
        imageview.image = [UIImage imageNamed:backgroundImageNames[i]];
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageview];
        
        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(HScaleHeight(280));
            make.height.mas_equalTo(HScaleHeight(275));
            make.centerX.mas_equalTo(view);
            make.centerY.mas_equalTo(view.mas_centerY).offset(-50);
        }];
        

        
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.font = H16;
        descLabel.textColor = kDefaultBlackTextColor;
        descLabel.text = ISNIL([descArrays objectOrNilAtIndex:i]);
        descLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:descLabel];
        
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(21);
            
            if (kiPhone4 || kiPhone5 || iPad) {
                
                make.bottom.mas_equalTo(-80);
                
            } else {
                
                make.bottom.mas_equalTo(HScaleHeight(-110));
                
            }
            
            
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont boldSystemFontOfSize:27];
        titleLabel.textColor = kDefaultBlueColor;
        titleLabel.text = ISNIL([titleArrays objectOrNilAtIndex:i]);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(30);
            make.bottom.mas_equalTo(descLabel.mas_top).offset(-15);
        }];
        
        
        if (i == backgroundImageNames.count-1) {
            UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
            [view addGestureRecognizer:tap];
            
            UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
            startButton.titleLabel.font = H16;
            [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [startButton setTitle:@"立即开启" forState:UIControlStateNormal];
            startButton.backgroundColor = kDefaultBlueColor;
            startButton.layer.borderColor = kDefaultBlueColor.CGColor;
            startButton.layer.borderWidth = 1;
            startButton.layer.masksToBounds = true;
            startButton.layer.cornerRadius = 17.5;
            [startButton addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:startButton];

            [startButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(131);
                make.height.mas_equalTo(35);
                make.centerX.mas_equalTo(view);
                make.bottom.mas_equalTo(-40);
            }];
        }
    }
    
    UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    skipButton.titleLabel.font = H18;
    [skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    [skipButton setTitleColor:kDefaultBlueColor forState:UIControlStateNormal];
    [self.view addSubview:skipButton];
    
    [skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(65);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(Height_StatusBar);
    }];
    [skipButton addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupPageController];
    
}

- (void)setupPageController{
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = 4;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = UIColorFromRGB(0xEAEAEA);
    self.pageControl.currentPageIndicatorTintColor = kDefaultBlueColor;
    [self.view addSubview:self.pageControl];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(6);
        make.bottom.mas_equalTo(-40);
    }];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat floatX = scrollView.contentOffset.x;
    
    CGFloat index = floatX/SCREENWIDTH;
    
    self.pageControl.currentPage = round(index);
    
    if (round(index) == 3) {
        self.pageControl.hidden = true;
    } else {
        self.pageControl.hidden = false;
    }
    
    if (floatX > SCREENWIDTH * 3) {
        [self tapAction];
    }
    
}

- (void)tapAction{
    
    if ([self.delegate respondsToSelector:@selector(changeRootViewController)]) {
        [self.delegate changeRootViewController];
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:[NSString stringWithFormat:@"IsFirstComeInAPP%@", [JFTools shortVersion]]];
    }
    
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

//
//  GHHospitalChooseAddressViewController.m
//  掌上优医
//
//  Created by GH on 2019/5/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHospitalChooseAddressViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>

@interface GHHospitalChooseAddressViewController ()<MAMapViewDelegate, AMapSearchDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) AMapSearchAPI *search;

@end

@implementation GHHospitalChooseAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"医院地址";
    
    ///初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    self.mapView.showsScale = false;
    self.mapView.showsCompass = false;
    self.mapView.zoomLevel = 15;
    
    [self.mapView setMaxZoomLevel:20];
    
    [self.mapView setMinZoomLevel:3.5];
    
    // 如果有经纬度, 那么就显示经纬度为中心点, 如果没有, 那么以当前位置为中心
    if (self.point.coordinate.latitude > 0 && self.point.coordinate.longitude > 0) {
        self.mapView.centerCoordinate = self.point.coordinate;
    } else {
        ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
        self.mapView.showsUserLocation = YES;
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    }
    
    
    
    [self.mapView addAnnotation:self.point];
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    UIView *locationView = [[UIView alloc] init];
    locationView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:locationView];
    
    [locationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(70 - kBottomSafeSpace);
    }];
    
    UILabel *locationLabel = [[UILabel alloc] init];
    locationLabel.font = H16;
    locationLabel.textColor = kDefaultBlackTextColor;
    locationLabel.text = ISNIL(self.location);
    locationLabel.numberOfLines = 0;
    [locationView addSubview:locationLabel];
    
    [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-110);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(70);
    }];
    self.locationLabel = locationLabel;
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setBackgroundColor:kDefaultBlueColor];
    submitButton.titleLabel.font = H18;
    submitButton.layer.cornerRadius = 4;
    submitButton.layer.masksToBounds = true;
    [locationView addSubview:submitButton];
    
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(74);
    }];
    [submitButton addTarget:self action:@selector(clickSubmitAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)clickSubmitAction {
    
    if ([self.delegate respondsToSelector:@selector(chooseAddressWithAddress:withCoordinate:)]) {
        
        [self.delegate chooseAddressWithAddress:self.locationLabel.text withCoordinate:self.point.coordinate];
        
    }
    
    [self.navigationController popViewControllerAnimated:true];
    
}

- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction {
    
    [self.mapView removeAnnotation:self.point];
    
    self.point.coordinate = self.mapView.centerCoordinate;
    
    [self.mapView addAnnotation:self.point];
    
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:self.point.coordinate.latitude longitude:self.point.coordinate.longitude];
    
    [self.search AMapReGoecodeSearch:regeo];
    
}

- (void)mapView:(MAMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction {
    
    [self.mapView removeAnnotation:self.point];
    
    self.point.coordinate = self.mapView.centerCoordinate;
    
    [self.mapView addAnnotation:self.point];
    
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:self.point.coordinate.latitude longitude:self.point.coordinate.longitude];
    
    [self.search AMapReGoecodeSearch:regeo];
    
}

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        NSLog(@"%@", response.regeocode);
        //解析response获取地址描述，具体解析见 Demo
        self.locationLabel.text = ISNIL(response.regeocode.formattedAddress);
    }
}


- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    
    static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
    
    MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
    
    if (annotationView == nil)
    {
        annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        
    }
    
    annotationView.image = [UIImage imageNamed:@"ic_ditu_dizhitubiao"];
    
    annotationView.centerOffset = CGPointMake(0, -20);
    
    return annotationView;
    
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

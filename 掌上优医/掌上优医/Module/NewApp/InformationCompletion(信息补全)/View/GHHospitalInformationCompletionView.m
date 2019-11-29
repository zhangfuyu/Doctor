//
//  GHHospitalInformationCompletionView.m
//  掌上优医
//
//  Created by GH on 2019/6/4.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHospitalInformationCompletionView.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

#import "GHMapHospitalAnnotationView.h"
#import "GHHospitalPointAnnotation.h"



#import "GHHospitalInformationCompletionSubmitView.h"


@interface GHHospitalInformationCompletionView ()<MAMapViewDelegate, AMapSearchDelegate, GHHospitalInformationCompletionSubmitViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic, strong) NSMutableArray *annotationArray;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UILabel *hospitalNameLabel;

@property (nonatomic, strong) UILabel *hospitalAddressLabel;

@property (nonatomic, strong) UILabel *hospitalDistanceLabel;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView *mapBgView;

/**
 不固定的内容
 */
@property (nonatomic, strong) UIView *otherContentView;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHHospitalInformationCompletionSubmitView *subView;


@end

@implementation GHHospitalInformationCompletionView

- (NSMutableArray *)annotationArray {
    
    if (!_annotationArray) {
        _annotationArray = [[NSMutableArray alloc] init];
    }
    return _annotationArray;
    
}

- (void)setupDataArray:(NSArray *)array {
    
    self.dataArray = array;
    
    [self.mapView removeAnnotations:self.annotationArray];
    
    [self.annotationArray removeAllObjects];
    
    for (GHSearchHospitalModel *model in array) {
        
        GHHospitalPointAnnotation *pointAnnotation = [[GHHospitalPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake([model.lat doubleValue], [model.lng doubleValue]);
        pointAnnotation.model = model;
        
        [self.annotationArray addObject:pointAnnotation];
        
        [self.mapView addAnnotation:pointAnnotation];
        
    }
    
    
    if (self.annotationArray.count) {
        [self.mapView setSelectedAnnotations:@[[self.annotationArray firstObject]]];
    }
    
    
}

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.bounces = false;
    scrollView.showsVerticalScrollIndicator = false;
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
        make.height.greaterThanOrEqualTo(@0.f);//此处保证容器View高度的动态变化 大于等于0.f的高度
    }];
    self.contentView = contentView;
 
    
    UIView *mapBGView = [[UIView alloc] initWithFrame:CGRectMake(6, 0, SCREENWIDTH - 12, 195)];
    mapBGView.layer.masksToBounds = true;
    [contentView addSubview:mapBGView];
    
    
    self.mapBgView = mapBGView;
    
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:mapBGView.bounds];
    self.mapView.delegate = self;
    [mapBGView addSubview:self.mapView];
    
    self.mapView.showsScale = false;
    self.mapView.showsCompass = false;
    self.mapView.zoomLevel = 14.5;
    
    [self.mapView setMaxZoomLevel:20];
    
    [self.mapView setMinZoomLevel:11.5];
    
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    UIView *otherContentView = [[UIView alloc] init];
    otherContentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:otherContentView];
    
    [otherContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mapBgView.mas_bottom);
        make.left.right.mas_equalTo(0);
    }];
    self.otherContentView = otherContentView;
    
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(otherContentView.mas_bottom).offset(10);
    }];

    
    
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    
    
    if ([annotation isKindOfClass:[GHHospitalPointAnnotation class]]) {
        
        static NSString *pointReuseIndentifier = @"GHMapHospitalAnnotationView";
        GHMapHospitalAnnotationView *annotationView = (GHMapHospitalAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[GHMapHospitalAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        annotationView.titleLabel.text = ISNIL(((GHHospitalPointAnnotation *)annotation).model.hospitalName);
        
        annotationView.size = CGSizeMake(70, 35);
        
        return annotationView;
        
    }
    
    return nil;
    
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    GHSearchHospitalModel *model = ((GHMapHospitalAnnotationView*)view).calloutView.model;
    
    [self setupOtherContentViewWithModel:model];
    
}

- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view {
    
    [self.otherContentView removeAllSubviews];
    
    [self.otherContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
    }];
    
}

- (void)setupOtherContentViewWithModel:(GHSearchHospitalModel *)model {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"id"] = model.modelId;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiHospital withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            GHSearchHospitalModel *hospitalModel = [[GHSearchHospitalModel alloc] initWithDictionary:response error:nil];
            hospitalModel.distance = model.distance;
            [self.subView removeFromSuperview];
            self.subView = nil;
            
            GHHospitalInformationCompletionSubmitView *view = [[GHHospitalInformationCompletionSubmitView alloc] init];
            view.model = hospitalModel;
            view.delegate = self;
            [self.otherContentView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.mas_equalTo(0);
            }];
            
            self.subView = view;
            
            [self.otherContentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(view.contentHeight);
            }];
            
        }
        
    }];
    

 
}

- (void)updateSubmitViewWithHeight:(CGFloat)height {
    
    [self.otherContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
}

@end

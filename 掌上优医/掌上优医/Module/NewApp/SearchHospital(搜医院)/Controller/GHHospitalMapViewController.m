//
//  GHHospitalMapViewController.m
//  掌上优医
//
//  Created by GH on 2019/5/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHospitalMapViewController.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

#import "GHMapHospitalTableViewCell.h"

#import "GHMapHospitalAnnotationView.h"
#import "GHHospitalPointAnnotation.h"

#import "GHHospitalDetailViewController.h"


#import "GHNewHospitalViewController.h"

@interface GHHospitalMapViewController ()<MAMapViewDelegate, AMapSearchDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;

/**
 <#Description#>
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *annotationArray;

@property (nonatomic, assign) NSUInteger hospitalCurrentPage;
@property (nonatomic, assign) NSUInteger hospitalTotalPage;
@property (nonatomic, assign) NSUInteger pageSize;

@end

@implementation GHHospitalMapViewController

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
    
}

- (NSMutableArray *)annotationArray {
    
    if (!_annotationArray) {
        _annotationArray = [[NSMutableArray alloc] init];
    }
    return _annotationArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"附近医院";
    
    [self setupMapAction];
    // Do any additional setup after loading the view.
    
    [self setupTableView];
    
    [self setupConfig];
    
    [self requestData];
    
    
}

- (void)setupConfig{
    
    self.pageSize = 10;
    self.hospitalTotalPage = 1;
    self.hospitalCurrentPage = 0;
    
}

- (void)refreshData{
    
    self.hospitalCurrentPage = 0;
    self.hospitalTotalPage = 1;
    
    [self requestData];
    
}

- (void)getMoreData{
    
    self.hospitalCurrentPage += self.pageSize;
    
    [self requestData];
    
}

- (void)setupMapAction {
    
    ///初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    self.mapView.showsScale = false;
    self.mapView.showsCompass = false;
    self.mapView.zoomLevel = 14.5;
    
    [self.mapView setMaxZoomLevel:20];
    
    [self.mapView setMinZoomLevel:12.5];
    
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;

    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
}

- (void)requestData {
    
    if (self.hospitalCurrentPage > self.hospitalTotalPage) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
//    params[@"pageSize"] = @(self.pageSize);
//    params[@"page"] = @(self.hospitalCurrentPage);
    
//    params[@"distance"] = @"5000";
//
//    params[@"areaId"] = @(1);
//    params[@"areaLevel"] = @(1);
//
//    params[@"sortType"] = @(2);
    params[@"sortType"] = @(2);
    params[@"lat"] = @([GHUserModelTool shareInstance].locationLatitude > 0 ? [GHUserModelTool shareInstance].locationLatitude : 30.3751);
    params[@"lng"] = @([GHUserModelTool shareInstance].locationLongitude > 0 ? [GHUserModelTool shareInstance].locationLongitude : 120.1236);
    params[@"city"] = [GHUserModelTool shareInstance].locationCity.length > 0 ? [GHUserModelTool shareInstance].locationCity : @"杭州市";

    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSearchHospital withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            if (self.hospitalCurrentPage == 0) {
                
                [self.dataArray removeAllObjects];
                [self.annotationArray removeAllObjects];
                
            }
            
            for (NSDictionary *dicInfo in response[@"data"][@"hospitalList"]) {
                
                GHSearchHospitalModel *model = [[GHSearchHospitalModel alloc] initWithDictionary:dicInfo[@"hospital"] error:nil];
                model.distance = dicInfo[@"distance"];
                
                if (model == nil) {
                    continue;
                }
                
                [self.dataArray addObject:model];
                
                GHHospitalPointAnnotation *pointAnnotation = [[GHHospitalPointAnnotation alloc] init];
                pointAnnotation.coordinate = CLLocationCoordinate2DMake([model.lat doubleValue], [model.lng doubleValue]);
                pointAnnotation.model = model;
                
                [self.annotationArray addObject:pointAnnotation];
                
                [self.mapView addAnnotation:pointAnnotation];
                
            }
            
            if (((NSArray *)response[@"data"][@"hospitalList"]).count >= self.pageSize) {
                self.hospitalTotalPage = self.dataArray.count + 1;
            } else {
                self.hospitalTotalPage = self.hospitalCurrentPage;
            }
            
            [self.tableView reloadData];
            
//            [self getMoreData];
            
        }
        
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
        
//        annotationView.image = [UIImage imageNamed:@"ic_fujinyiyuan_dizhi_unsected"];
        
//        annotationView.canShowCallout = true;       //设置气泡可以弹出，默认为NO

        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        annotationView.titleLabel.text = ISNIL(((GHHospitalPointAnnotation *)annotation).model.hospitalName);
        
        annotationView.size = CGSizeMake(70, 35);
        
        return annotationView;
        
    }
    
    return nil;
    
}

//- (void)showHospitalViewWithModel:(GHSearchHospitalModel *)model {
//
//}

- (void)setupTableView {
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.layer.cornerRadius = 4;
    tableView.layer.masksToBounds = true;
    
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    
    tableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-8);
        make.height.mas_equalTo(HScaleHeight(280) - kBottomSafeSpace);
        make.bottom.mas_equalTo(5);
    }];
    self.tableView = tableView;
    
    UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [centerButton setImage:[UIImage imageNamed:@"ic_fujinyiyuan_fangdasuoxiao"] forState:UIControlStateNormal];
    
    [self.view addSubview:centerButton];
    
    [centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(63);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(tableView.mas_top);
    }];
    [centerButton addTarget:self action:@selector(clickCenterAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickCenterAction {

    self.mapView.centerCoordinate = self.mapView.userLocation.location.coordinate;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 81;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHMapHospitalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHMapHospitalTableViewCell"];
    
    if (!cell) {
        cell = [[GHMapHospitalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHMapHospitalTableViewCell"];
    }
    
    cell.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHSearchHospitalModel *model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    GHNewHospitalViewController *vc = [[GHNewHospitalViewController alloc] init];
    vc.hospitalID = model.modelId;
    [self.navigationController pushViewController:vc animated:true];
    
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

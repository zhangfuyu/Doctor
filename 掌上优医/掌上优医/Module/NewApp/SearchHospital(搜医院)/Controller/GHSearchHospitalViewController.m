//
//  GHSearchHospitalViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHSearchHospitalViewController.h"
#import "GHSearchHospitalHeaderView.h"
#import "GHHospitalSpecialDepartmentModel.h"
#import "GHSearchHospitalListViewController.h"
#import "GHHomeBannerModel.h"

#import "GHProvinceCityAreaViewController.h"
#import "GHHospitalSortViewController.h"
#import "GHHospitalFilterViewController.h"

#import "UIButton+touch.h"

#import "GHNSearchHospitalTableViewCell.h"
#import "GHHospitalDetailViewController.h"

#import "GHNewHospitalTableViewCell.h"

#import "GHNSearchHotViewController.h"

#import "GHHospitalMapViewController.h"
#import "GHNewHospitalViewController.h"

#import "GHHospitalRecommendedModel.h"
@interface GHSearchHospitalViewController ()<UITableViewDelegate, UITableViewDataSource, GHProvinceCityAreaViewControllerDelegate, GHHospitalSortViewControllerDelegate, GHHospitalFilterViewControllerDelegate>

@property (nonatomic, strong) UIView *navigationView;

@property (nonatomic, strong) UITextField *searchTextField;

@property (nonatomic, strong) UITableView *tableView;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHSearchHospitalHeaderView *headerView;

@property (nonatomic, assign) NSUInteger pageSize;

@property (nonatomic, strong) UIView *hospitalHeaderView;

@property (nonatomic, strong) NSMutableArray *hospitalArray;
@property (nonatomic, assign) NSUInteger hospitalCurrentPage;
@property (nonatomic, assign) NSUInteger hospitalTotalPage;

@property (nonatomic, strong) NSMutableArray *recommendedArray;

@property (nonatomic, strong) UIButton *hospitalLocationButton;
@property (nonatomic, strong) UIButton *hospitalSortButton;
@property (nonatomic, strong) UIButton *hospitalFilterButton;
@property (nonatomic, strong) UIView *hospitalLocationView;
@property (nonatomic, strong) UIView *hospitalSortView;
@property (nonatomic, strong) UIView *hospitalFilterView;
@property (nonatomic, strong) UIViewController *hospitalLocationContentViewController;
@property (nonatomic, strong) UIViewController *hospitalSortContentViewController;
@property (nonatomic, strong) UIViewController *hospitalFilterContentViewController;
@property (nonatomic, strong) NSString *hospitalAreaId;
@property (nonatomic, assign) NSUInteger hospitalAreaLevel;

@property (nonatomic, strong) NSString *hospitalType;
@property (nonatomic, strong) NSString *hospitalGrade;

@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *area;

@property (nonatomic, strong) GHLocationStatusView *locationStatusView;

@end

@implementation GHSearchHospitalViewController

- (GHLocationStatusView *)locationStatusView {
    
    if (!_locationStatusView) {
        _locationStatusView = [[GHLocationStatusView alloc] init];
        [self.view addSubview:_locationStatusView];
        
        [_locationStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(53 - kBottomSafeSpace);
        }];
    }
    return _locationStatusView;
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    self.locationStatusView.hidden = [GHUserModelTool shareInstance].isHaveLocation;
    
}


- (UIView *)hospitalHeaderView {
    
    if (!_hospitalHeaderView) {
        
        _hospitalHeaderView = [[UIView alloc] init];
        _hospitalHeaderView.backgroundColor = [UIColor whiteColor];
        _hospitalHeaderView.frame = CGRectMake(0, 0, SCREENWIDTH, 44);
        
        for (NSInteger index = 0; index < 3; index++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.titleLabel.font = H14;
            [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
            [button setTitleColor:kDefaultBlueColor forState:UIControlStateSelected];
            button.isIgnore = true;
            
            if (index == 0) {
                [button setTitle:@"当前位置" forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"search_sort_down_icon"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"search_sort_up_icon"] forState:UIControlStateSelected];
                [button addTarget:self action:@selector(clickHospitalLocationAction:) forControlEvents:UIControlEventTouchUpInside];
                self.hospitalLocationButton = button;
            } else if (index == 1) {
                [button setTitle:@"离我最近" forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"search_sort_down_icon"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"search_sort_up_icon"] forState:UIControlStateSelected];
                [button addTarget:self action:@selector(clickHospitalSortAction:) forControlEvents:UIControlEventTouchUpInside];
                self.hospitalSortButton = button;
            } else if (index == 2) {
                [button setTitle:@"筛选" forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"search_filter_icon"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(clickHospitalFilterAction:) forControlEvents:UIControlEventTouchUpInside];
                self.hospitalFilterButton = button;
            }
            
            button.transform = CGAffineTransformMakeScale(-1, 1);
            button.titleLabel.transform = CGAffineTransformMakeScale(-1, 1);
            button.imageView.transform = CGAffineTransformMakeScale(-1, 1);
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
            [button setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -8)];
            
            [_hospitalHeaderView addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                make.left.mas_equalTo(index * (SCREENWIDTH / 3.f));
                make.width.mas_equalTo(SCREENWIDTH / 3.f);
            }];
            
        }
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = kDefaultLineViewColor;
        [_hospitalHeaderView addSubview:lineLabel];
        
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        UILabel *lineLabel2 = [[UILabel alloc] init];
        lineLabel2.backgroundColor = kDefaultLineViewColor;
        [_hospitalHeaderView addSubview:lineLabel2];
        
        [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREENWIDTH / 3.f);
            make.top.mas_equalTo(8);
            make.bottom.mas_equalTo(-8);
            make.width.mas_equalTo(1);
        }];
        
        UILabel *lineLabel3 = [[UILabel alloc] init];
        lineLabel3.backgroundColor = kDefaultLineViewColor;
        [_hospitalHeaderView addSubview:lineLabel3];
        
        [lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREENWIDTH / 3.f * 2);
            make.top.mas_equalTo(8);
            make.bottom.mas_equalTo(-8);
            make.width.mas_equalTo(1);
        }];
    }
    
    return _hospitalHeaderView;
    
    
}

- (UIView *)hospitalLocationView {
    
    if (!_hospitalLocationView) {
        _hospitalLocationView = [[UIView alloc] init];
        _hospitalLocationView.backgroundColor = RGBACOLOR(51,51,51,0.2);
        _hospitalLocationView.frame = CGRectMake(0, Height_NavBar + 44, SCREENWIDTH, SCREENHEIGHT - 0 - Height_NavBar);
        [self.view addSubview:_hospitalLocationView];
        
        GHProvinceCityAreaViewController *vc = [[GHProvinceCityAreaViewController alloc] init];
        vc.view.frame = CGRectMake(0, 0, SCREENWIDTH, 338);
        vc.delegate = self;
        [_hospitalLocationView addSubview:vc.view];
        
        self.hospitalLocationContentViewController = vc;
        
        UIView *tapView = [[UIView alloc] init];
        tapView.backgroundColor = [UIColor clearColor];
        [_hospitalLocationView addSubview:tapView];
        
        [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(vc.view.mas_bottom);
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNoneView)];
        [tapView addGestureRecognizer:tapGR];
    }
    
    return _hospitalLocationView;
    
}

- (UIView *)hospitalSortView {
    
    if (!_hospitalSortView) {
        _hospitalSortView = [[UIView alloc] init];
        _hospitalSortView.backgroundColor = RGBACOLOR(51,51,51,0.2);
        _hospitalSortView.frame = CGRectMake(0, Height_NavBar + 44, SCREENWIDTH, SCREENHEIGHT - 0 - Height_NavBar);
        [self.view addSubview:_hospitalSortView];
        
        GHHospitalSortViewController *vc = [[GHHospitalSortViewController alloc] init];
        vc.isNotHaveSearch = true;
        vc.view.frame = CGRectMake(0, 0, SCREENWIDTH, 180);
        
        vc.delegate = self;
        [_hospitalSortView addSubview:vc.view];
        
        self.hospitalSortContentViewController = vc;
        
        UIView *tapView = [[UIView alloc] init];
        tapView.backgroundColor = [UIColor clearColor];
        [_hospitalSortView addSubview:tapView];
        
        [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(vc.view.mas_bottom);
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNoneView)];
        [tapView addGestureRecognizer:tapGR];
    }
    
    return _hospitalSortView;
    
}

- (UIView *)hospitalFilterView {
    
    if (!_hospitalFilterView) {
        _hospitalFilterView = [[UIView alloc] init];
        _hospitalFilterView.backgroundColor = RGBACOLOR(51,51,51,0.2);
        _hospitalFilterView.frame = CGRectMake(0, Height_NavBar + 44, SCREENWIDTH, SCREENHEIGHT - 0 - Height_NavBar);
        [self.view addSubview:_hospitalFilterView];
        
        GHHospitalFilterViewController *vc = [[GHHospitalFilterViewController alloc] init];
        vc.view.frame = CGRectMake(0, 0, SCREENWIDTH, 328);
        vc.delegate = self;
        [_hospitalFilterView addSubview:vc.view];
        
        self.hospitalFilterContentViewController = vc;
        
        UIView *tapView = [[UIView alloc] init];
        tapView.backgroundColor = [UIColor clearColor];
        [_hospitalFilterView addSubview:tapView];
        
        [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(vc.view.mas_bottom);
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNoneView)];
        [tapView addGestureRecognizer:tapGR];
    }
    
    return _hospitalFilterView;
    
}

- (void)chooseFinishHospitalType:(NSString *)type level:(NSString *)level {
    
    self.hospitalType = type;
    
    self.hospitalGrade = level;
    
    [self clickNoneView];
    
    [self refreshData];
    
}

- (void)chooseFinishHospitalSortWithSort:(NSString *)sort {
    
    [self.hospitalSortButton setTitle:ISNIL(sort) forState:UIControlStateNormal];
    
    [self clickNoneView];
    
    [self refreshData];
    
}

- (void)clickHospitalLocationAction:(UIButton *)sender {
    
    if (sender.selected == true) {
        
        [self clickNoneView];
        
        sender.selected = false;
        
    } else {
        
        [self clickNoneView];
        
        sender.selected = true;
        
        [self reloadTableViewLocation];
        
    }
    
    self.hospitalLocationView.hidden = !sender.selected;
    
}

- (void)clickHospitalSortAction:(UIButton *)sender {
    
    if (sender.selected == true) {
        
        [self clickNoneView];
        
        sender.selected = false;
        
    } else {
        
        [self clickNoneView];
        
        sender.selected = true;
        
        [self reloadTableViewLocation];
        
    }
    
    self.hospitalSortView.hidden = !sender.selected;
    
}

- (void)clickHospitalFilterAction:(UIButton *)sender {
    
    if (sender.selected == true) {
        
        [self clickNoneView];
        
        sender.selected = false;
        
    } else {
        
        [self clickNoneView];
        
        sender.selected = true;
        
        [self reloadTableViewLocation];
        
    }
    
    self.hospitalFilterView.hidden = !sender.selected;
    
}

- (void)reloadTableViewLocation {
    
    if (self.tableView.contentOffset.y < [self.tableView rectForSection:0].origin.y) {
        [self.tableView setContentOffset:CGPointMake(0, [self.tableView rectForSection:0].origin.y) animated:false];
    }
    
}

- (void)clickNoneView {
    
    self.hospitalLocationView.hidden = true;
    self.hospitalLocationButton.selected = false;
    
    self.hospitalSortView.hidden = true;
    self.hospitalSortButton.selected = false;
    
    self.hospitalFilterView.hidden = true;
    self.hospitalFilterButton.selected = false;
    
    [self.searchTextField resignFirstResponder];
    
}

- (NSMutableArray *)hospitalArray {
    
    if (!_hospitalArray) {
        _hospitalArray = [[NSMutableArray alloc] init];
    }
    return _hospitalArray;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setupNavigationBar];
    [self setupConfig];
    [self setupUI];

//    [self refreshData];
//    [self getOtherDataAction];
    
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidAppear:) name:kNotificationWillEnterForeground object:nil];
}

- (void)getOtherDataAction {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"displayPosition"] = @(2);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiInfoSlideshows withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.tableView.mj_header endRefreshing];
        
        if (isSuccess) { 
            
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dic in response[@"data"][@"postList"]) {
                
                GHHomeBannerModel *model = [[GHHomeBannerModel alloc] initWithDictionary:dic error:nil];
                
                if (model == nil) {
                    continue;
                }
                
                [dataArray addObject:model];
                
            }
            
            [self.headerView setupScrollViewWithModelArray:dataArray];
            
        }
        
        [self getHospitalRecommended];//获取医院推荐

        
    }];
    
}

/// 获取医院推荐
- (void)getHospitalRecommended
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"lat"] = @([GHUserModelTool shareInstance].locationLatitude > 0 ? [GHUserModelTool shareInstance].locationLatitude : 30.3751);
    params[@"lng"] = @([GHUserModelTool shareInstance].locationLongitude > 0 ? [GHUserModelTool shareInstance].locationLongitude : 120.1236);
    params[@"province"] = self.province.length > 0 ? self.province :[GHUserModelTool shareInstance].locationprovince;
    

    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiGetTopHospital withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            NSArray *hospital = response[@"data"][@"hospitalList"];
            [self.recommendedArray removeAllObjects];

            if (hospital.count > 0) {
                for (NSInteger index = 0; index < hospital.count; index ++) {
                    NSDictionary *dic = hospital[index];
                    GHHospitalRecommendedModel *model = [[GHHospitalRecommendedModel alloc] initWithDictionary:dic error:nil];
                    [self.recommendedArray addObject:model];
                }
                
                self.headerView.frame = CGRectMake(0, 0, SCREENWIDTH, HScaleHeight(562.5));

                
            }
            else
            {
                self.headerView.frame = CGRectMake(0, 0, SCREENWIDTH, HScaleHeight(307));
            }
            [self.headerView setupRecommendHospitalModelArry:self.recommendedArray];
            [self.tableView reloadData];

        }
        else
        {
            self.headerView.frame = CGRectMake(0, 0, SCREENWIDTH, HScaleHeight(307));
            [self.tableView reloadData];

        }
        
    }];
}
- (void)setupConfig{
    
    self.pageSize = 10;
    self.hospitalTotalPage = 1;
    self.hospitalCurrentPage = 1;
    
}

- (void)refreshData{

    self.hospitalCurrentPage = 1;
    self.hospitalTotalPage = 1;
    if (self.hospitalArray.count) {
        [self.tableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:false];
    }
    [self getOtherDataAction];
    [self requestData];
    
}

- (void)getMoreData{
    
    self.hospitalCurrentPage ++ ;
    
    [self requestData];
    
}

- (void)requestData {

    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"wordsType"] = @(4);
//    params[@"typeId"] = @(1);
    params[@"page"] = @(self.hospitalCurrentPage);
//    params[@"words"] = @"腹痛";
    params[@"pageSize"] = @(10);



    if ([self.hospitalSortButton.currentTitle isEqualToString:@"评分最高"]) {
        params[@"sortType"] = @(1);
    } else if ([self.hospitalSortButton.currentTitle isEqualToString:@"离我最近"]) {
        params[@"sortType"] = @(2);
    }
    else if ([self.hospitalSortButton.currentTitle isEqualToString:@"服务优先"])
    {
         params[@"sortType"] = @(3);
    }
    else if ([self.hospitalSortButton.currentTitle isEqualToString:@"环境优先"])
    {
         params[@"sortType"] = @(4);
        
    }
//
    params[@"category"] = self.hospitalType.length ? self.hospitalType : nil;
    
    params[@"country"] = ISNIL(self.country);
    params[@"province"] = ISNIL(self.province);
    params[@"city"] = ISNIL(self.city);
    params[@"area"] = ISNIL(self.area);
    
//
    NSMutableArray *levelArray = [[NSMutableArray alloc] init];
//
    for (NSString *level in [self.hospitalGrade componentsSeparatedByString:@","]) {

        if ([level isEqualToString:@"三级医院"]) {
            [levelArray addObject:@"3"];
        } else if ([level isEqualToString:@"二级医院"]) {
            [levelArray addObject:@"2"];
        } else if ([level isEqualToString:@"一级医院"]) {
            [levelArray addObject:@"1"];
        }

    }
//
    NSString *levelString = [levelArray componentsJoinedByString:@","];
//
    params[@"hospitalLevel"] = levelString.length ? levelString : nil;
//
//
    
//    params[@"city"] = [GHUserModelTool shareInstance].locationCity.length > 0 ? [GHUserModelTool shareInstance].locationCity : @"杭州市";
    params[@"lat"] = @([GHUserModelTool shareInstance].locationLatitude > 0 ? [GHUserModelTool shareInstance].locationLatitude : 30.3751);
    params[@"lng"] = @([GHUserModelTool shareInstance].locationLongitude > 0 ? [GHUserModelTool shareInstance].locationLongitude : 120.1236);

    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSearchHospital withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            if (self.hospitalCurrentPage == 1) {
                
                [self.hospitalArray removeAllObjects];
                
            }
            
            for (NSDictionary *dicInfo in response[@"data"][@"hospitalList"]) {
                
                GHSearchHospitalModel *model = [[GHSearchHospitalModel alloc] initWithDictionary:dicInfo[@"hospital"] error:nil];
                model.distance = dicInfo[@"distance"];
                if (model == nil) {
                    continue;
                }
                
                [self.hospitalArray addObject:model];
                
            }
            
            if (((NSArray *)response[@"data"][@"hospitalList"]).count > 0) {
            } else {
                self.hospitalCurrentPage --;
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [self.tableView reloadData];
            
        }
        
    }];

}

- (void)setupUI {
    
    UITableView *tableView = [[UITableView alloc] init];
    
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(Height_NavBar);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    self.tableView = tableView;
    
    [self setupTableHeaderView];
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hospitalHeaderView.hidden = false;
        self.hospitalLocationView.hidden = true;
    });

}

- (void)setupTableHeaderView {
    
    GHSearchHospitalHeaderView *headerView = [[GHSearchHospitalHeaderView alloc] init];
    
    headerView.frame = CGRectMake(0, 0, SCREENWIDTH, HScaleHeight(562.5));
    
    self.tableView.tableHeaderView = headerView;
    
    self.headerView = headerView;
    
    self.headerView.specialArray = [GHSearchHospitalHeaderView getmodelarry];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.hospitalArray.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

//    return 126;
    return [GHNewHospitalTableViewCell getCellHeightFor:[self.hospitalArray objectAtIndex:indexPath.row]];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 44;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return self.hospitalHeaderView;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
//    GHNSearchHospitalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNSearchHospitalTableViewCell"];
    GHNewHospitalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNewHospitalTableViewCell"];
    if (!cell) {
        cell = [[GHNewHospitalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNewHospitalTableViewCell"];
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    cell.model = [self.hospitalArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:indexPath.row];
        
    GHSearchHospitalModel *model = [self.hospitalArray objectOrNilAtIndex:indexPath.row];
    
//    GHHospitalDetailViewController *vc = [[GHHospitalDetailViewController alloc] init];
    GHNewHospitalViewController *hospital = [[GHNewHospitalViewController alloc]init];
    hospital.hospitalID = model.modelId;
    [self.navigationController pushViewController:hospital animated:true];
    
    
}

- (void)chooseFinishWithCountryModel:(GHAreaModel *)countryModel provinceModel:(GHAreaModel *)provinceModel cityModel:(GHAreaModel *)cityModel areaModel:(GHAreaModel *)areaModel areaLevel:(NSInteger)areaLevel {
    

    if (areaLevel == 4) {
        [self.hospitalLocationButton setTitle:ISNIL(areaModel.areaName) forState:UIControlStateNormal];
//        self.hospitalAreaId = areaModel.modelId;
    } else if (areaLevel == 3) {
        [self.hospitalLocationButton setTitle:ISNIL(cityModel.areaName) forState:UIControlStateNormal];
//        self.hospitalAreaId = cityModel.modelId;
    } else if (areaLevel == 2) {
        [self.hospitalLocationButton setTitle:ISNIL(provinceModel.areaName) forState:UIControlStateNormal];
//        self.hospitalAreaId = provinceModel.modelId;
    } else if (areaLevel == 1) {
        [self.hospitalLocationButton setTitle:@"全国" forState:UIControlStateNormal];
//        self.hospitalAreaId = countryModel.modelId;
    }
//
//    self.hospitalAreaLevel = areaLevel;
    
    
    
    if (areaLevel == 1) {
        self.country = @"中国";
        self.province = nil;
        self.city = nil;
        self.area = nil;
    }
    else
    {
        self.province = provinceModel.areaName;
        self.city = cityModel.areaName;
        self.area = areaModel.areaName;
        self.country = nil;
    }
    
    [self clickNoneView];
    
    [self refreshData];
    
    
}


- (void)setupNavigationBar {
    
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, Height_NavBar)];
    navigationView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navigationView];
    
    self.navigationView = navigationView;
    
    
    
    
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.textColor = UIColorHex(0x010101);
    titlelabel.font = H15;
    titlelabel.text = @"搜医院";
    titlelabel.textAlignment = NSTextAlignmentCenter;
    [self.navigationView addSubview:titlelabel];
    
    [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Height_StatusBar);
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(self.navigationView.mas_centerX);
    }];
    
//    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    searchButton.titleLabel.font = H15;
////    [searchButton setTitle:@"  请输入医院名称" forState:UIControlStateNormal];
//    [searchButton setTitle:@"  搜医院" forState:UIControlStateNormal];
//    [searchButton setTitleColor:UIColorHex(0x010101) forState:UIControlStateNormal];
//    [searchButton setImage:[UIImage imageNamed:@"home_search"] forState:UIControlStateNormal];
//    searchButton.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
//    searchButton.layer.shadowOffset = CGSizeMake(0,2);
//    searchButton.layer.shadowOpacity = 1;
//    searchButton.layer.shadowRadius = 4;
//    searchButton.backgroundColor = [UIColor whiteColor];
//    searchButton.layer.cornerRadius = 17.5;
    
    
//    [navigationView addSubview:searchButton];
//
//    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.mas_equalTo(60);
//        make.height.mas_equalTo(35);
//        make.centerY.mas_equalTo(navigationView);
//        make.right.mas_equalTo(-121);
//
//
//    }];
//
//    if (!kiOS10Later) {
//        searchButton.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.11];
//    }
//
//    [searchButton addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mapButton setTitleColor:UIColorHex(0x010101) forState:UIControlStateNormal];
    mapButton.titleLabel.font = H15;
    [mapButton setTitle:@"  附近医院" forState:UIControlStateNormal];
    [mapButton setImage:[UIImage imageNamed:@"new_hospital_list_map"] forState:UIControlStateNormal];
    [mapButton addTarget:self action:@selector(clickMapAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:mapButton];
    
    [mapButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(searchButton.mas_right);
        make.left.mas_equalTo(self.navigationView.mas_right).offset(-121);

        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(Height_StatusBar);
        make.right.mas_equalTo(0);
    }];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, Height_StatusBar, 44, 44)];
    backBtn.showsTouchWhenHighlighted = NO;
    [backBtn setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:backBtn];
    
}

- (void)clickMapAction {
    
    GHHospitalMapViewController *vc = [[GHHospitalMapViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)clickSearchAction {
    
    GHNSearchHotViewController *vc = [[GHNSearchHotViewController alloc] init];
    
    vc.type = GHNSearchHotType_Hospital;
    
    [self.navigationController pushViewController:vc animated:false];
    
}

//- (void)clickSearchAction:(UITextField *)textField {
//
//    if (textField.text.length == 0) {
//        [SVProgressHUD showErrorWithStatus:@"请输入您要搜索的内容"];
//        return;
//    }
//
//    if (textField.text.length > 40) {
//        [SVProgressHUD showErrorWithStatus:@"搜索的内容不得大于40字"];
//        return;
//    }
//
//    if ([NSString isEmpty:textField.text] || [NSString stringContainsEmoji:textField.text]) {
//        [SVProgressHUD showErrorWithStatus:@"请输入正确的搜索内容"];
//        return;
//    }
//
//    [MobClick event:@"Search_Hospital_Input"];
//
//    GHSearchHospitalListViewController *vc = [[GHSearchHospitalListViewController alloc] init];
//    vc.searchKey = ISNIL(textField.text);
//    [self.navigationController pushViewController:vc animated:false];
//
//    self.searchTextField.text = @"";
//
//}

- (void)clickCancelAction {
    
    [self.view endEditing:true];
    
    [self.searchTextField resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:true];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//
//    [self setupNavigationStyle:GHNavigationBarStyleWhite];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = false;

    
//    self.navigationView.hidden = true;
    
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
//
//    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
}

- (NSMutableArray *)recommendedArray
{
    if (!_recommendedArray) {
        _recommendedArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _recommendedArray;
}
@end

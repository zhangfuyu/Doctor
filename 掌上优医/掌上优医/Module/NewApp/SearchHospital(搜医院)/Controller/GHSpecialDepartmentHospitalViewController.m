//
//  GHSpecialDepartmentHospitalViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/28.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHSpecialDepartmentHospitalViewController.h"

#import "GHNearbyDistanceViewController.h"
#import "GHProvinceCityAreaViewController.h"

#import "GHHospitalDetailViewController.h"

#import "GHProvinceCityAreaViewController.h"
#import "GHHospitalSortViewController.h"
#import "GHHospitalFilterViewController.h"

#import "UIButton+touch.h"

#import "GHNSearchHospitalTableViewCell.h"
#import "GHHospitalDetailViewController.h"

#import "GHNewHospitalViewController.h"

@interface GHSpecialDepartmentHospitalViewController ()<UITableViewDelegate, UITableViewDataSource, GHProvinceCityAreaViewControllerDelegate, GHHospitalSortViewControllerDelegate, GHHospitalFilterViewControllerDelegate>

@property (nonatomic, strong) UIView *navigationView;

@property (nonatomic, strong) UITextField *searchTextField;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSUInteger pageSize;

@property (nonatomic, strong) UIView *hospitalHeaderView;

@property (nonatomic, strong) NSMutableArray *hospitalArray;
@property (nonatomic, assign) NSUInteger hospitalCurrentPage;
@property (nonatomic, assign) NSUInteger hospitalTotalPage;

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

@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *area;


@property (nonatomic, strong) GHLocationStatusView *locationStatusView;

@end

@implementation GHSpecialDepartmentHospitalViewController

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
        _hospitalLocationView.frame = CGRectMake(0, 44, SCREENWIDTH, SCREENHEIGHT - 44 - Height_NavBar);
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
        _hospitalSortView.frame = CGRectMake(0, 44, SCREENWIDTH, SCREENHEIGHT - 44 - Height_NavBar);
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
        _hospitalFilterView.frame = CGRectMake(0, 44, SCREENWIDTH, SCREENHEIGHT - 44 - Height_NavBar);
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
        
    }
    
    self.hospitalFilterView.hidden = !sender.selected;
    
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
    
    self.navigationItem.title = ISNIL(self.choiceDepartment);
    
    [self setupConfig];
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidAppear:) name:kNotificationWillEnterForeground object:nil];
    
    // Do any additional setup after loading the view.
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
    
    [self requestData];
    
}

- (void)getMoreData{
    
    self.hospitalCurrentPage ++;
    
    [self requestData];
    
}

- (void)requestData {
    
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"words"] = ISNIL(self.choiceDepartment);
    params[@"pageSize"] = @(self.pageSize);
    params[@"page"] = @(self.hospitalCurrentPage);
    
   
    
    params[@"province"] = ISNIL(self.country);
    params[@"city"] = ISNIL(self.city);
    params[@"area"] = ISNIL(self.area);
  
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
    

    
    params[@"category"] = self.hospitalType.length ? self.hospitalType : nil;
    
    NSMutableArray *levelArray = [[NSMutableArray alloc] init];
    
    for (NSString *level in [self.hospitalGrade componentsSeparatedByString:@","]) {
        
        if ([level isEqualToString:@"三级医院"]) {
            [levelArray addObject:@"3"];
        } else if ([level isEqualToString:@"二级医院"]) {
            [levelArray addObject:@"2"];
        } else if ([level isEqualToString:@"一级医院"]) {
            [levelArray addObject:@"1"];
        }
        
    }
    
    NSString *levelString = [levelArray componentsJoinedByString:@","];
    
    params[@"hospitalLevel"] = levelString.length ? levelString : nil;
    
    
    params[@"lat"] = @([GHUserModelTool shareInstance].locationLatitude > 0 ? [GHUserModelTool shareInstance].locationLatitude : 30.3751);
    params[@"lng"] = @([GHUserModelTool shareInstance].locationLongitude > 0 ? [GHUserModelTool shareInstance].locationLongitude : 120.1236);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSearchHospital withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            if (self.hospitalCurrentPage == 1) {
                
                [self.hospitalArray removeAllObjects];
                
            }
            NSArray *hospitalList = response[@"data"][@"hospitalList"];
            for (NSInteger index = 0; index < hospitalList.count; index ++) {
                
                NSDictionary *dic = hospitalList[index];
                GHSearchHospitalModel *model = [[GHSearchHospitalModel alloc] initWithDictionary:dic[@"hospital"] error:nil];
                model.distance = dic[@"distance"];
                
                if (model == nil) {
                    continue;
                }
                
                [self.hospitalArray addObject:model];
            }
            
          
            if (hospitalList.count > 0) {
               
            } else {
                self.hospitalCurrentPage --;
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [self.tableView reloadData];
            
            if (self.hospitalArray.count == 0) {
                [self loadingEmptyView];
            }else{
                [self hideEmptyView];
            }
            
        }
        
    }];
    
}



- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationView.hidden = false;
    
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //
    //    [self setupNavigationStyle:GHNavigationBarStyleWhite];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationView.hidden = true;
    
    //    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setShadowImage:nil];
    //
    //    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
}



- (void)clickCancelAction {
    
    [self.view endEditing:true];
    
    [self.searchTextField resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:true];
    
}

- (void)setupUI {
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    self.tableView = tableView;
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
    self.hospitalHeaderView.hidden = false;
    self.hospitalLocationView.hidden = true;
    
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.hospitalArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 126;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.hospitalHeaderView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    GHNSearchHospitalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNSearchHospitalTableViewCell"];
    
    if (!cell) {
        cell = [[GHNSearchHospitalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNSearchHospitalTableViewCell"];
    }
    
    cell.model = [self.hospitalArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    GHSearchHospitalModel *model = [self.hospitalArray objectOrNilAtIndex:indexPath.row];
    
    GHNewHospitalViewController *vc = [[GHNewHospitalViewController alloc] init];
    vc.hospitalID = model.modelId;
    [self.navigationController pushViewController:vc animated:true];
    
    
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
    
//    self.hospitalAreaLevel = areaLevel;
    
    if (areaLevel == 1) {
        self.country = nil;
        self.city = nil;
        self.area = nil;
    }
    else
    {
        self.country = provinceModel.areaName;
        self.city = cityModel.areaName;
        self.area = areaModel.areaName;
    }
    
    [self clickNoneView];
    
    [self refreshData];
    
    
}



@end

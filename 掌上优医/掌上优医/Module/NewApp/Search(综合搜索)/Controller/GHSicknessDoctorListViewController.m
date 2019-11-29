//
//  GHSicknessDoctorListViewController.m
//  掌上优医
//
//  Created by GH on 2018/10/30.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHSicknessDoctorListViewController.h"

#import "GHProvinceCityAreaViewController.h"
#import "GHDoctorSortViewController.h"
#import "GHNewDoctorDetailViewController.h"
#import "GHNSearchDoctorTableViewCell.h"
#import "GHDoctorFilterViewController.h"

#import "UIButton+touch.h"
#import "GHNewDoctorModel.h"//add by  zhangfuyu
#import "GHNewDoctorTableViewCell.h"

@interface GHSicknessDoctorListViewController ()<UITableViewDelegate, UITableViewDataSource, GHProvinceCityAreaViewControllerDelegate, GHDoctorSortViewControllerDelegate, GHDoctorFilterViewControllerDelegate>

@property (nonatomic, assign) NSUInteger pageSize;

@property (nonatomic, strong) NSMutableArray *doctorArray;
@property (nonatomic, assign) NSUInteger doctorCurrentPage;
@property (nonatomic, assign) NSUInteger doctorTotalPage;
@property (nonatomic, strong) UITableView *doctorTableView;

@property (nonatomic, strong) UIView *doctorHeaderView;

@property (nonatomic, strong) UIButton *doctorLocationButton;
@property (nonatomic, strong) UIButton *doctorSortButton;
@property (nonatomic, strong) UIButton *doctorFilterButton;
@property (nonatomic, strong) UIView *doctorLocationView;
@property (nonatomic, strong) UIView *doctorSortView;
@property (nonatomic, strong) UIView *doctorFilterView;
@property (nonatomic, strong) UIViewController *doctorLocationContentViewController;
@property (nonatomic, strong) UIViewController *doctorSortContentViewController;
@property (nonatomic, strong) UIViewController *doctorFilterContentViewController;
@property (nonatomic, strong) NSString *doctorAreaId;
@property (nonatomic, assign) NSUInteger doctorAreaLevel;

@property (nonatomic, strong) NSString *doctorGrade;
@property (nonatomic, strong) NSString *doctorType;
@property (nonatomic, strong) NSString *doctorHospitalLevel;

@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *area;

@property (nonatomic, strong) GHLocationStatusView *locationStatusView;

@end

@implementation GHSicknessDoctorListViewController

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


- (UIView *)doctorHeaderView {
    
    if (!_doctorHeaderView) {
        
        _doctorHeaderView = [[UIView alloc] init];
        _doctorHeaderView.backgroundColor = [UIColor whiteColor];
        _doctorHeaderView.frame = CGRectMake(0, 0, SCREENWIDTH, 44);
        
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
                [button addTarget:self action:@selector(clickDoctorLocationAction:) forControlEvents:UIControlEventTouchUpInside];
                self.doctorLocationButton = button;
            } else if (index == 1) {
                [button setTitle:@"离我最近" forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"search_sort_down_icon"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"search_sort_up_icon"] forState:UIControlStateSelected];
                [button addTarget:self action:@selector(clickDoctorSortAction:) forControlEvents:UIControlEventTouchUpInside];
                self.doctorSortButton = button;
            } else if (index == 2) {
                [button setTitle:@"筛选" forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"search_filter_icon"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(clickDoctorFilterAction:) forControlEvents:UIControlEventTouchUpInside];
                self.doctorFilterButton = button;
            }
            
            button.transform = CGAffineTransformMakeScale(-1, 1);
            button.titleLabel.transform = CGAffineTransformMakeScale(-1, 1);
            button.imageView.transform = CGAffineTransformMakeScale(-1, 1);
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
            [button setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -8)];
            
            [_doctorHeaderView addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                make.left.mas_equalTo(index * (SCREENWIDTH / 3.f));
                make.width.mas_equalTo(SCREENWIDTH / 3.f);
            }];
            
        }
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = kDefaultLineViewColor;
        [_doctorHeaderView addSubview:lineLabel];
        
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        UILabel *lineLabel2 = [[UILabel alloc] init];
        lineLabel2.backgroundColor = kDefaultLineViewColor;
        [_doctorHeaderView addSubview:lineLabel2];
        
        [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREENWIDTH / 3.f);
            make.top.mas_equalTo(8);
            make.bottom.mas_equalTo(-8);
            make.width.mas_equalTo(1);
        }];
        
        UILabel *lineLabel3 = [[UILabel alloc] init];
        lineLabel3.backgroundColor = kDefaultLineViewColor;
        [_doctorHeaderView addSubview:lineLabel3];
        
        [lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREENWIDTH / 3.f * 2);
            make.top.mas_equalTo(8);
            make.bottom.mas_equalTo(-8);
            make.width.mas_equalTo(1);
        }];
        
        UILabel *lineLabel4 = [[UILabel alloc] init];
        lineLabel4.backgroundColor = kDefaultLineViewColor;
        [_doctorHeaderView addSubview:lineLabel4];
        
        [lineLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    
    return _doctorHeaderView;
    
}

- (UIView *)doctorLocationView {
    
    if (!_doctorLocationView) {
        _doctorLocationView = [[UIView alloc] init];
        _doctorLocationView.backgroundColor = RGBACOLOR(51,51,51,0.2);
        _doctorLocationView.frame = CGRectMake(0, 44, SCREENWIDTH, SCREENHEIGHT - 41 - Height_NavBar);
        [self.view addSubview:_doctorLocationView];
        
        GHProvinceCityAreaViewController *vc = [[GHProvinceCityAreaViewController alloc] init];
        vc.view.frame = CGRectMake(0, 0, SCREENWIDTH, 338);
        vc.delegate = self;
        [_doctorLocationView addSubview:vc.view];
        
        self.doctorLocationContentViewController = vc;
        
        UIView *tapView = [[UIView alloc] init];
        tapView.backgroundColor = [UIColor clearColor];
        [_doctorLocationView addSubview:tapView];
        
        [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(vc.view.mas_bottom);
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNoneView)];
        [tapView addGestureRecognizer:tapGR];
    }
    
    return _doctorLocationView;
    
}

- (UIView *)doctorSortView {
    
    if (!_doctorSortView) {
        _doctorSortView = [[UIView alloc] init];
        _doctorSortView.backgroundColor = RGBACOLOR(51,51,51,0.2);
        _doctorSortView.frame = CGRectMake(0, 44, SCREENWIDTH, SCREENHEIGHT - 41 - Height_NavBar);
        [self.view addSubview:_doctorSortView];
        
        GHDoctorSortViewController *vc = [[GHDoctorSortViewController alloc] init];
        vc.view.frame = CGRectMake(0, 0, SCREENWIDTH, 90);
        vc.delegate = self;
        [_doctorSortView addSubview:vc.view];
        
        self.doctorSortContentViewController = vc;
        
        UIView *tapView = [[UIView alloc] init];
        tapView.backgroundColor = [UIColor clearColor];
        [_doctorSortView addSubview:tapView];
        
        [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(vc.view.mas_bottom);
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNoneView)];
        [tapView addGestureRecognizer:tapGR];
    }
    
    return _doctorSortView;
    
}

- (UIView *)doctorFilterView {
    
    if (!_doctorFilterView) {
        _doctorFilterView = [[UIView alloc] init];
        _doctorFilterView.backgroundColor = RGBACOLOR(51,51,51,0.2);
        _doctorFilterView.frame = CGRectMake(0, 44, SCREENWIDTH, SCREENHEIGHT - 41 - Height_NavBar);
        [self.view addSubview:_doctorFilterView];
        
        GHDoctorFilterViewController *vc = [[GHDoctorFilterViewController alloc] init];
        vc.view.frame = CGRectMake(0, 0, SCREENWIDTH, 368);
        vc.delegate = self;
        [_doctorFilterView addSubview:vc.view];
        
        self.doctorFilterContentViewController = vc;
        
        UIView *tapView = [[UIView alloc] init];
        tapView.backgroundColor = [UIColor clearColor];
        [_doctorFilterView addSubview:tapView];
        
        [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(vc.view.mas_bottom);
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNoneView)];
        [tapView addGestureRecognizer:tapGR];
    }
    
    return _doctorFilterView;
    
}

//- (void)chooseFinishDoctorFilter:(NSString *)filter {
//
//    self.doctorGrade = filter;
//
//    [self clickNoneView];
//
//    [self refreshData];
//
//}



- (void)clickDoctorLocationAction:(UIButton *)sender {
    
    if (sender.selected == true) {
        
        [self clickNoneView];
        
        sender.selected = false;
        
    } else {
        
        [self clickNoneView];
        
        sender.selected = true;
        
    }
    
    self.doctorLocationView.hidden = !sender.selected;
    
}

- (void)clickDoctorSortAction:(UIButton *)sender {
    
    if (sender.selected == true) {
        
        [self clickNoneView];
        
        sender.selected = false;
        
    } else {
        
        [self clickNoneView];
        
        sender.selected = true;
        
    }
    
    self.doctorSortView.hidden = !sender.selected;
    
}

- (void)clickDoctorFilterAction:(UIButton *)sender {
    
    if (sender.selected == true) {
        
        [self clickNoneView];
        
        sender.selected = false;
        
    } else {
        
        [self clickNoneView];
        
        sender.selected = true;
        
    }
    
    self.doctorFilterView.hidden = !sender.selected;
    
}

- (void)clickNoneView {
    
    self.doctorLocationView.hidden = true;
    self.doctorLocationButton.selected = false;
    
    self.doctorSortView.hidden = true;
    self.doctorSortButton.selected = false;
    
    self.doctorFilterView.hidden = true;
    self.doctorFilterButton.selected = false;
    
}

- (NSMutableArray *)doctorArray {
    
    if (!_doctorArray) {
        _doctorArray = [[NSMutableArray alloc] init];
    }
    return _doctorArray;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.sicknessTitleName.length ? self.sicknessTitleName : ISNIL(self.departmentName);
    
    [self setupConfig];
    
//    [self setupNavigationBar];
    
    [self setupUI];
    
//    [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidAppear:) name:kNotificationWillEnterForeground object:nil];
    
}

- (void)setupConfig{
    
    self.pageSize = 10;
    self.doctorTotalPage = 1;
    self.doctorCurrentPage = 0;
    
}

- (void)setupUI {
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    
    tableView.backgroundColor = kDefaultGaryViewColor;
    
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    self.doctorTableView = tableView;
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
    self.doctorHeaderView.hidden = false;
    self.doctorLocationView.hidden = true;
    
    [self clickNoneView];
    
}

- (void)refreshData{
    
    self.doctorCurrentPage = 1;
    self.doctorTotalPage = 1;
    if (self.doctorArray.count) {
        [self.doctorTableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:false];
    }

    [self requestData];
    
}

- (void)getMoreData{
    
    self.doctorCurrentPage ++;
 
    [self requestData];
    
}
- (NSString *)resetToReplaceWith:(NSString *)text
{
    NSMutableArray *changearry = [NSMutableArray arrayWithCapacity:0];
    NSArray *arry = [text componentsSeparatedByString:@","];
    if ([arry containsObject:@"主任医师"]) {
        [changearry addObject:@"4"];
    }
    if ([arry containsObject:@"副主任医师"]) {
        [changearry addObject:@"3"];
    }
    if ([arry containsObject:@"主治医师"]) {
        [changearry addObject:@"2"];
    }
    if ([arry containsObject:@"医师"]) {
        [changearry addObject:@"1"];
    }
    
    return  [changearry componentsJoinedByString:@","];
}
- (void)requestData {

    
//    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"wordsType"] = self.wordsType;

    if ([self.wordsType isEqualToString:@"1"]) {
        params[@"words"] =  self.sicknessName;;
        params[@"typeId"] = @(1);

    }
    else
    {
        params[@"words"] =  self.departmentModel.departmentName;
        params[@"typeId"] = self.departmentModel.modelid;

    }
    params[@"page"] = @(self.doctorCurrentPage);
    
    params[@"pageSize"] = @(self.pageSize);
//    params[@"from"] = @(self.doctorCurrentPage);
//
    if ([self.doctorSortButton.currentTitle isEqualToString:@"评分最高"]) {
        params[@"sortType"] = @(2);
    } else if ([self.doctorSortButton.currentTitle isEqualToString:@"离我最近"]) {
        params[@"sortType"] = @(3);
    } else {
        params[@"sortType"] = @(1);
    }
//
    params[@"doctorGradeNum"] = self.doctorGrade.length ? [self resetToReplaceWith:self.doctorGrade]: nil;

    params[@"medicineType"] = self.doctorType.length ? self.doctorType : nil;

    

    params[@"hospitalLevel"] = self.doctorHospitalLevel.length ? self.doctorHospitalLevel : nil;
    
    params[@"country"] = ISNIL(self.country);
    params[@"province"] = ISNIL(self.province);
    params[@"city"] = ISNIL(self.city);
    params[@"area"] = ISNIL(self.area);
//
//    params[@"areaId"] = self.doctorAreaId;
//    params[@"areaLevel"] = @(self.doctorAreaLevel);
    params[@"lat"] = @([GHUserModelTool shareInstance].locationLatitude > 0 ? [GHUserModelTool shareInstance].locationLatitude : 30.3751);
    params[@"lng"] = @([GHUserModelTool shareInstance].locationLongitude > 0 ? [GHUserModelTool shareInstance].locationLongitude : 120.1236);
//
//    if (self.departmentModel) {
//
//        params[@"departmentId"] = self.departmentModel.modelId;
//        params[@"departmentLevel"] = self.departmentModel.departmentLevel;
        
//    } else {
//        params[@"diseaseName"] = self.sicknessName;
//    }
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSearchDoctor withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.doctorTableView.mj_header endRefreshing];
        [self.doctorTableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
          
            if (self.doctorCurrentPage == 1) {
                
                [self.doctorArray removeAllObjects];
                
            }
            
            for (NSDictionary *dicInfo in response[@"data"][@"hospitalDoctorList"]) {
                
                GHNewDoctorModel *model = [[GHNewDoctorModel alloc] initWithDictionary:dicInfo error:nil];
                
                if (model == nil) {
                    continue;
                }
                
                [self.doctorArray addObject:model];
                
            }
            
            if (((NSArray *)response[@"data"][@"hospitalDoctorList"]).count > 0) {
            } else {

                self.doctorCurrentPage --;
                [self.doctorTableView.mj_footer endRefreshingWithNoMoreData];
                
            }
            
            [self.doctorTableView reloadData];
            
            if (self.doctorArray.count == 0) {
                [self loadingEmptyView];
            }else{
                [self hideEmptyView];
            }
            
        }
        
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.doctorArray.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

     return [GHNewDoctorTableViewCell getCellHeitghtWithMoel:[self.doctorArray objectAtIndex:indexPath.row]];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 44;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return self.doctorHeaderView;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
        
        GHNewDoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNSearchDoctorTableViewCell"];
        
        if (!cell) {
            cell = [[GHNewDoctorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNSearchDoctorTableViewCell"];
        }
        
        cell.model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
        
        return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    GHNewDoctorDetailViewController *vc = [[GHNewDoctorDetailViewController alloc] init];
    GHSearchDoctorModel *model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
    vc.doctorId = model.doctorId;
    [self.navigationController pushViewController:vc animated:true];
        
//        GHDocterDetailViewController *vc = [[GHDocterDetailViewController alloc] init];
//        GHSearchDoctorModel *model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
//        vc.doctorId = model.modelId;
//        vc.distance = model.distance;
//        [self.navigationController pushViewController:vc animated:true];
    

}
#pragma mark - 点击三个不同筛选条件回调
- (void)chooseFinishDoctorPosition:(NSString *)position doctorType:(NSString *)doctorType hospitalLevel:(NSString *)hospitalLevel {
    
    self.doctorGrade = position;
    self.doctorType = doctorType;
    self.doctorHospitalLevel = hospitalLevel;
    
    [self clickNoneView];
    
    [self refreshData];
    
}

- (void)chooseFinishDoctorSortWithSort:(NSString *)sort {
    
    [self.doctorSortButton setTitle:ISNIL(sort) forState:UIControlStateNormal];
    
    [self clickNoneView];
    
    [self refreshData];
    
}
- (void)chooseFinishWithCountryModel:(GHAreaModel *)countryModel provinceModel:(GHAreaModel *)provinceModel cityModel:(GHAreaModel *)cityModel areaModel:(GHAreaModel *)areaModel areaLevel:(NSInteger)areaLevel {
    
    if (areaLevel == 4) {
        [self.doctorLocationButton setTitle:ISNIL(areaModel.areaName) forState:UIControlStateNormal];
        self.doctorAreaId = areaModel.modelId;
    } else if (areaLevel == 3) {
        [self.doctorLocationButton setTitle:ISNIL(cityModel.areaName) forState:UIControlStateNormal];
        self.doctorAreaId = cityModel.modelId;
    } else if (areaLevel == 2) {
        [self.doctorLocationButton setTitle:ISNIL(provinceModel.areaName) forState:UIControlStateNormal];
        self.doctorAreaId = provinceModel.modelId;
    } else if (areaLevel == 1) {
        [self.doctorLocationButton setTitle:@"全国" forState:UIControlStateNormal];
        self.doctorAreaId = countryModel.modelId;
    }
    
//    self.doctorAreaLevel = areaLevel;
    
    if (areaLevel == 1) {
        self.province = nil;
        self.country = @"中国";
        self.city = nil;
        self.area = nil;
    }
    else
    {
        self.country = countryModel.areaName;
        self.province = provinceModel.areaName;

        self.city = cityModel.areaName;
        self.area = areaModel.areaName;
        self.country = nil;

    }
    
    [self clickNoneView];
    
    [self refreshData];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
    
}




@end


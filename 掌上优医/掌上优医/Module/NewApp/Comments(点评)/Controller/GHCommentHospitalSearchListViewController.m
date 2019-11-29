//
//  GHCommentHospitalSearchListViewController.m
//  掌上优医
//
//  Created by GH on 2019/5/13.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHCommentHospitalSearchListViewController.h"


#import "GHNearbyDistanceViewController.h"
#import "GHProvinceCityAreaViewController.h"

#import "GHHospitalDetailViewController.h"

#import "GHProvinceCityAreaViewController.h"
#import "GHHospitalSortViewController.h"
#import "GHHospitalFilterViewController.h"

#import "UIButton+touch.h"

#import "GHCommentHospitalRecordTableViewCell.h"
#import "GHNewHospitalViewController.h"

@interface GHCommentHospitalSearchListViewController ()<UITableViewDelegate, UITableViewDataSource, GHProvinceCityAreaViewControllerDelegate, GHHospitalSortViewControllerDelegate, GHHospitalFilterViewControllerDelegate>

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

@implementation GHCommentHospitalSearchListViewController

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
                [button setTitle:@"默认排序" forState:UIControlStateNormal];
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
    
    [self setupNavigationBar];
    [self setupConfig];
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidAppear:) name:kNotificationWillEnterForeground object:nil];
    //    [self requestData];
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
    
    
    if (self.hospitalCurrentPage > self.hospitalTotalPage) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    //    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"words"] = ISNIL(self.searchKey);
    params[@"pageSize"] = @(self.pageSize);
    params[@"page"] = @(self.hospitalCurrentPage);
    params[@"wordsType"] = @(4);

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
    
    params[@"province"] = ISNIL(self.country);
    params[@"city"] = ISNIL(self.city);
    params[@"area"] = ISNIL(self.area);
    
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
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSearchHospital withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
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
                
//                GHNHospitalRecordModel *recordModel = [[GHNHospitalRecordModel alloc] init];
//
//                recordModel.modelId = model.modelId;
//                recordModel.hospitalName = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.hospitalName)];
//                recordModel.grade = model.hospitalGrade;
//                recordModel.category = model.category;
//                recordModel.profilePhoto = model.profilePhoto;
//
//                recordModel.hospitalAddress = model.hospitalAddress;
//
//                recordModel.contactNumber = model.contactNumber;
//                recordModel.choiceDepartments = model.choiceDepartments;
//
//
//                recordModel.medicalInsuranceFlag = model.medicalInsuranceFlag;
//
//                recordModel.introduction = model.introduction;
//
//
//                recordModel.pictures = model.pictures;
//
//                recordModel.medicineType = model.medicineType;
//                recordModel.governmentalHospitalFlag = model.governmentalHospitalFlag;
                
                
                
                [self.hospitalArray addObject:model];
                
            }
            
            if (((NSArray *)response[@"data"][@"hospitalList"]).count > 0) {
               
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


- (void)setupNavigationBar {
    
    //    [self hideLeftButton];
    //
    //    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, Height_NavBar - Height_StatusBar)];
    //    navigationView.backgroundColor = [UIColor clearColor];
    //    [self.navigationController.navigationBar addSubview:navigationView];
    //
    //    self.navigationView = navigationView;
    //
    //    UITextField *searchTextField = [[UITextField alloc] init];
    //    searchTextField.backgroundColor = [UIColor whiteColor];
    //    searchTextField.layer.cornerRadius = 17.5;
    //    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    //
    //    searchTextField.font = H14;
    //    searchTextField.textColor = kDefaultBlackTextColor;
    //    searchTextField.returnKeyType = UIReturnKeySearch;
    //    [navigationView addSubview:searchTextField];
    //
    //    UIImageView *searchIconImageView = [[UIImageView alloc] init];
    //    searchIconImageView.contentMode = UIViewContentModeCenter;
    //    searchIconImageView.image = [UIImage imageNamed:@"home_search"];
    //    searchIconImageView.size = CGSizeMake(35, 35);
    ////    searchIconImageView.size = CGSizeMake(Height_NavBar - Height_StatusBar - 10, Height_NavBar - Height_StatusBar - 10);
    //    searchIconImageView.userInteractionEnabled = true;
    //
    //    UITapGestureRecognizer *searchGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSearchShowAction)];
    //    [searchIconImageView addGestureRecognizer:searchGR];
    //
    //    searchTextField.leftView = searchIconImageView;
    //    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    //
    //
    //    searchTextField.frame = CGRectMake( SCREENWIDTH - 30 - 16 , 4.5, 25, 35);
    //
    //    [searchTextField addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventEditingDidEndOnExit];
    //
    //
    //
    //    self.searchTextField = searchTextField;
    //
    //
    //    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    //    backBtn.showsTouchWhenHighlighted = NO;
    ////    backBtn.backgroundColor = kDefaultBlueColor;
    //    [backBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    //    [backBtn addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    //    [navigationView addSubview:backBtn];
    
    
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, Height_NavBar - Height_StatusBar)];
    navigationView.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar addSubview:navigationView];
    
    
    self.navigationView = navigationView;
    
    UITextField *searchTextField = [[UITextField alloc] init];
    searchTextField.backgroundColor = [UIColor whiteColor];
    searchTextField.layer.cornerRadius = 17.5;
    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchTextField.placeholder = @"搜索医院名称";
    searchTextField.font = H14;
    searchTextField.textColor = kDefaultBlackTextColor;
    searchTextField.returnKeyType = UIReturnKeySearch;
    searchTextField.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    searchTextField.layer.shadowOffset = CGSizeMake(0,2);
    searchTextField.layer.shadowOpacity = 1;
    searchTextField.layer.shadowRadius = 4;
    
    if (!kiOS10Later) {
        searchTextField.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.11];
    }
    
    searchTextField.text = ISNIL(self.searchKey);
    [navigationView addSubview:searchTextField];
    
    UIImageView *searchIconImageView = [[UIImageView alloc] init];
    searchIconImageView.contentMode = UIViewContentModeCenter;
    searchIconImageView.image = [UIImage imageNamed:@"home_search"];
    searchIconImageView.size = CGSizeMake(35, 35);
    //    searchIconImageView.size = CGSizeMake(Height_NavBar - Height_StatusBar - 10, Height_NavBar - Height_StatusBar - 10);
    
    searchTextField.leftView = searchIconImageView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(56);
        make.height.mas_equalTo(35);
        make.centerY.mas_equalTo(navigationView);
        make.right.mas_equalTo(-64);
    }];
    [searchTextField addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    
    self.searchTextField = searchTextField;
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    searchButton.titleLabel.font = H16;
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:searchButton];
    
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(searchTextField.mas_right);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    backBtn.showsTouchWhenHighlighted = NO;
    [backBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:backBtn];
    
    
}

- (void)clickSearchShowAction {
    
    self.searchTextField.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    self.searchTextField.layer.shadowOffset = CGSizeMake(0,2);
    self.searchTextField.layer.shadowOpacity = 1;
    self.searchTextField.layer.shadowRadius = 4;
    
    [UIView animateWithDuration:1 animations:^{
        
        self.searchTextField.width = SCREENWIDTH - 120;
        self.searchTextField.mj_x = 60;
        
        //        [self.searchTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        //            make.width.mas_equalTo(SCREENWIDTH - 110);
        //        }];
        
    }];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.searchTextField.text = ISNIL(self.searchKey);
        self.searchTextField.placeholder = @"请输入医院名称";
    });
    
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

- (void)clickSearchAction {
    
    if (self.searchTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您要搜索的内容"];
        return;
    }
    
    if ([NSString isEmpty:self.searchTextField.text] || [NSString stringContainsEmoji:self.searchTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的搜索内容"];
        return;
    }
    
    [self.searchTextField resignFirstResponder];
    
    self.searchKey = ISNIL(self.searchTextField.text);
    
    if (self.hospitalArray.count) {
        [self.tableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:false];
    }
    
    [self refreshData];
    
    [self clickNoneView];
    
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
    
    return 180;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.hospitalHeaderView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    GHCommentHospitalRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHCommentHospitalRecordTableViewCell"];
    
    if (!cell) {
        cell = [[GHCommentHospitalRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHCommentHospitalRecordTableViewCell"];
    }
    
    cell.model = [self.hospitalArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    GHSearchHospitalModel *model = [self.hospitalArray objectOrNilAtIndex:indexPath.row];
    
////    GHSearchHospitalModel *hospitalModel = [[GHSearchHospitalModel alloc] initWithDictionary:[model toDictionary] error:nil];
//    hospitalModel.modelId = model.modelId;
//    
//    GHHospitalDetailViewController *vc = [[GHHospitalDetailViewController alloc] init];
//    vc.model = hospitalModel;
//    [self.navigationController pushViewController:vc animated:true];
    GHNewHospitalViewController *hospital = [[GHNewHospitalViewController alloc]init];
    hospital.hospitalID = model.modelId;
    [self.navigationController pushViewController:hospital animated:YES];
    
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


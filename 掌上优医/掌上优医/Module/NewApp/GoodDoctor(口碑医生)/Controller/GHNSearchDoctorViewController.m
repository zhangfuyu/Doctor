//
//  GHNSearchDoctorViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/18.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNSearchDoctorViewController.h"


#import "GHGoodDoctorDepartmentTableViewCell.h"
#import "GHSicknessDoctorListViewController.h"
#import "GHSearchResultDoctorViewController.h"
#import "GHDepartmentModel.h"
#import "GHDepartmentChildrenTableViewCell.h"
#import "GHSearchDoctorModel.h"

#import "GHNChooseTitleView.h"

#import "GHNSearchHotViewController.h"
#import "GHSearchSicknessModel.h"

#import "GHNDiseaseRecommendDoctorViewController.h"

#import "GHNewDepartMentModel.h"

/*************change by  zhangfuyu ********/
#import "GHSecondDepartModel.h"
/******************************************/

@interface GHNSearchDoctorViewController ()<GHNChooseTitleViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) GHNChooseTitleView *titleView;

@property (nonatomic, strong) UIView *searchView;

@property (nonatomic, strong) UITextField *searchTextField;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) NSUInteger sicknessCurrentPage;
@property (nonatomic, assign) NSUInteger sicknessTotalPage;
@property (nonatomic, assign) NSUInteger pageSize;

@property (nonatomic, strong) NSArray *sicknessColorArray;
@property (nonatomic, strong) NSMutableArray *sicknessArray;
@property (nonatomic, strong) UITableView *sicknessTableView;

@property (nonatomic, strong) NSMutableArray *departmentArray;
@property (nonatomic, strong) UITableView *departmentTableView;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *sicknessRealArray;

@end

@implementation GHNSearchDoctorViewController

- (NSMutableArray *)sicknessRealArray {
    
    if (!_sicknessRealArray) {
        _sicknessRealArray = [[NSMutableArray alloc] init];
    }
    return _sicknessRealArray;
    
}

- (NSMutableArray *)sicknessArray {
    
    if (!_sicknessArray) {
        _sicknessArray = [[NSMutableArray alloc] init];
    }
    return _sicknessArray;
    
}



- (NSMutableArray *)departmentArray {
    
    if (!_departmentArray) {
        _departmentArray = [[NSMutableArray alloc] init];
    }
    return _departmentArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"找医生";
    
    self.sicknessColorArray = @[UIColorHex(0x6A70FD),
                                UIColorHex(0xFEAE05),
                                UIColorHex(0xFF6188),
                                UIColorHex(0x51D9E0),
                                
                                UIColorHex(0xFEAE05),
                                UIColorHex(0xFF6188),
                                UIColorHex(0xFEAE05),
                                UIColorHex(0x6A70FD),
                                
                                UIColorHex(0x51D9E0),
                                UIColorHex(0xFF6188),
                                UIColorHex(0xFEAE05),
                                UIColorHex(0x6A70FD),
                                
                                UIColorHex(0xFF6188),
                                UIColorHex(0xFEAE05)
                                ];
    
    [self setupSearchView];
    
    [self setupUI];
    
    [self setupConfig];
    [self requestData];
    
    [self getDataAction];
    
    
    // Do any additional setup after loading the view.
}

- (void)setupConfig{
    
    self.pageSize = 20;
    self.sicknessTotalPage = 1;
    self.sicknessCurrentPage = 1;
    
}

//- (void)refreshData{
//    
//    self.sicknessCurrentPage = 1;
//    self.sicknessTotalPage = 1;
//    
//    [self requestData];
//    
//}
//
//- (void)getMoreData{
//    
//    self.sicknessCurrentPage ++;
//    
//    [self requestData];
//    
//}

- (void)requestData {
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"pageSize"] = @(self.pageSize);
    params[@"page"] = @(self.sicknessCurrentPage);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiCommondisease withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.sicknessTableView.mj_header endRefreshing];
        [self.sicknessTableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            if (self.sicknessCurrentPage == 1) {
                
                [self.sicknessArray removeAllObjects];
                
            }
            
            for (NSDictionary *dicInfo in response[@"data"][@"commonDiseaseList"]) {
                
                GHSecondDepartModel *model = [[GHSecondDepartModel alloc] initWithDictionary:dicInfo error:nil];
                
                if (model == nil) {
                    continue;
                }
                
//                if ([dicInfo[@"diseaseId"] longValue]) {
//                    model.modelid = dicInfo[@"diseaseId"];
//                }
//
                [self.sicknessArray addObject:model];
                
            }
            
            if (((NSArray *)response[@"data"][@"commonDiseaseList"]).count > 0) {
            } else {
                self.sicknessCurrentPage --;
                [self.sicknessTableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [self.sicknessTableView reloadData];
            
            if (self.sicknessArray.count == 0) {
                [self loadingEmptyView];
            }else{
                [self hideEmptyView];
            }
            
        }
        
    }];
    
}


- (void)getDataAction {
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSystemparamDepartments withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            

            
            for (NSDictionary *info in response[@"data"][@"departmentList"]) {
                
                GHNewDepartMentModel *model = [[GHNewDepartMentModel alloc]initWithDictionary:(NSDictionary *)info[@"firstDepartment"] error:nil];
                
                NSArray *secondDepartmentList = info[@"secondDepartmentList"];
                
                for (NSInteger index = 0; index < secondDepartmentList.count; index ++) {
                    
                    NSDictionary *secondDic = [secondDepartmentList objectAtIndex:index];
                    
                    GHNewDepartMentModel *second = [[GHNewDepartMentModel alloc]initWithDictionary:secondDic error:nil];
                    [model.secondDepartmentList addObject:second];
                }
                
                [self.departmentArray addObject:model];
                
            }
            
            
          
            
            if (self.departmentArray.count == 0) {
                [self loadingEmptyView];
            }else{
                [self hideEmptyView];
            }
                

            
            [self.departmentTableView reloadData];
            
        }
        
    }];
    
}

- (void)setupSearchView {
    
    UIView *searchView = [[UIView alloc] init];
    searchView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searchView];
    
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(68 + 44);
    }];
    
    self.searchView = searchView;
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.titleLabel.font = H14;
    [searchButton setTitle:@"  请输入医生姓名" forState:UIControlStateNormal];
    [searchButton setTitleColor:UIColorHex(0x999999) forState:UIControlStateNormal];
    [searchButton setImage:[UIImage imageNamed:@"home_search"] forState:UIControlStateNormal];
    searchButton.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    searchButton.layer.shadowOffset = CGSizeMake(0,2);
    searchButton.layer.shadowOpacity = 1;
    searchButton.layer.shadowRadius = 4;
    searchButton.backgroundColor = [UIColor whiteColor];
    searchButton.layer.cornerRadius = 17.5;
    
    
    [searchView addSubview:searchButton];
    
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(60);
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(7);
        make.right.mas_equalTo(-60);

        
    }];
    
    if (!kiOS10Later) {
        searchButton.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.11];
    }
    
    [searchButton addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultGaryViewColor;
    [searchView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(58);
    }];
    
    NSArray *titleArray = @[@"常见疾病", @"全部科室"];
    
    GHNChooseTitleView *titleView = [[GHNChooseTitleView alloc] initWithTitleArray:titleArray];
    titleView.delegate = self;
    [searchView addSubview:titleView];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *lineLabel2 = [[UILabel alloc] init];
    lineLabel2.backgroundColor = kDefaultGaryViewColor;
    [searchView addSubview:lineLabel2];
    
    [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
    
    
}

- (void)clickSearchAction {
    
    GHNSearchHotViewController *vc = [[GHNSearchHotViewController alloc] init];
    
    vc.type = GHNSearchHotType_Doctor;
    
    [self.navigationController pushViewController:vc animated:false];
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self setupNavigationStyle:GHNavigationBarStyleWhite];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    //    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setShadowImage:nil];
    
    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
}


- (void)setupUI {
    
    NSArray *titleArray = @[@"常见疾病", @"全部科室"];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(SCREENWIDTH * titleArray.count, SCREENHEIGHT - Height_NavBar - 112 + kBottomSafeSpace);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.frame = CGRectMake(0, 112, SCREENWIDTH, SCREENHEIGHT - Height_NavBar - 112 + kBottomSafeSpace);
    scrollView.delegate = self;
    scrollView.scrollEnabled = false;
    [self.view addSubview:scrollView];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tag = index;
        tableView.backgroundColor = kDefaultGaryViewColor;
        tableView.frame = CGRectMake(SCREENWIDTH * index, 0, SCREENWIDTH, scrollView.contentSize.height);
#ifdef __IPHONE_11_0

        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
#endif

        [scrollView addSubview:tableView];
        
        if (index == 0) {
            self.sicknessTableView = tableView;
//            tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
            
        } else if (index == 1) {
            self.departmentTableView = tableView;
        }
        
    }
   
    self.scrollView = scrollView;
    
    //    UITableView *tableView = [[UITableView alloc] init];
    //
    //    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    tableView.delegate = self;
    //    tableView.dataSource = self;
    //
    //    tableView.estimatedRowHeight = 0;
    //    tableView.estimatedSectionHeaderHeight = 0;
    //    tableView.estimatedSectionFooterHeight = 0;
    //
    //    [self.view addSubview:tableView];
    //
    //    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.mas_equalTo(0);
    //        make.top.mas_equalTo(self.searchView.mas_bottom);
    //        make.bottom.mas_equalTo(kBottomSafeSpace);
    //    }];
    //    self.tableView = tableView;
    
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == self.sicknessTableView) {
        return 1;
    } else {
        return self.departmentArray.count;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.sicknessTableView) {
        return self.sicknessArray.count;
    } else {
        GHNewDepartMentModel *model = [self.departmentArray objectOrNilAtIndex:section];
        return [model.isOpen integerValue] + 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.sicknessTableView) {
        return 52;
    } else {
        
        if (indexPath.row == 0) {
            return 52;
        } else {
            GHNewDepartMentModel *model = [self.departmentArray objectOrNilAtIndex:indexPath.section];
            return ceil(model.secondDepartmentList.count / 3.f) * 50 - 10 + 40;
        }
        

    }
    
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.sicknessTableView) {
        
        GHGoodDoctorDepartmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHGoodDoctorSicknessTableViewCell"];
        
        if (!cell) {
            cell = [[GHGoodDoctorDepartmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHGoodDoctorSicknessTableViewCell"];
        }
        
        cell.numberLabel.hidden = false;
        cell.iconImageView.hidden = true;
        
        cell.numberLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
        
        if (indexPath.row >= 99) {
            cell.numberLabel.font = H12;
        } else {
            cell.numberLabel.font = H16;
        }
        
        GHSecondDepartModel *model = [self.sicknessArray objectOrNilAtIndex:indexPath.row];
        
        cell.titleLabel.text = ISNIL(model.commonName);
        
        cell.numberLabel.backgroundColor = [self.sicknessColorArray objectOrNilAtIndex:indexPath.row % self.sicknessColorArray.count];
        
        return cell;
        
    } else {
        
        if (indexPath.row == 0) {
            
            GHGoodDoctorDepartmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHGoodDoctorDepartmentTableViewCell"];
            
            if (!cell) {
                cell = [[GHGoodDoctorDepartmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHGoodDoctorDepartmentTableViewCell"];
            }
            
            cell.model = [self.departmentArray objectOrNilAtIndex:indexPath.section];
            
            return cell;
            
        } else {
            
            GHDepartmentChildrenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHDepartmentChildrenTableViewCell"];
            
            if (!cell) {
                cell = [[GHDepartmentChildrenTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHDepartmentChildrenTableViewCell"];
            }
            
            GHNewDepartMentModel *model = [self.departmentArray objectOrNilAtIndex:indexPath.section];
            
            cell.childrenArray = [model.secondDepartmentList copy];
            
            return cell;
            
        }
        
    }
    
    
}

/**
 每当点击顶部按钮便刷新列表
 
 @param tag <#tag description#>
 */
- (void)clickButtonWithTag:(NSInteger)tag {
    
    [self.scrollView setContentOffset:CGPointMake(SCREENWIDTH * tag, 0) animated:NO];
    
    [self.searchTextField resignFirstResponder];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView == self.sicknessTableView) {
        
        [MobClick event:@"Search_Doctor_Disease"];
        
//        GHNDiseaseRecommendDoctorViewController *vc = [[GHNDiseaseRecommendDoctorViewController alloc] init];
//
//        GHSearchSicknessModel *model = [self.sicknessArray objectOrNilAtIndex:indexPath.row];
//
//        vc.sicknessName = ISNIL(model.diseaseName);
//        vc.sicknessId = model.modelId;
//        [self.navigationController pushViewController:vc animated:true];
        
        GHSecondDepartModel *model = [self.sicknessArray objectOrNilAtIndex:indexPath.row];
        GHSicknessDoctorListViewController *vc = [[GHSicknessDoctorListViewController alloc] init];
        vc.sicknessName = ISNIL(model.diseaseName);
        vc.sicknessTitleName = ISNIL(model.commonName);
        vc.wordsType = @"1";
        [self.navigationController pushViewController:vc animated:true];
        
    } else {
        
        
        
        if (indexPath.row == 0) {

            for (NSInteger index = 0; index < self.departmentArray.count; index++) {

                GHDepartmentModel *model = [self.departmentArray objectOrNilAtIndex:index];

                if (index == indexPath.section) {
                    continue;
                }

                model.isOpen = @(false);

            }

            [self.departmentTableView reloadData];

            GHNewDepartMentModel *model = [self.departmentArray objectOrNilAtIndex:indexPath.section];

//                GHSicknessDoctorListViewController *vc = [[GHSicknessDoctorListViewController alloc] init];
//                vc.departmentName = ISNIL(model.departmentName);
//                vc.departmentModel = model;
//                [self.navigationController pushViewController:vc animated:true];
            if (model.secondDepartmentList > 0) {

                model.isOpen = [NSNumber numberWithBool:![model.isOpen boolValue]];


                [self.departmentTableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];

//                [self.departmentTableView scrollToRow:0 inSection:indexPath.section atScrollPosition:UITableViewScrollPositionTop animated:false];
                
                
            } else {

//                    GHDepartmentModel *model = [self.departmentArray objectOrNilAtIndex:indexPath.row];

                [MobClick event:@"Search_Doctor_Department"];

                GHSicknessDoctorListViewController *vc = [[GHSicknessDoctorListViewController alloc] init];
                vc.departmentName = ISNIL(model.departmentName);
                vc.departmentModel = model;
                [self.navigationController pushViewController:vc animated:true];


            }


        }
        
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


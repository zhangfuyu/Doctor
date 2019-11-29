//
//  GHNDiseaseListViewController.m
//  掌上优医
//
//  Created by GH on 2019/4/4.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNDiseaseListViewController.h"

#import "GHDepartmentModel.h"

#import "GHNDiseaseSecondDepartmentTableViewCell.h"
#import "GHNDiseaseFirstDepartmentTableViewCell.h"

#import "GHNSearchHotViewController.h"

#import "GHNDiseaseTitleTableViewCell.h"

#import "GHSearchSicknessModel.h"
#import "GHNDiseaseDetailViewController.h"

#import "GHSearchViewController.h"
#import "GHNewDepartMentModel.h"
#import "GHSecondDepartModel.h"

#import "GHNewDiseaseDetailViewController.h"

@interface GHNDiseaseListViewController ()<UITableViewDelegate, UITableViewDataSource>

/**
 科室列表
 */
@property (nonatomic, strong) UITableView *departmentTableView;

@property (nonatomic , strong) NSIndexPath *selectIndexPath;
/**
 疾病列表
 */
@property (nonatomic, strong) UITableView *sicknessTableView;

@property (nonatomic, strong) NSMutableArray *departmentArray;

@property (nonatomic, strong) NSMutableArray *sicknessArray;

@property (nonatomic, assign) NSUInteger totalPage;

@property (nonatomic, assign) NSUInteger currentPage;

@property (nonatomic, assign) NSUInteger pageSize;

@end

@implementation GHNDiseaseListViewController

- (NSMutableArray *)departmentArray {
    
    if (!_departmentArray) {
        _departmentArray = [[NSMutableArray alloc] init];
    }
    return _departmentArray;
    
}

- (NSMutableArray *)sicknessArray {
    
    if (!_sicknessArray) {
        _sicknessArray = [[NSMutableArray alloc] init];
    }
    return _sicknessArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"查疾病";
    
    [self setupUI];
    
    [self setupConfig];
    
    [self requestDepartmentDataAction];
}

- (void)setupUI {
    
    [self setupSearchTextField];
    
    UITableView *departmentTableView = [[UITableView alloc] init];
    departmentTableView.delegate = self;
    departmentTableView.dataSource = self;
    departmentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    departmentTableView.backgroundColor = kDefaultGaryViewColor;
#ifdef __IPHONE_11_0
    
    departmentTableView.estimatedRowHeight = 0;
    departmentTableView.estimatedSectionHeaderHeight = 0;
    departmentTableView.estimatedSectionFooterHeight = 0;
#endif
    [self.view addSubview:departmentTableView];
    
    [departmentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREENWIDTH / 2.f);
        make.top.mas_equalTo(70);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    self.departmentTableView = departmentTableView;
    
    
    UITableView *sicknessTableView = [[UITableView alloc] init];
    sicknessTableView.delegate = self;
    sicknessTableView.dataSource = self;
    sicknessTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    sicknessTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sicknessTableView];
    
    [sicknessTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(SCREENWIDTH / 2.f);
        make.top.mas_equalTo(70);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    self.sicknessTableView = sicknessTableView;
    
//    sicknessTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
//    MJRefreshBackNormalFooter
    sicknessTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = UIColorHex(0xEFEFEF);
    [self.view addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(70);
        make.bottom.mas_equalTo(kBottomSafeSpace);
        make.left.mas_equalTo(SCREENWIDTH / 2.f - 0.5);
    }];

    
}


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
        
        if ([model.isOpen integerValue] == true) {
            return [model.secondDepartmentList count] + 1;
        } else {
            return 1;
        }
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.sicknessTableView) {
        GHSecondDepartModel *model = [self.sicknessArray objectOrNilAtIndex:indexPath.row];
        return [model.shouldHeight floatValue];
    } else {
        
        if (indexPath.row == 0) {
            return 50;
        } else {
            return 36;
        }

    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.sicknessTableView) {
        
        GHNDiseaseTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNDiseaseTitleTableViewCell"];
        
        if (!cell) {
            cell = [[GHNDiseaseTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNDiseaseTitleTableViewCell"];
        }
        
        GHSecondDepartModel *model = [self.sicknessArray objectOrNilAtIndex:indexPath.row];
        
        if (self.selectIndexPath.section == 0) {
            cell.titleLabel.text = ISNIL(model.commonName);

        }
        else
        {
            cell.titleLabel.text = ISNIL(model.diseaseName);

        }
        
        
        return cell;
        
    } else {
        
        if (indexPath.row == 0) {
            
            GHNDiseaseFirstDepartmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNDiseaseFirstDepartmentTableViewCell"];
            
            if (!cell) {
                cell = [[GHNDiseaseFirstDepartmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNDiseaseFirstDepartmentTableViewCell"];
            }
            
            GHNewDepartMentModel *model = [self.departmentArray objectOrNilAtIndex:indexPath.section];
            
            cell.model = model;
            
            return cell;
            
        } else {
            
            GHNDiseaseSecondDepartmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNDiseaseSecondDepartmentTableViewCell"];
            
            if (!cell) {
                cell = [[GHNDiseaseSecondDepartmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNDiseaseSecondDepartmentTableViewCell"];
            }
            
            GHNewDepartMentModel *model = [self.departmentArray objectOrNilAtIndex:indexPath.section];
            
            GHNewDepartMentModel *secondModel = [model.secondDepartmentList objectOrNilAtIndex:indexPath.row - 1];
            
            cell.model = secondModel;
            
            return cell;
            
        }
        
    }
    
    return [UITableViewCell new];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView == self.sicknessTableView) {

        GHSecondDepartModel *model = [self.sicknessArray objectOrNilAtIndex:indexPath.row];
//        GHNewDiseaseDetailViewController *vc = [[GHNewDiseaseDetailViewController alloc] init];
//        GHSearchSicknessModel *model = [self.sicknessArray objectOrNilAtIndex:indexPath.row];
//        vc.sicknessId = ISNIL(model.modelId);
//        vc.sicknessName = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.diseaseName)];
//        vc.departmentName = ISNIL(model.firstDepartmentName);
//        vc.symptom = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.symptom)];
//        [self.navigationController pushViewController:vc animated:true];
        
        GHNewDiseaseDetailViewController *disease = [[GHNewDiseaseDetailViewController alloc]init];
        
//        disease.sicknessId = self.selectIndexPath.section == 0? model.diseaseName : model.commonName;
        disease.sicknessId = model.diseaseName;
        disease.selectType = 1;
        [self.navigationController pushViewController:disease animated:YES];
        
    } else {
        
        self.selectIndexPath = indexPath;
        
        if (indexPath.row == 0) {
            
            for (NSInteger index = 0; index < self.departmentArray.count; index++) {
                
                GHDepartmentModel *model = [self.departmentArray objectOrNilAtIndex:index];
                
                if (index == indexPath.section) {
                    continue;
                }
                
                model.isOpen = @(false);
                
                model.isSelected = @(false);
                
            }
            
            [self.departmentTableView reloadData];
            
            GHNewDepartMentModel *model = [self.departmentArray objectOrNilAtIndex:indexPath.section];
            
//            model.isOpen = @(true);
//
//            model.isSelected = @(true);
            
            model.isOpen = [NSNumber numberWithBool:![model.isOpen boolValue]];
            
            model.isSelected = [NSNumber numberWithBool:![model.isSelected boolValue]];

            
            if (model.secondDepartmentList.count > 0) {
                
//                model.isOpen = [NSNumber numberWithBool:![model.isOpen boolValue]];
//
//                model.isSelected = [NSNumber numberWithBool:![model.isSelected boolValue]];
                
                [self.departmentTableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
                
            } else {
                
                
//                model.isOpen = [NSNumber numberWithBool:![model.isOpen boolValue]];
//
//                model.isSelected = [NSNumber numberWithBool:![model.isSelected boolValue]];
                
                [self.departmentTableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
                
                [self refreshData];
                
            }
            
            [self.departmentTableView scrollToRow:0 inSection:indexPath.section atScrollPosition:UITableViewScrollPositionTop animated:false];
            [self refreshData];

            
            
        } else {
            
            
            for (NSInteger index = 0; index < self.departmentArray.count; index++) {
                
                GHNewDepartMentModel *firstModel = [self.departmentArray objectOrNilAtIndex:index];
                
                for (GHNewDepartMentModel *secondModel in firstModel.secondDepartmentList) {
                    
                    secondModel.isSelected = @(false);
                    
                }
                
            }
            
            
            GHNewDepartMentModel *model = [self.departmentArray objectOrNilAtIndex:indexPath.section];
            
            for (GHDepartmentModel *secondModel in model.secondDepartmentList) {
                
                secondModel.isSelected = @(false);
                
            }
            
            GHNewDepartMentModel *secondModel = [model.secondDepartmentList objectOrNilAtIndex:indexPath.row - 1];
            
            secondModel.isSelected = @(true);
            
            [self.departmentTableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
            
            [self.sicknessArray removeAllObjects];
            [self.sicknessTableView reloadData];
            
            [self refreshData];
            
        }
        
    }
    
}


- (void)setupSearchTextField {
    
    UIView *searchTextView = [[UIView alloc] init];
    searchTextView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searchTextView];
    
    [searchTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(70);
    }];

    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.titleLabel.font = H14;
    [searchButton setTitle:@"  搜索疾病、医生、医院、资讯" forState:UIControlStateNormal];
    [searchButton setTitleColor:UIColorHex(0x999999) forState:UIControlStateNormal];
    [searchButton setImage:[UIImage imageNamed:@"home_search"] forState:UIControlStateNormal];
    searchButton.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    searchButton.layer.shadowOffset = CGSizeMake(0,2);
    searchButton.layer.shadowOpacity = 1;
    searchButton.layer.shadowRadius = 4;
    searchButton.backgroundColor = [UIColor whiteColor];
    searchButton.layer.cornerRadius = 17.5;


    [searchTextView addSubview:searchButton];
    
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(60);
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(8);
        make.right.mas_equalTo(-60);

    }];
    
    if (!kiOS10Later) {
        searchButton.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.11];
    }
    
    [searchButton addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventTouchUpInside];

    
    UILabel *lineLabel1 = [[UILabel alloc] init];
    lineLabel1.backgroundColor = kDefaultGaryViewColor;
    [searchTextView addSubview:lineLabel1];
    
    [lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *lineLabel2 = [[UILabel alloc] init];
    lineLabel2.backgroundColor = kDefaultGaryViewColor;
    [searchTextView addSubview:lineLabel2];
    
    [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
}

- (void)clickSearchAction {
    
    
    [MobClick event:@"Home_Search"];
    
    GHSearchViewController *vc = [[GHSearchViewController alloc] init];
    [self.navigationController pushViewController:vc animated:false];
    
    
    
//    GHNSearchHotViewController *vc = [[GHNSearchHotViewController alloc] init];
//
//    vc.type = GHNSearchHotType_Disease;
//
//    [self.navigationController pushViewController:vc animated:false];
    
}

- (void)setupConfig {
    self.currentPage = 0;
    self.totalPage = 1;
    self.pageSize = 20;
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

- (void)requestDepartmentDataAction {
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSystemparamDepartments withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            NSMutableArray *firstDepartmentArray = [[NSMutableArray alloc] init];
            
            
            for (NSDictionary *info in response[@"data"][@"departmentList"]) {
                
                
                NSDictionary *firstDepartment = info[@"firstDepartment"];
                
                GHNewDepartMentModel *model = [[GHNewDepartMentModel alloc] initWithDictionary:firstDepartment error:nil];
                
                NSArray *secondDepartmentList = info[@"secondDepartmentList"];
                for (NSDictionary *dic in secondDepartmentList) {
                    GHNewDepartMentModel *secondModel = [[GHNewDepartMentModel alloc] initWithDictionary:dic error:nil];
                    [model.secondDepartmentList addObject:secondModel];

                }
                
                [firstDepartmentArray addObject:model];
            }
    
            
            GHNewDepartMentModel *model = [[GHNewDepartMentModel alloc] init];
            model.modelid = @"0";
            model.departmentName = @"常见疾病";
            model.level = @"1";
            model.isOpen = @(false);
            
            [firstDepartmentArray insertObject:model atIndex:0];
            
            self.departmentArray = [firstDepartmentArray mutableCopy];
            
            [self.departmentTableView reloadData];
            
            [self tableView:self.departmentTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        }
    }];
    
}

- (void)requsetData {
    
    
    
    if (self.currentPage > self.totalPage) {
        [self.sicknessTableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
//    params[@"pageSize"] = @(self.pageSize);
//    params[@"from"] = @(self.currentPage);
    
    NSUInteger departmentId = 0;
    
    for (NSInteger index = 0; index < self.departmentArray.count; index++) {
        
        GHNewDepartMentModel *model = [self.departmentArray objectOrNilAtIndex:index];
        
        if ([model.isSelected boolValue] == true) {
            
            departmentId = [model.modelid longValue];
            
            if (departmentId == 0) {
                break;
            } else {
                
                for (GHNewDepartMentModel *secondDepartmentModel in model.secondDepartmentList) {
                    
                    if ([secondDepartmentModel.isSelected boolValue] == true) {
                        
                        departmentId = [secondDepartmentModel.modelid longValue];
                        
                        break;
                        
                    }
                    
                }
                
                
                break;
                
            }
            
            
        }
        
    }
    
    NSString *url;
    
    if (departmentId == 0) {
        url = kApiCommondisease;
    } else {
        
        url = kApiDiseasesDepartmentId;
        
        params[@"departmentId"] = @(departmentId);
        
    }
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:url withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.sicknessTableView.mj_header endRefreshing];
        [self.sicknessTableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            if (self.currentPage == 0) {
                
                [self.sicknessArray removeAllObjects];
                
                
                
            }
            
            NSArray *listArry = departmentId == 0 ? response[@"data"][@"commonDiseaseList"] :response[@"data"][@"diseaseDepartmentList"];
            
            for (NSDictionary *dicInfo in listArry) {
                
                GHSecondDepartModel *model = [[GHSecondDepartModel alloc] initWithDictionary:dicInfo error:nil];
                
                if (model == nil) {
                    continue;
                }
            
                
                CGFloat height = [ISNIL(model.commonName) heightForFont:H16 width:(SCREENWIDTH * .5) - 16 - 38];
                
                if (height > 25) {
                    model.shouldHeight = @"73";
                } else {
                    model.shouldHeight = @"50";
                }
                
                [self.sicknessArray addObject:model];
                
            }
            
            if (((NSArray *)response).count >= self.pageSize) {
                self.totalPage = self.sicknessArray.count + 1;
            } else {
                self.totalPage = self.currentPage;
            }
            
            [self.sicknessTableView reloadData];

            
        }
        
    }];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self setupNavigationStyle:GHNavigationBarStyleWhite];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
}

@end

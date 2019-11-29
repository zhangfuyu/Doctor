//
//  GHSicknessLibraryViewController.m
//  掌上优医
//
//  Created by GH on 2018/10/30.
//  Copyright © 2018 GH. All rights reserved.
//
//  疾病库

#import "GHSicknessLibraryViewController.h"

#import "GHSicknessLibraryDepartmentTableViewCell.h"
#import "GHSicknessLibrarySicknessTableViewCell.h"



#import "GHSearchSicknessModel.h"

#import "GHNDiseaseDetailViewController.h"

@interface GHSicknessLibraryViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *departmentTableView;

@property (nonatomic, strong) UITableView *sicknessTableView;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *sicknessArray;

@property (nonatomic, assign) NSUInteger totalPage;

@property (nonatomic, assign) NSUInteger currentPage;

@property (nonatomic, assign) NSUInteger pageSize;

@end

@implementation GHSicknessLibraryViewController

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
    
}

- (NSMutableArray *)sicknessArray {
    
    if (!_sicknessArray) {
        _sicknessArray = [[NSMutableArray alloc] init];
    }
    return _sicknessArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"疾病库";
    // Do any additional setup after loading the view.
    [self setupUI];
    
    [self setupConfig];
    [self requsetData];
    
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

- (void)requsetData {
    
    if (self.currentPage > self.totalPage) {
        [self.sicknessTableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    GHDepartmentModel *departmentModel = [self.dataArray objectOrNilAtIndex:self.selectedIndex];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"departmentId"] = departmentModel.modelId;
    params[@"pageSize"] = @(self.pageSize);
    params[@"from"] = @(self.currentPage);
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDiseasesDepartmentId withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
       
       
        
        [self.sicknessTableView.mj_header endRefreshing];
        [self.sicknessTableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            if (self.currentPage == 0) {
                
                if (self.sicknessArray.count) {
                    [self.sicknessTableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:false];
                }
                
                [self.sicknessArray removeAllObjects];
            }
            
            for (NSDictionary *dicInfo in response) {
                
                GHSearchSicknessModel *model = [[GHSearchSicknessModel alloc] initWithDictionary:dicInfo error:nil];
                
                if (model == nil) {
                    continue;
                }
                
                [self.sicknessArray addObject:model];
                
//                self.totalPage = [dicInfo[@"totalCount"] integerValue];
                
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
    
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
    
    [self setupNavigationStyle:GHNavigationBarStyleWhite];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
}


- (void)setupUI {
 
    UITableView *departmentTableView = [[UITableView alloc] init];
    departmentTableView.separatorStyle = 0;
    departmentTableView.delegate = self;
    departmentTableView.dataSource = self;
    departmentTableView.estimatedRowHeight = 0;
    departmentTableView.estimatedSectionHeaderHeight = 0;
    departmentTableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:departmentTableView];
    
    [departmentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
        make.width.mas_equalTo(110);
    }];
    self.departmentTableView = departmentTableView;
    
    
    UITableView *sicknessTableView = [[UITableView alloc] init];
    sicknessTableView.separatorStyle = 0;
    sicknessTableView.delegate = self;
    sicknessTableView.dataSource = self;
    sicknessTableView.estimatedRowHeight = 0;
    sicknessTableView.estimatedSectionHeaderHeight = 0;
    sicknessTableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:sicknessTableView];
    
    [sicknessTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
        make.left.mas_equalTo(departmentTableView.mas_right);
    }];
    self.sicknessTableView = sicknessTableView;
    
//    sicknessTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    sicknessTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
    [self tableView:departmentTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]];
    // 设置某项变为选中
    [departmentTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0] animated:YES
                              scrollPosition:UITableViewScrollPositionNone];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.selectedIndex + 4 <= self.dataArray.count) {
            [departmentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex + 3 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:false];
        } else {
            [departmentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:false];
        }
        
        
    });

}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.departmentTableView) {
        return self.dataArray.count;
    } else if (tableView == self.sicknessTableView) {
        return self.sicknessArray.count;
    }
    
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.departmentTableView) {
        return 76;
    } else if (tableView == self.sicknessTableView) {
        return 50;
    }
    
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.departmentTableView) {
        
        GHSicknessLibraryDepartmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHSicknessLibraryDepartmentTableViewCell"];
        
        if (!cell) {
            
            cell = [[GHSicknessLibraryDepartmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHSicknessLibraryDepartmentTableViewCell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
            cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];

        }
        
        cell.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
        
        return cell;
        
    } else if (tableView == self.sicknessTableView) {
        
        GHSicknessLibrarySicknessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHSicknessLibrarySicknessTableViewCell"];
        
        if (!cell) {
            
            cell = [[GHSicknessLibrarySicknessTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHSicknessLibrarySicknessTableViewCell"];
            
        }
        
        cell.model = [self.sicknessArray objectOrNilAtIndex:indexPath.row];

        return cell;
        
    }
    
    return [[UITableViewCell alloc] init];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.departmentTableView) {
        
        if (indexPath.row == self.selectedIndex) {
            if (self.sicknessArray.count > 0) {
             
                [self.sicknessTableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:false];
                
            }
        } else {
            self.selectedIndex = indexPath.row;
            [self refreshData];
        }
        
    } else if (tableView == self.sicknessTableView) {
        
        GHSearchSicknessModel *model = [self.sicknessArray objectOrNilAtIndex:indexPath.row];
        
        GHNDiseaseDetailViewController *vc = [[GHNDiseaseDetailViewController alloc] init];
        vc.sicknessId = ISNIL(model.modelId);
        vc.sicknessName = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.diseaseName)];
        vc.symptom = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.symptom)];
        vc.departmentName = [NSString stringWithFormat:@"%@", ISNIL(model.secondDepartmentName).length ? model.secondDepartmentName : ISNIL(model.firstDepartmentName)];
        
        [self.navigationController pushViewController:vc animated:true];
        
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

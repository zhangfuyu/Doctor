//
//  GHNInformationListViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/27.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNInformationListViewController.h"
#import "GHArticleInformationTableViewCell.h"
#import "GHInformationDetailViewController.h"
#import "GHNSearchInformationViewController.h"

#import "GHNSearchHotViewController.h"

@interface GHNInformationListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *navigationView;

@property (nonatomic, strong) UITextField *searchTextField;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSUInteger totalPage;

@property (nonatomic, assign) NSUInteger currentPage;

@property (nonatomic, assign) NSUInteger pageSize;

@end

@implementation GHNInformationListViewController



- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupUI];
    
    [self setupConfig];
    [self requsetData];
    // Do any additional setup after loading the view.
}

- (void)setupConfig {
    self.currentPage = 0;
    self.totalPage = 1;
    self.pageSize = 10;
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
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"pageSize"] = @(self.pageSize);
    params[@"from"] = @(self.currentPage);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiInfoNews withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            if (self.currentPage == 0) {
                
                [self.dataArray removeAllObjects];
                
            }
            
            for (NSDictionary *dicInfo in response) {
                
                GHArticleInformationModel *model = [[GHArticleInformationModel alloc] initWithDictionary:dicInfo error:nil];
                
                if (model == nil) {
                    continue;
                }
                
                [self.dataArray addObject:model];
                
//                self.totalPage = [dicInfo[@"totalCount"] integerValue];
                
            }
            
            if (((NSArray *)response).count >= self.pageSize) {
                self.totalPage = self.dataArray.count + 1;
            } else {
                self.totalPage = self.currentPage;
            }
            
            [self.tableView reloadData];
            
            if (self.dataArray.count == 0) {
                [self loadingEmptyView];
            }else{
                [self hideEmptyView];
            }
            
        }
        
    }];
    
}



- (void)setupNavigationBar {
    
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, Height_NavBar - Height_StatusBar)];
    navigationView.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar addSubview:navigationView];
    
    self.navigationView = navigationView;
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.titleLabel.font = H14;
    [searchButton setTitle:@"  请输入资讯标题" forState:UIControlStateNormal];
    [searchButton setTitleColor:UIColorHex(0x999999) forState:UIControlStateNormal];
    [searchButton setImage:[UIImage imageNamed:@"home_search"] forState:UIControlStateNormal];
    searchButton.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    searchButton.layer.shadowOffset = CGSizeMake(0,2);
    searchButton.layer.shadowOpacity = 1;
    searchButton.layer.shadowRadius = 4;
    searchButton.backgroundColor = [UIColor whiteColor];
    searchButton.layer.cornerRadius = 17.5;
    
    
    [navigationView addSubview:searchButton];
    
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(56);
        make.height.mas_equalTo(35);
        make.centerY.mas_equalTo(navigationView);
        make.right.mas_equalTo(-64);

    }];
    
    if (!kiOS10Later) {
        searchButton.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.11];
    }
    
    [searchButton addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventTouchUpInside];
    
//    UITextField *searchTextField = [[UITextField alloc] init];
//    searchTextField.backgroundColor = [UIColor whiteColor];
//    searchTextField.layer.cornerRadius = 17.5;
//    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    searchTextField.placeholder = @"搜索资讯";
//    searchTextField.font = H14;
//    searchTextField.textColor = kDefaultBlackTextColor;
//    searchTextField.returnKeyType = UIReturnKeySearch;
//
//    searchTextField.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
//    searchTextField.layer.shadowOffset = CGSizeMake(0,2);
//    searchTextField.layer.shadowOpacity = 1;
//    searchTextField.layer.shadowRadius = 4;
//
//    if (!kiOS10Later) {
//        searchTextField.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.11];
//    }
//
//    [navigationView addSubview:searchTextField];
//
//    UIImageView *searchIconImageView = [[UIImageView alloc] init];
//    searchIconImageView.contentMode = UIViewContentModeCenter;
//    searchIconImageView.image = [UIImage imageNamed:@"home_search"];
//    searchIconImageView.size = CGSizeMake(35, 35);
////    searchIconImageView.size = CGSizeMake(Height_NavBar - Height_StatusBar - 10, Height_NavBar - Height_StatusBar - 10);
//
//
//    searchTextField.leftView = searchIconImageView;
//    searchTextField.leftViewMode = UITextFieldViewModeAlways;
//
//
//    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(56);
//        make.height.mas_equalTo(35);
//        make.centerY.mas_equalTo(navigationView);
//        make.right.mas_equalTo(-64);
//    }];
//
//    [searchTextField addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    
//    self.searchTextField = searchTextField;
    
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    backBtn.showsTouchWhenHighlighted = NO;
    [backBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:backBtn];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationView.hidden = false;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
    
    self.navigationView.hidden = true;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.searchTextField resignFirstResponder];
    
}

- (void)clickSearchAction {

    GHNSearchHotViewController *vc = [[GHNSearchHotViewController alloc] init];
    
    vc.type = GHNSearchHotType_Information;
    
    [self.navigationController pushViewController:vc animated:false];
    
//    if (self.searchTextField.text.length == 0) {
//        [SVProgressHUD showErrorWithStatus:@"请输入您要搜索的内容"];
//        return;
//    }
//
//    if ([NSString isEmpty:self.searchTextField.text] || [NSString stringContainsEmoji:self.searchTextField.text]) {
//        [SVProgressHUD showErrorWithStatus:@"请输入正确的搜索内容"];
//        return;
//    }
//
//    [self.searchTextField resignFirstResponder];
//
////    self.searchKey = ISNIL(self.searchTextField.text);
//
//    [self.searchTextField resignFirstResponder];
//
//    [MobClick event:@"Search_News_Input"];
//
//    GHNSearchInformationViewController *vc = [[GHNSearchInformationViewController alloc] init];
//    vc.searchKey = ISNIL(self.searchTextField.text);
//    [self.navigationController pushViewController:vc animated:false];
//
//    self.searchTextField.text = @"";

}

- (void)clickCancelAction {
    
    [self.view endEditing:true];
    
    [self.searchTextField resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:true];
    
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 15);
    
    tableView.tableHeaderView = headerView;
    
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 128;
    
}


/**
 @param tableView tableView description
 @param indexPath indexPath description
 @return return value description
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHArticleInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHArticleInformationTableViewCell"];

    if (!cell) {
        cell = [[GHArticleInformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHArticleInformationTableViewCell"];
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }

    cell.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    GHInformationDetailViewController *vc = [[GHInformationDetailViewController alloc] init];
    GHArticleInformationModel *model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    vc.informationId = model.modelId;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:true];
    
    model.visitCount = [NSString stringWithFormat:@"%ld", [model.visitCount integerValue] + 1];
    model.isVisit = [NSNumber numberWithBool:true];
    [tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
    
}



@end

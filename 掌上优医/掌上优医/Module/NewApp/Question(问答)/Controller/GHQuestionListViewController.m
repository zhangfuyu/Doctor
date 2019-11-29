//
//  GHQuestionListViewController.m
//  掌上优医
//
//  Created by GH on 2019/5/27.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHQuestionListViewController.h"
#import "GHQuestionTableViewCell.h"
#import "GHQuestionViewController.h"
#import "GHAnswerListViewController.h"

@interface GHQuestionListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSUInteger totalPage;

@property (nonatomic, assign) NSUInteger currentPage;

@property (nonatomic, assign) NSUInteger pageSize;

@end

@implementation GHQuestionListViewController

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requsetData];

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"问答";
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    [self setupUI];
    
    [self setupConfig];
    
    [self addRightButton:@selector(clickQuestionAction) title:@"提问"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:kNotificationDoctorQuestionSuccess object:nil];
    
}

- (void)clickQuestionAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        GHQuestionViewController *vc = [[GHQuestionViewController alloc] init];
        vc.doctorId = self.doctorId;
        vc.doctorName = self.doctorName;
        [self.navigationController pushViewController:vc animated:true];
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self presentViewController:vc animated:true completion:nil];
        
    }
    
}

- (void)setupConfig {
    self.currentPage = 1;
    self.totalPage = 1;
    self.pageSize = 10;
}

- (void)refreshData{
    self.currentPage = 1;
    self.totalPage = 1;
    [self requsetData];
}

- (void)getMoreData{
    self.currentPage ++;
    [self requsetData];
}

- (void)requsetData {
    
   
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"ownerId"] = self.doctorId;
    params[@"pageSize"] = @(10);
    params[@"page"] = @(1);
    
    params[@"ownerType"] = @(2);

    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiCircleDoctorPosts withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            if (self.currentPage == 1) {
                
                [self.dataArray removeAllObjects];
                
            }
            
            for (NSDictionary *dic in response[@"data"][@"problemList"]) {
                
                GHQuestionModel *model = [[GHQuestionModel alloc] initWithDictionary:dic error:nil];
                
                if (model == nil) {
                    continue;
                }
                [self.dataArray addObject:model];
                
                
                
            }
            
            
            if (((NSArray *)response[@"data"][@"problemList"]).count > 0) {
            } else {
                self.currentPage --;
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


- (void)setupUI {
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.backgroundColor = kDefaultGaryViewColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    self.tableView = tableView;
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 106;
   
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHQuestionTableViewCell"];
    
    if (!cell) {
        
        cell = [[GHQuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHQuestionTableViewCell"];
        
    }
    
    cell.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHAnswerListViewController *vc = [[GHAnswerListViewController alloc] init];
    vc.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:true];
    
}

@end

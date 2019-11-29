//
//  GHNCoinRecordViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/20.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNCoinRecordViewController.h"
#import "GHCoinRecordTableViewCell.h"

@interface GHNCoinRecordViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSUInteger totalPage;

@property (nonatomic, assign) NSUInteger currentPage;

@property (nonatomic, assign) NSUInteger pageSize;

@end

@implementation GHNCoinRecordViewController

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"星医分明细";
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    [self setupUI];
    
    [self setupConfig];
    [self requsetData];
    
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
    
//    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"pageSize"] = @(self.pageSize);
    params[@"from"] = @(self.currentPage);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiFinanceUserpropertyVirtual withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            if (self.currentPage == 0) {
                
                [self.dataArray removeAllObjects];
                
            }
            
            for (NSDictionary *dicInfo in response) {
                
                GHCoinRecordModel *model = [[GHCoinRecordModel alloc] initWithDictionary:dicInfo error:nil];
                
                if (model == nil) {
                    continue;
                }
                
                [self.dataArray addObject:model];
                
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
    
    return 82;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHCoinRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHCoinRecordTableViewCell"];
    
    if (!cell) {
        
        cell = [[GHCoinRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHCoinRecordTableViewCell"];
        
        cell.contentView.backgroundColor = kDefaultGaryViewColor;
        
    }
    
    cell.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
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

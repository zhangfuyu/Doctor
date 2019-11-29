//
//  GHNoticeMessageSystemViewController.m
//  掌上优医
//
//  Created by GH on 2018/11/1.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHNoticeMessageSystemViewController.h"
#import "GHNoticeMessageSystemTableViewCell.h"
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"


@interface GHNoticeMessageSystemViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSUInteger totalPage;

@property (nonatomic, assign) NSUInteger currentPage;

@property (nonatomic, assign) NSUInteger pageSize;

@end

@implementation GHNoticeMessageSystemViewController

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"系统消息";
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
//    [self getDataAction];
    
    
    [self setupUI];
    
    [self setupConfig];
    [self requsetData];
    
    [JPUSHService resetBadge];  // 重置角标
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0]; // APP 清空角标
    
//    if (self.dataArray.count == 0) {
//        [self loadingEmptyView];
//    } else {
//        [self hideEmptyView];
//    }
    // Do any additional setup after loading the view.
}

- (void)setupConfig {
    self.currentPage = 1;
    self.totalPage = 1;
    self.pageSize = 20;
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
    
    if (self.currentPage > self.totalPage) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"pageSize"] = @(self.pageSize);
    params[@"page"] = @(self.currentPage);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiGetPushComment withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];

        if (isSuccess) {
            
            
            if (self.currentPage == 1) {
                
                [self.dataArray removeAllObjects];
                
            }
            
            for (NSDictionary *dicInfo in response[@"data"][@"pushCommentList"]) {
                
                GHNoticeSystemModel *model = [[GHNoticeSystemModel alloc] initWithDictionary:dicInfo error:nil];
                
                if (model == nil) {
                    continue;
                }
                
                [self.dataArray addObject:model];
                
            }
            
            if (((NSArray *)response[@"data"][@"pushCommentList"]).count > 0) {
                
            } else {
                self.currentPage--;
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


//- (void)getDataAction {
//
//    [self.dataArray addObjectsFromArray:[[GHSaveDataTool shareInstance] getSandboxNoticeDataWithType:GHSaveDataType_NoticeSystem]];
//
//}

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
    
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = kDefaultGaryViewColor;
//    view.frame = CGRectMake(0, 0, SCREENWIDTH, 20);
//    tableView.tableHeaderView = view;
    
}


#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    GHNoticeSystemModel *model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    return [self getShouldHeightWithContent:ISNIL(model.content) withFont:H15 withWidth:SCREENWIDTH - 45 - 62 - 24 withLineHeight:21] + 65 + 8 + 24;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    GHNoticeMessageSystemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNoticeMessageSystemTableViewCell"];
    
    if (!cell) {
        
        cell = [[GHNoticeMessageSystemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNoticeMessageSystemTableViewCell"];
        
    }
    
    cell.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
}


- (CGFloat)getShouldHeightWithContent:(NSString *)content withFont:(UIFont *)font withWidth:(CGFloat)width withLineHeight:(CGFloat)lineHeight {
    
    if (ISNIL(content).length == 0) {
        return 0.f;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.maximumLineHeight = lineHeight;
    paragraphStyle.minimumLineHeight = lineHeight;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content];
    
    [attr addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, content.length)];
    [attr addAttributes:@{NSFontAttributeName: font} range:NSMakeRange(0, content.length)];
    
    CGSize size = [attr boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    return size.height;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    
    [self setupNavigationStyle:GHNavigationBarStyleWhite];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
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

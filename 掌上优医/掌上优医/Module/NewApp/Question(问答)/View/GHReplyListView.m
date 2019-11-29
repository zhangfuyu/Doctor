//
//  GHReplyListView.m
//  掌上优医
//
//  Created by GH on 2019/5/28.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHReplyListView.h"
#import "GHReplyTableViewCell.h"
#import "GHReplyHeaderView.h"

@interface GHReplyListView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSUInteger totalPage;

@property (nonatomic, assign) NSUInteger currentPage;

@property (nonatomic, assign) NSUInteger pageSize;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHReplyHeaderView *headerView;

@end

@implementation GHReplyListView

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
    
}

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.backgroundColor = RGBACOLOR(51, 51, 51, 0.2);
    
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 8;
    contentView.layer.masksToBounds = true;
    [self addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(10);
        make.top.mas_equalTo(35);
    }];
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor clearColor];
    [self addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(contentView.mas_top);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = H15;
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.text = @"回复详情";
    [contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(16);
    }];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"icon_reply_detail_close"] forState:UIControlStateNormal];
    [contentView addSubview:closeButton];
    
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(0);
        make.width.height.mas_equalTo(38);
    }];
    [closeButton addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    
    [contentView addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(45);
        make.bottom.mas_equalTo(kBottomSafeSpace - 10);
    }];
    self.tableView = tableView;
    
    [self setupTableHeaderView];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCancelAction)];
    [topView addGestureRecognizer:tapGR];
    
    [self setupConfig];
    
}

- (void)clickCancelAction {
    
    self.hidden = true;
    
}

- (void)setupTableHeaderView {
    
    GHReplyHeaderView *headerView = [[GHReplyHeaderView alloc] init];
    headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 218);
    
    self.headerView = headerView;
    
    self.tableView.tableHeaderView = headerView;
    
}

- (void)setModel:(GHAnswerModel *)model {
    
    _model = model;
    
    self.headerView.model = model;
    
    self.headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 135 + [model.contentHeight floatValue]);
    
    self.dataArray = model.replyArray;
    [self.tableView reloadData];
//    [self refreshData];
    
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
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"pageSize"] = @(self.pageSize);
    params[@"from"] = @(self.currentPage);
    params[@"discussId"] = self.model.modelId;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiCircleDiscussidReply withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            if (self.currentPage == 0) {
                
                [self.dataArray removeAllObjects];
                
            }
            
            for (NSDictionary *dic in response) {
                
                GHReplyModel *model = [[GHReplyModel alloc] initWithDictionary:dic error:nil];
                
                if (model == nil) {
                    continue;
                }
                
                if ([model.authorId longValue] == [[GHUserModelTool shareInstance].userInfoModel.modelId longValue]) {
                    // 是我回复的
                    model.isMeReply = @(true);
                    
                    model.showContent = [NSString stringWithFormat:@"我: %@", ISNIL(model.content)];
                    
                } else {
                    
                    model.isMeReply = @(false);
                    
                    model.showContent = [NSString stringWithFormat:@"%@: %@", ISNIL(model.authorName), ISNIL(model.content)];
                }
                
                model.contentHeight = [NSNumber numberWithFloat:[model.showContent getShouldHeightWithContent:model.content withFont:H13 withWidth:SCREENWIDTH - 32 - 20  withLineHeight:18]];
                
                [self.dataArray addObject:model];
                
            }
            
            if (((NSArray *)response).count >= self.pageSize) {
                self.totalPage = self.dataArray.count + 1;
            } else {
                self.totalPage = self.currentPage;
            }
            
            [self.tableView reloadData];

            
        }
        
    }];
    
}



#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHReplyModel *model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    return [model.contentHeight floatValue] + 8;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHReplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHReplyTableViewCell"];
    
    if (!cell) {
        
        cell = [[GHReplyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHReplyTableViewCell"];
        
    }
    
    cell.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
}


@end

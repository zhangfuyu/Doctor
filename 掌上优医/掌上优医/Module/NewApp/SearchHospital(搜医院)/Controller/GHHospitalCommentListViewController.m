//
//  GHHospitalCommentListViewController.m
//  掌上优医
//
//  Created by GH on 2019/5/25.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHospitalCommentListViewController.h"

#import "GHHospitalDetailCommentTableViewCell.h"
#import "GHDoctorCommentModel.h"
#import "GHHospitalCommentDetailViewController.h"

@interface GHHospitalCommentListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (nonatomic, assign) NSUInteger totalPage;

@property (nonatomic, assign) NSUInteger currentPage;

@property (nonatomic, assign) NSUInteger pageSize;

/**
 <#Description#>
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *commentScoreLabel;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *commentTotalLabel;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIView *headerView;


@end

@implementation GHHospitalCommentListViewController

- (UIView *)headerView {
    
    if (!_headerView) {
        
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 56);
        
        
        
        UILabel *commentScoreLabel = [[UILabel alloc] init];
        commentScoreLabel.font = HM18;
        commentScoreLabel.textColor = UIColorHex(0xFF6188);
        [_headerView addSubview:commentScoreLabel];
        
        [commentScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(commentScoreLabel.superview.mas_centerX).offset(-10);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(56);
        }];
        self.commentScoreLabel = commentScoreLabel;
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        iconImageView.image = [UIImage imageNamed:@"ic_yonghuaming_xingxing_selected"];
        [_headerView addSubview:iconImageView];
        
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(16);
            make.right.mas_equalTo(commentScoreLabel.mas_left).offset(-10);
            make.centerY.mas_equalTo(commentScoreLabel);
        }];
        
        UILabel *commentTotalLabel = [[UILabel alloc] init];
        commentTotalLabel.font = H14;
        commentTotalLabel.textColor = kDefaultGrayTextColor;
        [_headerView addSubview:commentTotalLabel];
        
        [commentTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(commentScoreLabel.superview.mas_centerX).offset(10);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(56);
            make.right.mas_equalTo(-16);
        }];
//        self.commentTotalLabel = commentTotalLabel;
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = kDefaultLineViewColor;
        [_headerView addSubview:lineLabel];
        
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(10);
            make.right.left.mas_equalTo(0);
        }];
        
        
        
        //        UILabel *lineLabel2 = [[UILabel alloc] init];
        //        lineLabel2.backgroundColor = kDefaultGaryViewColor;
        //        [_headerView addSubview:lineLabel2];
        //
        //        [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.bottom.mas_equalTo(0);
        //            make.height.mas_equalTo(1);
        //            make.right.left.mas_equalTo(0);
        //        }];
        //
        //        UILabel *lineLabel3 = [[UILabel alloc] init];
        //        lineLabel3.backgroundColor = kDefaultGaryViewColor;
        //        [_headerView addSubview:lineLabel3];
        //
        //        [lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.mas_equalTo(0);
        //            make.height.mas_equalTo(1);
        //            make.right.left.mas_equalTo(0);
        //        }];
        
        self.commentScoreLabel.text = [NSString stringWithFormat:@"%.1f", [self.model.comprehensiveScore floatValue]];
        self.commentTotalLabel.text = [NSString stringWithFormat:@"%ld条评价", [self.model.comprehensiveCount integerValue]];
        
    }
    return _headerView;
    
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



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"患者评价";
    
    [self setupUI];
    
    [self setupConfig];
    
    [self refreshData];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadRefreshAllData) name:kNotificationHospitalCommentSuccess object:nil];
    
}

- (void)reloadRefreshAllData {
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"hospitalId"] = ISNIL(self.model.modelId);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiHospital withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
            self.model = [[GHSearchHospitalModel alloc] initWithDictionary:response[@"data"][@"hospital"] error:nil];
            
            
            self.commentScoreLabel.text = [NSString stringWithFormat:@"%.1f分", [self.model.comprehensiveScore floatValue]];
            self.commentTotalLabel.text = [NSString stringWithFormat:@"%ld人评价", [self.model.comprehensiveCount integerValue]];
            
        }
        
    }];
    
    
    [self refreshData];
    
}


- (void)setupConfig {
    self.currentPage = 0;
    self.pageSize = 10;
    self.totalPage = 1;
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
    
//    if (self.currentPage > self.totalPage) {
//        [self.tableView.mj_footer endRefreshingWithNoMoreData];
//        return;
//    }
    
    NSMutableDictionary *questionParams = [[NSMutableDictionary alloc] init];
//    questionParams[@"userId"] = [GHUserModelTool shareInstance].userInfoModel.modelId;
    questionParams[@"commentObjId"] = self.model.modelId;
    questionParams[@"commentObjType"] = @(2);
//    questionParams[@"choiceFlag"] = @(1);
    questionParams[@"sortType"] = @(1);
    questionParams[@"page"] = @(self.currentPage);
    questionParams[@"pageSize"] = @(10);
    
    NSString *url;
    
    url = kApiDoctorComments;
    
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:url withParameter:questionParams withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            if (self.currentPage == 1) {
                [self.dataArray removeAllObjects];
            }
            
            for (NSDictionary *dicInfo in response[@"data"][@"commentList"]) {
                
                GHDoctorCommentModel *model = [[GHDoctorCommentModel alloc] initWithDictionary:dicInfo[@"comment"]  error:nil];
                
                if (model == nil) {
                    continue;
                }
                
               
                NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
                paragraphStyle.maximumLineHeight = 21;
                paragraphStyle.minimumLineHeight = 21;
                paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
                
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:ISNIL(model.comment)];
                
                [attr addAttributes:@{NSFontAttributeName: H12} range:NSMakeRange(0, attr.string.length)];
                [attr addAttributes:@{NSForegroundColorAttributeName: kDefaultBlackTextColor} range:NSMakeRange(0, attr.string.length)];
                
                [attr addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, attr.string.length)];
                
                model.contentHeight = @([ISNIL(model.comment) getShouldHeightWithContent:attr.string withFont:H12 withWidth:SCREENWIDTH - 30 withLineHeight:21]);
                
                if ([model.contentHeight floatValue] - 24 > 21 * 6) {
                    model.contentHeight = @(21 * 6 + 24);
                }
                
                NSArray *pictureArray = [model.pictures jsonValueDecoded];
                
                
                NSInteger beishu = pictureArray.count / 3;
                
                NSInteger yushu = pictureArray.count % 3;
                
                
                float imageviewHeight = ((SCREENWIDTH - 15 * 4) / 3.0);
                
                
                if (yushu > 0) {
                    model.shouldHeight = @([model.contentHeight floatValue] + 67 + (imageviewHeight * (beishu + 1))  + ((beishu + 1) * 10) + 15);
                }
                else
                {
                    model.shouldHeight = @([model.contentHeight floatValue] + 67 + (imageviewHeight * beishu) + (beishu * 10)+ 15);
                    
                }
                
                [self.dataArray addObject:model];
                
            }
            
            if (((NSArray *)response[@"data"][@"commentList"]).count > 0) {
                
            } else {
                self.totalPage --;
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
//
- (void)setupUI {
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    //    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    commentButton.backgroundColor = kDefaultBlueColor;
    //    [commentButton setTitle:@"写评价" forState:UIControlStateNormal];
    //    commentButton.titleLabel.font = H18;
    //    commentButton.layer.cornerRadius = 4;
    //    commentButton.layer.masksToBounds = true;
    //    [commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [self.view addSubview:commentButton];
    //
    //    [commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(16);
    //        make.right.mas_equalTo(-16);
    //        make.height.mas_equalTo(47);
    //        make.bottom.mas_equalTo(kBottomSafeSpace - 15);
    //    }];
    //    [commentButton addTarget:self action:@selector(clickCommentAction) forControlEvents:UIControlEventTouchUpInside];
    
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
    self.tableView = tableView;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
}

- (void)clickCommentAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self presentViewController:vc animated:true completion:nil];
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 66;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}


#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GHMyCommentsModel *model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    return [model.shouldHeight floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GHHospitalDetailCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHHospitalDetailCommentTableViewCell"];
    
    if (!cell) {
        cell = [[GHHospitalDetailCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHHospitalDetailCommentTableViewCell"];
    }
    
    cell.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHHospitalCommentDetailViewController *vc = [[GHHospitalCommentDetailViewController alloc] init];
    
    GHDoctorCommentModel *commentmodel = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    vc.model = [[GHMyCommentsModel alloc] initWithDictionary:[commentmodel toDictionary] error:nil];
    vc.model.userProfileUrl = commentmodel.userProfileUrl;
    vc.model.score = [NSString stringWithFormat:@"%d",[commentmodel.score integerValue] *10];
    vc.model.envScore = [NSString stringWithFormat:@"%d",[commentmodel.envScore integerValue] *10];
    vc.model.serviceScore = [NSString stringWithFormat:@"%d",[commentmodel.serviceScore integerValue] *10];
    
//    vc.model.userNickName = commentmodel.userNickName;
//    vc.model.createTime = commentmodel.createTime;
//    vc.model.envScore = commentmodel.envScore;
//    vc.model.serviceScore = commentmodel.serviceScore;
//    vc.model.score = commentmodel.commentScore;
    vc.model.pictures = commentmodel.pictures;
    vc.model.comment = commentmodel.comment;
    vc.model.userNickName = commentmodel.userNickName;
    vc.model.gmtCreate = commentmodel.createTime;
    vc.model.modelId = self.model.modelId;
    
    
     
//    vc.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    vc.hospitalModel = self.model;
    [self.navigationController pushViewController:vc animated:true];
    
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

#pragma mark LazyLoad

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end

//
//  GHDoctorCommentListViewController.m
//  掌上优医
//
//  Created by GH on 2019/1/16.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHDoctorCommentListViewController.h"

#import "GHDoctorCommentViewController.h"

#import "GHMyCommentsDetailViewController.h"

#import "GHDoctorCommentTableViewCell.h"

@interface GHDoctorCommentListViewController ()<UITableViewDelegate,UITableViewDataSource>

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

@implementation GHDoctorCommentListViewController


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
        self.commentTotalLabel = commentTotalLabel;

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

        self.commentScoreLabel.text = [NSString stringWithFormat:@"%.1f", [self.model.commentScore floatValue]];
        self.commentTotalLabel.text = [NSString stringWithFormat:@"%ld条评价", (long)[self.model.commentCount integerValue]];

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadRefreshAllData) name:kNotificationDoctorCommentSuccess object:nil];
    
}

- (void)reloadRefreshAllData {
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"id"] = ISNIL(self.model.modelId);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDoctorDoctor withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
            GHSearchDoctorModel *model = [[GHSearchDoctorModel alloc] initWithDictionary:response error:nil];
            
            
            self.commentScoreLabel.text = [NSString stringWithFormat:@"%.1f分", [model.score floatValue]];
            self.commentTotalLabel.text = [NSString stringWithFormat:@"%ld人评价", [model.commentCount integerValue]];
            
        }
        
    }];
    
    
    [self refreshData];
    
}


- (void)setupConfig {
    self.currentPage = 1;
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
    
    if (self.currentPage > self.totalPage) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"userId"] = [GHUserModelTool shareInstance].userInfoModel.modelId;
    params[@"commentObjId"] = self.model.modelId;
    params[@"commentObjType"] = @(1);
//    params[@"choiceFlag"] = @(1);
    params[@"sortType"] = @(1);
    params[@"page"] = @(1);
    params[@"pageSIze"] = @(10);
    
    
    NSString *url;
    
    url = kApiDoctorComments;
    
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:url withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            if (self.currentPage == 1) {
                [self.dataArray removeAllObjects];
            }
            
            for (NSDictionary *dicInfo in response[@"data"][@"commentList"]) {
                
                GHDoctorCommentModel *model = [[GHDoctorCommentModel alloc] initWithDictionary:dicInfo[@"comment"] error:nil];
                model.doctorProfilePhoto = dicInfo[@"doctor"][@"headImgUrl"];
                
                NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
                paragraphStyle.maximumLineHeight = 21;
                paragraphStyle.minimumLineHeight = 21;
                paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
                
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:ISNIL(model.comment)];
                
                [attr addAttributes:@{NSFontAttributeName: H12} range:NSMakeRange(0, attr.string.length)];
                [attr addAttributes:@{NSForegroundColorAttributeName: kDefaultBlackTextColor} range:NSMakeRange(0, attr.string.length)];
                
                [attr addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, attr.string.length)];
                
                model.contentHeight = @([ISNIL(model.comment) getShouldHeightWithContent:attr.string withFont:H12 withWidth:SCREENWIDTH - 30 withLineHeight:21]);
                
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
                self.currentPage--;
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
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
        
        GHDoctorCommentViewController *vc = [[GHDoctorCommentViewController alloc] init];
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:true];
        
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
    GHDoctorCommentModel *model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    return [model.shouldHeight floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    GHDoctorCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHDoctorCommentTableViewCell"];
    
    if (!cell) {
        cell = [[GHDoctorCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHDoctorCommentTableViewCell"];
    }
    
    cell.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHMyCommentsDetailViewController *vc = [[GHMyCommentsDetailViewController alloc] init];
    GHDoctorCommentModel *model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    vc.model = [[GHMyCommentsModel alloc] initWithDictionary:[model toDictionary] error:nil];
    vc.model.pictures = model.pictures;

    vc.model.userProfileUrl = model.userProfileUrl;
    vc.model.doctorProfilePhoto = model.doctorProfilePhoto;
    vc.model.doctorName = self.model.doctorName;
    vc.model.doctorGrade = self.model.doctorGrade;
    vc.model.hospitalName = self.model.hospitalName;
//    vc.model.score = self.model.score;//[NSString stringWithFormat:@"%ld", [model.score integerValue] * 10];
    
    vc.model.score = [NSString stringWithFormat:@"%.1f",[model.score floatValue] * 10];
    vc.model.commentScore = [NSString stringWithFormat:@"%f",[self.model.commentScore floatValue]];
    
    vc.model.modelId = self.model.modelId;
    vc.model.doctorSecondDepartmentName = self.model.secondDepartmentName;
    
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



////
////  GHDoctorCommentListViewController.m
////  掌上优医
////
////  Created by GH on 2019/1/16.
////  Copyright © 2019 GH. All rights reserved.
////
//
//#import "GHDoctorCommentListViewController.h"
//#import "GHDoctorCommentStarTableViewCell.h"
//
//#import "GHDoctorCommentViewController.h"
//
//#import "GHMyCommentsDetailViewController.h"
//
//@interface GHDoctorCommentListViewController ()<UITableViewDelegate,UITableViewDataSource>
//
//@property (strong, nonatomic) NSMutableArray *dataArray;
//
//@property (nonatomic, assign) NSUInteger totalPage;
//
//@property (nonatomic, assign) NSUInteger currentPage;
//
//@property (nonatomic, assign) NSUInteger pageSize;
//
///**
// <#Description#>
// */
//@property (nonatomic, strong) UITableView *tableView;
//
///**
// <#Description#>
// */
//@property (nonatomic, strong) UIView *headerView;
//
///**
// <#Description#>
// */
//@property (nonatomic, strong) UILabel *commentScoreLabel;
//
///**
// <#Description#>
// */
//@property (nonatomic, strong) UILabel *commentTotalLabel;
//
///**
// <#Description#>
// */
//@property (nonatomic, strong) NSMutableArray *buttonArray;
//
///**
// <#Description#>
// */
//@property (nonatomic, strong) UILabel *moveLineLabel;
//
//@end
//
//@implementation GHDoctorCommentListViewController
//
//- (NSMutableArray *)buttonArray {
//
//    if (!_buttonArray) {
//        _buttonArray = [[NSMutableArray alloc] init];
//    }
//    return _buttonArray;
//
//}
//
//- (UIView *)headerView {
//
//    if (!_headerView) {
//
//        _headerView = [[UIView alloc] init];
//        _headerView.backgroundColor = [UIColor whiteColor];
//        _headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 88);
//
//
//
//        UILabel *commentScoreLabel = [[UILabel alloc] init];
//        commentScoreLabel.font = HM15;
//        commentScoreLabel.textColor = UIColorHex(0xFF6188);
//        [_headerView addSubview:commentScoreLabel];
//
//        [commentScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(commentScoreLabel.superview.mas_centerX).offset(-10);
//            make.top.mas_equalTo(0);
//            make.height.mas_equalTo(46);
//        }];
//        self.commentScoreLabel = commentScoreLabel;
//
//        UIImageView *iconImageView = [[UIImageView alloc] init];
//        iconImageView.contentMode = UIViewContentModeScaleAspectFill;
//        iconImageView.image = [UIImage imageNamed:@"ic_yonghuaming_xingxing_selected"];
//        [_headerView addSubview:iconImageView];
//
//        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.height.mas_equalTo(14);
//            make.right.mas_equalTo(commentScoreLabel.mas_left).offset(-10);
//            make.centerY.mas_equalTo(commentScoreLabel);
//        }];
//
//        UILabel *commentTotalLabel = [[UILabel alloc] init];
//        commentTotalLabel.font = H14;
//        commentTotalLabel.textColor = kDefaultGrayTextColor;
//        [_headerView addSubview:commentTotalLabel];
//
//        [commentTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(commentScoreLabel.superview.mas_centerX).offset(10);
//            make.top.mas_equalTo(0);
//            make.height.mas_equalTo(46);
//            make.right.mas_equalTo(-16);
//        }];
//        self.commentTotalLabel = commentTotalLabel;
//
//        UILabel *lineLabel = [[UILabel alloc] init];
//        lineLabel.backgroundColor = [UIColor whiteColor];
//        [_headerView addSubview:lineLabel];
//
//        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(45);
//            make.height.mas_equalTo(1);
//            make.right.left.mas_equalTo(0);
//        }];
//
//        NSArray *titleArray = @[@"全部", @"好评", @"差评"];
//
//        for (NSInteger index = 0; index < titleArray.count; index++) {
//
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            [button setTitle:ISNIL([titleArray objectOrNilAtIndex:index]) forState:UIControlStateNormal];
//            [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
//            [button setTitleColor:kDefaultBlueColor forState:UIControlStateSelected];
//            button.titleLabel.font = H16;
//            button.tag = index;
//            [_headerView addSubview:button];
//
//            [button mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(lineLabel.mas_bottom);
//                make.bottom.mas_equalTo(-1);
//                make.left.mas_equalTo(index * (SCREENWIDTH / titleArray.count));
//                make.width.mas_equalTo(SCREENWIDTH / titleArray.count);
//            }];
//
//            [self.buttonArray addObject:button];
//
//            [button addTarget:self action:@selector(clickTypeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//
//            if (index == 0) {
//
//                UILabel *moveLineLabel = [[UILabel alloc] init];
//                moveLineLabel.backgroundColor = kDefaultBlueColor;
//                moveLineLabel.frame = CGRectMake((0 * (SCREENWIDTH / 3.f)) + ((SCREENWIDTH / 3.f) * .5) - 16, 87, 32, 2);
//                [_headerView addSubview:moveLineLabel];
////
////                [moveLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
////                    make.bottom.mas_equalTo(-1);
////                    make.height.mas_equalTo(2);
////                    make.width.mas_equalTo(32);
////                    make.centerX.mas_equalTo(button);
////                }];
//                self.moveLineLabel = moveLineLabel;
//
//            }
//
//        }
//
//
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
//
//        self.commentScoreLabel.text = [NSString stringWithFormat:@"%.1f", [self.model.score floatValue]];
//        self.commentTotalLabel.text = [NSString stringWithFormat:@"%ld人评价", [self.model.commentCount integerValue]];
//
//    }
//    return _headerView;
//
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//
//    [super viewWillAppear:animated];
//
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//
//
//
//    [self setupNavigationStyle:GHNavigationBarStyleWhite];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//
//    [super viewWillDisappear:animated];
//
//
//    [self setupNavigationStyle:GHNavigationBarStyleBlue];
//
//}
//
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    self.navigationItem.title = @"患者评价";
//
//    [self setupUI];
//
//    [self setupConfig];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self clickTypeButtonAction:[self.buttonArray objectOrNilAtIndex:0]];
//    });
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadRefreshAllData) name:kNotificationDoctorCommentSuccess object:nil];
//
//}
//
//- (void)reloadRefreshAllData {
//
//
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    params[@"id"] = ISNIL(self.model.modelId);
//
//    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDoctorDoctor withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
//
//        if (isSuccess) {
//
//            GHSearchDoctorModel *model = [[GHSearchDoctorModel alloc] initWithDictionary:response error:nil];
//
//
//            self.commentScoreLabel.text = [NSString stringWithFormat:@"%.1f分", [model.score floatValue]];
//            self.commentTotalLabel.text = [NSString stringWithFormat:@"%ld人评价", [model.commentCount integerValue]];
//
//        }
//
//    }];
//
//
//    [self refreshData];
//
//}
//
//
//- (void)clickTypeButtonAction:(UIButton *)sender {
//
//    for (UIButton *button in self.buttonArray) {
//        button.selected = false;
//    }
//
//    sender.selected = true;
//
//    [UIView animateWithDuration:.3 animations:^{
//        self.moveLineLabel.mj_x = (sender.tag * (SCREENWIDTH / 3.f)) + ((SCREENWIDTH / 3.f) * .5) - 16;
//    }];
//
//    [self refreshData];
//
//}
//
//- (void)setupConfig {
//    self.currentPage = 0;
//    self.pageSize = 10;
//    self.totalPage = 1;
//}
//
//- (void)refreshData{
//    self.currentPage = 0;
//    self.totalPage = 1;
//    [self requsetData];
//}
//
//- (void)getMoreData{
//    self.currentPage += self.pageSize;
//    [self requsetData];
//}
//
//- (void)requsetData {
//
//    if (self.currentPage > self.totalPage) {
//        [self.tableView.mj_footer endRefreshingWithNoMoreData];
//        return;
//    }
//
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    params[@"pageSize"] = @(self.pageSize);
//    params[@"from"] = @(self.currentPage);
//    params[@"doctorId"] = ISNIL(self.model.modelId);
//
//    NSString *url;
//    if (((UIButton *)[self.buttonArray objectOrNilAtIndex:0]).selected == true) {
//        url = kApiDoctorComments;
//    } else if (((UIButton *)[self.buttonArray objectOrNilAtIndex:1]).selected == true) {
//        url = kApiDoctorPositiveComments;
//    } else if (((UIButton *)[self.buttonArray objectOrNilAtIndex:2]).selected == true) {
//        url = kApiDoctorNegativeComments;
//    }
//
//
//
//    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:url withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
//
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//
//        if (isSuccess) {
//
//            if (self.currentPage == 0) {
//                [self.dataArray removeAllObjects];
//            }
//
//            for (NSDictionary *dicInfo in response) {
//
//                GHDoctorCommentModel *model = [[GHDoctorCommentModel alloc] initWithDictionary:dicInfo error:nil];
//
//                if (model == nil) {
//                    continue;
//                }
//
//                if (model.comment.length == 0) {
//
//                    switch ([model.score integerValue]) {
//                        case 1:
//                            model.comment = @"差";
//                            break;
//
//                        case 2:
//                            model.comment = @"差";
//                            break;
//
//                        case 3:
//                            model.comment = @"较差";
//                            break;
//
//                        case 4:
//                            model.comment = @"较差";
//                            break;
//
//                        case 5:
//                            model.comment = @"一般";
//                            break;
//
//                        case 6:
//                            model.comment = @"一般";
//                            break;
//
//                        case 7:
//                            model.comment = @"满意";
//                            break;
//
//                        case 8:
//                            model.comment = @"满意";
//                            break;
//
//                        case 9:
//                            model.comment = @"非常满意";
//                            break;
//
//                        case 10:
//                            model.comment = @"非常满意";
//                            break;
//
//                        default:
//                            break;
//                    }
//
//                }
//
//                model.contentHeight = @([ISNIL(model.comment) getShouldHeightWithContent:ISNIL(model.comment) withFont:H15 withWidth:SCREENWIDTH - 32 withLineHeight:21] + 24);
//
//                NSArray *pictureArray = [model.pictures jsonValueDecoded];
//
//                if (pictureArray.count > 3) {
//
//                    model.shouldHeight = @([model.contentHeight floatValue] + 198 + 190 - 120);
//
//                } else if (pictureArray.count == 0) {
//
//                    model.shouldHeight = @([model.contentHeight floatValue] + 190 - 120);
//
//                } else {
//
//                    model.shouldHeight = @([model.contentHeight floatValue] + 198 + 95 - 120);
//
//                }
//
//                [self.dataArray addObject:model];
//
//            }
//
//            if (((NSArray *)response).count >= self.pageSize) {
//                self.totalPage = self.dataArray.count + 1;
//            } else {
//                self.totalPage = self.currentPage;
//            }
//
//            [self.tableView reloadData];
//
//            if (self.dataArray.count == 0) {
//                [self loadingEmptyView];
//            }else{
//                [self hideEmptyView];
//            }
//
//        }
//
//    }];
//
//}
////
//- (void)setupUI {
//
//    self.view.backgroundColor = kDefaultGaryViewColor;
//
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
//
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
//    tableView.backgroundColor = kDefaultGaryViewColor;
//
//    [self.view addSubview:tableView];
//
//    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(0);
//        make.top.mas_equalTo(0);
//        make.bottom.mas_equalTo(commentButton.mas_top).offset(-10);
//    }];
//    self.tableView = tableView;
//
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
//
//}
//
//- (void)clickCommentAction {
//
//    if ([GHUserModelTool shareInstance].isLogin) {
//
//        GHDoctorCommentViewController *vc = [[GHDoctorCommentViewController alloc] init];
//        vc.model = self.model;
//        [self.navigationController pushViewController:vc animated:true];
//
//    } else {
//
//        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
//        [self presentViewController:vc animated:true completion:nil];
//
//    }
//
//}
//
//
//#pragma mark UITableView
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.dataArray.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    GHDoctorCommentModel *model = [self.dataArray objectOrNilAtIndex:indexPath.row];
//    return [model.shouldHeight floatValue];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 90;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return self.headerView;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    GHDoctorCommentStarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHDoctorCommentStarTableViewCell"];
//
//    if (!cell) {
//        cell = [[GHDoctorCommentStarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHDoctorCommentStarTableViewCell"];
//    }
//
//    cell.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
//
//    return cell;
//
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    GHMyCommentsDetailViewController *vc = [[GHMyCommentsDetailViewController alloc] init];
//    GHDoctorCommentModel *model = [self.dataArray objectOrNilAtIndex:indexPath.row];
//    vc.model = [[GHMyCommentsModel alloc] initWithDictionary:[model toDictionary] error:nil];
//    vc.model.score = [NSString stringWithFormat:@"%ld", [model.score integerValue] * 10];
//    [self.navigationController pushViewController:vc animated:true];
//
//}
//
//- (CGFloat)getShouldHeightWithContent:(NSString *)content withFont:(UIFont *)font withWidth:(CGFloat)width withLineHeight:(CGFloat)lineHeight {
//
//    if (ISNIL(content).length == 0) {
//        return 0.f;
//    }
//
//    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
//    paragraphStyle.maximumLineHeight = lineHeight;
//    paragraphStyle.minimumLineHeight = lineHeight;
//
//    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content];
//
//    [attr addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, content.length)];
//    [attr addAttributes:@{NSFontAttributeName: font} range:NSMakeRange(0, content.length)];
//
//    CGSize size = [attr boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
//
//    return size.height;
//}
//
//#pragma mark LazyLoad
//
//- (NSMutableArray *)dataArray
//{
//    if (!_dataArray) {
//        _dataArray = [NSMutableArray array];
//    }
//    return _dataArray;
//}
//
//@end

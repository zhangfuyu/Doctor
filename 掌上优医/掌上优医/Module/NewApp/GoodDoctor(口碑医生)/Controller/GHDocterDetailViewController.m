//
//  GHDocterDetailViewController.m
//  掌上优医
//
//  Created by GH on 2018/10/30.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHDocterDetailViewController.h"
#import "GHDoctorInfoHeaderView.h"


#import "GHSearchDoctorModel.h"

#import "GHCommonShareView.h"

#import "GHDoctorInfoErrorViewController.h"
#import "GHDoctorMorePopView.h"

#import "GHDoctorCommentViewController.h"

#import "GHDoctorCommentTableViewCell.h"

#import "GHDoctorCommentListViewController.h"

#import <MapKit/MapKit.h>

#import "GHZuJiDoctorModel.h"
#import "GHNDoctorRecordModel.h"


#import "GHMyCommentsDetailViewController.h"

#import "GHDoctorDetailAnswerView.h"

#import "GHDoctorAuthenticationViewController.h"

@interface GHDocterDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) GHSearchDoctorModel *model;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) GHCommonShareView *shareView;

@property (nonatomic, strong) NSString *urlStr;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIView *moreCommentView;


/**
 <#Description#>
 */
@property (nonatomic, strong) UIButton *collectionButton;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *commentTotalLabel;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *commentArray;

@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, assign) CGFloat contentTextHeight;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *contentLabel;


/**
 <#Description#>
 */
@property (nonatomic, strong) GHDoctorDetailAnswerView *answerView;

@end

@implementation GHDocterDetailViewController

- (NSMutableArray *)commentArray {
    
    if (!_commentArray) {
        _commentArray = [[NSMutableArray alloc] init];
    }
    return _commentArray;
    
}

- (UIView *)moreCommentView {
    
    if (!_moreCommentView) {
        
        _moreCommentView = [[UIView alloc] init];
        _moreCommentView.backgroundColor = [UIColor whiteColor];
        _moreCommentView.frame = CGRectMake(0, 0, SCREENWIDTH, 56);
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = HM18;
        titleLabel.textColor = kDefaultBlackTextColor;
        titleLabel.text = @"患者评价";
        [_moreCommentView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(75);
        }];
        
        UILabel *totalCountLabel = [[UILabel alloc] init];
        totalCountLabel.font = H12;
        totalCountLabel.textColor = kDefaultGrayTextColor;
        [_moreCommentView addSubview:totalCountLabel];
        
        [totalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabel.mas_right).offset(8);
            make.top.bottom.mas_equalTo(0);
        }];
        self.commentTotalLabel = totalCountLabel;
        
        
        
        UIImageView *arrowImageView = [[UIImageView alloc] init];
        arrowImageView.contentMode = UIViewContentModeCenter;
        arrowImageView.image = [UIImage imageNamed:@"personcenter_right_arrow"];
        [_moreCommentView addSubview:arrowImageView];
        
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(13);
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(arrowImageView.superview);
        }];
        
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.font = H14;
        descLabel.textColor = kDefaultGrayTextColor;
        descLabel.text = @"查看更多";
        descLabel.textAlignment = NSTextAlignmentRight;
        [_moreCommentView addSubview:descLabel];
        
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-34);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(100);
        }];
        
        UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreCommentView addSubview:actionButton];
        
        [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        [actionButton addTarget:self action:@selector(clickMoreCommentAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = kDefaultLineViewColor;
        [_moreCommentView addSubview:lineLabel];
        
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _moreCommentView;
    
}


- (GHCommonShareView *)shareView {
    
    if (!_shareView) {
        _shareView = [[GHCommonShareView alloc] init];
        _shareView.title = [NSString stringWithFormat:@"%@ %@ %@", ISNIL(self.model.doctorName), ISNIL(self.model.hospitalName), ISNIL(self.model.secondDepartmentName)];
        _shareView.desc = @"为您找到治疗所患疾病有效、口碑好的优秀医生";
        _shareView.urlString = self.urlStr;
        [self.view addSubview:_shareView];
        
        [_shareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        _shareView.hidden = true;
    }
    return _shareView;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"医生介绍";
    // Do any additional setup after loading the view.
    
    self.urlStr = [[GHNetworkTool shareInstance] getDoctorDetailURLWithDoctorId:self.doctorId];
    
    self.moreCommentView.hidden = false;
    
    [self addNavigationRightView];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"id"] = ISNIL(self.doctorId);
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDoctorDoctor withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.tableView.mj_header endRefreshing];
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            self.model = [[GHSearchDoctorModel alloc] initWithDictionary:response error:nil];
            
            [self setupUI];
            
            GHZuJiDoctorModel *saveModel = [[GHZuJiDoctorModel alloc] init];
            
            saveModel.doctorName = ISNIL(self.model.doctorName);
            saveModel.doctorGrade = ISNIL(self.model.doctorGrade);
            saveModel.modelId = ISNIL(self.model.modelId);
            saveModel.profilePhoto = ISNIL(self.model.profilePhoto);
            saveModel.firstDepartmentId = ISNIL(self.model.firstDepartmentId);
            saveModel.firstDepartmentName = ISNIL(self.model.firstDepartmentName);
            saveModel.secondDepartmentId = ISNIL(self.model.secondDepartmentId);
            saveModel.secondDepartmentName = ISNIL(self.model.secondDepartmentName);
            saveModel.hospitalId = ISNIL(self.model.hospitalId);
            saveModel.hospitalName = ISNIL(self.model.hospitalName);
            
            if (saveModel) {
                [[GHSaveDataTool shareInstance] addObject:saveModel withType:GHSaveDataType_Doctor];
            }
            
            GHNDoctorRecordModel *recordModel = [[GHNDoctorRecordModel alloc] init];
            
            recordModel.doctorName = ISNIL(self.model.doctorName);
            recordModel.doctorGrade = ISNIL(self.model.doctorGrade);
            recordModel.modelId = ISNIL(self.model.modelId);
            recordModel.profilePhoto = ISNIL(self.model.profilePhoto);
            recordModel.firstDepartmentId = ISNIL(self.model.firstDepartmentId);
            recordModel.firstDepartmentName = ISNIL(self.model.firstDepartmentName);
            recordModel.secondDepartmentId = ISNIL(self.model.secondDepartmentId);
            recordModel.secondDepartmentName = ISNIL(self.model.secondDepartmentName);
            recordModel.hospitalId = ISNIL(self.model.hospitalId);
            recordModel.hospitalName = ISNIL(self.model.hospitalName);
            recordModel.score = ISNIL(self.model.score);
            recordModel.medicineType = ISNIL(self.model.medicineType);
            
            if (recordModel) {
                [[GHSaveDataTool shareInstance] addObjectToCommentDoctorRecord:recordModel];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDoctorRecordShouldReload object:nil];
            
            if ([GHUserModelTool shareInstance].isLogin) {
                [self getCollectionData];
            }
            
            [self getDataAction];
            
            
        }
        
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCollectionInfoAction) name:kNotificationDoctorCollectionSuccess object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDataAction) name:kNotificationDoctorCommentSuccess object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDataAction) name:kNotificationDoctorQuestionSuccess object:nil];
    
    
}

- (void)getCollectionData {
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiGetConllection withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            for (NSDictionary *dicInfo in response) {
                
                if ([dicInfo[@"contentId"] longValue] == [self.doctorId longValue]) {
                    
                    
                    self.model.collectionId = [NSString stringWithFormat:@"%ld", [dicInfo[@"id"] longValue]];
                    
                    
                    self.collectionButton.selected = true;
                    
                    break;
                }
                
                
            }
            
            
        }
        
    }];
    
}

- (void)addNavigationRightView {
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 86, 44);
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:[UIImage imageNamed:@"icon_hospital_share"] forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(0, 0, 50, 44);
    
    [shareButton addTarget:self action:@selector(clickShareAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectionButton setImage:[UIImage imageNamed:@"icon_hospital_uncollection"] forState:UIControlStateNormal];
    [collectionButton setImage:[UIImage imageNamed:@"icon_hospital_collection"] forState:UIControlStateSelected];
    collectionButton.frame = CGRectMake(0, 0, 30, 44);
    self.collectionButton = collectionButton;
    
    [collectionButton addTarget:self action:@selector(clickCollectionAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBtn1 = [[UIBarButtonItem alloc] initWithCustomView:collectionButton];
    UIBarButtonItem *rightBtn2 = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItems = @[rightBtn2, rightBtn1];
    
    
}

- (void)clickShareAction {
    
    self.shareView.hidden = false;
    
}

- (void)clickInfoErrorAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        GHDoctorInfoErrorViewController *vc = [[GHDoctorInfoErrorViewController alloc] init];
        vc.realModel = self.model;
        [self.navigationController pushViewController:vc animated:true];
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self presentViewController:vc animated:true completion:nil];
        
    }
    
}

- (void)getCollectionInfoAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiGetConllection withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            if (isSuccess) {
                
                [SVProgressHUD dismiss];
                
                for (NSDictionary *dicInfo in response) {
                    
                    if ([dicInfo[@"contentId"] longValue] == [self.doctorId longValue]) {
                        
                        
                        self.model.collectionId = [NSString stringWithFormat:@"%ld", [dicInfo[@"id"] longValue]];
                        
                        
                        self.collectionButton.selected = true;
                        
                        break;
                    }
                    
                    
                }
                
            }
            
        }];
        
    }
    
}


- (void)getDataAction {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"id"] = ISNIL(self.doctorId);
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDoctorDoctor withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
//            self.model = [[GHSearchDoctorModel alloc] initWithDictionary:response error:nil];
            
            self.commentTotalLabel.text = [NSString stringWithFormat:@"(共 %ld 条)", [self.model.commentCount integerValue]];
            
        }
        
    }];
    
    
    NSMutableDictionary *sonParams = [[NSMutableDictionary alloc] init];
    sonParams[@"pageSize"] = @(3);
    sonParams[@"from"] = @(0);
    sonParams[@"doctorId"] = ISNIL(self.doctorId);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDoctorComments withParameter:sonParams withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [self.commentArray removeAllObjects];
        
        if (isSuccess) {
            
            for (NSDictionary *dicInfo in response) {
                
                GHDoctorCommentModel *model = [[GHDoctorCommentModel alloc] initWithDictionary:dicInfo error:nil];
                
                if (model.comment.length == 0) {
                    
                    switch ([model.score integerValue]) {
                        case 1:
                            model.comment = @"差";
                            break;
                            
                        case 2:
                            model.comment = @"差";
                            break;
                            
                        case 3:
                            model.comment = @"较差";
                            break;
                            
                        case 4:
                            model.comment = @"较差";
                            break;
                            
                        case 5:
                            model.comment = @"一般";
                            break;
                            
                        case 6:
                            model.comment = @"一般";
                            break;
                            
                        case 7:
                            model.comment = @"满意";
                            break;
                            
                        case 8:
                            model.comment = @"满意";
                            break;
                            
                        case 9:
                            model.comment = @"非常满意";
                            break;
                            
                        case 10:
                            model.comment = @"非常满意";
                            break;
                            
                        default:
                            break;
                    }
                    
                }
                
                model.contentHeight = @([ISNIL(model.comment) getShouldHeightWithContent:ISNIL(model.comment) withFont:H15 withWidth:SCREENWIDTH - 32 withLineHeight:21] + 24);
                
                if ([model.contentHeight floatValue] - 24 > 21 * 6) {
                    model.contentHeight = @(21 * 6 + 24);
                }
                
                NSArray *pictureArray = [model.pictures jsonValueDecoded];
                
                if (pictureArray.count > 3) {
                    
                    model.shouldHeight = @([model.contentHeight floatValue] + 198 + 190 - 100);
                    
                } else if (pictureArray.count == 0) {
                    
                    model.shouldHeight = @([model.contentHeight floatValue] + 190 - 100);
                    
                } else {
                    
                    model.shouldHeight = @([model.contentHeight floatValue] + 198 + 95 - 100);
                    
                }
                
                [self.commentArray addObject:model];
                
            }
            
            [self.tableView reloadData];
            
            
            
        }
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSMutableDictionary *questionParams = [[NSMutableDictionary alloc] init];
        questionParams[@"doctorId"] = self.model.modelId;
        questionParams[@"from"] = @(0);
        questionParams[@"pageSize"] = @(1);
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiCircleDoctorPosts withParameter:questionParams withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:false withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
           
            if (isSuccess) {
                
                for (NSDictionary *dic in response) {
                    
                    GHQuestionModel *model = [[GHQuestionModel alloc] initWithDictionary:dic error:nil];
                    
                    if (model != nil) {
                        
                        self.answerView.model = model;
                        
                    }
                    
                }
                
            }
            
        }];
        
    });
    
}

- (void)clickCollectionAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        if (self.collectionButton.selected == true) {
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"id"] = ISNIL(self.model.collectionId);
            
            [SVProgressHUD showWithStatus:kDefaultTipsText];
            
            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_DELETE withUrl:kApiMyFavoriteDoctor  withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
                
                
                
                if (isSuccess) {
                    
                    [SVProgressHUD dismiss];
                    
                    [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
                    
                    self.collectionButton.selected = false;
                    
                    self.model.collectionId = nil;
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCancelDoctorCollectionSuccess object:nil];
                    });
                    
                }
                
            }];
            
        } else {
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"contentId"] = ISNIL(self.model.modelId);
            
            params[@"title"] = ISNIL(self.model.doctorName);
            params[@"userId"] = ISNIL([GHUserModelTool shareInstance].userInfoModel.modelId);
            
            //            NSMutableDictionary *contentInfo = [[NSMutableDictionary alloc] init];
            //            contentInfo[@"title"] = ISNIL(self.model.title);
            //            contentInfo[@"gmtCreate"] = ISNIL(self.model.gmtCreate);
            //            contentInfo[@"id"] = ISNIL(self.model.modelId);
            //
            //            params[@"contentInfo"] = [contentInfo jsonStringEncoded];
            [SVProgressHUD showWithStatus:kDefaultTipsText];
            
            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiMyFavoriteDoctor withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
                
                if (isSuccess) {
                    
                    [SVProgressHUD dismiss];
                    
                    [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
                    self.collectionButton.selected = true;
                    
                    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiGetConllection withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
                        
                        if (isSuccess) {
                            
                            [SVProgressHUD dismiss];
                            
                            for (NSDictionary *dicInfo in response) {
                                
                                if ([dicInfo[@"contentId"] longValue] == [self.model.modelId longValue]) {
                                    
                                    
                                    self.model.collectionId = [NSString stringWithFormat:@"%ld", [dicInfo[@"id"] longValue]];
                                    
                                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDoctorCollectionSuccess object:nil];
                                    
                                    break;
                                    
                                }
                                
                                
                            }
                            
                        }
                        
                    }];
                    
                }
                
            }];
            
        }
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self presentViewController:vc animated:true completion:nil];
        
    }
    
}
/**
 
 */
- (void)setupUI {
    
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.backgroundColor = kDefaultBlueColor;
    [commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commentButton setImage:[UIImage imageNamed:@"doctor_comment_new"] forState:UIControlStateNormal];
    [commentButton setTitle:@"写评价" forState:UIControlStateNormal];
    commentButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
    commentButton.titleLabel.font = H12;
    [commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:commentButton];
    
    [commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(47);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    [commentButton addTarget:self action:@selector(clickCommentAction) forControlEvents:UIControlEventTouchUpInside];
    
    
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
        make.bottom.mas_equalTo(commentButton.mas_top);
    }];
    self.tableView = tableView;
    
    [self setupTableHeaderView];
    
    [self setupTableFooterView];
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getDataAction)];
    
}

- (void)setupTableFooterView {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kDefaultGaryViewColor;
    view.frame = CGRectMake(0, 0, SCREENWIDTH, 165);
    
    self.tableView.tableFooterView = view;
    
    UIView *errorBgView = [[UIView alloc] init];
    errorBgView.backgroundColor = UIColorHex(0xFF9690);
    errorBgView.alpha = 0.27;
    errorBgView.layer.cornerRadius = 4;
    errorBgView.layer.masksToBounds = true;
    [view addSubview:errorBgView];
    
    [errorBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(50);
    }];
    
    UIButton *errorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    errorButton.titleLabel.font = H15;
    [errorButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    [errorButton setTitle:@" 信息报错" forState:UIControlStateNormal];
    [errorButton setImage:[UIImage imageNamed:@"icon_hospital_error"] forState:UIControlStateNormal];
    [view addSubview:errorButton];
    
    [errorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(errorBgView);
    }];
    [errorButton addTarget:self action:@selector(clickInfoErrorAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.textColor = kDefaultGrayTextColor;
    textLabel.font = H11;
    textLabel.text = @"以上信息，来源于用户自行申报及工商系统数据，具体以工商部门登记为准．用户需保证信息真实有效，平台也将定期核查，如与实际不符，如有疑问，请联系平台客服";
    textLabel.numberOfLines = 0;
    [view addSubview:textLabel];
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(errorButton.mas_bottom);
        make.bottom.mas_equalTo(-10);
    }];
    
}




- (void)setupTableHeaderView {

    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    
    self.contentHeight = 0;
    
    GHDoctorInfoHeaderView *headerView = [[GHDoctorInfoHeaderView alloc] init];
    headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 190 + 32);
    headerView.model = self.model;
    [contentView addSubview:headerView];
    
    self.contentHeight += 16;
    self.contentHeight += 190;
    self.contentHeight += 16;
    
    UILabel *lineLabel1 = [[UILabel alloc] init];
    lineLabel1.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel1];
    
    [lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(190 + 32);
    }];
    
    self.contentHeight += 10;
    
    UIView *authenticationView = [[UIView alloc] init];
    authenticationView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:authenticationView];
    
    [authenticationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel1.mas_bottom);
        make.height.mas_equalTo(52);
    }];
    self.contentHeight += 52;
    
    UIImageView *authenticationImageView = [[UIImageView alloc] init];
    authenticationImageView.contentMode = UIViewContentModeCenter;
    authenticationImageView.image = [UIImage imageNamed:@"icon_hospital_authentication"];
    [authenticationView addSubview:authenticationImageView];
    
    [authenticationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(22);
        make.left.mas_equalTo(16);
        make.centerY.mas_equalTo(authenticationView);
    }];
    
    UILabel *authenticationTitleLabel = [[UILabel alloc] init];
    authenticationTitleLabel.font = HM16;
    authenticationTitleLabel.textColor = kDefaultBlackTextColor;
    authenticationTitleLabel.text = @"资质认证";
    [authenticationView addSubview:authenticationTitleLabel];
    
    [authenticationTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-38);
    }];
    
    UIImageView *authenticationViewArrowImageView = [[UIImageView alloc] init];
    authenticationViewArrowImageView.contentMode = UIViewContentModeCenter;
    authenticationViewArrowImageView.image = [UIImage imageNamed:@"icon_hospital_arrow_gray"];
    [authenticationView addSubview:authenticationViewArrowImageView];
    
    [authenticationViewArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(13);
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(authenticationView);
    }];
    
    UIButton *authenticationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [authenticationView addSubview:authenticationButton];
    
    [authenticationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    [authenticationButton addTarget:self action:@selector(clickAuthenticationAction) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self.model.qualityCertifyFlag integerValue] != 3) {
        // 如果认证状态不是已认证, 那么则隐藏查看认证的入口
        authenticationView.hidden = true;
        
        [authenticationView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        
        self.contentHeight -= 52;
        
    }
    
    
    UILabel *lineLabel2 = [[UILabel alloc] init];
    lineLabel2.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel2];
    
    [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(authenticationView.mas_bottom);
    }];
    
    self.contentHeight += 1;
    
    
    CGFloat contentInfoHeight = 0;
    
    UIView *contentInfoView = [[UIView alloc] init];
    contentInfoView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:contentInfoView];
    
    [contentInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel2.mas_bottom);
    }];
    
    UILabel *doctorInfoTitleLabel = [[UILabel alloc] init];
    doctorInfoTitleLabel.font = HM18;
    doctorInfoTitleLabel.textColor = kDefaultBlackTextColor;
    doctorInfoTitleLabel.text = @"医生介绍";
    [contentInfoView addSubview:doctorInfoTitleLabel];
    
    [doctorInfoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.height.mas_equalTo(25);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
    }];
    
    UILabel *doctorGoodAtTitleLabel = [[UILabel alloc] init];
    doctorGoodAtTitleLabel.font = HM15;
    doctorGoodAtTitleLabel.textColor = kDefaultBlackTextColor;
    doctorGoodAtTitleLabel.text = @"擅长领域";
    [contentInfoView addSubview:doctorGoodAtTitleLabel];
    
    [doctorGoodAtTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(53);
        make.left.mas_equalTo(41);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(100);
    }];
    
    UIImageView *doctorGoodAtIconImageView = [[UIImageView alloc] init];
    doctorGoodAtIconImageView.contentMode = UIViewContentModeCenter;
    doctorGoodAtIconImageView.image = [UIImage imageNamed:@"doctor_goodat_new"];
    [contentInfoView addSubview:doctorGoodAtIconImageView];
    
    [doctorGoodAtIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(19);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(14);
        make.centerY.mas_equalTo(doctorGoodAtTitleLabel);
    }];
    
    UILabel *doctorGoodAtLabel = [[UILabel alloc] init];
    doctorGoodAtLabel.font = H15;
    doctorGoodAtLabel.textColor = kDefaultBlackTextColor;
    doctorGoodAtLabel.numberOfLines = 0;
    [contentInfoView addSubview:doctorGoodAtLabel];
    
    [doctorGoodAtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17);
        make.right.mas_equalTo(-17);
        make.top.mas_equalTo(doctorGoodAtTitleLabel.mas_bottom).offset(12);
    }];
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.maximumLineHeight = 21;
    paragraphStyle.minimumLineHeight = 21;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSMutableAttributedString *attr2 = [[NSMutableAttributedString alloc] initWithString:ISNIL(self.model.specialize)];
    
    [attr2 addAttributes:@{NSFontAttributeName: H15} range:NSMakeRange(0, attr2.string.length)];
    [attr2 addAttributes:@{NSForegroundColorAttributeName: kDefaultBlackTextColor} range:NSMakeRange(0, attr2.string.length)];
    
    [attr2 addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, attr2.string.length)];
    
    doctorGoodAtLabel.attributedText = attr2;
    
    
    
    CGFloat goodAtHeight = [ISNIL(self.model.specialize) getShouldHeightWithContent:ISNIL(self.model.specialize) withFont:H15 withWidth:(SCREENWIDTH - 32) withLineHeight:21] + 2;
    
    contentInfoHeight += 90;
    contentInfoHeight += goodAtHeight;
    
    [doctorGoodAtLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(goodAtHeight);
    }];
    
    UILabel *doctorIntroduceTitleLabel = [[UILabel alloc] init];
    doctorIntroduceTitleLabel.font = HM15;
    doctorIntroduceTitleLabel.textColor = kDefaultBlackTextColor;
    doctorIntroduceTitleLabel.text = @"职业经历";
    [contentInfoView addSubview:doctorIntroduceTitleLabel];
    
    [doctorIntroduceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(doctorGoodAtLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(41);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(100);
    }];
    
    UIImageView *doctorIntroduceIconImageView = [[UIImageView alloc] init];
    doctorIntroduceIconImageView.contentMode = UIViewContentModeCenter;
    doctorIntroduceIconImageView.image = [UIImage imageNamed:@"doctor_introduce_new"];
    [contentInfoView addSubview:doctorIntroduceIconImageView];
    
    [doctorIntroduceIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(19);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(14);
        make.centerY.mas_equalTo(doctorIntroduceTitleLabel);
    }];
    
    contentInfoHeight += 53;
    
    NSMutableAttributedString *attr3 = [[NSMutableAttributedString alloc] initWithString:ISNIL(self.model.doctorInfo)];
    
    [attr3 addAttributes:@{NSFontAttributeName: H15} range:NSMakeRange(0, attr3.string.length)];
    [attr3 addAttributes:@{NSForegroundColorAttributeName: kDefaultBlackTextColor} range:NSMakeRange(0, attr3.string.length)];
    
    [attr3 addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, attr3.string.length)];
    
    CGFloat shouldHeight = [ISNIL(self.model.doctorInfo) getShouldHeightWithContent:attr3.string withFont:H15 withWidth:SCREENWIDTH - 32 withLineHeight:21];
    
    self.contentTextHeight = shouldHeight;
    
    if (shouldHeight > 65) {
        shouldHeight = 65;
    }
    
    UIButton *arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [arrowButton setTitleColor:kDefaultGrayTextColor forState:UIControlStateNormal];
    arrowButton.titleLabel.font = H14;
    [arrowButton setImage:[UIImage imageNamed:@"ic_yiyuanzhuye_gengduo"] forState:UIControlStateNormal];
    [arrowButton setImage:[UIImage imageNamed:@"ic_yiyuanzhuye_shouqi"] forState:UIControlStateSelected];
    arrowButton.transform = CGAffineTransformMakeScale(-1, 1);
    arrowButton.titleLabel.transform = CGAffineTransformMakeScale(-1, 1);
    arrowButton.imageView.transform = CGAffineTransformMakeScale(-1, 1);
    [arrowButton setTitle:@"展开" forState:UIControlStateNormal];
    [arrowButton setTitle:@"收起" forState:UIControlStateSelected];
    arrowButton.backgroundColor = [UIColor whiteColor];
    [contentInfoView addSubview:arrowButton];
    
    [arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.top.bottom.mas_equalTo(doctorIntroduceTitleLabel);
    }];
    [arrowButton addTarget:self action:@selector(clickOpenAction:) forControlEvents:UIControlEventTouchUpInside];
    arrowButton.hidden = true;
    
    if (shouldHeight == 65) {
        arrowButton.hidden = false;
    }
    
    
    UILabel *doctorContentLabel = [[UILabel alloc] init];
    doctorContentLabel.numberOfLines = 0;
    doctorContentLabel.textColor = kDefaultBlackTextColor;
    doctorContentLabel.attributedText = attr3;
    doctorContentLabel.font = H15;
    [contentInfoView addSubview:doctorContentLabel];
    
    
    [doctorContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(doctorIntroduceTitleLabel.mas_bottom).offset(12);
        make.height.mas_equalTo(shouldHeight);
    }];
    self.contentLabel = doctorContentLabel;
    
    
    contentInfoHeight += shouldHeight;
    
    contentInfoHeight += 16;
    
    
    [contentInfoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(doctorContentLabel.mas_bottom).offset(16);
    }];
    
    self.contentHeight += contentInfoHeight;
    
    UILabel *lineLabel3 = [[UILabel alloc] init];
    lineLabel3.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel3];
    
    [lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(contentInfoView.mas_bottom);
    }];
    
    self.contentHeight += 10;
    
    
    UIView *locationAndTimeInfoView = [[UIView alloc] init];
    locationAndTimeInfoView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:locationAndTimeInfoView];
    
    [locationAndTimeInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel3.mas_bottom);
    }];
    
    UILabel *locationTitleLabel = [[UILabel alloc] init];
    locationTitleLabel.font = HM18;
    locationTitleLabel.textColor = kDefaultBlackTextColor;
    locationTitleLabel.text = @"出诊地点";
    [locationAndTimeInfoView addSubview:locationTitleLabel];
    
    [locationTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.height.mas_equalTo(25);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
    }];
    
    UILabel *hospitalNameLabel = [[UILabel alloc] init];
    hospitalNameLabel.font = H15;
    hospitalNameLabel.textColor = kDefaultBlackTextColor;
    hospitalNameLabel.text = ISNIL(self.model.hospitalName);
    [locationAndTimeInfoView addSubview:hospitalNameLabel];
    
    [hospitalNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(locationTitleLabel.mas_bottom).offset(12);
        make.height.mas_equalTo(21);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-88);
    }];
    
    UILabel *hospitalAddressLabel = [[UILabel alloc] init];
    hospitalAddressLabel.font = H13;
    hospitalAddressLabel.textColor = kDefaultGrayTextColor;
    hospitalAddressLabel.text = ISNIL(self.model.hospitalAddress);
    [locationAndTimeInfoView addSubview:hospitalAddressLabel];
    
    [hospitalAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hospitalNameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(21);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-88);
    }];
    
    UIImageView *hospitalAddressImageView = [[UIImageView alloc] init];
    hospitalAddressImageView.contentMode = UIViewContentModeCenter;
    hospitalAddressImageView.image = [UIImage imageNamed:@"icon_hospital_location"];
    [locationAndTimeInfoView addSubview:hospitalAddressImageView];
    
    [hospitalAddressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-26);
        make.width.height.mas_equalTo(28);
        make.top.mas_equalTo(47);
    }];
    
    UILabel *lineLabel4 = [[UILabel alloc] init];
    lineLabel4.backgroundColor = kDefaultGaryViewColor;
    [locationAndTimeInfoView addSubview:lineLabel4];
    
    [lineLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(114);
    }];
    
    self.contentHeight += 114;
    
    UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationAndTimeInfoView addSubview:locationButton];
    
    [locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(lineLabel4);
    }];
    [locationButton addTarget:self action:@selector(clickMapAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *timeTitleLabel = [[UILabel alloc] init];
    timeTitleLabel.font = HM18;
    timeTitleLabel.textColor = kDefaultBlackTextColor;
    timeTitleLabel.text = @"出诊时间";
    [locationAndTimeInfoView addSubview:timeTitleLabel];
    
    [timeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineLabel4.mas_bottom).offset(16);
        make.height.mas_equalTo(25);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
    }];
    
    self.contentHeight += 56;
    
    NSString *time = [[self.model.diagnosisTime componentsSeparatedByString:@","] componentsJoinedByString:@"; "];
    

    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = HM13;
    timeLabel.textColor = kDefaultBlackTextColor;
    
    if (time.length == 0) {
        time = @"未知";
        timeLabel.text = ISNIL(time);
    } else {
    
        time = [NSString stringWithFormat:@"%@; ", time];
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", time]];
        
        NSUInteger qian = 0;
        NSUInteger hou = 0;
        
        for(int i = 0; i < [time length]; i++)
        {
            NSString *temp = [time substringWithRange:NSMakeRange(i, 1)];
            
            if ([temp isEqualToString:@"("]) {
                
                qian = i;
                
            } else if ([temp isEqualToString:@" "]) {
                
                hou = i;
                
                [attr addAttributes:@{NSForegroundColorAttributeName: kDefaultGrayTextColor} range:NSMakeRange(qian, hou - qian)];
                
            }
            
        }
        
        timeLabel.attributedText = attr;
        
        
        //    [attr addAttributes:@{NSForegroundColorAttributeName: kDefaultBlueColor} range:NSMakeRange(0, text1.length)];
        //    [attr addAttributes:@{NSForegroundColorAttributeName: kDefaultBlueColor} range:NSMakeRange(text1.length + text2.length, text3.length)];
        //
        
    }
    
    timeLabel.numberOfLines = 2;
    [locationAndTimeInfoView addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeTitleLabel.mas_bottom).offset(12);
        make.height.mas_equalTo([time heightForFont:timeLabel.font width:SCREENWIDTH - 2] + 3);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
    }];
    
    [locationAndTimeInfoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(timeLabel.mas_bottom).offset(16);
    }];
    
    self.contentHeight += [time heightForFont:timeLabel.font width:SCREENWIDTH - 2] + 3;
    self.contentHeight += 16;
    
    UILabel *lineLabel5 = [[UILabel alloc] init];
    lineLabel5.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel5];
    
    [lineLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(locationAndTimeInfoView.mas_bottom);
    }];
    self.contentHeight += 10;
    
    GHDoctorDetailAnswerView *answerView = [[GHDoctorDetailAnswerView alloc] init];
    answerView.doctorId = self.model.modelId;
    answerView.doctorName = self.model.doctorName;
    [contentView addSubview:answerView];
    
    [answerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(96);
        make.top.mas_equalTo(lineLabel5.mas_bottom);
    }];
    self.answerView = answerView;
    
    self.contentHeight += 96;
    
    UILabel *lineLabel6 = [[UILabel alloc] init];
    lineLabel6.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel6];
    
    [lineLabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(answerView.mas_bottom);
    }];
    self.contentHeight += 4;
    
    
    
    self.headerView = contentView;
    contentView.frame = CGRectMake(0, 0, SCREENWIDTH, self.contentHeight);
    self.tableView.tableHeaderView = contentView;

    
}

- (void)clickOpenAction:(UIButton *)sender {
    
    if (sender.selected == false) {
        
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.contentTextHeight);
        }];
        
        sender.selected = true;
        
        self.headerView.frame = CGRectMake(0, 0, SCREENWIDTH, self.contentHeight - 65 + self.contentTextHeight);
        self.tableView.tableHeaderView = self.headerView;
        
    } else {
        
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(65);
        }];
        
        sender.selected = false;
        
        self.headerView.frame = CGRectMake(0, 0, SCREENWIDTH, self.contentHeight);
        self.tableView.tableHeaderView = self.headerView;
        
    }
    
}

- (void)clickAuthenticationAction {
    
    GHDoctorAuthenticationViewController *vc = [[GHDoctorAuthenticationViewController alloc] init];
    vc.qualification = [self.model.qualityCertifyMaterials jsonValueDecoded];
    [self.navigationController pushViewController:vc animated:true];

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

- (void)clickMapAction {
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"id"] = self.model.hospitalId;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiHospital withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[response[@"lat"] doubleValue] longitude:[response[@"lng"] doubleValue]];
            
            
            //终点坐标
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择地图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"用iPhone自带地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //当前位置
                MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
                MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
                //传入目的地，会显示在苹果自带地图上面目的地一栏
                toLocation.name = ISNIL(self.model.hospitalName);
                //导航方式选择
                [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                               launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
            }];
            
            [alert addAction:action];
            
            
            if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
            {
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"用高德地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    NSURL *myLocationScheme = [NSURL URLWithString:[[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&t=0",@"掌上优医",coordinate.latitude,coordinate.longitude,ISNIL(self.model.hospitalName)] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    
                    if ([[UIDevice currentDevice].systemVersion integerValue] >= 10) {
                        //iOS10以后,使用新API
                        [[UIApplication sharedApplication] openURL:myLocationScheme options:@{} completionHandler:^(BOOL success) { NSLog(@"scheme调用结束"); }];
                        
                    } else {
                        //iOS10以前,使用旧API
                        [[UIApplication sharedApplication] openURL:myLocationScheme];
                    }
                    
                    
                }];
                
                [alert addAction:action];
            }
            
            if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
                
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"用百度地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    NSURL *myLocationScheme = [NSURL URLWithString: [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name:%@&mode=driving&coord_type=gcj02",coordinate.latitude, coordinate.longitude, ISNIL(self.model.hospitalName)] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    
                    if ([[UIDevice currentDevice].systemVersion integerValue] >= 10) {
                        //iOS10以后,使用新API
                        [[UIApplication sharedApplication] openURL:myLocationScheme options:@{} completionHandler:^(BOOL success) { NSLog(@"scheme调用结束"); }];
                        
                    } else {
                        //iOS10以前,使用旧API
                        [[UIApplication sharedApplication] openURL:myLocationScheme];
                    }
                    
                    
                }];
                
                [alert addAction:action];
                
            }
            
            if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
                
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"用腾讯地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    NSURL *myLocationScheme = [NSURL URLWithString: [[NSString stringWithFormat:@"qqmap://map/routeplan?fromcoord=CurrentLocation&type=drive&to=%@&tocoord=%f,%f&policy=1",ISNIL(self.model.hospitalName), coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    
                    if ([[UIDevice currentDevice].systemVersion integerValue] >= 10) {
                        //iOS10以后,使用新API
                        [[UIApplication sharedApplication] openURL:myLocationScheme options:@{} completionHandler:^(BOOL success) { NSLog(@"scheme调用结束"); }];
                        
                    } else {
                        //iOS10以前,使用旧API
                        [[UIApplication sharedApplication] openURL:myLocationScheme];
                    }
                    
                    
                }];
                
                [alert addAction:action];
                
            }
            
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
                
            }];
            
        }
        
    }];
    
}


- (void)clickMoreCommentAction {
    
    GHDoctorCommentListViewController *vc = [[GHDoctorCommentListViewController alloc] init];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:true];
    
}


#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.commentArray.count) {
        return 1;
    } else {
        return 0;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.commentArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHDoctorCommentModel *model = [self.commentArray objectOrNilAtIndex:indexPath.row];
    
    return [model.shouldHeight floatValue];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 56;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.moreCommentView;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    GHDoctorCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHDoctorCommentTableViewCell"];
    
    if (!cell) {
        cell = [[GHDoctorCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHDoctorCommentTableViewCell"];
    }
    
    cell.model = [self.commentArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHDoctorCommentModel *model = [self.commentArray objectOrNilAtIndex:indexPath.row];
    
    GHMyCommentsDetailViewController *vc = [[GHMyCommentsDetailViewController alloc] init];
    vc.model = [[GHMyCommentsModel alloc] initWithDictionary:[model toDictionary] error:nil];
    vc.model.score = [NSString stringWithFormat:@"%ld", [model.score integerValue] * 10];
    [self.navigationController pushViewController:vc animated:true];
    
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


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end


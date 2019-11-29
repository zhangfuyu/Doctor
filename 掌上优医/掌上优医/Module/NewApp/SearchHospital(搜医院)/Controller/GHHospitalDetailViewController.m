//
//  GHHospitalDetailViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/25.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHospitalDetailViewController.h"
#import "SDCycleScrollView.h"

#import "GHZuJiHospitalModel.h"

#import "GHNHospitalRecordModel.h"

#import <MapKit/MapKit.h>
#import "GHCommonShareView.h"

#import "GHMyCommentsModel.h"
#import "GHMyCommentsDetailViewController.h"
#import "GHHospitalDetailCommentTableViewCell.h"

#import "GHHospitalDetailInfoErrorViewController.h"

#import "GHHospitlAuthenticationViewController.h"

#import "GHHospitalCommentViewController.h"

#import "GHHospitalCommentDetailViewController.h"

#import "GHHospitalCommentListViewController.h"

#import "GHHospitalDepartmentDoctorListViewController.h"

#import "GHHospitalDepartmentViewController.h"

//#define ForegroundStarImage @"ic_huanzhepingjia_pingfenxing"
//#define BackgroundStarImage @"ic_huanzhepingjia_pingfenxing_unselected"

#define ForegroundStarImage @"ic_xingxing_all_selected"
#define BackgroundStarImage @"ic_xingxing_all_unselected"

@interface GHHospitalDetailViewController ()<SDCycleScrollViewDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) GHCommonShareView *shareView;

@property (nonatomic, strong) NSString *urlStr;

@property (nonatomic, strong) UIView *navigationView;

@property (nonatomic, strong) UITableView *tableView;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIView *headerView;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIButton *collectionButton;


/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *contentLabel;

/**
 <#Description#>
 */
@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, assign) CGFloat contentTextHeight;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) NSMutableArray *commentArray;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIView *moreCommentView;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *commentTotalLabel;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *departmentTitleArray;

/**
 特色科室信息数组
 */
@property (nonatomic, strong) NSMutableArray *departmentInfoArray;

/**
 全部科室的名称
 */
@property (nonatomic, strong) NSString *allDepartmentStr;

@property (nonatomic, assign) BOOL isHaveDepartment;

@end

@implementation GHHospitalDetailViewController

- (NSMutableArray *)departmentTitleArray {
    
    if (!_departmentTitleArray) {
        _departmentTitleArray = [[NSMutableArray alloc] init];
    }
    return _departmentTitleArray;
    
}

- (NSMutableArray *)departmentInfoArray {
    
    if (!_departmentInfoArray) {
        _departmentInfoArray = [[NSMutableArray alloc] init];
    }
    return _departmentInfoArray;
    
}

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
        _shareView.title = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.hospitalName)];
        _shareView.desc = @"了解医疗知识，关注健康生活。";
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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"医院主页";
    
    self.moreCommentView.hidden = false;
    
    self.urlStr = [[GHNetworkTool shareInstance] getHospitalDetailURLWithHospitalId:self.model.modelId];
    
    [self addNavigationRightView];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"id"] = self.model.modelId;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiHospital withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            self.model = [[GHSearchHospitalModel alloc] initWithDictionary:response error:nil];
            
//            if ([self.model.categoryByScale isEqualToString:@"综合医院"]) {
            
                NSMutableDictionary *sonParams = [[NSMutableDictionary alloc] init];
                sonParams[@"hospitalId"] = self.model.modelId;
                
                [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiHospitalDepartments withParameter:sonParams withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                   
                    if (isSuccess) {
                        
                        NSInteger allDepartmentCount = 0;
                        
                        for (NSDictionary *dic in response) {
                            
                            // 特色科室只有一级科室
                            if ([dic[@"departmentLevel"] integerValue] == 1 && [dic[@"characteristicDepartmentFlag"] integerValue] == 1) {
                                
                                NSString *departmentStr = [NSString stringWithFormat:@"%@(%ld位)", dic[@"departmentName"], [dic[@"doctorCount"] integerValue]];
                                
                                [self.departmentTitleArray addObject:departmentStr];
                                
                                [self.departmentInfoArray addObject:dic];
                                
                            }
                            
                            if ([dic[@"departmentLevel"] integerValue] == 2) {
                                
                                allDepartmentCount += 1;
                                
                            }
                            
                        }
                        
                        self.allDepartmentStr = [NSString stringWithFormat:@"该医院全部科室(%ld个)", allDepartmentCount];
                        
                        if (allDepartmentCount > 0) {
                            self.isHaveDepartment = true;
                        } else {
                            self.isHaveDepartment = false;
                        }
                        
                        [self setupUI];
                        
                        
                        GHZuJiHospitalModel *model = [[GHZuJiHospitalModel alloc] init];
                        
                        model.modelId = self.model.modelId;
                        model.hospitalName = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.hospitalName)];
                        model.grade = self.model.hospitalGrade;
                        model.category = self.model.category;
                        model.profilePhoto = self.model.profilePhoto;
                        
                        model.hospitalAddress = self.model.hospitalAddress;
                        
                        model.contactNumber = self.model.contactNumber;
                        model.choiceDepartments = self.model.choiceDepartments;
                        
                        
                        model.medicalInsuranceFlag = self.model.medicalInsuranceFlag;
                        
                        model.introduction = self.model.introduction;
                        
                        
                        model.pictures = self.model.profilePhoto;
                        
                        
                        if (model) {
                            [[GHSaveDataTool shareInstance] addObject:model withType:GHSaveDataType_Hospital];
                        }
                        
                        GHNHospitalRecordModel *recordModel = [[GHNHospitalRecordModel alloc] init];
                        
                        recordModel.modelId = self.model.modelId;
                        recordModel.hospitalName = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.hospitalName)];
                        recordModel.grade = self.model.hospitalGrade;
                        recordModel.category = self.model.category;
                        recordModel.profilePhoto = self.model.profilePhoto;
                        
                        recordModel.score = self.model.score;
                        
                        recordModel.hospitalAddress = self.model.hospitalAddress;
                        
                        recordModel.contactNumber = self.model.contactNumber;
                        recordModel.choiceDepartments = self.model.choiceDepartments;
                        
                        
                        recordModel.medicalInsuranceFlag = self.model.medicalInsuranceFlag;
                        
                        recordModel.introduction = self.model.introduction;
                        
                        
                        recordModel.pictures = self.model.profilePhoto;
                        
                        recordModel.medicineType = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.medicineType)];;
                        recordModel.governmentalHospitalFlag = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.governmentalHospitalFlag)];;
                        
                        if (recordModel) {
                            [[GHSaveDataTool shareInstance] addObjectToCommentHospitalRecord:recordModel];
                            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationHospitalRecordShouldReload object:nil];
                        }
                        
                        
                        if ([GHUserModelTool shareInstance].isLogin) {
                            [self getCollectionData];
                        }
                        
                        [self getDataAction];
                        
                        
                    }
                    
                }];
                
//            } else {
//
//                [self setupUI];
//
//
//                GHZuJiHospitalModel *model = [[GHZuJiHospitalModel alloc] init];
//
//                model.modelId = self.model.modelId;
//                model.hospitalName = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.hospitalName)];
//                model.grade = self.model.grade;
//                model.category = self.model.category;
//                model.profilePhoto = self.model.profilePhoto;
//
//                model.hospitalAddress = self.model.hospitalAddress;
//
//                model.contactNumber = self.model.contactNumber;
//                model.choiceDepartments = self.model.choiceDepartments;
//
//
//                model.medicalInsuranceFlag = self.model.medicalInsuranceFlag;
//
//                model.introduction = self.model.introduction;
//
//
//                model.pictures = self.model.profilePhoto;
//
//
//                if (model) {
//                    [[GHSaveDataTool shareInstance] addObject:model withType:GHSaveDataType_Hospital];
//                }
//
//                GHNHospitalRecordModel *recordModel = [[GHNHospitalRecordModel alloc] init];
//
//                recordModel.modelId = self.model.modelId;
//                recordModel.hospitalName = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.hospitalName)];
//                recordModel.grade = self.model.grade;
//                recordModel.category = self.model.category;
//                recordModel.profilePhoto = self.model.profilePhoto;
//
//                recordModel.score = self.model.score;
//
//                recordModel.hospitalAddress = self.model.hospitalAddress;
//
//                recordModel.contactNumber = self.model.contactNumber;
//                recordModel.choiceDepartments = self.model.choiceDepartments;
//
//
//                recordModel.medicalInsuranceFlag = self.model.medicalInsuranceFlag;
//
//                recordModel.introduction = self.model.introduction;
//
//
//                recordModel.pictures = self.model.profilePhoto;
//
//                recordModel.medicineType = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.medicineType)];;
//                recordModel.governmentalHospitalFlag = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.governmentalHospitalFlag)];;
//
//                if (recordModel) {
//                    [[GHSaveDataTool shareInstance] addObjectToCommentHospitalRecord:recordModel];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationHospitalRecordShouldReload object:nil];
//                }
//
//
//                if ([GHUserModelTool shareInstance].isLogin) {
//                    [self getCollectionData];
//                }
//
//                [self getDataAction];
//
//
//            }
            
        
        }
        
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDataAction) name:kNotificationHospitalCommentSuccess object:nil];
    
    
}

- (void)getDataAction {

    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"id"] = self.model.modelId;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiHospital withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            self.model = [[GHSearchHospitalModel alloc] initWithDictionary:response error:nil];
            
            self.commentTotalLabel.text = [NSString stringWithFormat:@"(共 %ld 条)", [self.model.commentCount integerValue]];
            
        }
        
    }];
    
    NSMutableDictionary *sonParams = [[NSMutableDictionary alloc] init];
    sonParams[@"pageSize"] = @(3);
    sonParams[@"from"] = @(0);
    sonParams[@"hospitalId"] = ISNIL(self.model.modelId);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiHospitalComments withParameter:sonParams withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [self.commentArray removeAllObjects];
        
        if (isSuccess) {
            
            
            
            for (NSDictionary *dicInfo in response) {
                
                GHMyCommentsModel *model = [[GHMyCommentsModel alloc] initWithDictionary:dicInfo error:nil];
                
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
                    
                    model.shouldHeight = @([model.contentHeight floatValue] + 198 + 190 - 25 + 45 - 120);
                    
                } else if (pictureArray.count == 0) {
                    
                    model.shouldHeight = @([model.contentHeight floatValue] + 190 - 25 + 45 - 120);
                    
                } else {
                    
                    model.shouldHeight = @([model.contentHeight floatValue] + 198 + 95 - 25 + 45 - 120);
                    
                }
                
                [self.commentArray addObject:model];
                
            }
            
            [self.tableView reloadData];
            

            
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

- (void)getCollectionData {
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiMyFavoriteHospitals withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            for (NSDictionary *dicInfo in response) {
                
                if ([dicInfo[@"contentId"] longValue] == [self.model.modelId longValue]) {
                    
                    
                    self.model.collectionId = [NSString stringWithFormat:@"%ld", [dicInfo[@"id"] longValue]];
                    
                    self.collectionButton.selected = true;
                    
                    break;
                    
                }
                
                
            }
            
        }
        
    }];
    
}


- (void)clickCollectionAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        if (self.collectionButton.selected == true) {
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"id"] = ISNIL(self.model.collectionId);
            
            [SVProgressHUD showWithStatus:kDefaultTipsText];
            
            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_DELETE withUrl:kApiMyDonotConllection  withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
                
                
                
                if (isSuccess) {
                    
                    [SVProgressHUD dismiss];
                    
                    [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
                    
                    self.collectionButton.selected = false;
                    
                    self.model.collectionId = nil;
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCancelDoctorCollectionSuccess object:nil];
                    
                }
                
            }];
            
        } else {
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"contentId"] = ISNIL(self.model.modelId);
            
            params[@"title"] = ISNIL(self.model.hospitalName);
            params[@"userId"] = ISNIL([GHUserModelTool shareInstance].userInfoModel.modelId);
            
            [SVProgressHUD showWithStatus:kDefaultTipsText];
            
            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiDoConllection withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
                
                if (isSuccess) {
                    
                    [SVProgressHUD dismiss];
                    
                    [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
                    self.collectionButton.selected = true;
                    
                    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiMyFavoriteHospitals withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
                        
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

- (void)clickCommentAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        GHHospitalCommentViewController *vc = [[GHHospitalCommentViewController alloc] init];
        
        vc.model = self.model;
        
        [self.navigationController pushViewController:vc animated:true];
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self presentViewController:vc animated:true completion:nil];
        
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHMyCommentsModel *model = [self.commentArray objectOrNilAtIndex:indexPath.row];
    
    return [model.shouldHeight floatValue];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (self.commentArray.count == 0) {
        return 0;
    }
    
    return 56;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.moreCommentView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHHospitalDetailCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHHospitalDetailCommentTableViewCell"];
    
    if (!cell) {
        cell = [[GHHospitalDetailCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHHospitalDetailCommentTableViewCell"];
    }
    
    cell.model = [self.commentArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)clickMoreCommentAction {
    
    GHHospitalCommentListViewController *vc = [[GHHospitalCommentListViewController alloc] init];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    GHHospitalCommentDetailViewController *vc = [[GHHospitalCommentDetailViewController alloc] init];
    
    vc.model = [self.commentArray objectOrNilAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:true];
    
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
    [errorButton addTarget:self action:@selector(clickErrorAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.textColor = kDefaultGrayTextColor;
    textLabel.font = H11;
    textLabel.text = @"以上信息，来源于用户自行申报及工商系统数据，具体以工商部门登记为准．用户需保证信息真实有效，平台也将定期核查，如与实际不符，如有疑问，请联系平台客服";
    textLabel.numberOfLines = 0;
    [view addSubview:textLabel];
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(errorButton.mas_bottom);
        make.bottom.mas_equalTo(-10);
    }];
    
}

- (void)setupTableHeaderView {
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    

    self.contentHeight = 0;
    
    UIScrollView *infoScrollView = [[UIScrollView alloc] init];
    infoScrollView.frame = CGRectMake(0, 0, SCREENWIDTH, HScaleHeight(184));
    infoScrollView.backgroundColor = [UIColor whiteColor];
    infoScrollView.showsVerticalScrollIndicator = false;
    infoScrollView.showsHorizontalScrollIndicator = false;
    [contentView addSubview:infoScrollView];
    
    NSMutableArray *urlArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in [self.model.pictures jsonValueDecoded]) {
        [urlArray addObject:ISNIL(dic[@"url"])];
    }
    
    
    for (NSInteger index = 0; index < urlArray.count; index++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.tag = index;
        
        imageView.userInteractionEnabled = true;
        imageView.width = SCREENWIDTH - 16 - 26;
        imageView.height = HScaleHeight(160);
        imageView.mj_y = HScaleHeight(10);
        imageView.mj_x = 16 + (SCREENWIDTH - 16 - 26 + 10) * index;
        [imageView sd_setImageWithURL:kGetBigImageURLWithString([urlArray objectOrNilAtIndex:index]) placeholderImage:[UIImage imageNamed:@"hospital_detail_placeholder"]];
        
        [infoScrollView addSubview:imageView];
        
        if (urlArray.count == 1) {
            imageView.width = SCREENWIDTH - 16 - 16;
        }
        
        imageView.layer.cornerRadius = 4;
        imageView.layer.masksToBounds = true;
        
        UIButton *signButton = [UIButton buttonWithType:UIButtonTypeCustom];
        signButton = signButton;
        signButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        signButton.titleLabel.font = H14;
        
        [signButton setImage:[UIImage imageNamed:@"hospital_image_sign"] forState:UIControlStateNormal];
        [signButton setTitle:[NSString stringWithFormat:@" %ld", urlArray.count] forState:UIControlStateNormal];
        
        signButton.layer.cornerRadius = 12.5;
        signButton.layer.masksToBounds = true;
        
        signButton.width = 50;
        signButton.height = 25;
        signButton.mj_y = MaxY(imageView) - 25 - 8;
        signButton.mj_x = MaxX(imageView) - 50 - 8;
        [infoScrollView addSubview:signButton];
        
        UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPhotoAction:)];
        [imageView addGestureRecognizer:tapGr];
        
    }
    
    if (urlArray.count == 0) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.layer.cornerRadius = 4;
        imageView.layer.masksToBounds = true;
        imageView.size = CGSizeMake(SCREENWIDTH - 16 - 16, HScaleHeight(160));
        imageView.mj_y = HScaleHeight(10);
        imageView.mj_x = 16;
        imageView.image = [UIImage imageNamed:@"hospital_detail_placeholder"];
        [infoScrollView addSubview:imageView];
        
        infoScrollView.contentSize = CGSizeMake(SCREENWIDTH, HScaleHeight(180));
        
    } else if (urlArray.count == 1) {
        
        infoScrollView.contentSize = CGSizeMake(SCREENWIDTH, HScaleHeight(180));
        
    } else {
        infoScrollView.contentSize = CGSizeMake(32 - 10 + (SCREENWIDTH - 16 - 26 + 10) * urlArray.count, HScaleHeight(180));
    }
    
    self.contentHeight += HScaleHeight(180);
    
    
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kDefaultBlackTextColor;
    nameLabel.font = [UIFont boldSystemFontOfSize:24];
    nameLabel.text = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.hospitalName)];
    nameLabel.numberOfLines = 0;
    [contentView addSubview:nameLabel];
    
    CGFloat nameLabelHeight = [ISNIL(nameLabel.text) heightForFont:[UIFont boldSystemFontOfSize:24] width:(SCREENWIDTH - 40)];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(nameLabelHeight);
        make.top.mas_equalTo(infoScrollView.mas_bottom).offset(5);
    }];
    
    self.contentHeight += 5;
    self.contentHeight += nameLabelHeight;
    
    
    
    NSArray *imageNameArray = @[@"icon_hospital_level", @"icon_hospital_category", @"icon_hospital_yibao", @"icon_hospital_sigong"];
    NSArray *titleArray = @[ISNIL(self.model.hospitalGrade),
                            ISNIL(self.model.category),
                            [self.model.medicalInsuranceFlag integerValue] == 0 ? @"不支持医保" : @"支持医保",
                            [self.model.governmentalHospitalFlag integerValue] == 0 ? @"私立" : @"公立"
                            ];
    
    CGFloat shouldX = 14;
    
    for (NSInteger index = 0; index < imageNameArray.count; index++) {
        
        shouldX += 8;
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        iconImageView.image = [UIImage imageNamed:ISNIL([imageNameArray objectOrNilAtIndex:index])];
        iconImageView.mj_x = shouldX;
        iconImageView.width = 15;
        iconImageView.height = 15;
        iconImageView.mj_y = HScaleHeight(180) + 5 + 13 + [ISNIL(nameLabel.text) heightForFont:[UIFont boldSystemFontOfSize:24] width:(SCREENWIDTH - 40)];
        [contentView addSubview:iconImageView];
        
        shouldX += 15;
        
        shouldX += 4;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = H12;
        titleLabel.textColor = kDefaultGrayTextColor;
        titleLabel.text = ISNIL([titleArray objectOrNilAtIndex:index]);
        titleLabel.mj_x = shouldX;
        titleLabel.width = [titleLabel.text widthForFont:H12] + 2;
        titleLabel.height = 15;
        titleLabel.mj_y = iconImageView.mj_y;
        [contentView addSubview:titleLabel];
        
        shouldX += [titleLabel.text widthForFont:H12] + 2;
        
    }
    
    NSArray *tagArray = [self.model.hospitalTags componentsSeparatedByString:@","];
    
    shouldX = 22;
    
    for (NSInteger index = 0; index < tagArray.count + 1; index++) {
        
        UILabel *bgLabel = [[UILabel alloc] init];
        bgLabel.backgroundColor = UIColorHex(0xFF6188);
        bgLabel.alpha = 0.15;
        bgLabel.layer.cornerRadius = 2.5;
        bgLabel.layer.masksToBounds = true;
        [contentView addSubview:bgLabel];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = H12;
        
        titleLabel.textColor = UIColorHex(0xFF6188);
        if (index == 0) {
            titleLabel.text = ISNIL(self.model.medicineType);
        } else {
            titleLabel.text = ISNIL([tagArray objectOrNilAtIndex:index - 1]);
        }
        
        if (titleLabel.text.length == 0) {
            titleLabel.hidden = true;
            bgLabel.hidden = true;
        }
        
        bgLabel.mj_x = shouldX;
        bgLabel.width = [titleLabel.text widthForFont:H12] + 6;
        bgLabel.height = 18;
        bgLabel.mj_y = HScaleHeight(180) + 5 + 13 + [ISNIL(nameLabel.text) heightForFont:[UIFont boldSystemFontOfSize:24] width:(SCREENWIDTH - 40)] + 30;
        
        titleLabel.frame = bgLabel.frame;
        [contentView addSubview:titleLabel];
        
        
        shouldX += [titleLabel.text widthForFont:H12] + 6 + 4;
        
    }
    
    
    
    UILabel *lineLabel1 = [[UILabel alloc] init];
    lineLabel1.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel1];
    
    if (tagArray.count == 0 && self.model.medicineType.length == 0) {
        // 一个标签都没有
        [lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(nameLabel.mas_bottom).offset(40);
        }];
        
        self.contentHeight += 40;
        
    } else {
        
        [lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(nameLabel.mas_bottom).offset(75);
        }];
        
        self.contentHeight += 75;
        
    }

    
    UIView *scoreView = [[UIView alloc] init];
    scoreView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:scoreView];
    
    [scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel1.mas_bottom);
        make.height.mas_equalTo(45);
    }];
    
    self.contentHeight += 45;
    
    UIImageView *backgroundStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:BackgroundStarImage]];
    backgroundStarView.contentMode = UIViewContentModeLeft;
    backgroundStarView.clipsToBounds = true;
    [scoreView addSubview:backgroundStarView];
    
    [backgroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(15 * 5);
        make.top.mas_equalTo(11.5);
    }];
    
    UIImageView *foregroundStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:ForegroundStarImage]];
    foregroundStarView.contentMode = UIViewContentModeLeft;
    foregroundStarView.clipsToBounds = true;
    [scoreView addSubview:foregroundStarView];
    
    [foregroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(15 * .5 * [self.model.score floatValue]);
        make.top.mas_equalTo(11.5);
    }];
    
    UILabel *hospitalScoreLabel = [[UILabel alloc] init];
    hospitalScoreLabel.textColor = UIColorHex(0xFF6188);
    hospitalScoreLabel.font = HM14;
    hospitalScoreLabel.text = [NSString stringWithFormat:@"%.1f分", [self.model.score floatValue]];
    [scoreView addSubview:hospitalScoreLabel];
    
    [hospitalScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.left.mas_equalTo(backgroundStarView.mas_right).offset(5);
        make.top.bottom.mas_equalTo(backgroundStarView);
    }];
    
    UILabel *hospitalOtherScoreLabel = [[UILabel alloc] init];
    hospitalOtherScoreLabel.font = H12;
    hospitalOtherScoreLabel.textColor = kDefaultGrayTextColor;
    hospitalOtherScoreLabel.text = [NSString stringWithFormat:@"环境: %.1f分   服务: %.1f分", [self.model.environmentScore floatValue], [self.model.serviceScore floatValue]];
    [scoreView addSubview:hospitalOtherScoreLabel];
    
    [hospitalOtherScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(155);
        make.top.bottom.mas_equalTo(hospitalScoreLabel);
        make.right.mas_equalTo(0);
    }];
    
    
    UILabel *lineLabel2 = [[UILabel alloc] init];
    lineLabel2.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel2];
    
    [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(scoreView.mas_bottom).offset(0);
    }];
    self.contentHeight += 10;
    
    UIView *authenticationView = [[UIView alloc] init];
    authenticationView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:authenticationView];
    
    [authenticationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel2.mas_bottom);
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
        
        authenticationView.hidden = true;
        
        [authenticationView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        
        self.contentHeight -= 52;
        
        lineLabel2.hidden = true;
        
        [lineLabel2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        
        self.contentHeight -= 10;
        
    }
    
    UILabel *lineLabel3 = [[UILabel alloc] init];
    lineLabel3.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel3];
    
    [lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(authenticationView.mas_bottom).offset(0);
    }];
    
    self.contentHeight += 10;
    
    //    认证材料
    //    self.model.qualityCertifyMaterials
    
    CGFloat contentInfoHeight = 0;
    
    UIView *contentInfoView = [[UIView alloc] init];
    contentInfoView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:contentInfoView];
    
    [contentInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel3.mas_bottom);
    }];
    
    UIView *contentAddressInfoView = [[UIView alloc] init];
    contentAddressInfoView.backgroundColor = [UIColor whiteColor];
    [contentInfoView addSubview:contentAddressInfoView];
    
    [contentAddressInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(65);
    }];
    
    contentInfoHeight += 49;
    contentInfoHeight += 21;
    contentInfoHeight += 5;
    
    
    UIImageView *hospitalAddressIconImageView = [[UIImageView alloc] init];
    hospitalAddressIconImageView.contentMode = UIViewContentModeCenter;
    hospitalAddressIconImageView.image = [UIImage imageNamed:@"icon_hospital_info_location"];
    [contentAddressInfoView addSubview:hospitalAddressIconImageView];
    
    [hospitalAddressIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(49);
        make.top.mas_equalTo(0);
    }];
    
    
    UILabel *hospitalAddressTitleLabel = [[UILabel alloc] init];
    hospitalAddressTitleLabel.font = HM15;
    hospitalAddressTitleLabel.textColor = kDefaultBlackTextColor;
    hospitalAddressTitleLabel.text = @"医院地址";
    [contentAddressInfoView addSubview:hospitalAddressTitleLabel];
    
    [hospitalAddressTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(38);
        make.height.mas_equalTo(49);
        make.width.mas_equalTo(100);
    }];
    
    UIImageView *hospitalAddressImageView = [[UIImageView alloc] init];
    hospitalAddressImageView.contentMode = UIViewContentModeCenter;
    hospitalAddressImageView.image = [UIImage imageNamed:@"icon_hospital_location"];
    [contentAddressInfoView addSubview:hospitalAddressImageView];
    
    [hospitalAddressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-26);
        make.width.height.mas_equalTo(28);
        make.top.mas_equalTo(16);
    }];
    
    UILabel *hospitalAddressValueLabel = [[UILabel alloc] init];
    hospitalAddressValueLabel.font = H15;
    hospitalAddressValueLabel.textColor = kDefaultBlackTextColor;
    hospitalAddressValueLabel.text = ISNIL(self.model.hospitalAddress);
    [contentAddressInfoView addSubview:hospitalAddressValueLabel];
    
    [hospitalAddressValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(49);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(21);
        make.left.mas_equalTo(16);
    }];
    
    UIButton *hospitalAddressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentAddressInfoView addSubview:hospitalAddressButton];
    
    [hospitalAddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    [hospitalAddressButton addTarget:self action:@selector(clickLocationAction) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *contactPhoneArray = [self.model.contactNumber componentsSeparatedByString:@","];
    
    UIView *contentPhoneInfoView = [[UIView alloc] init];
    contentPhoneInfoView.backgroundColor = [UIColor whiteColor];
    [contentInfoView addSubview:contentPhoneInfoView];
    
    [contentPhoneInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(contentInfoHeight);
        make.height.mas_equalTo(49 + 5 + (21 + 5) * contactPhoneArray.count);
    }];
    
    contentInfoHeight += 49;
    contentInfoHeight += (21 + 5) * contactPhoneArray.count;
    contentInfoHeight += 5;
    
    
    UIImageView *hospitalContactIconImageView = [[UIImageView alloc] init];
    hospitalContactIconImageView.contentMode = UIViewContentModeCenter;
    hospitalContactIconImageView.image = [UIImage imageNamed:@"icon_hospital_info_phone"];
    [contentPhoneInfoView addSubview:hospitalContactIconImageView];
    
    [hospitalContactIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(49);
        make.top.mas_equalTo(0);
    }];
    
    
    UILabel *hospitalContactTitleLabel = [[UILabel alloc] init];
    hospitalContactTitleLabel.font = HM15;
    hospitalContactTitleLabel.textColor = kDefaultBlackTextColor;
    hospitalContactTitleLabel.text = @"联系电话";
    [contentPhoneInfoView addSubview:hospitalContactTitleLabel];
    
    [hospitalContactTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(38);
        make.height.mas_equalTo(49);
        make.width.mas_equalTo(100);
    }];
    
    UIImageView *hospitalContactImageView = [[UIImageView alloc] init];
    hospitalContactImageView.contentMode = UIViewContentModeCenter;
    hospitalContactImageView.image = [UIImage imageNamed:@"icon_hospital_call"];
    [contentPhoneInfoView addSubview:hospitalContactImageView];
    
    [hospitalContactImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-26);
        make.width.height.mas_equalTo(28);
        make.top.mas_equalTo(16);
    }];
    
    for (NSInteger index = 0; index < contactPhoneArray.count; index++) {
        
        UILabel *hospitalContactValueLabel = [[UILabel alloc] init];
        hospitalContactValueLabel.font = H15;
        hospitalContactValueLabel.textColor = kDefaultBlackTextColor;
        hospitalContactValueLabel.text = [contactPhoneArray objectOrNilAtIndex:index];
        [contentPhoneInfoView addSubview:hospitalContactValueLabel];
        
        [hospitalContactValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(49 + (21 + 5) * index);
            make.right.mas_equalTo(-16);
            make.height.mas_equalTo(21);
            make.left.mas_equalTo(16);
        }];
        
    }
    
    UIButton *hospitalContactButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentPhoneInfoView addSubview:hospitalContactButton];
    
    [hospitalContactButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    [hospitalContactButton addTarget:self action:@selector(clickPhoneAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.maximumLineHeight = 21;
    paragraphStyle.minimumLineHeight = 21;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:ISNIL(self.model.introduction)];
    
    [attr addAttributes:@{NSFontAttributeName: H15} range:NSMakeRange(0, attr.string.length)];
    [attr addAttributes:@{NSForegroundColorAttributeName: kDefaultBlackTextColor} range:NSMakeRange(0, attr.string.length)];
    
    [attr addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, attr.string.length)];
    
    CGFloat shouldHeight = [ISNIL(self.model.introduction) getShouldHeightWithContent:attr.string withFont:H15 withWidth:SCREENWIDTH - 32 withLineHeight:21];
    
    self.contentTextHeight = shouldHeight;
    
    if (shouldHeight > 88) {
        shouldHeight = 88;
    }
    
    UIView *contentIntrudeInfoView = [[UIView alloc] init];
    contentIntrudeInfoView.backgroundColor = [UIColor whiteColor];
    [contentInfoView addSubview:contentIntrudeInfoView];
    
    [contentIntrudeInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(contentInfoHeight);
    }];
    
    contentInfoHeight += 49;
    contentInfoHeight += shouldHeight;
    contentInfoHeight += 16;
    
    UIImageView *hospitalIntrudeIconImageView = [[UIImageView alloc] init];
    hospitalIntrudeIconImageView.contentMode = UIViewContentModeCenter;
    hospitalIntrudeIconImageView.image = [UIImage imageNamed:@"icon_hospital_info_intruder"];
    [contentIntrudeInfoView addSubview:hospitalIntrudeIconImageView];
    
    [hospitalIntrudeIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(49);
        make.top.mas_equalTo(0);
    }];
    
    UILabel *hospitalIntruderTitleLabel = [[UILabel alloc] init];
    hospitalIntruderTitleLabel.font = HM15;
    hospitalIntruderTitleLabel.textColor = kDefaultBlackTextColor;
    hospitalIntruderTitleLabel.text = @"医院简介";
    [contentIntrudeInfoView addSubview:hospitalIntruderTitleLabel];
    
    [hospitalIntruderTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(38);
        make.height.mas_equalTo(49);
        make.width.mas_equalTo(100);
    }];
    
    
    
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
    [contentIntrudeInfoView addSubview:arrowButton];
    
    [arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.top.bottom.mas_equalTo(hospitalIntruderTitleLabel);
    }];
    [arrowButton addTarget:self action:@selector(clickOpenAction:) forControlEvents:UIControlEventTouchUpInside];
    arrowButton.hidden = true;
    
    if (shouldHeight == 88) {
        arrowButton.hidden = false;
    }
    
    self.contentHeight += contentInfoHeight;
    
    UILabel *hospitalContentLabel = [[UILabel alloc] init];
    hospitalContentLabel.numberOfLines = 0;
    hospitalContentLabel.textColor = kDefaultBlackTextColor;
    hospitalContentLabel.attributedText = attr;
    hospitalContentLabel.font = H15;
    [contentIntrudeInfoView addSubview:hospitalContentLabel];
    
    
    [hospitalContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(49);
        make.height.mas_equalTo(shouldHeight);
    }];
    self.contentLabel = hospitalContentLabel;
    
    [contentIntrudeInfoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(hospitalContentLabel.mas_bottom).offset(6);
    }];
    
    [contentInfoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(contentIntrudeInfoView.mas_bottom).offset(10);
    }];
    
    UILabel *lineLabel4 = [[UILabel alloc] init];
    lineLabel4.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel4];
    
    [lineLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(contentInfoView.mas_bottom).offset(0);
    }];
    self.contentHeight += 10;
    
    UIView *timeContentView = [[UIView alloc] init];
    timeContentView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:timeContentView];
    
    [timeContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel4.mas_bottom);
    }];
    
    if ([self.model.categoryByScale hasPrefix:@"综合医院"]) {
    
        UIImageView *hospitalMenZhenIconImageView = [[UIImageView alloc] init];
        hospitalMenZhenIconImageView.contentMode = UIViewContentModeCenter;
        hospitalMenZhenIconImageView.image = [UIImage imageNamed:@"icon_hospital_info_time"];
        [timeContentView addSubview:hospitalMenZhenIconImageView];
        
        [hospitalMenZhenIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.width.mas_equalTo(14);
            make.height.mas_equalTo(21);
            make.top.mas_equalTo(16);
        }];
        
        UILabel *hospitalMenZhenTitleLabel = [[UILabel alloc] init];
        hospitalMenZhenTitleLabel.font = HM15;
        hospitalMenZhenTitleLabel.textColor = kDefaultBlackTextColor;
        hospitalMenZhenTitleLabel.text = [NSString stringWithFormat:@"门诊时间 | %@", ISNIL(self. model.outpatientDepartmentTime)];
        [timeContentView addSubview:hospitalMenZhenTitleLabel];
        
        [hospitalMenZhenTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(38);
            make.height.mas_equalTo(21);
            make.top.mas_equalTo(16);
            make.right.mas_equalTo(-16);
        }];
        
        UIImageView *hospitalJizhenIconImageView = [[UIImageView alloc] init];
        hospitalJizhenIconImageView.contentMode = UIViewContentModeCenter;
        hospitalJizhenIconImageView.image = [UIImage imageNamed:@"icon_hospital_info_time"];
        [timeContentView addSubview:hospitalJizhenIconImageView];
        
        [hospitalJizhenIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.width.mas_equalTo(14);
            make.height.mas_equalTo(21);
            make.top.mas_equalTo(hospitalMenZhenTitleLabel.mas_bottom).offset(20);
        }];
        
        UILabel *hospitalJizhenTitleLabel = [[UILabel alloc] init];
        hospitalJizhenTitleLabel.font = HM15;
        hospitalJizhenTitleLabel.textColor = kDefaultBlackTextColor;
        hospitalJizhenTitleLabel.text = [NSString stringWithFormat:@"急诊时间 | %@", ISNIL(self. model.emergencyTreatmentTime)];
        [timeContentView addSubview:hospitalJizhenTitleLabel];
        
        [hospitalJizhenTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(38);
            make.height.mas_equalTo(21);
            make.top.mas_equalTo(hospitalMenZhenTitleLabel.mas_bottom).offset(20);
        }];
        
        UIImageView *hospitalSheshiIconImageView = [[UIImageView alloc] init];
        hospitalSheshiIconImageView.contentMode = UIViewContentModeCenter;
        hospitalSheshiIconImageView.image = [UIImage imageNamed:@"icon_hospital_info_sheshi"];
        [timeContentView addSubview:hospitalSheshiIconImageView];
        
        [hospitalSheshiIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.width.mas_equalTo(14);
            make.height.mas_equalTo(21);
            make.top.mas_equalTo(hospitalJizhenTitleLabel.mas_bottom).offset(20);
        }];
        
        UILabel *hospitalSheshiTitleLabel = [[UILabel alloc] init];
        hospitalSheshiTitleLabel.font = HM15;
        hospitalSheshiTitleLabel.textColor = kDefaultBlackTextColor;
        hospitalSheshiTitleLabel.text = @"医院设施";
        [timeContentView addSubview:hospitalSheshiTitleLabel];
        
        [hospitalSheshiTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(38);
            make.height.mas_equalTo(21);
            make.top.mas_equalTo(hospitalJizhenTitleLabel.mas_bottom).offset(20);
        }];
        
        
        titleArray = @[@"支付宝", @"微信支付", @"支持刷卡", @"ATM机", @"付费停车", @"WiFi", @"充电宝", @"便利店", @"自动贩卖机", @"食堂", @"儿童娱乐区"];
        
        NSArray *shesheSelectedArray = [self.model.hospitalFacility componentsSeparatedByString:@","];
        
        UIView *hotContentView = [[UIView alloc] init];
        [timeContentView addSubview:hotContentView];
        
        [hotContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(hospitalSheshiTitleLabel.mas_bottom).offset(12);
        }];
        
        CGFloat width = 16;
        NSInteger line = 0;
        for (NSInteger index = 0; index < titleArray.count; index++) {
            
            NSString *str = [titleArray objectOrNilAtIndex:index];
            
            UIButton *sicknessButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            sicknessButton.layer.cornerRadius = 2;
            sicknessButton.titleLabel.font = H12;
            sicknessButton.tag = index;
            sicknessButton.userInteractionEnabled = false;
            
            [sicknessButton setTitle:str forState:UIControlStateNormal];
            
            if ([shesheSelectedArray containsObject:str]) {
                
                [sicknessButton setTitleColor:UIColorHex(0x999999) forState:UIControlStateNormal];
                sicknessButton.layer.borderColor = UIColorHex(0x999999).CGColor;
                
            } else {
                
                [sicknessButton setTitleColor:UIColorHex(0xCCCCCC) forState:UIControlStateNormal];
                sicknessButton.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
                
            }
            

            sicknessButton.layer.borderWidth = .5;
            sicknessButton.layer.masksToBounds = true;
            
            [hotContentView addSubview:sicknessButton];
            
            [sicknessButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(width);
                make.width.mas_equalTo([str widthForFont:sicknessButton.titleLabel.font] + 6);
                make.top.mas_equalTo(line * 27);
                make.height.mas_equalTo(18);
            }];
            
            width += [str widthForFont:sicknessButton.titleLabel.font] + 6 + 4;
            
            if (width > SCREENWIDTH - 16) {
                line += 1;
                width = 16;
                [sicknessButton mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(width);
                    make.top.mas_equalTo(line * 27);
                }];
                width += [str widthForFont:sicknessButton.titleLabel.font] + 6 + 4;
            }
            
        }
        
        [hotContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(line * 27 + 16 + 18);
        }];
        
        
        
        UILabel *lineLabel5 = [[UILabel alloc] init];
        lineLabel5.backgroundColor = kDefaultGaryViewColor;
        [timeContentView addSubview:lineLabel5];
        
        [lineLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(10);
            make.top.mas_equalTo(hotContentView.mas_bottom).offset(0);
        }];
        
        self.contentHeight += 132;
        self.contentHeight += (line * 27 + 16 + 18);
        self.contentHeight += 10;
        
        
        UIView *departmentContentView = [[UIView alloc] init];
        [timeContentView addSubview:departmentContentView];
        
        [departmentContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(lineLabel5.mas_bottom).offset(0);
        }];
        
        UIImageView *departmentIconImageView = [[UIImageView alloc] init];
        departmentIconImageView.contentMode = UIViewContentModeCenter;
        departmentIconImageView.image = [UIImage imageNamed:@"icon_hospital_info_keshi"];
        [departmentContentView addSubview:departmentIconImageView];
        
        [departmentIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.width.mas_equalTo(14);
            make.height.mas_equalTo(21);
            make.top.mas_equalTo(16);
        }];
        
        UILabel *departmentTitleLabel = [[UILabel alloc] init];
        departmentTitleLabel.font = HM15;
        departmentTitleLabel.textColor = kDefaultBlackTextColor;
        departmentTitleLabel.text = @"特色科室";
        [departmentContentView addSubview:departmentTitleLabel];
        
        [departmentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(38);
            make.height.mas_equalTo(21);
            make.top.mas_equalTo(16);
        }];
        
        
        NSArray *departmentArray = [self.departmentTitleArray copy];
        
        width = 22;
        line = 0;
        for (NSInteger index = 0; index < departmentArray.count; index++) {
            
            NSString *str = [departmentArray objectOrNilAtIndex:index];
            
            UILabel *bgLabel = [[UILabel alloc] init];
            bgLabel.backgroundColor = kDefaultBlueColor;
            bgLabel.alpha = 0.08;
            bgLabel.layer.cornerRadius = 13.5;
            bgLabel.layer.masksToBounds = true;
            [departmentContentView addSubview:bgLabel];
            
            UIButton *sicknessButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            sicknessButton.layer.cornerRadius = 13.5;
            sicknessButton.titleLabel.font = H14;
            sicknessButton.tag = index;
            
            [sicknessButton setTitle:str forState:UIControlStateNormal];
            [sicknessButton setTitleColor:kDefaultBlueColor forState:UIControlStateNormal];
            sicknessButton.layer.masksToBounds = true;
            
            [departmentContentView addSubview:sicknessButton];
            
            [sicknessButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(width);
                make.width.mas_equalTo([str widthForFont:sicknessButton.titleLabel.font] + 24);
                make.top.mas_equalTo(line * 39 + 53);
                make.height.mas_equalTo(27);
            }];
            
            width += [str widthForFont:sicknessButton.titleLabel.font] + 24 + 8;
            
            
            [sicknessButton addTarget:self action:@selector(clickDepartmentAction:) forControlEvents:UIControlEventTouchUpInside];
            
            if (width > SCREENWIDTH - 22) {
                
                line += 1;
                
                width = 22;
                [sicknessButton mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(width);
                    make.top.mas_equalTo(line * 39 + 53);
                }];
                width += [str widthForFont:sicknessButton.titleLabel.font] + 24 + 8;
            }
            
            [bgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.mas_equalTo(sicknessButton);
            }];
            
        }
        
        [departmentContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(line * 39 + 27 + 53 + 76);
        }];
        
        self.contentHeight += (line * 39 + 27 + 53 + 76);
        
        UIButton *allDepartmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [allDepartmentButton setBackgroundColor:kDefaultBlueColor];
        [allDepartmentButton setTitle:ISNIL(self.allDepartmentStr) forState:UIControlStateNormal];
        allDepartmentButton.titleLabel.font = H14;
        [allDepartmentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        allDepartmentButton.layer.cornerRadius = 4;
        allDepartmentButton.layer.masksToBounds = true;
        [departmentContentView addSubview:allDepartmentButton];
        
        [allDepartmentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(163);
            make.centerX.mas_equalTo(departmentContentView);
            make.bottom.mas_equalTo(-20);
        }];
        [allDepartmentButton addTarget:self action:@selector(clickAllDepartmentAction) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lineLabel6 = [[UILabel alloc] init];
        lineLabel6.backgroundColor = kDefaultGaryViewColor;
        [timeContentView addSubview:lineLabel6];
        
        [lineLabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(10);
            make.top.mas_equalTo(departmentContentView.mas_bottom).offset(0);
        }];
        
        
        UIView *bangdanView = [[UIView alloc] init];
        bangdanView.backgroundColor = [UIColor whiteColor];
        [timeContentView addSubview:bangdanView];
        
        [bangdanView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(lineLabel6.mas_bottom);
        }];
        
        NSArray *bangdanArray = [self.model.hospitalNews jsonValueDecoded];
        
        if (bangdanArray.count == 0) {
            
            [bangdanView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
            
            self.contentHeight += 0;
            
            bangdanView.hidden = true;
            
            [lineLabel6 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
            
            self.contentHeight -= 10;
            
            lineLabel6.hidden = true;
            
        } else {
            
            [bangdanView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(40 + 35 * bangdanArray.count + 12 * (bangdanArray.count - 1));
            }];
            
            self.contentHeight += (40 + 35 * bangdanArray.count + 12 * (bangdanArray.count - 1));
            
        }
        
        for (NSUInteger index = 0; index < bangdanArray.count; index++) {
            
            NSDictionary *dicInfo = [bangdanArray objectOrNilAtIndex:index];
            
            UIView *bangdanChildrenBgView = [[UIView alloc] init];
            bangdanChildrenBgView.backgroundColor = UIColorHex(0xFEAE05);
            bangdanChildrenBgView.alpha = 0.16;
            bangdanChildrenBgView.layer.cornerRadius = 8;
            bangdanChildrenBgView.layer.masksToBounds = true;
            [bangdanView addSubview:bangdanChildrenBgView];
            
            [bangdanChildrenBgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(16);
                make.right.mas_equalTo(-16);
                make.height.mas_equalTo(35);
                make.top.mas_equalTo(20 + (35 + 12) * index);
            }];
            
            UIView *bangdanChildrenView = [[UIView alloc] init];
            bangdanChildrenView.backgroundColor = [UIColor clearColor];
            [bangdanView addSubview:bangdanChildrenView];
            
            [bangdanChildrenView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.mas_equalTo(bangdanChildrenBgView);
            }];
            
            
            UIImageView *bangdanImageView = [[UIImageView alloc] init];
            bangdanImageView.contentMode = UIViewContentModeCenter;
            bangdanImageView.image = [UIImage imageNamed:@"icon_hospital_bangdan"];
            [bangdanChildrenView addSubview:bangdanImageView];
            
            [bangdanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(22);
                make.width.mas_equalTo(22);
                make.left.mas_equalTo(12);
                make.centerY.mas_equalTo(bangdanChildrenView);
            }];
            
            UILabel *bangdanTitleLabel = [[UILabel alloc] init];
            bangdanTitleLabel.font = H15;
            bangdanTitleLabel.textColor = kDefaultBlackTextColor;
            bangdanTitleLabel.text = ISNIL(dicInfo[@"title"]);
            [bangdanChildrenView addSubview:bangdanTitleLabel];
            
            [bangdanTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                make.left.mas_equalTo(38);
                make.right.mas_equalTo(-38);
            }];
            
            UIImageView *bangdanArrowImageView = [[UIImageView alloc] init];
            bangdanArrowImageView.contentMode = UIViewContentModeCenter;
            bangdanArrowImageView.image = [UIImage imageNamed:@"icon_hospital_arrow_yellow"];
            [bangdanChildrenView addSubview:bangdanArrowImageView];
            
            [bangdanArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(20);
                make.width.mas_equalTo(13);
                make.right.mas_equalTo(-12);
                make.centerY.mas_equalTo(bangdanChildrenView);
            }];
            
            UIButton *bangdanButton = [UIButton buttonWithType:UIButtonTypeCustom];
            bangdanButton.tag = index;
            [bangdanChildrenView addSubview:bangdanButton];
            
            [bangdanButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.mas_equalTo(0);
            }];
            [bangdanButton addTarget:self action:@selector(clickBangdanAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        UILabel *lineLabel7 = [[UILabel alloc] init];
        lineLabel7.backgroundColor = kDefaultGaryViewColor;
        [timeContentView addSubview:lineLabel7];
        
        [lineLabel7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(10);
            make.top.mas_equalTo(bangdanView.mas_bottom).offset(0);
        }];
        
        self.contentHeight += 22;
        
        [timeContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(lineLabel7.mas_bottom);
        }];
        
    } else {
        
        UIImageView *hospitalMenZhenIconImageView = [[UIImageView alloc] init];
        hospitalMenZhenIconImageView.contentMode = UIViewContentModeCenter;
        hospitalMenZhenIconImageView.image = [UIImage imageNamed:@"icon_hospital_info_time"];
        [timeContentView addSubview:hospitalMenZhenIconImageView];
        
        [hospitalMenZhenIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.width.mas_equalTo(14);
            make.height.mas_equalTo(21);
            make.top.mas_equalTo(16);
        }];
        
        UILabel *hospitalMenZhenTitleLabel = [[UILabel alloc] init];
        hospitalMenZhenTitleLabel.font = HM15;
        hospitalMenZhenTitleLabel.textColor = kDefaultBlackTextColor;
        hospitalMenZhenTitleLabel.text = [NSString stringWithFormat:@"营业时间 | %@", ISNIL(self. model.outpatientDepartmentTime)];
        [timeContentView addSubview:hospitalMenZhenTitleLabel];
        
        [hospitalMenZhenTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(38);
            make.height.mas_equalTo(21);
            make.top.mas_equalTo(16);
            make.right.mas_equalTo(-16);
        }];
        
        UIImageView *hospitalSheshiIconImageView = [[UIImageView alloc] init];
        hospitalSheshiIconImageView.contentMode = UIViewContentModeCenter;
        hospitalSheshiIconImageView.image = [UIImage imageNamed:@"icon_hospital_info_sheshi"];
        [timeContentView addSubview:hospitalSheshiIconImageView];
        
        [hospitalSheshiIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.width.mas_equalTo(14);
            make.height.mas_equalTo(21);
            make.top.mas_equalTo(hospitalMenZhenTitleLabel.mas_bottom).offset(20);
        }];
        
        UILabel *hospitalSheshiTitleLabel = [[UILabel alloc] init];
        hospitalSheshiTitleLabel.font = HM15;
        hospitalSheshiTitleLabel.textColor = kDefaultBlackTextColor;
        hospitalSheshiTitleLabel.text = @"医院设施";
        [timeContentView addSubview:hospitalSheshiTitleLabel];
        
        [hospitalSheshiTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(38);
            make.height.mas_equalTo(21);
            make.top.mas_equalTo(hospitalMenZhenTitleLabel.mas_bottom).offset(20);
        }];
        
        NSArray *titleArray = @[@"支付宝", @"微信支付", @"支持刷卡", @"ATM机", @"付费停车", @"WiFi", @"充电宝", @"便利店", @"自动贩卖机", @"食堂", @"儿童娱乐区"];
        
        NSArray *shesheSelectedArray = [self.model.hospitalFacility componentsSeparatedByString:@","];
        
        UIView *hotContentView = [[UIView alloc] init];
        [timeContentView addSubview:hotContentView];
        
        [hotContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(hospitalSheshiTitleLabel.mas_bottom).offset(12);
        }];
        
        CGFloat width = 16;
        NSInteger line = 0;
        for (NSInteger index = 0; index < titleArray.count; index++) {
            
            NSString *str = [titleArray objectOrNilAtIndex:index];
            
            UIButton *sicknessButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            sicknessButton.layer.cornerRadius = 2;
            sicknessButton.titleLabel.font = H12;
            sicknessButton.tag = index;
            sicknessButton.userInteractionEnabled = false;
            
            [sicknessButton setTitle:str forState:UIControlStateNormal];
            
            if ([shesheSelectedArray containsObject:str]) {
                
                [sicknessButton setTitleColor:UIColorHex(0x999999) forState:UIControlStateNormal];
                sicknessButton.layer.borderColor = UIColorHex(0x999999).CGColor;
                
            } else {
                
                [sicknessButton setTitleColor:UIColorHex(0xCCCCCC) forState:UIControlStateNormal];
                sicknessButton.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
                
            }
            
            sicknessButton.layer.borderWidth = .5;
            sicknessButton.layer.masksToBounds = true;
            
            [hotContentView addSubview:sicknessButton];
            
            [sicknessButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(width);
                make.width.mas_equalTo([str widthForFont:sicknessButton.titleLabel.font] + 6);
                make.top.mas_equalTo(line * 27);
                make.height.mas_equalTo(18);
            }];
            
            width += [str widthForFont:sicknessButton.titleLabel.font] + 6 + 4;
            
            if (width > SCREENWIDTH - 16) {
                line += 1;
                width = 16;
                [sicknessButton mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(width);
                    make.top.mas_equalTo(line * 27);
                }];
                width += [str widthForFont:sicknessButton.titleLabel.font] + 6 + 4;
            }
            
        }
        
        [hotContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(line * 27 + 16 + 18);
        }];
        
        self.contentHeight += 90;
        self.contentHeight += (line * 27 + 16 + 18);
        self.contentHeight += 10;
        
        UILabel *lineLabel5 = [[UILabel alloc] init];
        lineLabel5.backgroundColor = kDefaultGaryViewColor;
        [timeContentView addSubview:lineLabel5];
        
        [lineLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(10);
            make.top.mas_equalTo(hotContentView.mas_bottom).offset(0);
        }];
        
        
        UIView *departmentContentView = [[UIView alloc] init];
        [timeContentView addSubview:departmentContentView];
        
        [departmentContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(lineLabel5.mas_bottom).offset(0);
        }];
        
        UIImageView *departmentIconImageView = [[UIImageView alloc] init];
        departmentIconImageView.contentMode = UIViewContentModeCenter;
        departmentIconImageView.image = [UIImage imageNamed:@"icon_hospital_info_keshi"];
        [departmentContentView addSubview:departmentIconImageView];
        
        [departmentIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.width.mas_equalTo(14);
            make.height.mas_equalTo(21);
            make.top.mas_equalTo(16);
        }];
        
        UILabel *departmentTitleLabel = [[UILabel alloc] init];
        departmentTitleLabel.font = HM15;
        departmentTitleLabel.textColor = kDefaultBlackTextColor;
        departmentTitleLabel.text = @"特色科室";
        [departmentContentView addSubview:departmentTitleLabel];
        
        [departmentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(38);
            make.height.mas_equalTo(21);
            make.top.mas_equalTo(16);
        }];
        
        
        NSArray *departmentArray = [self.departmentTitleArray copy];
        
        width = 22;
        line = 0;
        for (NSInteger index = 0; index < departmentArray.count; index++) {
            
            NSString *str = [departmentArray objectOrNilAtIndex:index];
            
            UILabel *bgLabel = [[UILabel alloc] init];
            bgLabel.backgroundColor = kDefaultBlueColor;
            bgLabel.alpha = 0.08;
            bgLabel.layer.cornerRadius = 13.5;
            bgLabel.layer.masksToBounds = true;
            [departmentContentView addSubview:bgLabel];
            
            UIButton *sicknessButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            sicknessButton.layer.cornerRadius = 13.5;
            sicknessButton.titleLabel.font = H14;
            sicknessButton.tag = index;
            
            [sicknessButton setTitle:str forState:UIControlStateNormal];
            [sicknessButton setTitleColor:kDefaultBlueColor forState:UIControlStateNormal];
            sicknessButton.layer.masksToBounds = true;
            
            [departmentContentView addSubview:sicknessButton];
            
            [sicknessButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(width);
                make.width.mas_equalTo([str widthForFont:sicknessButton.titleLabel.font] + 24);
                make.top.mas_equalTo(line * 39 + 53);
                make.height.mas_equalTo(27);
            }];
            
            width += [str widthForFont:sicknessButton.titleLabel.font] + 24 + 8;
            
            
            [sicknessButton addTarget:self action:@selector(clickDepartmentAction:) forControlEvents:UIControlEventTouchUpInside];
            
            if (width > SCREENWIDTH - 22) {
                
                line += 1;
                
                width = 22;
                [sicknessButton mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(width);
                    make.top.mas_equalTo(line * 39 + 53);
                }];
                width += [str widthForFont:sicknessButton.titleLabel.font] + 24 + 8;
            }
            
            [bgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.mas_equalTo(sicknessButton);
            }];
            
        }
        
        [departmentContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(line * 39 + 27 + 53 + 76);
        }];
        
        self.contentHeight += (line * 39 + 27 + 53 + 76);
        
        UIButton *allDepartmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [allDepartmentButton setBackgroundColor:kDefaultBlueColor];
        [allDepartmentButton setTitle:ISNIL(self.allDepartmentStr) forState:UIControlStateNormal];
        allDepartmentButton.titleLabel.font = H14;
        [allDepartmentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        allDepartmentButton.layer.cornerRadius = 4;
        allDepartmentButton.layer.masksToBounds = true;
        [departmentContentView addSubview:allDepartmentButton];
        
        [allDepartmentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(163);
            make.centerX.mas_equalTo(departmentContentView);
            make.bottom.mas_equalTo(-20);
        }];
        [allDepartmentButton addTarget:self action:@selector(clickAllDepartmentAction) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lineLabel6 = [[UILabel alloc] init];
        lineLabel6.backgroundColor = kDefaultGaryViewColor;
        [timeContentView addSubview:lineLabel6];
        
        [lineLabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(10);
            make.top.mas_equalTo(departmentContentView.mas_bottom).offset(0);
        }];
        
        
        UIView *bangdanView = [[UIView alloc] init];
        bangdanView.backgroundColor = [UIColor whiteColor];
        [timeContentView addSubview:bangdanView];
        
        [bangdanView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(lineLabel6.mas_bottom);
        }];
        
        NSArray *bangdanArray = [self.model.hospitalNews jsonValueDecoded];
        
        if (bangdanArray.count == 0) {
            
            [bangdanView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
            
            self.contentHeight += 0;
            
            bangdanView.hidden = true;
            
            [lineLabel6 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
            
            self.contentHeight -= 10;
            
            lineLabel6.hidden = true;
            
        } else {
            
            [bangdanView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(40 + 35 * bangdanArray.count + 12 * (bangdanArray.count - 1));
            }];
            
            self.contentHeight += (40 + 35 * bangdanArray.count + 12 * (bangdanArray.count - 1));
            
        }
        
        for (NSUInteger index = 0; index < bangdanArray.count; index++) {
            
            NSDictionary *dicInfo = [bangdanArray objectOrNilAtIndex:index];
            
            UIView *bangdanChildrenBgView = [[UIView alloc] init];
            bangdanChildrenBgView.backgroundColor = UIColorHex(0xFEAE05);
            bangdanChildrenBgView.alpha = 0.16;
            bangdanChildrenBgView.layer.cornerRadius = 8;
            bangdanChildrenBgView.layer.masksToBounds = true;
            [bangdanView addSubview:bangdanChildrenBgView];
            
            [bangdanChildrenBgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(16);
                make.right.mas_equalTo(-16);
                make.height.mas_equalTo(35);
                make.top.mas_equalTo(20 + (35 + 12) * index);
            }];
            
            UIView *bangdanChildrenView = [[UIView alloc] init];
            bangdanChildrenView.backgroundColor = [UIColor clearColor];
            [bangdanView addSubview:bangdanChildrenView];
            
            [bangdanChildrenView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.mas_equalTo(bangdanChildrenBgView);
            }];
            
            
            UIImageView *bangdanImageView = [[UIImageView alloc] init];
            bangdanImageView.contentMode = UIViewContentModeCenter;
            bangdanImageView.image = [UIImage imageNamed:@"icon_hospital_bangdan"];
            [bangdanChildrenView addSubview:bangdanImageView];
            
            [bangdanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(22);
                make.width.mas_equalTo(22);
                make.left.mas_equalTo(12);
                make.centerY.mas_equalTo(bangdanChildrenView);
            }];
            
            UILabel *bangdanTitleLabel = [[UILabel alloc] init];
            bangdanTitleLabel.font = H15;
            bangdanTitleLabel.textColor = kDefaultBlackTextColor;
            bangdanTitleLabel.text = ISNIL(dicInfo[@"title"]);
            [bangdanChildrenView addSubview:bangdanTitleLabel];
            
            [bangdanTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                make.left.mas_equalTo(38);
                make.right.mas_equalTo(-38);
            }];
            
            UIImageView *bangdanArrowImageView = [[UIImageView alloc] init];
            bangdanArrowImageView.contentMode = UIViewContentModeCenter;
            bangdanArrowImageView.image = [UIImage imageNamed:@"icon_hospital_arrow_yellow"];
            [bangdanChildrenView addSubview:bangdanArrowImageView];
            
            [bangdanArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(20);
                make.width.mas_equalTo(13);
                make.right.mas_equalTo(-12);
                make.centerY.mas_equalTo(bangdanChildrenView);
            }];
            
            UIButton *bangdanButton = [UIButton buttonWithType:UIButtonTypeCustom];
            bangdanButton.tag = index;
            [bangdanChildrenView addSubview:bangdanButton];
            
            [bangdanButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.mas_equalTo(0);
            }];
            [bangdanButton addTarget:self action:@selector(clickBangdanAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        UILabel *lineLabel7 = [[UILabel alloc] init];
        lineLabel7.backgroundColor = kDefaultGaryViewColor;
        [timeContentView addSubview:lineLabel7];
        
        [lineLabel7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(10);
            make.top.mas_equalTo(bangdanView.mas_bottom).offset(0);
        }];
        
        self.contentHeight += 22;
        
        [timeContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(lineLabel7.mas_bottom);
        }];
        
        
//        UIView *bangdanView = [[UIView alloc] init];
//        bangdanView.backgroundColor = [UIColor whiteColor];
//        [timeContentView addSubview:bangdanView];
//
//        [bangdanView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(0);
//            make.top.mas_equalTo(lineLabel5.mas_bottom);
//        }];
//
//        NSArray *bangdanArray = [self.model.hospitalNews jsonValueDecoded];
//
//        if (bangdanArray.count == 0) {
//
//            [bangdanView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(0);
//            }];
//
//            self.contentHeight += 0;
//
//            bangdanView.hidden = true;
//
//            [lineLabel5 mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(0);
//            }];
//
//            self.contentHeight -= 10;
//
//            lineLabel5.hidden = true;
//
//        } else {
//
//            [bangdanView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(40 + 35 * bangdanArray.count + 12 * (bangdanArray.count - 1));
//            }];
//
//            self.contentHeight += (40 + 35 * bangdanArray.count + 12 * (bangdanArray.count - 1));
//        }
//
//        for (NSUInteger index = 0; index < bangdanArray.count; index++) {
//
//            NSDictionary *dicInfo = [bangdanArray objectOrNilAtIndex:index];
//
//            UIView *bangdanChildrenBgView = [[UIView alloc] init];
//            bangdanChildrenBgView.backgroundColor = UIColorHex(0xFEAE05);
//            bangdanChildrenBgView.alpha = 0.16;
//            bangdanChildrenBgView.layer.cornerRadius = 8;
//            bangdanChildrenBgView.layer.masksToBounds = true;
//            [bangdanView addSubview:bangdanChildrenBgView];
//
//            [bangdanChildrenBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(16);
//                make.right.mas_equalTo(-16);
//                make.height.mas_equalTo(35);
//                make.top.mas_equalTo(20 + (35 + 12) * index);
//            }];
//
//            UIView *bangdanChildrenView = [[UIView alloc] init];
//            bangdanChildrenView.backgroundColor = [UIColor clearColor];
//            [bangdanView addSubview:bangdanChildrenView];
//
//            [bangdanChildrenView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.right.top.bottom.mas_equalTo(bangdanChildrenBgView);
//            }];
//
//
//            UIImageView *bangdanImageView = [[UIImageView alloc] init];
//            bangdanImageView.contentMode = UIViewContentModeCenter;
//            bangdanImageView.image = [UIImage imageNamed:@"icon_hospital_bangdan"];
//            [bangdanChildrenView addSubview:bangdanImageView];
//
//            [bangdanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(22);
//                make.width.mas_equalTo(22);
//                make.left.mas_equalTo(12);
//                make.centerY.mas_equalTo(bangdanChildrenView);
//            }];
//
//            UILabel *bangdanTitleLabel = [[UILabel alloc] init];
//            bangdanTitleLabel.font = H15;
//            bangdanTitleLabel.textColor = kDefaultBlackTextColor;
//            bangdanTitleLabel.text = ISNIL(dicInfo[@"title"]);
//            [bangdanChildrenView addSubview:bangdanTitleLabel];
//
//            [bangdanTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.bottom.mas_equalTo(0);
//                make.left.mas_equalTo(38);
//                make.right.mas_equalTo(-38);
//            }];
//
//            UIImageView *bangdanArrowImageView = [[UIImageView alloc] init];
//            bangdanArrowImageView.contentMode = UIViewContentModeCenter;
//            bangdanArrowImageView.image = [UIImage imageNamed:@"icon_hospital_arrow_yellow"];
//            [bangdanChildrenView addSubview:bangdanArrowImageView];
//
//            [bangdanArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(20);
//                make.width.mas_equalTo(13);
//                make.right.mas_equalTo(-12);
//                make.centerY.mas_equalTo(bangdanChildrenView);
//            }];
//
//            UIButton *bangdanButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            bangdanButton.tag = index;
//            [bangdanChildrenView addSubview:bangdanButton];
//
//            [bangdanButton mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.right.top.bottom.mas_equalTo(0);
//            }];
//            [bangdanButton addTarget:self action:@selector(clickBangdanAction:) forControlEvents:UIControlEventTouchUpInside];
//        }
//
//        UILabel *lineLabel6 = [[UILabel alloc] init];
//        lineLabel6.backgroundColor = kDefaultGaryViewColor;
//        [timeContentView addSubview:lineLabel6];
//
//        [lineLabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(0);
//            make.height.mas_equalTo(10);
//            make.top.mas_equalTo(bangdanView.mas_bottom).offset(0);
//        }];
//
//        self.contentHeight += 15;
//
//        [timeContentView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(lineLabel6.mas_bottom);
//        }];
        
    }
    
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
        
        self.headerView.frame = CGRectMake(0, 0, SCREENWIDTH, self.contentHeight - 88 + self.contentTextHeight);
        self.tableView.tableHeaderView = self.headerView;
        
    } else {
        
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(88);
        }];
        
        sender.selected = false;
        
        self.headerView.frame = CGRectMake(0, 0, SCREENWIDTH, self.contentHeight);
        self.tableView.tableHeaderView = self.headerView;
        
    }
    
}

- (void)clickErrorAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        GHHospitalDetailInfoErrorViewController *vc = [[GHHospitalDetailInfoErrorViewController alloc] init];
        vc.realModel = self.model;
        [self.navigationController pushViewController:vc animated:true];
        NSLog(@"信息报错");
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self presentViewController:vc animated:true completion:nil];
        
    }
    

    
}

- (void)clickAllDepartmentAction {
    
    NSLog(@"全部科室");
    
    GHHospitalDepartmentViewController *vc = [[GHHospitalDepartmentViewController alloc] init];
    vc.hospitalId = self.model.modelId;
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)clickDepartmentAction:(UIButton *)sender {
    
    NSLog(@"科室医生");
    
    GHHospitalDepartmentDoctorListViewController *vc = [[GHHospitalDepartmentDoctorListViewController alloc] init];
    
    NSDictionary *departmentInfo = [self.departmentInfoArray objectOrNilAtIndex:sender.tag];
    
    vc.hospitalId = self.model.modelId;
    
    vc.departmentLevel = @"1";
    
    vc.departmentId = departmentInfo[@"departmentId"];
    
    vc.navigationItem.title = ISNIL(departmentInfo[@"departmentName"]);
    
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)clickBangdanAction:(UIButton *)sender {
 
    NSLog(@"榜单");
    
    NSArray *bangdanArray = [self.model.hospitalNews jsonValueDecoded];
    
    NSDictionary *dicInfo = [bangdanArray objectOrNilAtIndex:sender.tag];
    
    GHCommonWebViewController *vc = [[GHCommonWebViewController alloc] init];
    vc.navTitle = @"大众星医";
    
    if (((NSString *)dicInfo[@"h5url"]).length) {
        vc.urlStr = dicInfo[@"h5url"];
    } else if (((NSString *)dicInfo[@"pics"]).length) {
        vc.urlStr = dicInfo[@"pics"];
    }
    
    [self.navigationController pushViewController:vc animated:true];
    
}

/**
 资质认证
 */
- (void)clickAuthenticationAction {
    
    NSLog(@"资质认证");
    
    GHHospitlAuthenticationViewController *vc = [[GHHospitlAuthenticationViewController alloc] init];
    vc.qualification = [self.model.qualityCertifyMaterials jsonValueDecoded];
    [self.navigationController pushViewController:vc animated:true];
    
}

- (UIView *)createStarViewWithImage:(NSString *)imageName {
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < 5; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * 13.5, 0, 12, 22);
        imageView.contentMode = UIViewContentModeCenter;
        [view addSubview:imageView];
        
    }
    return view;
}

- (void)clickPhotoAction:(UIGestureRecognizer *)gr {
    
    UIImageView *imageView = (UIImageView *)gr.view;
    
    kWeakSelf
    
    NSMutableArray *urlArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in [self.model.pictures jsonValueDecoded]) {
        [urlArray addObject:ISNIL(dic[@"url"])];
    }
    
    [[GHPhotoTool shareInstance] showBigImage:urlArray currentIndex:imageView.tag viewController:weakSelf cancelBtnText:@"取消"];
    
}

- (void)clickLocationAction {
    
    if (self.model.hospitalAddress.length == 0) {
        return;
    }
    
    
    
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[self.model.lat doubleValue] longitude:[self.model.lng doubleValue]];
    
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


- (void)clickPhoneAction {
    
    NSArray *phoneArray = [self.model.contactNumber componentsSeparatedByString:@","];
    
    if (phoneArray.count) {
        
        if (phoneArray.count == 1) {
            
            NSString *contactNumber = [phoneArray firstObject];
            
            if (contactNumber.length) {
                [JFTools callPhone:ISNIL(contactNumber)];
            }
            
        } else {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择您要拨打的电话" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            for (NSString *contactNumber in phoneArray) {
                
                if (contactNumber.length) {
                    
                    UIAlertAction *action = [UIAlertAction actionWithTitle:ISNIL(contactNumber) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [JFTools callPhone:ISNIL(contactNumber)];
                    }];
                    
                    [alert addAction:action];
                    
                }
                
            }
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
                
            }];
            
        }
        
        
    }
    

    
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

- (void)clickCancelAction {
    
    [self.navigationController popViewControllerAnimated:true];
    
}


@end


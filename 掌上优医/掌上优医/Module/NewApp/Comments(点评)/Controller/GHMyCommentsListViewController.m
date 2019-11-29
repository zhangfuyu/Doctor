//
//  GHMyCommentsListViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/20.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHMyCommentsListViewController.h"

#import "GHMyCommentsTableViewCell.h"

#import "GHMyCommentsDetailViewController.h"

#import "GHNChooseTitleView.h"

#import "GHMyCommentHospitalTableViewCell.h"

#import "GHHospitalCommentDetailViewController.h"


#import "GHDoctorCommentModel.h"
#import "GHSearchDoctorModel.h"//医生cellmodel

@interface GHMyCommentsListViewController ()<GHNChooseTitleViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) GHNChooseTitleView *titleView;

@property (nonatomic, strong) NSMutableArray *tableViewArray;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) NSUInteger pageSize;

@property (nonatomic, strong) NSMutableArray *doctorArray;
@property (nonatomic, assign) NSUInteger doctorCurrentPage;
@property (nonatomic, assign) NSUInteger doctorTotalPage;
@property (nonatomic, strong) UITableView *doctorTableView;

@property (nonatomic, strong) NSMutableArray *hospitalArray;
@property (nonatomic, assign) NSUInteger hospitalCurrentPage;
@property (nonatomic, assign) NSUInteger hospitalTotalPage;
@property (nonatomic, strong) UITableView *hospitalTableView;

@property (nonatomic, strong) UIView *doctorEmptyView;
@property (nonatomic, strong) UIView *hospitalEmptyView;

@end

@implementation GHMyCommentsListViewController


- (UIView *)doctorEmptyView{
    
    if (!_doctorEmptyView) {
        _doctorEmptyView = [[UIView alloc] init];
        _doctorEmptyView.userInteractionEnabled = NO;
        _doctorEmptyView.frame = CGRectMake(SCREENWIDTH * 1, 90, SCREENWIDTH, self.scrollView.contentSize.height);
        [self.scrollView addSubview:_doctorEmptyView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_collection"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_doctorEmptyView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.centerX.mas_equalTo(imageView.superview);
            make.size.mas_equalTo(CGSizeMake(300, 110));
        }];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.font = H14;
        tipLabel.textColor = kDefaultGrayTextColor;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"暂无点评记录";
        [_doctorEmptyView addSubview:tipLabel];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(imageView.mas_bottom).offset(0);
            make.height.mas_equalTo(60);
        }];
        
        _doctorEmptyView.hidden = YES;
        _doctorEmptyView.userInteractionEnabled = false;
    }
    return _doctorEmptyView;
    
}

- (UIView *)hospitalEmptyView{
    
    if (!_hospitalEmptyView) {
        _hospitalEmptyView = [[UIView alloc] init];
        _hospitalEmptyView.userInteractionEnabled = NO;
        _hospitalEmptyView.frame = CGRectMake(SCREENWIDTH * 0, 90, SCREENWIDTH, self.scrollView.contentSize.height);
        [self.scrollView addSubview:_hospitalEmptyView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_collection"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_hospitalEmptyView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.centerX.mas_equalTo(imageView.superview);
            make.size.mas_equalTo(CGSizeMake(300, 110));
        }];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.font = H14;
        tipLabel.textColor = kDefaultGrayTextColor;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"暂无点评记录";
        [_hospitalEmptyView addSubview:tipLabel];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(imageView.mas_bottom).offset(0);
            make.height.mas_equalTo(60);
        }];
        
        _hospitalEmptyView.hidden = YES;
        _hospitalEmptyView.userInteractionEnabled = false;
    }
    return _hospitalEmptyView;
    
}



- (NSMutableArray *)doctorArray {
    
    if (!_doctorArray) {
        _doctorArray = [[NSMutableArray alloc] init];
    }
    return _doctorArray;
    
}

- (NSMutableArray *)hospitalArray {
    
    if (!_hospitalArray) {
        _hospitalArray = [[NSMutableArray alloc] init];
    }
    return _hospitalArray;
    
}

- (NSMutableArray *)tableViewArray {
    
    if (!_tableViewArray) {
        _tableViewArray = [[NSMutableArray alloc] init];
    }
    return _tableViewArray;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的点评";
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    [self setupConfig];
    [self setupUI];
    [self requestData];
    
}

- (void)setupConfig {

    self.pageSize = 10;
//    self.doctorTotalPage = 1;
//    self.hospitalTotalPage = 1;
    
    self.doctorCurrentPage = 1;
    self.hospitalCurrentPage = 1;
    
    
}

- (void)setupUI {
    
    NSArray *titleArray = @[@"评价医院", @"评价医生"];
    
    GHNChooseTitleView *titleView = [[GHNChooseTitleView alloc] initWithTitleArray:titleArray];
    titleView.delegate = self;
    [self.view addSubview:titleView];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(SCREENWIDTH * titleArray.count, SCREENHEIGHT - Height_NavBar - 44 + kBottomSafeSpace);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.frame = CGRectMake(0, 44, SCREENWIDTH, SCREENHEIGHT - Height_NavBar - 44 + kBottomSafeSpace);
    scrollView.delegate = self;
    scrollView.scrollEnabled = false;
    [self.view addSubview:scrollView];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tag = index;
        tableView.backgroundColor = kDefaultGaryViewColor;
        tableView.frame = CGRectMake(SCREENWIDTH * index, 0, SCREENWIDTH, scrollView.contentSize.height);
        
        [scrollView addSubview:tableView];
        
        [self.tableViewArray addObject:tableView];
        
        if (index == 1) {
            self.doctorTableView = tableView;
        } else if (index ==  0){
            self.hospitalTableView = tableView;
        }
        
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
        
    }
    
    self.scrollView = scrollView;
    
    
}

- (void)refreshData{
    
    if (self.scrollView.contentOffset.x == SCREENWIDTH * 1) {
        self.doctorCurrentPage = 1;
        self.doctorTotalPage = 1;
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 0) {
        self.hospitalCurrentPage = 1;
        self.hospitalTotalPage = 1;
    }
    
    [self requestData];
    
}

- (void)getMoreData{
    
    if (self.scrollView.contentOffset.x == SCREENWIDTH * 1) {
        
        self.doctorCurrentPage ++;
        
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 0) {
        
        self.hospitalCurrentPage ++;
        
    }
    
    [self requestData];
}

- (void)requestData {
    
    if (self.scrollView.contentOffset.x == SCREENWIDTH * 1) {
    
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"pageSize"] = @(self.pageSize);
        params[@"page"] = @(self.doctorCurrentPage);
        params[@"commentObjType"] = @(1);
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiMyComments withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            [self.doctorTableView.mj_header endRefreshing];
            [self.doctorTableView.mj_footer endRefreshing];
            
            if (isSuccess) {
                
                [SVProgressHUD dismiss];
                
                if (self.doctorCurrentPage == 1) {
                    
                    [self.doctorArray removeAllObjects];
                    
                }
                NSArray *commentList = response[@"data"][@"commentList"];
                
                if (commentList.count > 0) {
                    
                    for (NSDictionary *dic in commentList) {
                        
                        GHDoctorCommentModel *model = [[GHDoctorCommentModel alloc]initWithDictionary:dic[@"comment"] error:nil];
                        GHSearchDoctorModel *doctormodel = [[GHSearchDoctorModel alloc]initWithDictionary:dic[@"doctor"] error:nil];
                        model.doctorModel = doctormodel;
                        
                        [self.doctorArray addObject:model];
                        
                        
                        model.contentHeight = @([ISNIL(model.comment) getShouldHeightWithContent:ISNIL(model.comment) withFont:H15 withWidth:SCREENWIDTH - 32 withLineHeight:21] + 24);
                        
                        if ([model.contentHeight floatValue] - 24 > 21 * 6) {
                            model.contentHeight = @(21 * 6 + 24);
                        }
                        
                        NSArray *pictureArray = [model.pictures jsonValueDecoded];
                        
                        if (pictureArray.count > 3) {
                            
                            model.shouldHeight = @([model.contentHeight floatValue] + 198 + 190 - 15 + 45);
                            
                        } else if (pictureArray.count == 0) {
                            
                            model.shouldHeight = @([model.contentHeight floatValue] + 190 - 15 + 45);
                            
                        } else {
                            
                            model.shouldHeight = @([model.contentHeight floatValue] + 198 + 95 - 15 + 45);
                            
                        }
                    }
                    
                }
                else
                {

                    self.doctorTotalPage --;
                    [self.doctorTableView.mj_footer endRefreshingWithNoMoreData];
                }

                [self.doctorTableView reloadData];

                
            }
            
            if (self.doctorArray.count == 0) {
                self.doctorEmptyView.hidden = NO;
            }
            else
            {
                self.doctorEmptyView.hidden = YES;

            }
                
//                NSMutableArray *doctorIdsArray = [[NSMutableArray alloc] init];
//
//                for (NSDictionary *dicInfo in response) {
//
//                    GHMyCommentsModel *model = [[GHMyCommentsModel alloc] initWithDictionary:dicInfo error:nil];
//
//                    if (model == nil) {
//                        continue;
//                    }
//
//
//                    if (model.comment.length == 0) {
//
//                        switch ([model.score integerValue]) {
//                            case 1:
//                                model.comment = @"差";
//                                break;
//
//                            case 2:
//                                model.comment = @"差";
//                                break;
//
//                            case 3:
//                                model.comment = @"较差";
//                                break;
//
//                            case 4:
//                                model.comment = @"较差";
//                                break;
//
//                            case 5:
//                                model.comment = @"一般";
//                                break;
//
//                            case 6:
//                                model.comment = @"一般";
//                                break;
//
//                            case 7:
//                                model.comment = @"满意";
//                                break;
//
//                            case 8:
//                                model.comment = @"满意";
//                                break;
//
//                            case 9:
//                                model.comment = @"非常满意";
//                                break;
//
//                            case 10:
//                                model.comment = @"非常满意";
//                                break;
//
//                            default:
//                                break;
//                        }
//
//                    }
//
//
//                    model.contentHeight = @([ISNIL(model.comment) getShouldHeightWithContent:ISNIL(model.comment) withFont:H15 withWidth:SCREENWIDTH - 32 withLineHeight:21] + 24);
//
//                    if ([model.contentHeight floatValue] - 24 > 21 * 6) {
//                        model.contentHeight = @(21 * 6 + 24);
//                    }
//
//                    NSArray *pictureArray = [model.pictures jsonValueDecoded];
//
//                    if (pictureArray.count > 3) {
//
//                        model.shouldHeight = @([model.contentHeight floatValue] + 198 + 190 - 15 + 45);
//
//                    } else if (pictureArray.count == 0) {
//
//                        model.shouldHeight = @([model.contentHeight floatValue] + 190 - 15 + 45);
//
//                    } else {
//
//                        model.shouldHeight = @([model.contentHeight floatValue] + 198 + 95 - 15 + 45);
//
//                    }
//
//                    if (![doctorIdsArray containsObject:ISNIL(model.commentObjId)]) {
//                        [doctorIdsArray addObject:ISNIL(model.commentObjId)];
//                    }
//
//
//
//                    [self.doctorArray addObject:model];
//
//                }
//
            
                
                
                
            
//                if (doctorIdsArray.count) {
//
//                    NSMutableDictionary *sonParams = [[NSMutableDictionary alloc] init];
//                    sonParams[@"ids"] = [doctorIdsArray componentsJoinedByString:@","];
//
//                    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDoctorSampleinfoIds withParameter:sonParams withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
//
//                        if (isSuccess) {
//
//                            for (NSInteger index = 0; index < self.doctorArray.count; index++) {
//
//                                GHMyCommentsModel *model = [self.doctorArray objectOrNilAtIndex:index];
//
//                                if (model.doctorGrade.length > 0) {
//                                    continue;
//                                }
//
//                                for (NSDictionary *dic in response) {
//
//                                    if ([dic[@"id"] longValue] == [model.commentObjId longValue]) {
//
//                                        model.doctorName = ISNIL(dic[@"doctorName"]);
//                                        model.doctorGrade = ISNIL(dic[@"doctorGrade"]);
//                                        model.doctorProfilePhoto = ISNIL(dic[@"profilePhoto"]);
//                                        model.doctorScore = [NSString stringWithFormat:@"%ld", [dic[@"score"] integerValue]];
//                                        model.doctorHospitalName = ISNIL(dic[@"hospitalName"]);
//                                        model.doctorFirstDepartmentName = ISNIL(dic[@"firstDepartmentName"]);
//                                        model.doctorSecondDepartmentName = ISNIL(dic[@"secondDepartmentName"]);
//
//                                        continue;
//
//                                    }
//
//                                }
//
//                            }
//
//                            [self.doctorTableView reloadData];
//
//                        }
//
//                    }];
//
//                } else {
//                    [self.doctorTableView reloadData];
//                }
//
//            }
//
        }];
        
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 0) {
        
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"pageSize"] = @(self.pageSize);
        params[@"page"] = @(self.hospitalCurrentPage);
        params[@"commentObjType"] = @(2);
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiMyComments withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            [self.hospitalTableView.mj_header endRefreshing];
            [self.hospitalTableView.mj_footer endRefreshing];
            
            if (isSuccess) {
                
                [SVProgressHUD dismiss];
                
                if (self.hospitalCurrentPage == 1) {
                    
                    [self.hospitalArray removeAllObjects];
                    
                }
                
                
                NSArray *commentList = response[@"data"][@"commentList"];
                
                if (commentList.count  > 0) {
                    for (NSDictionary *dic in commentList) {
                        GHDoctorCommentModel *model = [[GHDoctorCommentModel alloc]initWithDictionary:dic[@"comment"] error:nil];
                        GHSearchHospitalModel *hospital = [[GHSearchHospitalModel alloc]initWithDictionary:dic[@"hospital"] error:nil];
                        model.hospitalModel = hospital;
                        model.contentHeight = @([ISNIL(model.comment) getShouldHeightWithContent:ISNIL(model.comment) withFont:H15 withWidth:SCREENWIDTH - 32 withLineHeight:21] + 24);
                        
                        if ([model.contentHeight floatValue] - 24 > 21 * 6) {
                            model.contentHeight = @(21 * 6 + 24);
                        }
                        
                        NSArray *pictureArray = [model.pictures jsonValueDecoded];
                        
                        if (pictureArray.count > 3) {
                            
                            model.shouldHeight = @([model.contentHeight floatValue] + 198 + 190 - 15 + 45);
                            
                        } else if (pictureArray.count == 0) {
                            
                            model.shouldHeight = @([model.contentHeight floatValue] + 190 - 15 + 45);
                            
                        } else {
                            
                            model.shouldHeight = @([model.contentHeight floatValue] + 198 + 95 - 15 + 45);
                            
                        }
                        
//                        if (![doctorIdsArray containsObject:ISNIL(model.commentObjId)]) {
//                            [doctorIdsArray addObject:ISNIL(model.commentObjId)];
//                        }
                        
                        
                        
                        [self.hospitalArray addObject:model];
                        
                    }
                    [self.hospitalTableView reloadData];

                }
                else
                {
                    self.hospitalCurrentPage--;
                    [self.hospitalTableView.mj_footer endRefreshingWithNoMoreData];
                }
                

                if (commentList.count >= self.pageSize) {
                    self.hospitalTotalPage = self.hospitalArray.count + 1;
                } else {
                    self.hospitalTotalPage = self.hospitalCurrentPage;
                }
//                NSMutableArray *doctorIdsArray = [[NSMutableArray alloc] init];
//
//                for (NSDictionary *dicInfo in response) {
//
//                    GHMyCommentsModel *model = [[GHMyCommentsModel alloc] initWithDictionary:dicInfo error:nil];
//
//                    if (model == nil) {
//                        continue;
//                    }
//
//
//                    if (model.comment.length == 0) {
//
//                        switch ([model.score integerValue]) {
//                            case 1:
//                                model.comment = @"差";
//                                break;
//
//                            case 2:
//                                model.comment = @"差";
//                                break;
//
//                            case 3:
//                                model.comment = @"较差";
//                                break;
//
//                            case 4:
//                                model.comment = @"较差";
//                                break;
//
//                            case 5:
//                                model.comment = @"一般";
//                                break;
//
//                            case 6:
//                                model.comment = @"一般";
//                                break;
//
//                            case 7:
//                                model.comment = @"满意";
//                                break;
//
//                            case 8:
//                                model.comment = @"满意";
//                                break;
//
//                            case 9:
//                                model.comment = @"非常满意";
//                                break;
//
//                            case 10:
//                                model.comment = @"非常满意";
//                                break;
//
//                            default:
//                                break;
//                        }
//
//                    }
//
//
//                    model.contentHeight = @([ISNIL(model.comment) getShouldHeightWithContent:ISNIL(model.comment) withFont:H15 withWidth:SCREENWIDTH - 32 withLineHeight:21] + 24);
//
//                    if ([model.contentHeight floatValue] - 24 > 21 * 6) {
//                        model.contentHeight = @(21 * 6 + 24);
//                    }
//
//                    NSArray *pictureArray = [model.pictures jsonValueDecoded];
//
//                    if (pictureArray.count > 3) {
//
//                        model.shouldHeight = @([model.contentHeight floatValue] + 198 + 190 - 15 + 45);
//
//                    } else if (pictureArray.count == 0) {
//
//                        model.shouldHeight = @([model.contentHeight floatValue] + 190 - 15 + 45);
//
//                    } else {
//
//                        model.shouldHeight = @([model.contentHeight floatValue] + 198 + 95 - 15 + 45);
//
//                    }
//
//                    if (![doctorIdsArray containsObject:ISNIL(model.commentObjId)]) {
//                        [doctorIdsArray addObject:ISNIL(model.commentObjId)];
//                    }
//
//
//
//                    [self.hospitalArray addObject:model];
//
//                }
                
             
                
                
//                if (self.hospitalArray.count == 0) {
//                    [self loadingEmptyView];
//                }else{
//                    [self hideEmptyView];
//                }
//
//                if (doctorIdsArray.count) {
//
//                    NSMutableDictionary *sonParams = [[NSMutableDictionary alloc] init];
//                    sonParams[@"ids"] = [doctorIdsArray componentsJoinedByString:@","];
//
//                    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiHospitalSampleinfoIds withParameter:sonParams withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
//
//                        if (isSuccess) {
//
//                            for (NSInteger index = 0; index < self.hospitalArray.count; index++) {
//
//                                GHMyCommentsModel *model = [self.hospitalArray objectOrNilAtIndex:index];
//
//                                if (model.doctorGrade.length > 0) {
//                                    continue;
//                                }
//
//                                for (NSDictionary *dic in response) {
//
//                                    if ([dic[@"id"] longValue] == [model.commentObjId longValue]) {
//
//                                        model.hospitalProfilePhoto = dic[@"profilePhoto"];
//
//                                        model.hospitalCategory = dic[@"category"];
//                                        model.hospitalGovernmentalHospitalFlag = dic[@"governmentalHospitalFlag"];
//
//                                        model.hospitalGrade = dic[@"grade"];
//                                        model.hospitalAddress = dic[@"hospitalAddress"];
//                                        model.hospitalName = dic[@"hospitalName"];
//                                        model.hospitalMedicalInsuranceFlag = dic[@"medicalInsuranceFlag"];
//                                        model.hospitalMedicineType = dic[@"medicineType"];
//                                        model.hospitalGovernmentalHospitalFlag = dic[@"governmentalHospitalFlag"];
//                                        model.hospitalScore = dic[@"score"];
//
//                                        continue;
//
//                                    }
//
//                                }
//
//                            }
//
//                            [self.hospitalTableView reloadData];
//
//                        }
//
//                    }];
//
//                } else {
//                    [self.hospitalTableView reloadData];
//                }
                
            }
            
            if (self.hospitalArray.count == 0) {
                self.hospitalEmptyView.hidden = NO;
            }
            else
            {
                self.hospitalEmptyView.hidden = YES;
            }
            
        }];
        
        
        
    }
    
 
    
}


#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.doctorTableView) {
        return self.doctorArray.count;
    } else if (tableView == self.hospitalTableView) {
        return self.hospitalArray.count;
    }
    
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.doctorTableView) {
        
        GHMyCommentsModel *model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
        
        return [model.shouldHeight floatValue];
        
    } else if (tableView == self.hospitalTableView) {
        
        GHMyCommentsModel *model = [self.hospitalArray objectOrNilAtIndex:indexPath.row];
        
        return [model.shouldHeight floatValue];
        
    }
    
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = kDefaultGaryViewColor;
    view.frame = CGRectMake(0, 0, SCREENWIDTH, 10);
    
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.doctorTableView) {
        
        GHMyCommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHMyCommentsTableViewCell"];
        
        if (!cell) {
            
            cell = [[GHMyCommentsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHMyCommentsTableViewCell"];
            
            cell.contentView.backgroundColor = kDefaultGaryViewColor;
            
        }
        
        cell.model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
        
        return cell;
        
    } else if (tableView == self.hospitalTableView) {
        
        GHMyCommentHospitalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHMyCommentHospitalTableViewCell"];
        
        if (!cell) {
            
            cell = [[GHMyCommentHospitalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHMyCommentHospitalTableViewCell"];
            
            cell.contentView.backgroundColor = kDefaultGaryViewColor;
            
        }
        
        cell.model = [self.hospitalArray objectOrNilAtIndex:indexPath.row];
        
        return cell;
        
    }
    
    return [UITableViewCell new];
    

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.doctorTableView) {
        
        
        GHDoctorCommentModel *model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
        
        GHMyCommentsDetailViewController *vc = [[GHMyCommentsDetailViewController alloc] init];
        vc.model = [[GHMyCommentsModel alloc] initWithDictionary:[model toDictionary] error:nil];
        vc.model.pictures = model.pictures;

        vc.model.doctorName = model.doctorModel.doctorName;
        vc.model.doctorGrade = model.doctorModel.doctorGrade;
        vc.model.hospitalName = model.doctorModel.hospitalName;
        vc.model.score = [NSString stringWithFormat:@"%ld", [model.score integerValue] * 10];
        vc.model.commentScore = [NSString stringWithFormat:@"%ld", [model.doctorModel.commentScore integerValue]];
        vc.model.doctorSecondDepartmentName = model.doctorModel.secondDepartmentName;
        vc.model.modelId = model.doctorModel.modelId;
        [self.navigationController pushViewController:vc animated:true];
        
        
//        GHMyCommentsDetailViewController *vc = [[GHMyCommentsDetailViewController alloc] init];
//        vc.model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
//        [self.navigationController pushViewController:vc animated:true];
        
        
    } else if (tableView == self.hospitalTableView) {

//        GHHospitalCommentDetailViewController *vc = [[GHHospitalCommentDetailViewController alloc] init];
//        vc.model = [self.hospitalArray objectOrNilAtIndex:indexPath.row];
//        [self.navigationController pushViewController:vc animated:true];
        
        GHHospitalCommentDetailViewController *vc = [[GHHospitalCommentDetailViewController alloc] init];
        
        GHDoctorCommentModel *commentModel = [self.hospitalArray objectOrNilAtIndex:indexPath.row];
        
        vc.model = [[GHMyCommentsModel alloc] initWithDictionary:[commentModel toDictionary] error:nil];
        vc.model.pictures = commentModel.pictures;
        vc.model.modelId = commentModel.hospitalModel.modelId;
        vc.model.score = [NSString stringWithFormat:@"%d",[commentModel.score intValue] * 10];
        vc.model.envScore = [NSString stringWithFormat:@"%d",[commentModel.envScore intValue] * 10];
        vc.model.serviceScore = [NSString stringWithFormat:@"%d",[commentModel.serviceScore intValue] * 10];
        
        vc.hospitalModel = commentModel.hospitalModel;
        [self.navigationController pushViewController:vc animated:true];
        
    }
    

    
}

/**
 每当点击顶部按钮便刷新列表
 
 @param tag <#tag description#>
 */
- (void)clickButtonWithTag:(NSInteger)tag {
    
    [self.scrollView setContentOffset:CGPointMake(SCREENWIDTH * tag, 0) animated:NO];
    [self refreshData];
    
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




////
////  GHMyCommentsListViewController.m
////  掌上优医
////
////  Created by GH on 2019/2/20.
////  Copyright © 2019 GH. All rights reserved.
////
//
//#import "GHMyCommentsListViewController.h"
//
//#import "GHMyCommentsTableViewCell.h"
//
//#import "GHMyCommentsDetailViewController.h"
//
//@interface GHMyCommentsListViewController ()<UITableViewDelegate, UITableViewDataSource>
//
//@property (nonatomic, strong) UITableView *tableView;
//
//@property (nonatomic, strong) NSMutableArray *dataArray;
//
//@property (nonatomic, assign) NSUInteger totalPage;
//
//@property (nonatomic, assign) NSUInteger currentPage;
//
//@property (nonatomic, assign) NSUInteger pageSize;
//
//@end
//
//@implementation GHMyCommentsListViewController
//
//- (NSMutableArray *)dataArray {
//
//    if (!_dataArray) {
//        _dataArray = [[NSMutableArray alloc] init];
//    }
//    return _dataArray;
//
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//
//    self.navigationItem.title = @"我的点评";
//
//    self.view.backgroundColor = kDefaultGaryViewColor;
//
//    [self setupUI];
//
//    [self setupConfig];
//    [self requsetData];
//
//}
//
//- (void)setupConfig {
//    self.currentPage = 0;
//    self.totalPage = 1;
//    self.pageSize = 5;
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
////    [SVProgressHUD showWithStatus:kDefaultTipsText];
//
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    params[@"pageSize"] = @(self.pageSize);
//    params[@"from"] = @(self.currentPage);
//
//    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDoctorMyComments withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
//
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//
//        if (isSuccess) {
//
//            [SVProgressHUD dismiss];
//
//            if (self.currentPage == 0) {
//
//                [self.dataArray removeAllObjects];
//
//            }
//
//            NSMutableArray *doctorIdsArray = [[NSMutableArray alloc] init];
//
//            for (NSDictionary *dicInfo in response) {
//
//                GHMyCommentsModel *model = [[GHMyCommentsModel alloc] initWithDictionary:dicInfo error:nil];
//
//                if (model == nil) {
//                    continue;
//                }
//
//
//                if (model.comment.length == 0) {
//
//                    switch ([model.score integerValue]) {
//                        case 1:
//                            model.comment = @"极差";
//                            break;
//
//                        case 2:
//                            model.comment = @"极差";
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
//
//                model.contentHeight = @([ISNIL(model.comment) getShouldHeightWithContent:ISNIL(model.comment) withFont:H15 withWidth:SCREENWIDTH - 32 withLineHeight:21] + 24);
//
//                NSArray *pictureArray = [model.pictures jsonValueDecoded];
//
//                if (pictureArray.count > 3) {
//
//                    model.shouldHeight = @([model.contentHeight floatValue] + 198 + 190 - 15);
//
//                } else if (pictureArray.count == 0) {
//
//                    model.shouldHeight = @([model.contentHeight floatValue] + 190 - 15);
//
//                } else {
//
//                    model.shouldHeight = @([model.contentHeight floatValue] + 198 + 95 - 15);
//
//                }
//
//                if (![doctorIdsArray containsObject:ISNIL(model.doctorId)]) {
//                    [doctorIdsArray addObject:ISNIL(model.doctorId)];
//                }
//
//
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
//
//
//            if (self.dataArray.count == 0) {
//                [self loadingEmptyView];
//            }else{
//                [self hideEmptyView];
//            }
//
//            if (doctorIdsArray.count) {
//
//                NSMutableDictionary *sonParams = [[NSMutableDictionary alloc] init];
//                sonParams[@"ids"] = [doctorIdsArray componentsJoinedByString:@","];
//
//                [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDoctorSampleinfoIds withParameter:sonParams withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
//
//                    if (isSuccess) {
//
//                        for (NSInteger index = 0; index < self.dataArray.count; index++) {
//
//                            GHMyCommentsModel *model = [self.dataArray objectOrNilAtIndex:index];
//
//                            if (model.doctorName.length > 0) {
//                                continue;
//                            }
//
//                            for (NSDictionary *dic in response) {
//
//                                if ([dic[@"id"] longValue] == [model.doctorId longValue]) {
//
//                                    model.doctorName = ISNIL(dic[@"doctorName"]);
//                                    model.doctorGrade = ISNIL(dic[@"doctorGrade"]);
//                                    model.doctorProfilePhoto = ISNIL(dic[@"profilePhoto"]);
//                                    model.doctorScore = [NSString stringWithFormat:@"%ld", [dic[@"score"] integerValue]];
//                                    model.doctorHospitalName = ISNIL(dic[@"hospitalName"]);
//
//                                    continue;
//
//                                }
//
//                            }
//
//                        }
//
//                        [self.tableView reloadData];
//
//                    }
//
//                }];
//
//            } else {
//                [self.tableView reloadData];
//            }
//
//        }
//
//    }];
//
//}
//
//
//- (void)setupUI {
//
//    UITableView *tableView = [[UITableView alloc] init];
//
//    tableView.backgroundColor = kDefaultGaryViewColor;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tableView.delegate = self;
//    tableView.dataSource = self;
//
//    tableView.estimatedRowHeight = 0;
//    tableView.estimatedSectionHeaderHeight = 0;
//    tableView.estimatedSectionFooterHeight = 0;
//
//    [self.view addSubview:tableView];
//
//    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.mas_equalTo(0);
//        make.bottom.mas_equalTo(kBottomSafeSpace);
//    }];
//    self.tableView = tableView;
//
//    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
//    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
//
//}
//
//#pragma mark - TableViewDataSource
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 1;
//
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return self.dataArray.count;
//
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    GHMyCommentsModel *model = [self.dataArray objectOrNilAtIndex:indexPath.row];
//
//    return [model.shouldHeight floatValue];
//
//}
//
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    GHMyCommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHMyCommentsTableViewCell"];
//
//    if (!cell) {
//
//        cell = [[GHMyCommentsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHMyCommentsTableViewCell"];
//
//        cell.contentView.backgroundColor = kDefaultGaryViewColor;
//
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
//    vc.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
//    [self.navigationController pushViewController:vc animated:true];
//
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end

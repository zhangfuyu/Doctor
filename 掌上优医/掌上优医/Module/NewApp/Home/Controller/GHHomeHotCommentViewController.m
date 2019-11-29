//
//  GHHomeHotCommentViewController.m
//  掌上优医
//
//  Created by apple on 2019/10/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHomeHotCommentViewController.h"
#import "LMHWaterFallLayout.h"

#import "GHNChooseTitleView.h"
#import "GHSearchDoctorModel.h"
#import "GHDoctorCommentModel.h"
#import "GHChoiceModel.h"
#import "GHHomeCommentsCollectionViewCell.h"
#import "GHMyCommentsDetailViewController.h"
#import "GHHospitalCommentDetailViewController.h"

@interface GHHomeHotCommentViewController ()<GHNChooseTitleViewDelegate, LMHWaterFallLayoutDeleaget, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) GHNChooseTitleView *titleView;

@property (nonatomic, strong) NSMutableArray *tableViewArray;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) NSUInteger pageSize;

@property (nonatomic, strong) NSMutableArray *doctorArray;
@property (nonatomic, assign) NSUInteger doctorCurrentPage;
@property (nonatomic, assign) NSUInteger doctorTotalPage;
@property (nonatomic, strong) UICollectionView *doctorTableView;

@property (nonatomic, strong) NSMutableArray *hospitalArray;
@property (nonatomic, assign) NSUInteger hospitalCurrentPage;
@property (nonatomic, assign) NSUInteger hospitalTotalPage;
@property (nonatomic, strong) UICollectionView *hospitalTableView;

@property (nonatomic, strong) UIView *doctorEmptyView;
@property (nonatomic, strong) UIView *hospitalEmptyView;


@end

@implementation GHHomeHotCommentViewController

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
    
    self.navigationItem.title = @"评价";
       
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
    
    NSArray *titleArray = @[@"医院评价", @"医生评价"];
    
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
        
        LMHWaterFallLayout * waterFallLayout = [[LMHWaterFallLayout alloc]init];
           waterFallLayout.fallDelegate = self;
        UICollectionView *collocview = [[UICollectionView alloc]initWithFrame:CGRectMake(SCREENWIDTH * index, 0, SCREENWIDTH, scrollView.contentSize.height) collectionViewLayout:waterFallLayout];
        collocview.backgroundColor = [UIColor whiteColor];
        collocview.delegate = self;
        collocview.dataSource = self;
        collocview.showsVerticalScrollIndicator = NO;
        [collocview registerClass:[GHHomeCommentsCollectionViewCell class] forCellWithReuseIdentifier:@"GHHomeCommentsCollectionViewCell"];

        [scrollView addSubview:collocview];
        
//        UITableView *tableView = [[UITableView alloc] init];
//        tableView.delegate = self;
//        tableView.dataSource = self;
//        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        tableView.tag = index;
//        tableView.backgroundColor = kDefaultGaryViewColor;
//        tableView.frame = CGRectMake(SCREENWIDTH * index, 0, SCREENWIDTH, scrollView.contentSize.height);
//
//        [scrollView addSubview:tableView];
        
        [self.tableViewArray addObject:collocview];
        
        if (index == 1) {
            self.doctorTableView = collocview;
        } else if (index ==  0){
            self.hospitalTableView = collocview;
        }
        
        collocview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        
        collocview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
        
    }
    
    self.scrollView = scrollView;
    
    
}

#pragma mark  - <LMHWaterFallLayoutDeleaget>
- (CGFloat)waterFallLayout:(LMHWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth{
    
    GHChoiceModel *model ;
    
    if (self.scrollView.contentOffset.x == SCREENWIDTH * 1)
    {
        model = [self.doctorArray objectOrNilAtIndex:indexPath];
        
    }
    else
    {
      model = [self.hospitalArray objectOrNilAtIndex:indexPath];

    }
    return [model.shouldHeight floatValue] + 4;
}

- (CGFloat)rowMarginInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout {
    
    return 8;
    
}

- (CGFloat)columnMarginInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout {
    
    return 8;
    
}

- (NSUInteger)columnCountInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout{
    
    return 2;
    
}

//- (UIEdgeInsets)edgeInsetdInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout {
//
//    return UIEdgeInsetsMake(HScaleHeight(350), 16, 16, 16);
//
//}


#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    if (self.scrollView.contentOffset.x == SCREENWIDTH * 1)
       {
           return self.doctorArray.count;
           
       }
       else
       {
           return self.hospitalArray.count;
       }
    
    return 0;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GHHomeCommentsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GHHomeCommentsCollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    if (self.scrollView.contentOffset.x == SCREENWIDTH * 1)
    {
        cell.model = [self.doctorArray objectOrNilAtIndex:indexPath.row];

          
    }
    else
    {
        cell.model = [self.hospitalArray objectOrNilAtIndex:indexPath.row];
    }
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.view endEditing:true];
    
    [MobClick event:@"Home_Choice"];
    
    
    GHChoiceModel *model ;
    
    if (self.scrollView.contentOffset.x == SCREENWIDTH * 1)
    {
        model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
        
    }
    else
    {
      model = [self.hospitalArray objectOrNilAtIndex:indexPath.row];

    }
    if ([model.commentObjType integerValue] == 1) {
        
        GHMyCommentsDetailViewController *vc = [[GHMyCommentsDetailViewController alloc] init];
        
        vc.model = [[GHMyCommentsModel alloc] initWithDictionary:[model.doctormoodel toDictionary] error:nil];
        vc.model.score = model.score;
        vc.model.doctorProfilePhoto = model.doctormoodel.headImgUrl;
        vc.model.pictures = model.pictures;
        vc.model.serviceScore = model.serviceScore;
        vc.model.comment = model.comment;
        vc.model.userNickName = model.userNickName;
        vc.model.createTime = model.createTime;
        vc.model.userProfileUrl = model.userProfileUrl;
        vc.model.doctorName = model.doctormoodel.doctorName;
        vc.model.doctorGrade = model.doctormoodel.doctorGrade;
        vc.model.hospitalName = model.doctormoodel.hospitalName;
        vc.model.diseaseName = model.diseaseName;
        vc.model.cureMethod = model.cureMethod;
        vc.model.cureState = model.cureState;
        vc.model.commentScore = [NSString stringWithFormat:@"%f",[model.doctormoodel.commentScore floatValue]];
        vc.model.doctorSecondDepartmentName = model.doctormoodel.secondDepartmentName;
        vc.model.modelId = model.doctormoodel.modelId;
        [self.navigationController pushViewController:vc animated:true];
        
    } else if ([model.commentObjType integerValue] == 2) {
        
        GHHospitalCommentDetailViewController *vc = [[GHHospitalCommentDetailViewController alloc] init];
        
        vc.model = [[GHMyCommentsModel alloc] initWithDictionary:[model.hospitalmoodel toDictionary] error:nil];
        vc.model.createTime = model.createTime;
        vc.model.envScore = model.envScore;
        vc.model.serviceScore = model.serviceScore;
        vc.model.score = [NSString stringWithFormat:@"%d",[model.score intValue]];
        vc.model.pictures = model.pictures;
        vc.model.comment = model.comment;
        vc.model.userNickName = model.userNickName;
        vc.model.gmtCreate = model.createTime;
        vc.model.modelId = model.hospitalmoodel.modelId;
        vc.hospitalModel = model.hospitalmoodel;
        [self.navigationController pushViewController:vc animated:true];
        
    }
    
    if (![[GHSaveDataTool shareInstance].readCommentIdArray containsObject:model.modelId]) {
        [[GHSaveDataTool shareInstance].readCommentIdArray addObject:model.modelId];
    }
    
    model.visitCount = [NSString stringWithFormat:@"%ld", [model.visitCount integerValue] + 1];
    
    [collectionView reloadData];
    //    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
}


/**
 每当点击顶部按钮便刷新列表
 
 @param tag <#tag description#>
 */
- (void)clickButtonWithTag:(NSInteger)tag {
    
    [self.scrollView setContentOffset:CGPointMake(SCREENWIDTH * tag, 0) animated:NO];
    [self refreshData];
    
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
        params[@"choiceFlag"] = @(2);
        params[@"sortType"] = @(1);
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDoctorComments withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            [self.doctorTableView.mj_header endRefreshing];
            [self.doctorTableView.mj_footer endRefreshing];
            
            if (isSuccess) {
                
                [SVProgressHUD dismiss];
                
                if (self.doctorCurrentPage == 1) {
                    
                    [self.doctorArray removeAllObjects];
                    
                }
                NSArray *commentList = response[@"data"][@"commentList"];
                
                if (commentList.count > 0) {
                    
                    for (NSDictionary *dicInfo in commentList) {
                        
                         GHChoiceModel *model = [[GHChoiceModel alloc] initWithDictionary:dicInfo[@"comment"] error:nil];
                             GHSearchDoctorModel *docmodel = [[GHSearchDoctorModel alloc] initWithDictionary:dicInfo[@"doctor"] error:nil];
                             model.doctormoodel = docmodel;
                
                         
                         if (model == nil) {
                             continue;
                         }
                         
                         CGFloat shouldHeight = 8;
                         
                         NSArray *array = [model.pictures jsonValueDecoded];
                         
                         if (array.count) {
                             
                             NSDictionary *dic = [array firstObject];
                             
                             model.firstPicture = dic[@"url"];
                             CGFloat imageWidth = [dic[@"width"] floatValue];
                             CGFloat imageHeight = [dic[@"height"] floatValue];
                             
                             shouldHeight += (((SCREENWIDTH - 32 - 8) * .5) / imageWidth) * imageHeight;
                             
                             model.imageHeight = [NSString stringWithFormat:@"%.2f", shouldHeight - 8];

                             
                         }
                         
                         
                         //                shouldHeight += [model.comment heightForFont:HM14 width:((SCREENWIDTH - 32 - 8) * .5) - 15];
                         
                         
                         CGFloat contentHeight = [model.comment heightForFont:HM13 width:((SCREENWIDTH - 32 - 8) * .5) - 15];
                         
                         if (model.comment.length) {
                             
                             if (contentHeight < 25) {
                                 shouldHeight += 17;
                             } else {
                                 shouldHeight += 34;
                             }
                             
                         }
                         
                         shouldHeight += 42 - 3;
                         
                         
                         model.shouldHeight = [NSString stringWithFormat:@"%.2f", shouldHeight];
                        [self.doctorArray addObject:model];
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
                

        }];
        
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 0) {
        
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"pageSize"] = @(self.pageSize);
        params[@"page"] = @(self.hospitalCurrentPage);
        params[@"commentObjType"] = @(2);
        params[@"choiceFlag"] = @(2);
        params[@"sortType"] = @(1);
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDoctorComments withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            [self.hospitalTableView.mj_header endRefreshing];
            [self.hospitalTableView.mj_footer endRefreshing];
            
            if (isSuccess) {
                
                [SVProgressHUD dismiss];
                
                if (self.hospitalCurrentPage == 1) {
                    
                    [self.hospitalArray removeAllObjects];
                    
                }
                
                
                NSArray *commentList = response[@"data"][@"commentList"];
                
                if (commentList.count  > 0) {
                     for (NSDictionary *dicInfo in response[@"data"][@"commentList"]) {
                                   
                        GHChoiceModel *model = [[GHChoiceModel alloc] initWithDictionary:dicInfo[@"comment"] error:nil];
                        
                           GHSearchHospitalModel *hosmodel = [[GHSearchHospitalModel alloc] initWithDictionary:dicInfo[@"hospital"] error:nil];
                           model.hospitalmoodel = hosmodel;

                           
                           if (model == nil) {
                               continue;
                           }
                           
                           CGFloat shouldHeight = 8;
                           
                           NSArray *array = [model.pictures jsonValueDecoded];
                           
                           if (array.count) {
                               
                               NSDictionary *dic = [array firstObject];
                               
                               model.firstPicture = dic[@"url"];
                               CGFloat imageWidth = [dic[@"width"] floatValue];
                               CGFloat imageHeight = [dic[@"height"] floatValue];
                               
                               shouldHeight += (((SCREENWIDTH - 32 - 8) * .5) / imageWidth) * imageHeight;
                               
                               model.imageHeight = [NSString stringWithFormat:@"%.2f", shouldHeight - 8];

                               
                           }
                           
                           
                           //                shouldHeight += [model.comment heightForFont:HM14 width:((SCREENWIDTH - 32 - 8) * .5) - 15];
                           
                           
                           CGFloat contentHeight = [model.comment heightForFont:HM13 width:((SCREENWIDTH - 32 - 8) * .5) - 15];
                           
                           if (model.comment.length) {
                               
                               if (contentHeight < 25) {
                                   shouldHeight += 17;
                               } else {
                                   shouldHeight += 34;
                               }
                               
                           }
                           
                           shouldHeight += 42 - 3;
                           
                           
                           model.shouldHeight = [NSString stringWithFormat:@"%.2f", shouldHeight];
                           
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

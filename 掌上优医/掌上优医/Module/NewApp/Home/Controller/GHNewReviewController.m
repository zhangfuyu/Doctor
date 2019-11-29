//
//  GHNewReviewController.m
//  掌上优医
//
//  Created by apple on 2019/7/31.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewReviewController.h"
#import "LMHWaterFallLayout.h"
#import "GHHomeCommentsCollectionViewCell.h"
#import "GHMyCommentsDetailViewController.h"
#import "GHHospitalCommentDetailViewController.h"



@interface GHNewReviewController ()<LMHWaterFallLayoutDeleaget, UICollectionViewDelegate, UICollectionViewDataSource,UIGestureRecognizerDelegate>


/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSUInteger totalPage;

@property (nonatomic, assign) NSUInteger currentPage;

@property (nonatomic, assign) NSUInteger pageSize;

@end

@implementation GHNewReviewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    
    [self setupConfig];
    
    // 创建布局
    LMHWaterFallLayout * waterFallLayout = [[LMHWaterFallLayout alloc]init];
    waterFallLayout.fallDelegate = self;
//    waterFallLayout.headerReferenceSize = CGSizeMake(SCREENWIDTH, HScaleHeight(350));
    
    //    UICollectionViewFlowLayout *waterFallLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //    waterFallLayout.headerReferenceSize = CGSizeMake(SCREENWIDTH, HScaleHeight(350));
    
    // 创建collectionView
    self.scrollView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - Height_TabBar - Height_NavBar - 50) collectionViewLayout:waterFallLayout];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.delegate = self;
    self.scrollView.dataSource = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    
    
    [self.scrollView registerClass:[GHHomeCommentsCollectionViewCell class] forCellWithReuseIdentifier:@"GHHomeCommentsCollectionViewCell"];
    
    [self.view addSubview:self.scrollView];
//    //注册头视图
//    [self.collectionView registerClass:[GHHomeTopCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GHHomeTopCollectionReusableView"];
    
//    self.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.scrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
    [self refreshData];
}
- (void)reloadRequest
{
    [self refreshData];
}

- (void)refreshData{
    self.currentPage = 1;
    self.totalPage = 1;
    [self requsetData];
}
- (void)setupConfig {
    self.currentPage = 1;
    self.totalPage = 1;
    self.pageSize = 10;
}
- (void)getMoreData{
    self.currentPage ++;
    [self requsetData];
}

#pragma mark  - <LMHWaterFallLayoutDeleaget>
- (CGFloat)waterFallLayout:(LMHWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth{
    
    GHChoiceModel *model = [self.dataArray objectOrNilAtIndex:indexPath];
    
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
    
    return self.dataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GHHomeCommentsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GHHomeCommentsCollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(SCREENWIDTH, HScaleHeight(350));
//}
//
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//
//
//    return nil;
//
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.view endEditing:true];
    
    [MobClick event:@"Home_Choice"];
    
    
    GHChoiceModel *model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    if ([model.commentObjType integerValue] == 1) {
        
        GHMyCommentsDetailViewController *vc = [[GHMyCommentsDetailViewController alloc] init];
        
        vc.model = [[GHMyCommentsModel alloc] init];//WithDictionary:[model.doctormoodel toDictionary] error:nil];
        vc.model.score = model.score;
        vc.model.pictures = model.pictures;
        vc.model.serviceScore = model.serviceScore;
        vc.model.comment = model.comment;
        vc.model.userNickName = model.userNickName;
        vc.model.gmtCreate = model.createTime;
        vc.model.userProfileUrl = model.userProfileUrl;
        vc.model.doctorName = model.doctormoodel.doctorName;
        vc.model.doctorGrade = model.doctormoodel.doctorGrade;
        vc.model.hospitalName = model.doctormoodel.hospitalName;
        vc.model.createTime = model.createTime;
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
        vc.model.userProfileUrl = model.userImgUrl;
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
    
    [self.scrollView reloadData];
    //    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        //        if (!self.fingerIsTouch) {//这里的作用是在手指离开屏幕后也不让显示主视图，具体可以自己看看效果
        //            return;
        //        }
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];//到顶通知父视图改变状态
    }
//    self.scrollView.showsVerticalScrollIndicator = _vcCanScroll?YES:NO;
}
- (void)requsetData {
    
    
    NSMutableDictionary *questionParams = [[NSMutableDictionary alloc] init];
//    questionParams[@"userId"] = [GHUserModelTool shareInstance].userInfoModel.modelId;
//    questionParams[@"commentObjId"] = self.model.modelId;
//    questionParams[@"commentObjType"] = @(1);
    questionParams[@"choiceFlag"] = @(2);
    questionParams[@"sortType"] = @(1);
    questionParams[@"page"] = @(self.currentPage);
    questionParams[@"pageSize"] = @(10);
    if ([self.title isEqualToString:@"医生评价"]) {
        questionParams[@"commentObjType"] = @(1);

    }
    else
    {
        questionParams[@"commentObjType"] = @(2);

    }
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDoctorComments withParameter:questionParams withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.scrollView.mj_header endRefreshing];
        [self.scrollView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            if (self.currentPage == 1) {
                
                [self.dataArray removeAllObjects];
                
            }
            
            for (NSDictionary *dicInfo in response[@"data"][@"commentList"]) {
                
                
                
                
                GHChoiceModel *model = [[GHChoiceModel alloc] initWithDictionary:dicInfo[@"comment"] error:nil];
                if ([model.commentObjType integerValue] == 1) {
                    GHSearchDoctorModel *docmodel = [[GHSearchDoctorModel alloc] initWithDictionary:dicInfo[@"doctor"] error:nil];
                    model.doctormoodel = docmodel;
                    model.userProfileUrl = model.userImgUrl;
                }
                else
                {
                    GHSearchHospitalModel *hosmodel = [[GHSearchHospitalModel alloc] initWithDictionary:dicInfo[@"hospital"] error:nil];
                    model.hospitalmoodel = hosmodel;
                    model.userProfileUrl = model.userImgUrl;

                }
                
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
                
                [self.dataArray addObject:model];
                
            }
            
            if (((NSArray *)response[@"data"][@"commentList"]).count >0) {
                
            } else {
                self.currentPage ++;
                [self.scrollView.mj_footer endRefreshingWithNoMoreData];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.scrollView reloadData];

            });
            
            
        }
        
    }];
    
    
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

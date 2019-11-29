//
//  GHNewDoctorDetailViewController.m
//  掌上优医
//
//  Created by apple on 2019/8/9.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewDoctorDetailViewController.h"
#import "GHSearchDoctorModel.h"
#import "GHNewDoctorDetailView.h"
#import "GHQuestionModel.h"
#import "GHTNewQuestionableViewCell.h"
#import "GHQuestionViewController.h"
#import "GHNewAnswerHeaderView.h"
#import "GHAnswerListViewController.h"

#import "GHNewCommentsFootView.h"
#import "GHDoctorCommentModel.h"
#import "GHDoctorCommentTableViewCell.h"//评论cell
#import "GHMyCommentsDetailViewController.h"

#import "GHNewCommentsHeaderView.h"
#import "GHDoctorCommentViewController.h"
#import "GHCommonShareView.h"

@interface GHNewDoctorDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) GHCommonShareView *shareView;
@property (nonatomic, strong) GHSearchDoctorModel *model;
@property (nonatomic, strong) GHNewDoctorDetailView *doctorHeaderView;
@property (nonatomic, strong) UITableView *datatabelview;
@property (nonatomic, strong) NSMutableArray *answerData;
@property (nonatomic, strong) GHNewAnswerHeaderView *firstHeaderview;
@property (nonatomic, strong) GHNewCommentsFootView *tablefootview;
@property (nonatomic, strong) NSMutableArray *commentArray;//评论数组
@property (nonatomic, strong) GHNewCommentsHeaderView *secondHeaderview;
@property (nonatomic, strong) NSString *problemNums;//问答条数

@property (nonatomic, strong) UIButton *collectionButton;


@end

@implementation GHNewDoctorDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"医生介绍";
    self.problemNums = @"0";
    
    [self addNavigationRightView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDataAction) name:kNotificationDoctorCommentSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getanswerData) name:kNotificationDoctorQuestionSuccess object:nil];

    
//    [self.datatabelview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.mas_equalTo(0);
//        make.bottom.mas_equalTo(kBottomSafeSpace);
//    }];
    
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.backgroundColor = kDefaultBlueColor;
    [commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commentButton setImage:[UIImage imageNamed:@"doctor_comment_new"] forState:UIControlStateNormal];
    [commentButton setTitle:@"写评价" forState:UIControlStateNormal];
    commentButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
    commentButton.titleLabel.font = H17;
    [commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:commentButton];
    
    [commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(47);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    [commentButton addTarget:self action:@selector(clickCommentAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.datatabelview setTableHeaderView:self.doctorHeaderView];
    [self.datatabelview setTableFooterView:self.tablefootview];
    
    __weak typeof(self) weakSekf = self;
    self.doctorHeaderView.backSelfHeight = ^(CGFloat headHeight) {
        weakSekf.doctorHeaderView.frame = CGRectMake(0, 0, SCREENWIDTH, CGRectGetHeight(weakSekf.doctorHeaderView.frame) + headHeight);
        [weakSekf.datatabelview reloadData];
    };
    
//    self.datatabelview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getDataAction)];

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"doctorId"] = ISNIL(self.doctorId);
    params[@"lat"] = @([GHUserModelTool shareInstance].locationLatitude > 0 ? [GHUserModelTool shareInstance].locationLatitude : 30.3751);
    params[@"lng"] = @([GHUserModelTool shareInstance].locationLongitude > 0 ? [GHUserModelTool shareInstance].locationLongitude : 120.1236);
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDetailDocotr withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];

            self.model = [[GHSearchDoctorModel alloc] initWithDictionary:response[@"data"][@"doctor"] error:nil];
            self.model.hospitalId = response[@"data"][@"hospitalId"];
            self.model.hospitalName = response[@"data"][@"hospitalName"];
            self.model.hospitalAddress = response[@"data"][@"hospitalAddress"];
            self.model.distance = response[@"data"][@"distance"];
            NSArray *departmentarry = response[@"data"][@"hospitalDepartment"];
            if (departmentarry.count > 0) {
                self.model.firstDepartmentName = departmentarry.firstObject;

            }
            self.doctorHeaderView.model = self.model;
            self.tablefootview.model = self.model;
            self.secondHeaderview.model = self.model;
            self.firstHeaderview.doctorId = self.model.modelId;
//            [self getDataAction];
            [self getanswerData];
            [GHUserModelTool shareInstance].isLogin ? [self addFootprint] : nil;;
            [self chooseCollection];


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

- (void)addFootprint
{
    NSMutableDictionary *parmars = [[NSMutableDictionary alloc]init];
    parmars[@"contentType"] = @(2);
    parmars[@"contentId"] = self.model.modelId;
    parmars[@"title"] = self.model.doctorName;
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiAddFootprint withParameter:parmars withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            NSLog(@"----->添加足迹成功");
        }
    }];
}

- (void)getanswerData
{
    NSMutableDictionary *questionParams = [[NSMutableDictionary alloc] init];
    questionParams[@"ownerType"] = @(2);
    questionParams[@"ownerId"] = self.model.modelId;
    questionParams[@"page"] = @(1);
    questionParams[@"pageSize"] = @(2);
    
    [self.answerData removeAllObjects];
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiCircleDoctorPosts withParameter:questionParams withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            self.problemNums = [NSString stringWithFormat:@"%@",response[@"data"][@"problemNums"]];
            
            for (NSDictionary *dic in response[@"data"][@"problemList"]) {
                
                GHQuestionModel *model = [[GHQuestionModel alloc] initWithDictionary:dic error:nil];
                [self.answerData addObject:model];

                
                
            }

            
        }
        [self getDataAction];

        
    }];
}

- (void)getDataAction {
    
    NSMutableDictionary *questionParams = [[NSMutableDictionary alloc] init];
//    questionParams[@"userId"] = [GHUserModelTool shareInstance].userInfoModel.modelId;
    questionParams[@"commentObjId"] = self.model.modelId;
    questionParams[@"commentObjType"] = @(1);
//    questionParams[@"choiceFlag"] = @(1);
    questionParams[@"sortType"] = @(1);
    questionParams[@"page"] = @(1);
    questionParams[@"pageSize"] = @(2);
    
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];

    
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDoctorComments withParameter:questionParams withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.datatabelview.mj_header endRefreshing];
        [self.datatabelview.mj_footer endRefreshing];
        
        [self.commentArray removeAllObjects];
        [SVProgressHUD dismiss];
        if (isSuccess) {
            
            for (NSDictionary *dicInfo in response[@"data"][@"commentList"]) {
                
                GHDoctorCommentModel *model = [[GHDoctorCommentModel alloc] initWithDictionary:dicInfo[@"comment"] error:nil];
                model.doctorModel = [[GHSearchDoctorModel alloc]initWithDictionary:dicInfo[@"doctor"] error:nil];
                
                
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
                
                
                

                [self.commentArray addObject:model];
                
            }
            
            [self.datatabelview reloadData];
            
            
            
        }
        
    }];
}

#pragma  mark -UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.answerData.count;
    }
    return self.commentArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellid = @"cellid";
        GHTNewQuestionableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[GHTNewQuestionableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.model = self.answerData[indexPath.row];
        return cell;
    }
    else
    {
        GHDoctorCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHDoctorCommentTableViewCell"];
        
        if (!cell) {
            cell = [[GHDoctorCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHDoctorCommentTableViewCell"];
        }
        
        cell.model = [self.commentArray objectOrNilAtIndex:indexPath.row];
        
        return cell;
    }
    return nil;
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
        GHAnswerListViewController *vc = [[GHAnswerListViewController alloc] init];
        vc.model = [self.answerData objectOrNilAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:true];
    }
    else{
        GHDoctorCommentModel *model = [self.commentArray objectOrNilAtIndex:indexPath.row];
        
        GHMyCommentsDetailViewController *vc = [[GHMyCommentsDetailViewController alloc] init];
        vc.model = [[GHMyCommentsModel alloc] initWithDictionary:[model toDictionary] error:nil];
        vc.model.pictures = model.pictures;
        vc.model.userProfileUrl = model.userProfileUrl;
        vc.model.diseaseName = model.diseaseName;
        vc.model.doctorName = self.model.doctorName;
        vc.model.doctorGrade = self.model.doctorGrade;
        vc.model.hospitalName = self.model.hospitalName;
        vc.model.doctorProfilePhoto = self.model.headImgUrl;
        vc.model.score = [NSString stringWithFormat:@"%.1f",[model.score floatValue] * 10];
        vc.model.commentScore = [NSString stringWithFormat:@"%f",[model.doctorModel.commentScore floatValue]];
        vc.model.doctorSecondDepartmentName = self.model.secondDepartmentName;
        vc.model.modelId = self.model.modelId;
        [self.navigationController pushViewController:vc animated:true];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 120;
    }
    GHDoctorCommentModel *model = [self.commentArray objectOrNilAtIndex:indexPath.row];
    
    return [model.shouldHeight floatValue];
    
//    return 110;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {

        if (self.answerData.count!= 0) {
            return 50;
        }
        else
        {
            return 140;
        }
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
   
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        self.firstHeaderview.frame = CGRectMake(0, 0, SCREENWIDTH, self.answerData.count == 0 ? 140 : 50);
        self.firstHeaderview.problemNums = self.problemNums;
        return self.firstHeaderview;
    }
    return self.secondHeaderview;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
    
        return nil;
    }
    return nil;
}
//然后在UITableView的代理方法中加入以下代码
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
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
- (void)chooseCollection
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"contentType"] = @(1);
    params[@"contentId"] = self.model.modelId;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiIsConllection  withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            if ([response[@"data"][@"isConllection"] boolValue]) {
                self.collectionButton.selected = YES;
                self.model.collectionId = [NSString stringWithFormat:@"%@",response[@"data"][@"id"]];
            }
            else
            {
                self.collectionButton.selected = NO;
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
            
            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiMyDonotConllection  withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
                
                
                
                if (isSuccess) {
                    
                    [SVProgressHUD dismiss];
                    
                    [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
                    
                    self.collectionButton.selected = false;
                    
                    if (self.clickCollectionBlock) {
                        self.clickCollectionBlock(NO);
                    }
                    
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCancelDoctorCollectionSuccess object:nil];
                    
                }
                
            }];
            
        } else {
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"contentId"] = ISNIL(self.model.modelId);
            
            params[@"title"] = ISNIL(self.model.doctorName);
            params[@"contentType"] = @(1);
            
            [SVProgressHUD showWithStatus:kDefaultTipsText];
            
            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiDoConllection withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
                
                if (isSuccess) {
                    
                    [SVProgressHUD dismiss];
                    self.model.collectionId = [NSString stringWithFormat:@"%@",response[@"data"][@"id"]];

                    self.collectionButton.selected = true;
                    [SVProgressHUD showSuccessWithStatus:@"收藏成功"];

                  
                    if (self.clickCollectionBlock) {
                        self.clickCollectionBlock(YES);
                    }
                }
                
            }];
            
        }
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self presentViewController:vc animated:true completion:nil];
        
    }
    
    
}
- (void)clickShareAction
{
    //    NSString *sharurl = [NSString stringWithFormat:@"%@?hospitalId=%@",@"http://share.zsu1.com/#/hospital",self.model.modelId];
    if (self.model.modelId.length > 0) {
        self.shareView.hidden = NO;
        
    }
}
- (GHCommonShareView *)shareView {
    
    if (!_shareView) {
        _shareView = [[GHCommonShareView alloc] init];
        _shareView.title = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.hospitalName)];
        _shareView.desc = @"了解医疗知识，关注健康生活。";
        _shareView.urlString = [[GHNetworkTool shareInstance] getDoctorDetailURLWithDoctorId:self.model.modelId];//[NSString stringWithFormat:@"%@?doctorId=%@",@"http://share.zsu1.com/doctorInfo.html",self.model.modelId];;
        [self.view addSubview:_shareView];
        
        [_shareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        _shareView.hidden = true;
    }
    return _shareView;
    
}
- (GHNewDoctorDetailView *)doctorHeaderView
{
    if (!_doctorHeaderView) {
        _doctorHeaderView = [[GHNewDoctorDetailView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 291.6)];
        _doctorHeaderView.backgroundColor = [UIColor whiteColor];
        
       
    }
    return _doctorHeaderView;
}

- (UITableView *)datatabelview
{
    if (!_datatabelview) {
        _datatabelview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _datatabelview.delegate= self;
        _datatabelview.dataSource = self;
        [self.view addSubview:_datatabelview];
        [_datatabelview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(kBottomSafeSpace - 47 );

        }];
    }
    return _datatabelview;
}
- (NSMutableArray *)answerData
{
    if (!_answerData) {
        _answerData = [NSMutableArray arrayWithCapacity:0];
    }
    return _answerData;
}
- (GHNewAnswerHeaderView *)firstHeaderview
{
    if (!_firstHeaderview) {
        _firstHeaderview = [[GHNewAnswerHeaderView alloc]init];
        _firstHeaderview.doctorId = self.doctorId;
        _firstHeaderview.clipsToBounds = YES;
    }
    return _firstHeaderview;
}

- (GHNewCommentsHeaderView *)secondHeaderview
{
    if (!_secondHeaderview) {
        _secondHeaderview = [[GHNewCommentsHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
    }
    return _secondHeaderview;
}

- (NSMutableArray *)commentArray
{
    if (!_commentArray) {
        _commentArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _commentArray;
}
- (GHNewCommentsFootView *)tablefootview
{
    if (!_tablefootview) {
        _tablefootview = [[GHNewCommentsFootView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 196)];
    }
    return _tablefootview;
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

//
//  GHNewDiseaseDetailViewController.m
//  掌上优医
//
//  Created by apple on 2019/8/6.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewDiseaseDetailViewController.h"
#import "GHNewContentHeaderView.h"
#import "GHNDiseaseModel.h"

#import "GHNewChooseRoleView.h"//选择医院 医生。资讯

#import "GHNewCasesView.h"

#import "GHNSearchDoctorTableViewCell.h"//老版的医生cell。后期销毁

#import "GHNewDoctorTableViewCell.h"//新版 医生cell

#import "GHConditionsView.h"

#import "GHNewDoctorDetailViewController.h"

#import "GHNewHospitalTableViewCell.h"//医院cell

#import "GHHospitalDetailViewController.h"//医院详情 old
#import "GHNewHospitalViewController.h"

#import "GHNewDoctorModel.h"
#import "GHNewZiXunModel.h"
#import "GHNewZiXunTableViewCell.h"
#import "GHNewInformationDetailViewController.h"

@interface GHNewDiseaseDetailViewController ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic, strong) GHNDiseaseModel *model;

@property (nonatomic, strong) NSMutableArray *diseaseList;

@property (nonatomic, strong) GHNewCasesView *segMentTitleView;

@property (nonatomic, strong) GHNewContentHeaderView *contentview;

@property (nonatomic, strong) UIView *tableHeader;

@property (nonatomic, strong) UIView *tableFooterView;

@property (nonatomic, strong) UITableView *dataTableView;

@property (nonatomic, strong) NSMutableArray *doctorArray;//医生数据

@property (nonatomic, strong) NSMutableArray *hospitalArray;//医院数据

@property (nonatomic, strong) NSMutableArray *zixunArry;//资讯数据

@property (nonatomic, assign) NSInteger doctorCurrentPage;//医生当前页

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, assign) NSUInteger doctorTotalPage;


@property (nonatomic, assign) NSInteger hospitalCurrentPage;//医院当前页

@property (nonatomic, assign) NSInteger zixunCurrentPage;//医院当前页

@property (nonatomic, assign) NSInteger hospitalpageSize;

@property (nonatomic, assign) NSUInteger hospitalTotalPage;

@property (nonatomic, strong) GHConditionsView *conditionview;//筛选条件

@property (nonatomic, strong) GHNewChooseRoleView *chooseRoleview;//区头

@property (nonatomic, strong) NSDictionary *preciseDisease;//简介wordsType

@property (nonatomic, strong) NSString *wordsType;//简介

@property (nonatomic, assign) NSInteger diseaseid;//疾病id

@property (nonatomic, strong) NSString *doctorMedicineType;// 中医 西医

@property (nonatomic, strong) NSString *hospitalLevel;//医院等级

@property (nonatomic, strong) NSString *doctorGradeNum;//医生职称

@property (nonatomic, strong) NSString *sortType;//离我最近
@property (nonatomic, strong) NSString *hospitalsortType;//离我最近

@property (nonatomic, strong) NSString *hospitalAdreessLevel;//医院等级

@property (nonatomic, strong) NSString *hospitalType;//医院等级
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, assign) NSInteger areLeave;

@property (nonatomic, copy) NSString *doctorSortText;
@property (nonatomic, copy) NSString *hospitalSortText;

@property (nonatomic, copy) NSString *departmentId;//科室id

@property (nonatomic, assign) BOOL isrequestHospital;

@end

@implementation GHNewDiseaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageSize = 10;
    
    if (self.sicknessId.length > 0) {
        self.searchTextField.text = self.sicknessId;
    }
    
    self.doctorSortText = @"离我最近";
    self.hospitalSortText = @"离我最近";
    self.hospitalsortType = @"2";
    self.sortType = @"3";
    self.areLeave = 3;
    self.city = [GHUserModelTool shareInstance].locationCity;
    self.area = [GHUserModelTool shareInstance].locationCityArea;
//    self.country = [GHUserModelTool shareInstance].loca;
    
    [self.searchTextField addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventEditingDidEndOnExit];
    self.dataTableView.tableFooterView = [UIView new];
    
    self.dataTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.dataTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
    
    [self firstRequest];
    
   
    
    
}

- (void)firstRequest
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"words"] = self.sicknessId;
    params[@"wordsType"] = @(self.selectType);
    params[@"sortType"] = @"2";
    params[@"lat"] = @([GHUserModelTool shareInstance].locationLatitude > 0 ? [GHUserModelTool shareInstance].locationLatitude : 30.3751);
    params[@"lng"] = @([GHUserModelTool shareInstance].locationLongitude > 0 ? [GHUserModelTool shareInstance].locationLongitude : 120.1236);
    
    
    if (self.areLeave == 1) {
        params[@"country"] = self.country;

    }
    else if (self.areLeave == 2)
    {
        params[@"province"] = self.country;

    }
    else if (self.areLeave == 3)
    {
        params[@"city"] = ISNIL(self.city);

    }
    else if (self.areLeave == 4)
    {
        params[@"city"] = ISNIL(self.city);
        params[@"area"] = ISNIL(self.area);
    }
    

    [SVProgressHUD showWithStatus:@"正在加载"];
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiNewAppSearch withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        [SVProgressHUD dismiss];
        if (isSuccess) {
            
            NSString *msg = response[@"data"][@"msg"];
            if ([msg hasPrefix:@"暂无数据"]) {
                self.doctorArray.count > 0 ?[self.doctorArray removeAllObjects] :nil;
                [self.hospitalArray removeAllObjects];
                [self.zixunArry removeAllObjects];
                [self changeTableviewHeader];

                return ;
            }
            
            self.preciseDisease = response[@"data"][@"preciseDisease"];
            
            self.wordsType = response[@"data"][@"wordsType"];
            
            self.diseaseid = [response[@"data"][@"preciseDisease"][@"id"] integerValue];
            
            self.model = [[GHNDiseaseModel alloc] initWithDictionary:response[@"data"][@"preciseDisease"] error:nil];
            
            self.model.firstDepartmentName = [[self.model.departmentNames componentsSeparatedByString:@","] componentsJoinedByString:@" | "];
            
            
           
            
            self.doctorArray.count > 0 ?[self.doctorArray removeAllObjects] :nil;
            
            self.chooseRoleview.rolesType = [response[@"data"][@"resultType"] intValue] - 1;
            self.isrequestHospital = NO;

            if (self.chooseRoleview.rolesType == GHrolesType_Doctor) {
                NSArray *hospitalDoctorList = response[@"data"][@"hospitalDoctorList"];
                [self.doctorArray removeAllObjects];

                for (NSInteger index = 0; index < hospitalDoctorList.count; index ++) {
                    GHNewDoctorModel *model = [[GHNewDoctorModel alloc] initWithDictionary:[hospitalDoctorList objectAtIndex:index] error:nil];
                    [self.doctorArray addObject:model];
                }
            }
            else if (self.chooseRoleview.rolesType == GHrolesType_Hospital)
            {
                
                NSArray *hospitalList = response[@"data"][@"hospitalList"];
                
                [self.hospitalArray removeAllObjects];
            
                for (NSDictionary *dicInfo in hospitalList) {
                    
                    GHSearchHospitalModel *model = [[GHSearchHospitalModel alloc] initWithDictionary:dicInfo[@"hospital"] error:nil];
                    model.distance = [NSString stringWithFormat:@"%@",dicInfo[@"distance"]];
                    if (model == nil) {
                        continue;
                    }
                    
                    [self.hospitalArray addObject:model];
                    
                }

                                   
            }
            else
            {
                NSArray *articleList = response[@"data"][@"articleList"];

                [self.zixunArry removeAllObjects];
                for (NSDictionary *zixundic in articleList) {
                    GHNewZiXunModel *model = [[GHNewZiXunModel alloc]initWithDictionary:zixundic error:nil];
                    [self.zixunArry addObject:model];
                }
            }
            
           
            
            
            
            
            self.model.summary = self.preciseDisease[@"summary"];
            
            self.model.symptom = self.preciseDisease[@"symptom"];
            
            self.model.pathogeny = self.preciseDisease[@"pathogeny"];
            
            self.model.diagnosis = self.preciseDisease[@"diagnosis"];
            
            self.model.treatment = self.preciseDisease[@"treatment"];
            
            
            
            if (ISNIL(self.model.summary).length == 0) {
                self.model.summary = @"<p>暂无</p>";
            }
            
            if (ISNIL(self.model.symptom).length == 0) {
                self.model.symptom = @"<p>暂无</p>";
            }
            
            if (ISNIL(self.model.pathogeny).length == 0) {
                self.model.pathogeny = @"<p>暂无</p>";
            }
            
            if (ISNIL(self.model.diagnosis).length == 0) {
                self.model.diagnosis = @"<p>暂无</p>";
            }
            
            if (ISNIL(self.model.treatment).length == 0) {
                self.model.treatment = @"<p>暂无</p>";
            }
            
            
            self.departmentId = [NSString stringWithFormat:@"%@",response[@"data"][@"departmentId"]];
            
            [self.diseaseList removeAllObjects];
            if (((NSArray *)response[@"data"][@"diseaseList"]).count) {
                [self.diseaseList addObjectsFromArray:(NSArray *)response[@"data"][@"diseaseList"]];

            }
            
            if (self.diseaseList.count >0) {
                [self.diseaseList insertObject:response[@"data"][@"preciseDisease"][@"diseaseName"] atIndex:0];
            }
            else
            {
        
                if ([((NSDictionary *)response[@"data"]).allKeys containsObject:@"preciseDisease"]) {
                    if (((NSDictionary *)response[@"data"][@"preciseDisease"]).allKeys.count > 0) {
                        [self.diseaseList addObject:response[@"data"][@"preciseDisease"][@"diseaseName"]];

                    }

                }
            }
            
            [self changeTableviewHeader];
            
            [GHUserModelTool shareInstance].isLogin ? [self addFootprint] : nil;;

        }
        else
        {
            NSLog(@"----->%@",response[@"message"]);
        }
        [self.dataTableView reloadData];
    }];
}

- (void)addFootprint
{
    NSMutableDictionary *parmars = [[NSMutableDictionary alloc]init];
    parmars[@"contentType"] = @(1);
    parmars[@"contentId"] = self.model.modelId;
    parmars[@"title"] = [self.diseaseList firstObject];
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiAddFootprint withParameter:parmars withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            NSLog(@"----->添加足迹成功");
        }
    }];
}

- (void)clickSearchAction
{
    self.sicknessId = self.searchTextField.text;
//    self.chooseRoleview.rolesType = GHrolesType_Doctor;
    [self firstRequest];
}

- (void)refreshData{
    
    
    
    if (self.chooseRoleview.rolesType == GHrolesType_Doctor) {
        self.doctorCurrentPage = 1;
        self.doctorTotalPage = 1;
        [self requestData];


    }
    else if (self.chooseRoleview.rolesType == GHrolesType_Hospital)
    {
        self.hospitalCurrentPage = 1;
        [self requestHospitalData];
    }
    else
    {
        self.zixunCurrentPage = 1;

        
        [self.dataTableView.mj_header endRefreshing];
        
        [self getkApiAllSearchArticle];

//        [self.dataTableView reloadData];
    }
    
    
    //    if (self.doctorArray.count) {
    //        [self.doctorTableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:false];
    //    }
    
    
}


- (void)getMoreData{
    
    if (self.chooseRoleview.rolesType == GHrolesType_Doctor) {
        self.doctorCurrentPage ++;
        [self requestData];


    }
    else if (self.chooseRoleview.rolesType == GHrolesType_Hospital)
    {
        self.hospitalCurrentPage ++;
        [self requestHospitalData];
    }
    else
    {
        [self.dataTableView.mj_footer endRefreshingWithNoMoreData];
    }

    
}
- (void)getkApiAllSearchArticle
{
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"page"] = @(self.zixunCurrentPage);
    parmas[@"words"] = self.searchTextField.text;
    parmas[@"pageSize"] = @(10);
    parmas[@"sortType"] = @(1);
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiAllSearchArticle withParameter:parmas withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
    
        if (isSuccess) {
            NSLog(@"请求成功");
            
            if (self.zixunCurrentPage == 1) {
                [self.zixunArry removeAllObjects];
            }
            
            if (((NSArray *)response[@"data"]).count > 0) {
                for (NSDictionary *zixundic in (NSArray *)response[@"data"]) {
                    GHNewZiXunModel *model = [[GHNewZiXunModel alloc]initWithDictionary:zixundic error:nil];
                    [self.zixunArry addObject:model];
                }
            }
            [self.dataTableView reloadData];
        }
    }];
    
}
- (void)requestData {
    
    //    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"words"] = self.sicknessId;

    params[@"page"] = @(self.doctorCurrentPage);
    
    params[@"wordsType"] = @([self.wordsType integerValue]);
    
    params[@"typeId"] = self.preciseDisease[@"id"];
    
//    params[@"doctorGradeNum"] = self.doctorGradeNum;
//    params[@"medicineType"] = self.doctorMedicineType;
//    params[@"hospitalLevel"] = self.hospitalLevel;
    params[@"lat"] = @([GHUserModelTool shareInstance].locationLatitude > 0 ? [GHUserModelTool shareInstance].locationLatitude : 30.3751);
    params[@"lng"] = @([GHUserModelTool shareInstance].locationLongitude > 0 ? [GHUserModelTool shareInstance].locationLongitude : 120.1236);
    
    
    
    params[@"hospitalLevel"] = ISNIL(self.hospitalLevel);
    params[@"doctorGradeNum"] = ISNIL(self.doctorGradeNum);
    params[@"medicineType"] = ISNIL(self.doctorMedicineType);
    params[@"sortType"] = ISNIL(self.sortType);
    params[@"province"] = ISNIL(self.country);
    if (self.areLeave == 1) {
        params[@"country"] = self.country;

    }
    else if (self.areLeave == 2)
    {
        params[@"province"] = self.country;

    }
    else if (self.areLeave == 3)
    {
        params[@"province"] = self.country;

        params[@"city"] = ISNIL(self.city);

    }
    else if (self.areLeave == 4)
    {
        params[@"province"] = self.country;
        params[@"city"] = ISNIL(self.city);
        params[@"area"] = ISNIL(self.area);
    }
    
    
    
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSearchDoctor withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.dataTableView.mj_header endRefreshing];
        [self.dataTableView.mj_footer endRefreshing];
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            NSArray *hospitalDoctorList = response[@"data"][@"hospitalDoctorList"];

            
            if (self.doctorCurrentPage == 1) {
                
                [self.doctorArray removeAllObjects];
                
            }
            
            if (hospitalDoctorList.count == 0) {
                self.doctorCurrentPage --;
                [self.dataTableView.mj_footer endRefreshingWithNoMoreData];
            }
            else
            {
                for (NSInteger index = 0; index < hospitalDoctorList.count; index ++) {
                    GHNewDoctorModel *model = [[GHNewDoctorModel alloc] initWithDictionary:[hospitalDoctorList objectAtIndex:index] error:nil];
                    [self.doctorArray addObject:model];
                }
            }
            
            [self.dataTableView reloadData];
        }
        
    }];
    
}


- (void)requestHospitalData {
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"pageSize"] = @(self.pageSize);
    params[@"words"] = self.sicknessId;
    NSString *foretid = [NSString stringWithFormat:@"%ld",self.diseaseid];
    params[@"typeId"] = ISNIL(foretid);
    params[@"wordsType"] = @(self.selectType);
    params[@"page"] = @(self.hospitalCurrentPage);
    
    params[@"category"] = self.hospitalType;
    params[@"hospitalLevel"] = self.hospitalAdreessLevel;
    
    params[@"sortType"] = ISNIL(self.hospitalsortType);
    
    params[@"province"] = ISNIL(self.country);
   if (self.areLeave == 1) {
        params[@"country"] = self.country;

    }
    else if (self.areLeave == 2)
    {
        params[@"province"] = self.country;

    }
    else if (self.areLeave == 3)
    {
        params[@"province"] = self.country;
        params[@"city"] = ISNIL(self.city);

    }
    else if (self.areLeave == 4)
    {
        params[@"province"] = self.country;
        params[@"city"] = ISNIL(self.city);
        params[@"area"] = ISNIL(self.area);
    }
    else
    {
        params[@"province"] = self.country;
        params[@"city"] = ISNIL(self.city);
        params[@"area"] = ISNIL(self.area);
    }
    
    params[@"lat"] = @([GHUserModelTool shareInstance].locationLatitude > 0 ? [GHUserModelTool shareInstance].locationLatitude : 30.3751);
    params[@"lng"] = @([GHUserModelTool shareInstance].locationLongitude > 0 ? [GHUserModelTool shareInstance].locationLongitude : 120.1236);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSearchHospital withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.dataTableView.mj_header endRefreshing];
        [self.dataTableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            NSLog(@"------>%@",response[@"data"][@"msg"]);
            
            [SVProgressHUD dismiss];
            
            if (self.hospitalCurrentPage == 1) {
                
                [self.hospitalArray removeAllObjects];
                
            }
            
            NSArray *hospitalList = response[@"data"][@"hospitalList"];
            
            if (hospitalList.count == 0) {
                self.hospitalCurrentPage --;
                [self.dataTableView.mj_footer endRefreshingWithNoMoreData];
            }
            else
            {
                for (NSDictionary *dicInfo in hospitalList) {
                    
                    GHSearchHospitalModel *model = [[GHSearchHospitalModel alloc] initWithDictionary:dicInfo[@"hospital"] error:nil];
                    model.distance = [NSString stringWithFormat:@"%@",dicInfo[@"distance"]];
                    if (model == nil) {
                        continue;
                    }
                    
                    [self.hospitalArray addObject:model];
                    
                }

            }
            
           
            
           
            
            
        }
        [self.dataTableView reloadData];

    }];
    
}


#pragma mark - UITableViewDelegate , UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.chooseRoleview.rolesType ==GHrolesType_Doctor) {
        return self.doctorArray.count;

    }
    else if (self.chooseRoleview.rolesType ==GHrolesType_Hospital)
    {
        return self.hospitalArray.count;
    }
    else
    {
        return self.zixunArry.count;

    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.chooseRoleview.rolesType == GHrolesType_Doctor) {
            return [GHNewDoctorTableViewCell getCellHeitghtWithMoel:[self.doctorArray objectAtIndex:indexPath.row]];
    }
    else if (self.chooseRoleview.rolesType == GHrolesType_Hospital)
    {
       return [GHNewHospitalTableViewCell getCellHeightFor:[self.hospitalArray objectAtIndex:indexPath.row]];
    }
    else
    {
        return 130;
    }
    

    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.chooseRoleview.rolesType == GHrolesType_Doctor) {
        GHNewDoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNSearchDoctorTableViewCell"];
        
        if (!cell) {
            cell = [[GHNewDoctorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNSearchDoctorTableViewCell"];
            
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        
        cell.model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
        
        return cell;
    }
    else if (self.chooseRoleview.rolesType == GHrolesType_Hospital)
    {
        GHNewHospitalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNewHospitalTableViewCell"];
        
        if (!cell) {
            cell = [[GHNewHospitalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNewHospitalTableViewCell"];
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        
        cell.model = [self.hospitalArray objectAtIndex:indexPath.row];
        
        return cell;
    }
    else
    {
        GHNewZiXunTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GHNewZiXunTableViewCell"];
        if (!cell) {
            cell = [[GHNewZiXunTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNewZiXunTableViewCell"];
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        cell.model = [self.zixunArry objectAtIndex:indexPath.row];
        return cell;
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView *headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.selectType == GHrolesType_information ? 45 : 80)];
    kWeakSelf;
    //点击 位置 距离 筛选
    self.chooseRoleview.chooseConditionsBlock = ^(GHconditions conditon) {
        
        if (weakSelf.dataTableView.contentOffset.y < weakSelf.tableHeader.height) {
            [weakSelf.dataTableView setContentOffset:CGPointMake(0, weakSelf.tableHeader.height) animated:false];
        }
        
        [weakSelf.view bringSubviewToFront:weakSelf.conditionview];

        weakSelf.conditionview.hidden = NO;
        weakSelf.conditionview.conditions = conditon;
    };
    
    
    self.chooseRoleview.chooseRolesTypeBlock = ^(GHrolesType rolesType, NSString * _Nonnull roseText) {
        NSLog(@"------>%@ ---->%ld",roseText,weakSelf.chooseRoleview.rolesType);
        
        weakSelf.selectType = rolesType;
        
        if (rolesType == GHrolesType_Doctor) {
            weakSelf.chooseRoleview.sortText = weakSelf.doctorSortText;

        }
        else if (rolesType == GHrolesType_Hospital)
        {
            weakSelf.chooseRoleview.sortText = weakSelf.hospitalSortText;

        }
        
        
        [weakSelf.chooseRoleview resetbtnSelect];
        weakSelf.conditionview.rolesType = rolesType;

        [weakSelf.conditionview clickNoneView];
        
        
        if (weakSelf.isrequestHospital) {
                    
            [weakSelf reloadTableviewWith:rolesType];
        }
        weakSelf.isrequestHospital = YES;

//        if (rolesType == GHrolesType_information) {
            [weakSelf.dataTableView reloadData];
//        }
//        else
//        {
//            [weakSelf.dataTableView reloadData];
//
//        }
    };
    headerview.clipsToBounds = YES;
    [headerview addSubview:self.chooseRoleview];
    

    return headerview;
}

- (GHNewChooseRoleView *)chooseRoleview
{
    if (!_chooseRoleview) {
        _chooseRoleview = [[GHNewChooseRoleView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 80)];

    }
    return _chooseRoleview;
}

- (void)reloadTableviewWith:(GHrolesType)type
{
    if (type == GHrolesType_Doctor) {
        if (self.doctorArray.count > 0) {
            
            [self.dataTableView reloadData];

        }
        else
        {
            self.doctorCurrentPage = 1;

            [self refreshData];
        }
    }
    else if (type == GHrolesType_Hospital)
    {
        
        if (self.hospitalArray.count > 0) {
            [self.dataTableView reloadData];
        }
        else
        {
            self.hospitalCurrentPage = 1;
            [self requestHospitalData];

        }
    }
    else
    {
        if (self.zixunArry.count > 0) {
            [self.dataTableView reloadData];

        }
        else
        {
            [self refreshData];
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (self.chooseRoleview.rolesType == GHrolesType_Doctor) {
        GHNewDoctorDetailViewController *vc = [[GHNewDoctorDetailViewController alloc] init];
        GHSearchDoctorModel *model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
        vc.doctorId = model.doctorId;
        [self.navigationController pushViewController:vc animated:true];
    }
    else if (self.chooseRoleview.rolesType == GHrolesType_Hospital)
    {
        GHSearchHospitalModel *model = [self.hospitalArray objectOrNilAtIndex:indexPath.row];
        
        GHNewHospitalViewController *vc = [[GHNewHospitalViewController alloc] init];
        vc.hospitalID = model.modelId;
        vc.distance = model.distance;
        vc.departmentId = self.departmentId;
        [self.navigationController pushViewController:vc animated:true];
    }
    else
    {
        GHNewInformationDetailViewController *vc = [[GHNewInformationDetailViewController alloc] init];
        GHNewZiXunModel *model = [self.zixunArry objectOrNilAtIndex:indexPath.row];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:true];
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.selectType == GHrolesType_information ? 45 : 80;
}

- (void)changeTableviewHeader
{
    if (self.diseaseList.count) {
        
        self.tableHeader.frame = CGRectMake(0, 0, SCREENWIDTH, 137 + 53);
        self.segMentTitleView.frame = CGRectMake(0, 0, SCREENWIDTH, 53);
        self.contentview.frame = CGRectMake(0, 53, SCREENWIDTH, CGRectGetHeight(self.contentview.frame));
        self.segMentTitleView.titleArry = [NSMutableArray arrayWithArray:self.diseaseList];
        [self.dataTableView reloadData];
    }
    else
    {
        self.tableHeader.frame = CGRectMake(0, 0, SCREENWIDTH, 137);
        self.segMentTitleView.frame = CGRectMake(0, 0, SCREENWIDTH, 53);
        self.contentview.frame = CGRectMake(0, 0, SCREENWIDTH, CGRectGetHeight(self.contentview.frame));
        [self.dataTableView reloadData];

    }
    self.contentview.model = self.model;

}
- (UIView *)tableHeader
{
    if (!_tableHeader) {
        _tableHeader = [[UIView alloc]initWithFrame:CGRectZero];
    
        self.segMentTitleView = [[GHNewCasesView alloc]initWithFrame:CGRectZero];
        self.segMentTitleView.backgroundColor = [UIColor whiteColor];
//        self.segMentTitleView.titleArry = [NSMutableArray arrayWithObjects:@"鼻炎",@"慢性鼻炎",@"过敏性鼻炎",@"鼻窦性鼻炎",@"萎缩性鼻炎",@"萎缩性鼻炎",@"萎缩性鼻炎", nil];
        kWeakSelf;
        self.segMentTitleView.clickTypeBlock = ^(NSString * _Nonnull clickTitle) {
            NSLog(@"------>点击了 %@",clickTitle);
            weakSelf.sicknessId = clickTitle;
            weakSelf.searchTextField.text = clickTitle;
            [weakSelf firstRequest];
        };
        [_tableHeader addSubview:self.segMentTitleView];
        
        self.contentview = [[GHNewContentHeaderView alloc]initWithFrame:CGRectMake(0, 53, SCREENWIDTH, 84)];
        
        self.contentview.clickTypeBlock = ^(float height) {
            weakSelf.contentview.frame = CGRectMake(0, weakSelf.diseaseList.count ? 53 : 0, SCREENWIDTH, height);
            weakSelf.tableHeader.frame = CGRectMake(0, 0, SCREENWIDTH, weakSelf.diseaseList.count > 0 ? 53 + height : height);
            [weakSelf.dataTableView reloadData];
            
        };
        
        
        [_tableHeader addSubview:self.contentview];
        
    }
    return _tableHeader;
}
- (UITableView *)dataTableView
{
    if (!_dataTableView) {
        _dataTableView = [[UITableView alloc] init];
        
        _dataTableView.backgroundColor = [UIColor whiteColor];
//        _dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _dataTableView.delegate = self;
        _dataTableView.dataSource = self;
        _dataTableView.separatorColor = [UIColor colorWithHexString:@"F2F2F2"];
        [_dataTableView setTableHeaderView:self.tableHeader];
        _dataTableView.estimatedRowHeight = 0;
        _dataTableView.estimatedSectionHeaderHeight = 0;
        _dataTableView.estimatedSectionFooterHeight = 0;
        
        [self.view addSubview:_dataTableView];
        
        [_dataTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_equalTo(kBottomSafeSpace);
        }];
    }
    return _dataTableView;
}
- (UIView *)tableFooterView {
    
    if (!_tableFooterView) {
        _tableFooterView = [[UIView alloc] init];
        
        _tableFooterView.backgroundColor = [UIColor whiteColor];
        
        _tableFooterView.frame = CGRectMake(0, 0, SCREENWIDTH, 265);
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_data"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_tableFooterView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(23);
            make.centerX.mas_equalTo(imageView.superview);
            make.size.mas_equalTo(CGSizeMake(300, 150));
        }];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.font = H14;
        tipLabel.textColor = kDefaultGrayTextColor;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"暂无可推荐医生";
        [_tableFooterView addSubview:tipLabel];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(imageView.mas_bottom).offset(19);
            make.height.mas_equalTo(22);
        }];
        
    }
    return _tableFooterView;
    
}
- (GHConditionsView *)conditionview
{
    if (!_conditionview) {
        _conditionview = [[GHConditionsView alloc]initWithFrame:CGRectMake(0, 80, SCREENWIDTH, SCREENHEIGHT - 80 - Height_NavBar)];
        _conditionview.hidden = YES;
        //选择地址block
        kWeakSelf;
        //选择地方回调
        _conditionview.chooseLocationBlock = ^(NSString * _Nonnull country, NSString * _Nonnull city, NSString * _Nonnull area,NSInteger areaLevel) {
            
            
            weakSelf.areLeave = areaLevel;
            if (areaLevel == 1) {
                  weakSelf.chooseRoleview.locationtext = @"全国";
                  weakSelf.country = country;
                  weakSelf.city = nil;
                  weakSelf.area = nil;
                [weakSelf refreshData];

            
            }
            else if (areaLevel == 2)
            {
                weakSelf.chooseRoleview.locationtext = country;
                weakSelf.country = country;
                [weakSelf refreshData];

            }
            else if (areaLevel == 3)
            {
                weakSelf.chooseRoleview.locationtext = city;
                weakSelf.country = country;
                weakSelf.city = city;
                [weakSelf refreshData];


            }
            else if (areaLevel == 4)
            {
                weakSelf.chooseRoleview.locationtext = area;
                weakSelf.country = country;
                weakSelf.city = city;
                weakSelf.area = area;
                [weakSelf refreshData];

            }
            
            

        };
       
        /***************医生***************/
       
        //选择排序回调
        _conditionview.chooseSortBlock = ^(NSString * _Nonnull sortText) {
            weakSelf.chooseRoleview.sortText = sortText;
            
            if (sortText.length != 0) {
                           
                if (weakSelf.conditionview.rolesType == GHrolesType_Doctor)
                {
                    
                    weakSelf.doctorSortText = sortText;
                    
                    if ([sortText isEqualToString:@"综合排序"]) {
                        weakSelf.sortType = @"1";
                    }
                    
                    else if ([sortText isEqualToString:@"评分最高"])
                    {
                        weakSelf.sortType = @"2";
                    }
                    else
                    {
                        weakSelf.sortType = @"3";

                    }
                    [weakSelf refreshData];

                    
                }
                else if  (weakSelf.conditionview.rolesType == GHrolesType_Hospital)
                {
                    
                    weakSelf.hospitalSortText = sortText;
                    
                    if ([sortText isEqualToString:@"评分最高"]) {
                        weakSelf.hospitalsortType = @"1";
                    }
                    
                    else if ([sortText isEqualToString:@"服务优先"])
                    {
                        weakSelf.hospitalsortType = @"3";
                    }
                    else if ([sortText isEqualToString:@"环境优先"])
                    {
                        weakSelf.hospitalsortType = @"4";

                    }
                    else
                    {
                        weakSelf.hospitalsortType = @"2";
                        
                    }
                    [weakSelf refreshData];

                }
                else
                {
                    
                }
            }

            
        };
       //筛选回调
        _conditionview.chooseFillerBlock = ^(NSString * _Nonnull GradeNum, NSString * _Nonnull doctorType, NSString * _Nonnull hospitalLevel) {
            
            NSLog(@"------>点击了筛选");
            
            if (GradeNum.length == 0 && doctorType.length == 0 && hospitalLevel.length == 0) {
                
                if (weakSelf.conditionview.rolesType == GHrolesType_Doctor)
                {
                    weakSelf.doctorGradeNum = nil;
                    weakSelf.doctorMedicineType = nil;
                    weakSelf.hospitalLevel = nil;

                }
                else if (weakSelf.conditionview.rolesType == GHrolesType_Hospital)
                {
                    weakSelf.hospitalAdreessLevel = nil;
                    weakSelf.hospitalType = nil;
                }
                

                [weakSelf refreshData];

            }
            else
            {
                 if (weakSelf.conditionview.rolesType == GHrolesType_Doctor) {
                     if (GradeNum.length > 0) {
                      
                         weakSelf.doctorGradeNum = [weakSelf resetToReplaceWith:GradeNum];
                         
                     }
                     else
                     {
                         weakSelf.doctorGradeNum = nil;
                     }
                     
                     if (hospitalLevel.length > 0) {
                         weakSelf.hospitalLevel = hospitalLevel;
                     }
                     else
                     {
                         weakSelf.hospitalLevel = nil;

                     }
                     
                     if (doctorType.length >0) {
                         weakSelf.doctorMedicineType = doctorType;

                     }
                     else
                     {
                         weakSelf.doctorMedicineType = nil;

                     }
                     [weakSelf refreshData];

                 }
                 else if  (weakSelf.conditionview.rolesType == GHrolesType_Hospital)
                 {
                     if (hospitalLevel.length > 0) {
                         weakSelf.hospitalAdreessLevel = [hospitalLevel stringByReplacingOccurrencesOfString:@"一级医院" withString:@"1"];
                         weakSelf.hospitalAdreessLevel = [weakSelf.hospitalAdreessLevel stringByReplacingOccurrencesOfString:@"二级医院" withString:@"2"];
                         weakSelf.hospitalAdreessLevel = [weakSelf.hospitalAdreessLevel stringByReplacingOccurrencesOfString:@"三级医院" withString:@"3"];
                     }
                     else
                     {
                         weakSelf.hospitalAdreessLevel = nil;
                     }
                     
                     if (doctorType.length > 0) {
                         weakSelf.hospitalType = doctorType;

                     }
                     else
                     {
                         weakSelf.hospitalType = nil;

                     }
                     [weakSelf refreshData];

                 }
                 else
                 {
                     
                 }
                 
                
                 
                 [weakSelf.chooseRoleview resetbtnSelect];
                 [weakSelf refreshData];
                 
            }
            

        };
        
        
        
        
        
        
        [self.view addSubview:_conditionview];
    }
    return _conditionview;
}

- (NSString *)resetToReplaceWith:(NSString *)text
{
    NSMutableArray *changearry = [NSMutableArray arrayWithCapacity:0];
    NSArray *arry = [text componentsSeparatedByString:@","];
    if ([arry containsObject:@"主任医师"]) {
        [changearry addObject:@"4"];
    }
    if ([arry containsObject:@"副主任医师"]) {
        [changearry addObject:@"3"];
    }
    if ([arry containsObject:@"主治医师"]) {
        [changearry addObject:@"2"];
    }
    if ([arry containsObject:@"医师"]) {
        [changearry addObject:@"1"];
    }
    
    return  [changearry componentsJoinedByString:@","];
}

- (NSMutableArray *)doctorArray
{
    if (!_doctorArray) {
        _doctorArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _doctorArray;
}
- (NSMutableArray *)hospitalArray
{
    if (!_hospitalArray) {
        _hospitalArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _hospitalArray;
}
- (NSMutableArray *)zixunArry
{
    if (!_zixunArry) {
        _zixunArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _zixunArry;
}
- (NSMutableArray *)diseaseList
{
    if (!_diseaseList) {
        _diseaseList = [NSMutableArray arrayWithCapacity:0];
    }
    return _diseaseList;
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

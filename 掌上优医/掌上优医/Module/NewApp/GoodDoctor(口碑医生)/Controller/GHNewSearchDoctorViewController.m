//
//  GHNewSearchDoctorViewController.m
//  掌上优医
//
//  Created by apple on 2019/10/28.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNewSearchDoctorViewController.h"
#import "GHNweMainTableView.h"
#import "GHBottomTableViewCell.h"
#import "GHSearchHearView.h"
#import "GHCommonDiseasesViewController.h"
#import "GHAllDepartmentsViewController.h"

#import "GHSearchDoctorHeaderView.h"
#import "GHHomeBannerModel.h"
#import "GHDoctorRecommendedModel.h"

@interface GHNewSearchDoctorViewController ()<UITableViewDelegate,UITableViewDataSource,GHPageContentViewDelegate>
@property (nonatomic, strong) GHNweMainTableView *homeTableview;
@property (nonatomic, assign) BOOL canScroll;

@property (nonatomic, strong) GHBottomTableViewCell *contentCell;
@property (nonatomic, strong) GHSearchHearView *headerview;
@property (nonatomic, strong) GHSearchDoctorHeaderView *tableheaderview;
@property (nonatomic, strong) NSMutableArray *recommendedArray;
@end

@implementation GHNewSearchDoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"找医生";
    
    self.canScroll = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"searchDoctorleaveTop" object:nil];

    [self.view addSubview:self.homeTableview];
    
    [self getOtherDataAction];

}
#pragma mark notify
- (void)changeScrollStatus//改变主视图的状态
{
    self.canScroll = YES;
    self.contentCell.cellCanScroll = NO;
}
#pragma  mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _contentCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!_contentCell) {
        _contentCell = [[GHBottomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        NSArray *titles = @[@"常见疾病",@"全部科室"];
        NSMutableArray *contentVCs = [NSMutableArray array];
        for (NSString *title in titles) {
            
            if ([title isEqualToString:@"常见疾病"]) {
                GHCommonDiseasesViewController *Diseases = [[GHCommonDiseasesViewController alloc]init];
                Diseases.title = title;
//                Diseases.str = title;
                [contentVCs addObject:Diseases];
            }
            else if ([title isEqualToString:@"全部科室"])
            {
                GHAllDepartmentsViewController *Departments = [[GHAllDepartmentsViewController alloc]init];
                Departments.title = title;
//                Departments.str = title;
                [contentVCs addObject:Departments];
            }
            
        }
        _contentCell.viewControllers = contentVCs;
        _contentCell.pageContentView = [[GHPageContentView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - Height_TabBar - Height_NavBar) childVCs:contentVCs parentVC:self delegate:self];
        [_contentCell.contentView addSubview:_contentCell.pageContentView];
    }
    return _contentCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREENHEIGHT - Height_TabBar - Height_NavBar;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    return 50;
    return 44;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.headerview = [[GHSearchHearView alloc]initWithTitleArray:@[@"常见疾病",@"全部科室"]];
    self.headerview.frame = CGRectMake(0, 0, SCREENWIDTH, 44);
    __weak typeof(self) weakself = self;

    self.headerview.clickTypeBlock = ^(NSInteger clickTag) {
        weakself.contentCell.pageContentView.contentViewCurrentIndex = clickTag;

    };
    
    return self.headerview;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma  mark - GHPageContentViewDelegate
- (void)FSContenViewDidEndDecelerating:(GHPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.headerview.selectBtnTag = endIndex;
    self.homeTableview.scrollEnabled =YES;//此处其实是监测scrollview滚动，pageView滚动结束主tableview可以滑动，或者通过手势监听或者kvo，这里只是提供一种实现方式
}

- (void)FSContentViewDidScroll:(GHPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress
{
    self.homeTableview.scrollEnabled = NO;//pageView开始滚动主tableview禁止滑动
}

/// 获取轮番图
- (void)getOtherDataAction {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"displayPosition"] = @(2);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiInfoSlideshows withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        
        if (isSuccess) {
            
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dic in response[@"data"][@"postList"]) {
                
                GHHomeBannerModel *model = [[GHHomeBannerModel alloc] initWithDictionary:dic error:nil];
                
                if (model == nil) {
                    continue;
                }
                
                [dataArray addObject:model];
                
            }
            
            [self.tableheaderview setupScrollViewWithModelArray:dataArray];
            
        }
        
        [self getDoctorRecommended];//获取医生推荐

        
    }];
    
}
//获取医生推荐
- (void)getDoctorRecommended
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"lat"] = @([GHUserModelTool shareInstance].locationLatitude > 0 ? [GHUserModelTool shareInstance].locationLatitude : 30.3751);
    params[@"lng"] = @([GHUserModelTool shareInstance].locationLongitude > 0 ? [GHUserModelTool shareInstance].locationLongitude : 120.1236);
    params[@"province"] = [GHUserModelTool shareInstance].locationCity;
    

    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiGetTopDoctor withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            NSArray *hospital = response[@"data"][@"doctorList"];
            [self.recommendedArray removeAllObjects];

            if (hospital.count > 0) {
                for (NSInteger index = 0; index < hospital.count; index ++) {
                    NSDictionary *dic = hospital[index];
                    GHDoctorRecommendedModel *model = [[GHDoctorRecommendedModel alloc] initWithDictionary:dic error:nil];
                    [self.recommendedArray addObject:model];
                }
                
                if (hospital.count > 2) {
                    self.tableheaderview.frame = CGRectMake(0, 0, SCREENWIDTH, HScaleHeight(464));

                }
                else
                {
                    self.tableheaderview.frame = CGRectMake(0, 0, SCREENWIDTH, HScaleHeight(348));

                }
                

                
            }
            else
            {
                self.tableheaderview.frame = CGRectMake(0, 0, SCREENWIDTH, HScaleHeight(201));
            }
            [self.tableheaderview setupRecommendDoctorModelArry:self.recommendedArray];
            [self.homeTableview reloadData];

        }
        else
        {
            self.tableheaderview.frame = CGRectMake(0, 0, SCREENWIDTH, HScaleHeight(201));
            [self.homeTableview reloadData];

        }
        
    }];
}

#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat bottomCellOffset = [self.homeTableview rectForSection:0].origin.y;

    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            self.contentCell.cellCanScroll = YES;
        }
    }
    else{
        if (!self.canScroll) {//子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
    self.homeTableview.showsVerticalScrollIndicator = _canScroll?YES:NO;
}

- (GHNweMainTableView *)homeTableview
{
    if (!_homeTableview) {
        _homeTableview = [[GHNweMainTableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - kBottomSafeSpace - Height_NavBar) style:UITableViewStylePlain];
//        _homeTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getHomeDataAction)];
        _homeTableview.delegate = self;
        _homeTableview.dataSource = self;
        _homeTableview.showsVerticalScrollIndicator = NO;
        _homeTableview.showsHorizontalScrollIndicator = NO;
        _homeTableview.backgroundColor = [UIColor whiteColor];
        _homeTableview.tableHeaderView = self.tableheaderview;
    }
    return _homeTableview;
}
- (GHSearchDoctorHeaderView *)tableheaderview
{
    if (!_tableheaderview) {
        _tableheaderview = [[GHSearchDoctorHeaderView alloc]init];
        _tableheaderview.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        _tableheaderview.clipsToBounds = YES;
        _tableheaderview.frame = CGRectMake(0, 0, SCREENWIDTH, HScaleHeight(464));
    }
    return _tableheaderview;
}
- (NSMutableArray *)recommendedArray
{
    if (!_recommendedArray) {
        _recommendedArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _recommendedArray;
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

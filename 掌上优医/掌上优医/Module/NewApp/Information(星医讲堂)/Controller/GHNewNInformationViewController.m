//
//  GHNewNInformationViewController.m
//  掌上优医
//
//  Created by apple on 2019/8/1.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewNInformationViewController.h"

#import "GHArticleInformationTableViewCell.h"
#import "GHInformationDetailViewController.h"
#import "GHNSearchInformationViewController.h"

#import "GHNSearchHotViewController.h"
#import "GHNewZiXunTableViewCell.h"
#import "GHNewInformationDetailViewController.h"
@interface GHNewNInformationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSUInteger totalPage;

@property (nonatomic, assign) NSUInteger currentPage;

@property (nonatomic, assign) NSUInteger pageSize;

@property (nonatomic, assign) NSInteger indexPath;
@end

@implementation GHNewNInformationViewController

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
//    self.navigationView.hidden = false;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self setupConfig];
    [self requsetData];
}
- (void)setupConfig {
    self.currentPage = 1;
    
}

- (void)getMoreData{
    self.currentPage ++;
    [self requsetData];
}
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UITableView alloc] init];
    
    self.scrollView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.scrollView.delegate = self;
    self.scrollView.dataSource = self;
    
    self.scrollView.estimatedRowHeight = 0;
    self.scrollView.estimatedSectionHeaderHeight = 0;
    self.scrollView.estimatedSectionFooterHeight = 0;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.scrollView];
    
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    
//    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.scrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 15);
    
    self.scrollView.tableHeaderView = headerView;
    
}


#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 130;
    
}


/**
 @param tableView tableView description
 @param indexPath indexPath description
 @return return value description
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHNewZiXunTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GHNewZiXunTableViewCell"];
    if (!cell) {
        cell = [[GHNewZiXunTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNewZiXunTableViewCell"];
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    GHInformationDetailViewController *vc = [[GHInformationDetailViewController alloc] init];
//    GHArticleInformationModel *model = [self.dataArray objectOrNilAtIndex:indexPath.row];
//    vc.informationId = model.modelId;
//    vc.model = model;
//    [self.navigationController pushViewController:vc animated:true];
//
//    model.visitCount = [NSString stringWithFormat:@"%ld", [model.visitCount integerValue] + 1];
//    model.isVisit = [NSNumber numberWithBool:true];
//    [tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
    
    self.indexPath = indexPath.row;
    
    GHNewInformationDetailViewController *vc = [[GHNewInformationDetailViewController alloc] init];
    GHNewZiXunModel *model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    model.visitCount = [NSString stringWithFormat:@"%d",[model.visitCount intValue] + 1];
    [tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
    vc.model = model;
    vc.clickCollectionBlock = ^(BOOL collection) {
        if (collection) {
            
            model.favoriteCount = [NSString stringWithFormat:@"%d",[model.favoriteCount intValue] + 1];

        }
        else
        {
            model.favoriteCount = [NSString stringWithFormat:@"%d",[model.favoriteCount intValue] - 1];

        }
        [tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];

    };
    [self.navigationController pushViewController:vc animated:true];
    
}


- (void)requsetData {
    
//    if (self.currentPage > self.totalPage) {
//        [self.scrollView.mj_footer endRefreshingWithNoMoreData];
//        return;
//    }
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"page"] = @(self.currentPage);
    parmas[@"pageSize"] = @(10);
   
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiAllSearchArticle withParameter:parmas withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [SVProgressHUD dismiss];
        
        [self.scrollView.mj_header endRefreshing];
        [self.scrollView.mj_footer endRefreshing];
        
        if (isSuccess) {
            NSLog(@"请求成功");
            
            if (self.currentPage == 1) {
                [self.dataArray removeAllObjects];
            }
            
            if (((NSArray *)response[@"data"]).count > 0) {
                for (NSDictionary *zixundic in (NSArray *)response[@"data"]) {
                    GHNewZiXunModel *model = [[GHNewZiXunModel alloc]initWithDictionary:zixundic error:nil];
                    [self.dataArray addObject:model];
                }
            }
            else
            {
                self.currentPage --;
                [self.scrollView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.scrollView reloadData];
        }
        
        
        [self.scrollView reloadData];
        
        if (self.dataArray.count == 0) {
            [self loadingEmptyView];
        }else{
            [self hideEmptyView];
        }
        
    }];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isShowHomepush) {
        return;
    }
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

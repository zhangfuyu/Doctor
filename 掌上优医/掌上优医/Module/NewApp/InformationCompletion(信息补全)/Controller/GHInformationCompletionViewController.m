//
//  GHInformationCompletionViewController.m
//  掌上优医
//
//  Created by GH on 2019/6/4.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHInformationCompletionViewController.h"

#import "GHNChooseTitleView.h"

#import "GHHospitalInformationCompletionView.h"

#import "GHSearchHospitalModel.h"

#import "GHInformationCompletionHospitalListTableViewCell.h"

#import "GHInformationCompletionAddViewController.h"

@interface GHInformationCompletionViewController () <GHNChooseTitleViewDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) GHNChooseTitleView *titleView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *hospitalListTableView;

@property (nonatomic, strong) GHHospitalInformationCompletionView *hospitalInformationCompletionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSUInteger hospitalCurrentPage;
@property (nonatomic, assign) NSUInteger hospitalTotalPage;
@property (nonatomic, assign) NSUInteger pageSize;

@end

@implementation GHInformationCompletionViewController

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"信息补全";
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    [self setupUI];
    
    [self setupConfig];
    
    [self requestData];
}

- (void)setupConfig{
    
    self.pageSize = 10;
    self.hospitalTotalPage = 1;
    self.hospitalCurrentPage = 0;
    
}

- (void)refreshData{
    
    self.hospitalCurrentPage = 0;
    self.hospitalTotalPage = 1;
    
    [self requestData];
    
}

- (void)getMoreData{
    
    self.hospitalCurrentPage += self.pageSize;
    
    [self requestData];
    
}

- (void)requestData {
    
    if (self.hospitalCurrentPage > self.hospitalTotalPage) {
        [self.hospitalListTableView.mj_footer endRefreshingWithNoMoreData];
        [self.hospitalInformationCompletionView setupDataArray:[self.dataArray copy]];
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"pageSize"] = @(self.pageSize);
    params[@"from"] = @(self.hospitalCurrentPage);
    
    params[@"distance"] = @"5000";
    
    params[@"areaId"] = @(1);
    params[@"areaLevel"] = @(1);
    
    params[@"sortType"] = @(2);
    
    params[@"lat"] = @([GHUserModelTool shareInstance].locationLatitude > 0 ? [GHUserModelTool shareInstance].locationLatitude : 30.3751);
    params[@"lng"] = @([GHUserModelTool shareInstance].locationLongitude > 0 ? [GHUserModelTool shareInstance].locationLongitude : 120.1236);
    
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSearchHospital withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {

        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            if (self.hospitalCurrentPage == 0) {
                
                [self.dataArray removeAllObjects];
                
            }
            
            for (NSDictionary *dicInfo in response) {
                
                GHSearchHospitalModel *model = [[GHSearchHospitalModel alloc] initWithDictionary:dicInfo[@"hospital"] error:nil];
                model.distance = dicInfo[@"distance"];
                
                if (model == nil) {
                    continue;
                }
                
                [self.dataArray addObject:model];
                
            }
            
            if (((NSArray *)response).count >= self.pageSize) {
                self.hospitalTotalPage = self.dataArray.count + 1;
            } else {
                self.hospitalTotalPage = self.hospitalCurrentPage;
            }
            
            [self.hospitalListTableView reloadData];
            
            [self getMoreData];
            
        }
        
    }];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultGaryViewColor;
    [self.view addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(67);
    }];
    
}



- (void)setupUI {
    
    NSArray *titleArray = @[@"附近医院", @"医院列表"];
    
    GHNChooseTitleView *titleView = [[GHNChooseTitleView alloc] initWithTitleArray:titleArray];
    titleView.delegate = self;
    [self.view addSubview:titleView];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(58);
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(SCREENWIDTH * titleArray.count, SCREENHEIGHT - Height_NavBar - 68 + kBottomSafeSpace);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.frame = CGRectMake(0, 68, SCREENWIDTH, SCREENHEIGHT - Height_NavBar - 68 + kBottomSafeSpace);
    scrollView.delegate = self;
    scrollView.scrollEnabled = false;
    [self.view addSubview:scrollView];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        
        if (index == 1) {
            
            UITableView *tableView = [[UITableView alloc] init];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.tag = index;
            tableView.backgroundColor = kDefaultGaryViewColor;
            tableView.frame = CGRectMake(SCREENWIDTH * index, 0, SCREENWIDTH, scrollView.contentSize.height);
            
            [scrollView addSubview:tableView];
            
            self.hospitalListTableView = tableView;
            
        } else {
            
            GHHospitalInformationCompletionView *infoView = [[GHHospitalInformationCompletionView alloc] init];
            infoView.frame = CGRectMake(SCREENWIDTH * index, 0, SCREENWIDTH, scrollView.contentSize.height);
            [scrollView addSubview:infoView];
            
            self.hospitalInformationCompletionView = infoView;
            
        }
        
    }
    
    self.scrollView = scrollView;
    
}

/**
 每当点击顶部按钮便刷新列表
 
 @param tag <#tag description#>
 */
- (void)clickButtonWithTag:(NSInteger)tag {
    
    [self.scrollView setContentOffset:CGPointMake(SCREENWIDTH * tag, 0) animated:NO];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 97;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHInformationCompletionHospitalListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHInformationCompletionHospitalListTableViewCell"];
    
    if (!cell) {
        cell = [[GHInformationCompletionHospitalListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHInformationCompletionHospitalListTableViewCell"];
    }
    
    cell.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHSearchHospitalModel *model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"id"] = model.modelId;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiHospital withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            GHSearchHospitalModel *hospitalModel = [[GHSearchHospitalModel alloc] initWithDictionary:response error:nil];
            hospitalModel.distance = model.distance;

            GHInformationCompletionAddViewController *vc = [[GHInformationCompletionAddViewController alloc] init];
            vc.model = hospitalModel;
            [self.navigationController pushViewController:vc animated:true];
            
        }
        
    }];
    
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

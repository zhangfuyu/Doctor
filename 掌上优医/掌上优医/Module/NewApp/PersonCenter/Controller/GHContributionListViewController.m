//
//  GHContributionListViewController.m
//  掌上优医
//
//  Created by GH on 2019/6/5.
//  Copyright © 2019 GH. doctor rights reserved.
//

#import "GHContributionListViewController.h"

#import "GHNChooseTitleView.h"

#import "GHContributeListTableViewCell.h"

#import "GHContributeDetailViewController.h"

@interface GHContributionListViewController () <GHNChooseTitleViewDelegate, UITableViewDelegate, UITableViewDataSource>

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

@implementation GHContributionListViewController

- (UIView *)doctorEmptyView{
    
    if (!_doctorEmptyView) {
        _doctorEmptyView = [[UIView alloc] init];
        _doctorEmptyView.userInteractionEnabled = NO;
        _doctorEmptyView.frame = CGRectMake(SCREENWIDTH * 0, 90, SCREENWIDTH, self.scrollView.contentSize.height);
        [self.scrollView addSubview:_doctorEmptyView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_data"]];
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
        tipLabel.text = @"暂无数据";
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
        _hospitalEmptyView.frame = CGRectMake(SCREENWIDTH * 1, 90, SCREENWIDTH, self.scrollView.contentSize.height);
        [self.scrollView addSubview:_hospitalEmptyView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_data"]];
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
        tipLabel.text = @"暂无数据";
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
    
    self.navigationItem.title = @"贡献记录";
    
    [self setupConfig];
    
    [self setupUI];
    
    [self requestData];
}


- (void)setupConfig{
    
    self.pageSize = 10;
    self.doctorTotalPage = 1;
    self.hospitalTotalPage = 1;
    self.doctorCurrentPage = 0;
    self.hospitalCurrentPage = 0;
    
}

- (void)setupUI {
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    NSArray *titleArray = @[@"医生", @"医院"];
    
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
        
        if (index == 0) {
            self.doctorTableView = tableView;
        } else if (index == 1) {
            self.hospitalTableView = tableView;
        }
        
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
        
    }
    
    self.scrollView = scrollView;
    
}

- (void)refreshData{
    
    if (self.scrollView.contentOffset.x == SCREENWIDTH * 0) {
        self.doctorCurrentPage = 0;
        self.doctorTotalPage = 1;
        if (self.doctorArray.count) {
            [self.doctorTableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:false];
        }
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 1) {
        self.hospitalCurrentPage = 0;
        self.hospitalTotalPage = 1;
        if (self.hospitalArray.count) {
            [self.hospitalTableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:false];
        }
    }
    [self requestData];
    
}

- (void)getMoreData{
    
    if (self.scrollView.contentOffset.x == SCREENWIDTH * 0) {
        self.doctorCurrentPage += self.pageSize;
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 1) {
        self.hospitalCurrentPage += self.pageSize;
    }
    
    [self requestData];
    
}

- (void)requestData {
    
    if (self.scrollView.contentOffset.x == SCREENWIDTH * 0) {
        
        if (self.doctorCurrentPage > self.doctorTotalPage) {
            [self.doctorTableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        
        //        [SVProgressHUD showWithStatus:kDefaultTipsText];
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"pageSize"] = @(self.pageSize);
        params[@"from"] = @(self.doctorCurrentPage);
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDataCollectionMyDoctors withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            [self.doctorTableView.mj_header endRefreshing];
            [self.doctorTableView.mj_footer endRefreshing];
            
            if (isSuccess) {
                
                [SVProgressHUD dismiss];
                
                if (self.doctorCurrentPage == 0) {
                    
                    [self.doctorArray removeAllObjects];
                    
                }
                
                for (NSDictionary *dicInfo in response) {
                    
                    GHDataCollectionDoctorModel *model = [[GHDataCollectionDoctorModel alloc] initWithDictionary:dicInfo error:nil];
                    
                    if (model == nil) {
                        continue;
                    }
                    
                    [self.doctorArray addObject:model];
                    
                }
                
                if (((NSArray *)response).count >= self.pageSize) {
                    self.doctorTotalPage = self.doctorArray.count + 1;
                } else {
                    self.doctorTotalPage = self.doctorCurrentPage;
                }
                
                [self.doctorTableView reloadData];
                
                if (self.doctorArray.count == 0) {
                    self.doctorEmptyView.hidden = false;
                }else{
                    self.doctorEmptyView.hidden = true;
                }
                
            }
            
        }];

        
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 1) {
        
        if (self.hospitalCurrentPage > self.hospitalTotalPage) {
            [self.hospitalTableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        
        //        [SVProgressHUD showWithStatus:kDefaultTipsText];
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"pageSize"] = @(self.pageSize);
        params[@"from"] = @(self.hospitalCurrentPage);
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDataCollectionMyHospitals withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            [self.hospitalTableView.mj_header endRefreshing];
            [self.hospitalTableView.mj_footer endRefreshing];
            
            if (isSuccess) {
                
                [SVProgressHUD dismiss];
                
                if (self.hospitalCurrentPage == 0) {
                    
                    [self.hospitalArray removeAllObjects];
                    
                }
                
                for (NSDictionary *dicInfo in response) {
                    
                    GHDataCollectionHospitalModel *model = [[GHDataCollectionHospitalModel alloc] initWithDictionary:dicInfo error:nil];
                    
                    if (model == nil) {
                        continue;
                    }
                    
                    [self.hospitalArray addObject:model];
                    
                }
                
                if (((NSArray *)response).count >= self.pageSize) {
                    self.hospitalTotalPage = self.hospitalArray.count + 1;
                } else {
                    self.hospitalTotalPage = self.hospitalCurrentPage;
                }
                
                [self.hospitalTableView reloadData];
                
                if (self.hospitalArray.count == 0) {
                    self.hospitalEmptyView.hidden = false;
                }else{
                    self.hospitalEmptyView.hidden = true;
                }
                
            }
            
        }];
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.doctorTableView) {
        return self.doctorArray.count;
    } else if (tableView == self.hospitalTableView) {
        return self.hospitalArray.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 162;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHContributeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHContributeListTableViewCell"];
    
    if (!cell) {
        cell = [[GHContributeListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHContributeListTableViewCell"];
    }
    
    if (tableView == self.doctorTableView) {
        cell.doctorModel = [self.doctorArray objectOrNilAtIndex:indexPath.row];
    } else if (tableView == self.hospitalTableView) {
        cell.hospitalModel = [self.hospitalArray objectOrNilAtIndex:indexPath.row];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHContributeDetailViewController *vc = [[GHContributeDetailViewController alloc] init];
    
    if (tableView == self.doctorTableView) {
        vc.doctorModel = [self.doctorArray objectOrNilAtIndex:indexPath.row];
        vc.type = 1;
    } else if (tableView == self.hospitalTableView) {
        vc.hospitalModel = [self.hospitalArray objectOrNilAtIndex:indexPath.row];
        vc.type = 2;
    }
    
    [self.navigationController pushViewController:vc animated:true];
    
    
    
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

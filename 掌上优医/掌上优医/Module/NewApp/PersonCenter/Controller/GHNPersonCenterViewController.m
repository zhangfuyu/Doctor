//
//  GHNPersonCenterViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/19.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNPersonCenterViewController.h"

#import "GHMyselfTableViewCell.h"
#import "GHSetupViewController.h"
#import "GHEditUserInfoViewController.h"

#import "GHNPersonCenterHeaderView.h"
#import "GHNPersonCenterFooterView.h"




@interface GHNPersonCenterViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) GHNPersonCenterHeaderView *headerView;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHNPersonCenterFooterView *footerView;

@property (nonatomic, strong) NSArray *vcInfoArray;

@property (nonatomic, assign) BOOL isCanUseSideBack;  // 手势是否启动

@end

@implementation GHNPersonCenterViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //    self.navigationController.navigationBar.hidden = true;
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

/**
 每次该页面出现, 如果用户已登录, 都需要去刷新用户信息
 
 @param animated <#animated description#>
 */
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self cancelSideBack];
    
    if ([GHUserModelTool shareInstance].isLogin) {
        [self getUserInfoData];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [self startSideBack];
    
}

/**
 * 关闭ios右滑返回
 */
-(void)cancelSideBack{
    self.isCanUseSideBack = NO;
    
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}
/*
 开启ios右滑返回
 */
- (void)startSideBack {
    self.isCanUseSideBack=YES;
    
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

/**
 在根控制器禁止右滑返回手势,否则可能造成程序假死
 
 @param gestureRecognizer <#gestureRecognizer description#>
 @return <#return value description#>
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    return self.isCanUseSideBack;
}

- (NSArray *)vcInfoArray {
    
    if (!_vcInfoArray) {
        
        _vcInfoArray = @[
                         @[
                             @{@"clsName" : @"GHNoticeMessageViewController", @"imageName" : @"ic_gerenzhongxin_tongzhi_mormal", @"title" : @"消息通知"},
                             //                             @{@"clsName" : @"", @"imageName" : @"ic_gerenzhongxin_dangan_mormal", @"title" : @"健康档案"},
                             @{@"clsName" : @"GHMyCollectionViewController", @"imageName" : @"ic_gerenzhongxin_shoucang_mormal", @"title" : @"我的收藏"},
                             ],
                         @[
                             @{@"clsName" : @"GHAddNewDoctorViewController", @"imageName" : @"ic_gerenzhongxin_tuijian_mormal", @"title" : @"推荐医生"},
                             @{@"clsName" : @"GHAboutMeViewController", @"imageName" : @"ic_gerenzhongxin_guanyuwomen_mormal", @"title" : @"关于我们"}
                             ],
                         @[
                             @{@"clsName" : @"GHSetupViewController", @"imageName" : @"ic_gerenzhongxin_set_mormal", @"title" : @"设置"}
                             ]
                         ];
        
    }
    return _vcInfoArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNavigationStyle:GHNavigationBarStyleWhite];
    
    self.view.backgroundColor = UIColorHex(0xF5F5F5);
    
    [self setupUI];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSuccessAction) name:kNotificationLogout object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessAction) name:kNotificationLoginSuccess object:nil];
    
}

- (void)setupUI {
    
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.backgroundColor = UIColorHex(0xF5F5F5);
    
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    self.tableView = tableView;
    
    //    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getUserInfoData)];
    
    [self setupTableHeaderView];
    
//    [self setupTableFooterView];
    
}

- (void)setupTableHeaderView {
    
    GHNPersonCenterHeaderView *headerView = [[GHNPersonCenterHeaderView alloc] init];
    
    headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 272 + Height_StatusBar + 166 + HScaleHeight(86) + 15 + 52);
    
    [headerView reloadData];
    
    self.tableView.tableHeaderView = headerView;
    
    self.headerView = headerView;
    
}

/**
 
 */
- (void)setupTableFooterView {
    
    GHNPersonCenterFooterView *footerView = [[GHNPersonCenterFooterView alloc] init];
    footerView.frame = CGRectMake(0, 0, SCREENWIDTH, 220);
    
    [footerView reloadData];
    
    self.tableView.tableFooterView = footerView;
    
    self.footerView = footerView;
    
}

- (void)clickEditInfoActionOrLoginAction {
    
    if ([GHUserModelTool shareInstance].isLogin == true) {
        
        // 编辑信息
        GHEditUserInfoViewController *vc = [[GHEditUserInfoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:true];
        
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self presentViewController:vc animated:false completion:nil];
        
    }
    
}


#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.vcInfoArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
    
//    return ((NSArray *)[self.vcInfoArray objectOrNilAtIndex:section]).count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHMyselfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHMyselfTableViewCell"];
    
    if (!cell) {
        cell = [[GHMyselfTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHMyselfTableViewCell"];
    }
    
    NSDictionary *vcInfo = [((NSArray *)[self.vcInfoArray objectOrNilAtIndex:indexPath.section]) objectOrNilAtIndex:indexPath.row];
    
    cell.titleLabel.text = [vcInfo objectForKey:@"title"];
    cell.iconImageView.image = [UIImage imageNamed:[vcInfo objectForKey:@"imageName"]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSDictionary *vcInfo = [((NSArray *)[self.vcInfoArray objectOrNilAtIndex:indexPath.section]) objectOrNilAtIndex:indexPath.row];
    NSString *clsName = vcInfo[@"clsName"];
    
    if (clsName.length > 0) {
        
        if ([clsName isEqualToString:@"GHSetupViewController"] || [clsName isEqualToString:@"GHAboutMeViewController"]) {
            
            UIViewController *vc = [[NSClassFromString(clsName) alloc] init];
            
            [self.navigationController pushViewController:vc animated:true];
            
        } else {
            
            if ([GHUserModelTool shareInstance].isLogin == false) {
                
                GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
                [self presentViewController:vc animated:false completion:nil];
                
                
            } else {
                
                UIViewController *vc = [[NSClassFromString(clsName) alloc] init];
                
                [self.navigationController pushViewController:vc animated:true];
                
            }
            
        }
        
    }
    
}


/**
 微信登录成功/手机号登录成功/退出登录
 */
- (void)shouldReloadHeaderView {
    
    [self.headerView reloadData];
    
}

/**
 获取用户信息
 */
- (void)getUserInfoData {
    
    //    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *parame = [@{@"Authorization":[GHUserModelTool shareInstance].token}copy];
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiGetUserMe withParameter:parame withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.tableView.mj_header endRefreshing];
        
        if (isSuccess) {
            
            [GHUserModelTool shareInstance].userInfoModel = [[GHUserInfoModel alloc] initWithDictionary:response[@"data"] error:nil];
            
//            if ([GHUserModelTool shareInstance].userInfoModel == nil || [[GHUserModelTool shareInstance].userInfoModel.status intValue] == 2) {
            
//                [[GHUserModelTool shareInstance] removeAllProperty];
            
//                [GHUserModelTool shareInstance].isLogin = false;
                
                [[GHUserModelTool shareInstance] saveUserDefaultToSandBox];
                
                [[GHSaveDataTool shareInstance] userLogoutRemoveAllNotice];
                
                
                [self shouldReloadHeaderView];

                
//            }
#warning 后面结构不走
            return;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiFinanceUserproperty withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                    
                    if (isSuccess) {
                        
                        [GHUserModelTool shareInstance].userInfoModel.virtualCoinBalance = [NSString stringWithFormat:@"%ld", [response[@"virtualCoinBalance"] integerValue]];
                        
                        [self shouldReloadHeaderView];
                        
                    }
                    
                }];
                
            });
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                NSMutableDictionary *commentParams = [[NSMutableDictionary alloc] init];
//                commentParams[@"peroid"] = @"2";
                commentParams[@"taskId"] = @"2";
                commentParams[@"userId"] = ISNIL([GHUserModelTool shareInstance].userInfoModel.modelId);
                
                [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiBusinesstaskAllowstatus withParameter:commentParams withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                    
                    if (isSuccess) {
                        
                        [self.footerView setIsCanCommentTask:[response boolValue]];
                        
                    }
                    
                }];
                
                NSMutableDictionary *shareParams = [[NSMutableDictionary alloc] init];
//                shareParams[@"peroid"] = @"1";
                shareParams[@"taskId"] = @"1";
                shareParams[@"userId"] = ISNIL([GHUserModelTool shareInstance].userInfoModel.modelId);
                
                [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiBusinesstaskAllowstatus withParameter:shareParams withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                    
                    if (isSuccess) {
                        
                        [self.footerView setIsCanShareTask:[response boolValue]];
                        
                    }
                    
                }];
                
            });
           
            
//            [self shouldReloadHeaderView];
            
        } else {
            
            //            [[GHUserModelTool shareInstance] removeAllProperty];
            //
            //            [GHUserModelTool shareInstance].isLogin = false;
            //
            //            [[GHUserModelTool shareInstance] saveUserDefaultToSandBox];
            //
            //            [[GHSaveDataTool shareInstance] userLogoutRemoveAllNotice];
            
        }
        
    }];
    
}




/**
 退出登录成功 刷新头部
 */
- (void)logoutSuccessAction {
    
    [self shouldReloadHeaderView];
    
}

/**
 登录成功 刷新头部
 */
- (void)loginSuccessAction {
    
    [self getUserInfoData];
    
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

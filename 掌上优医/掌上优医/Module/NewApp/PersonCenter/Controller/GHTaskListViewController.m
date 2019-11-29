//
//  GHTaskListViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/25.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHTaskListViewController.h"
#import "GHNTaskView.h"
#import "GHNSearchDoctorViewController.h"
#import "GHEditUserInfoViewController.h"
#import "GHTabBarControllerController.h"

@interface GHTaskListViewController ()

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *coinLabel;

@property (nonatomic, strong) GHNTaskView *commentsTaskView;

@property (nonatomic, strong) GHNTaskView *shareTaskView;

@property (nonatomic, strong) GHNTaskView *infoTaskView;

@end

@implementation GHTaskListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"每日任务";
    // Do any additional setup after loading the view.
    [self setupUI];
    
    

}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self getCoinDataAction];

    [self getStatusDataAction];
//    if ([GHUserModelTool shareInstance].userInfoModel.nickName.length && [GHUserModelTool shareInstance].userInfoModel.profilePhoto.length && [[GHUserModelTool shareInstance].userInfoModel.sex integerValue] > 0 && [GHUserModelTool shareInstance].userInfoModel.birthday.length && [[GHUserModelTool shareInstance].userInfoModel.stature integerValue] && [[GHUserModelTool shareInstance].userInfoModel.avoirdupois integerValue]) {
//
//        self.infoTaskView.finishButton.userInteractionEnabled = false;
//        self.infoTaskView.finishButton.selected = true;
//        self.infoTaskView.finishButton.backgroundColor = UIColorHex(0xBDBDBD);
//
//    } else {
//
//        self.infoTaskView.finishButton.userInteractionEnabled = true;
//        self.infoTaskView.finishButton.selected = false;
//        self.infoTaskView.finishButton.backgroundColor = kDefaultBlueColor;
//
//    }
    
}

- (void)getStatusDataAction {
    
    NSMutableDictionary *commentParams = [[NSMutableDictionary alloc] init];
//    commentParams[@"peroid"] = @"2";
    commentParams[@"taskId"] = @"2";
    commentParams[@"userId"] = ISNIL([GHUserModelTool shareInstance].userInfoModel.modelId);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiBusinesstaskAllowstatus withParameter:commentParams withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            if (![response boolValue]) {
                
                self.commentsTaskView.finishButton.userInteractionEnabled = false;
                self.commentsTaskView.finishButton.selected = true;
                self.commentsTaskView.finishButton.backgroundColor = UIColorHex(0xBDBDBD);

                self.commentsTaskView.actionButton.userInteractionEnabled = false;
                self.commentsTaskView.actionButton.selected = true;
                
            } else {
                
                self.commentsTaskView.finishButton.userInteractionEnabled = true;
                self.commentsTaskView.finishButton.selected = false;
                self.commentsTaskView.finishButton.backgroundColor = kDefaultBlueColor;
                
                self.commentsTaskView.actionButton.userInteractionEnabled = true;
                self.commentsTaskView.actionButton.selected = false;
                
            }
            
        }
        
    }];
    
    NSMutableDictionary *shareParams = [[NSMutableDictionary alloc] init];
//    shareParams[@"peroid"] = @"1";
    shareParams[@"taskId"] = @"1";
    shareParams[@"userId"] = ISNIL([GHUserModelTool shareInstance].userInfoModel.modelId);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiBusinesstaskAllowstatus withParameter:shareParams withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            if (![response boolValue]) {
                
                self.shareTaskView.finishButton.userInteractionEnabled = false;
                self.shareTaskView.finishButton.selected = true;
                self.shareTaskView.finishButton.backgroundColor = UIColorHex(0xBDBDBD);
                
                self.shareTaskView.actionButton.userInteractionEnabled = false;
                self.shareTaskView.actionButton.selected = true;
                
            } else {
                
                self.shareTaskView.finishButton.userInteractionEnabled = true;
                self.shareTaskView.finishButton.selected = false;
                self.shareTaskView.finishButton.backgroundColor = kDefaultBlueColor;
                
                self.shareTaskView.actionButton.userInteractionEnabled = true;
                self.shareTaskView.actionButton.selected = false;
                
            }
            
        }
        
    }];
    
    NSMutableDictionary *infoParams = [[NSMutableDictionary alloc] init];
//    infoParams[@"peroid"] = @"10000000";
    infoParams[@"taskId"] = @"3";
    infoParams[@"userId"] = ISNIL([GHUserModelTool shareInstance].userInfoModel.modelId);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiBusinesstaskAllowstatus withParameter:infoParams withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            if (![response boolValue]) {
                
                self.infoTaskView.finishButton.userInteractionEnabled = false;
                self.infoTaskView.finishButton.selected = true;
                self.infoTaskView.finishButton.backgroundColor = UIColorHex(0xBDBDBD);
                
                self.infoTaskView.actionButton.userInteractionEnabled = false;
                self.infoTaskView.actionButton.selected = true;
                
            } else {
                
                self.infoTaskView.finishButton.userInteractionEnabled = true;
                self.infoTaskView.finishButton.selected = false;
                self.infoTaskView.finishButton.backgroundColor = kDefaultBlueColor;
                
                self.infoTaskView.actionButton.userInteractionEnabled = true;
                self.infoTaskView.actionButton.selected = false;
                
            }
            
        }
        
    }];
    
}

- (void)getCoinDataAction {
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiFinanceUserproperty withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            [GHUserModelTool shareInstance].userInfoModel.virtualCoinBalance = [NSString stringWithFormat:@"%ld", [response[@"virtualCoinBalance"] integerValue]];
            
            self.coinLabel.text = [NSString stringWithFormat:@"%ld", [[GHUserModelTool shareInstance].userInfoModel.virtualCoinBalance integerValue]];
            
        }
        
    }];
    
}

- (void)setupUI {
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.bounces = false;
    scrollView.showsVerticalScrollIndicator = false;
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.backgroundColor = kDefaultGaryViewColor;
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = kDefaultGaryViewColor;
    [scrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
        make.height.greaterThanOrEqualTo(@0.f);//此处保证容器View高度的动态变化 大于等于0.f的高度
    }];
    
    UIView *topContentView = [[UIView alloc] init];
    topContentView.backgroundColor = [UIColor whiteColor];
    topContentView.layer.cornerRadius = 4;
    topContentView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    topContentView.layer.shadowOffset = CGSizeMake(0,2);
    topContentView.layer.shadowOpacity = 1;
    topContentView.layer.shadowRadius = 6;
    [contentView addSubview:topContentView];
    
    [topContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(113);
    }];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    iconImageView.image = [UIImage imageNamed:@"task_coin"];
    [topContentView addSubview:iconImageView];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.top.mas_equalTo(16);
        make.left.mas_equalTo(SCREENWIDTH / 2.f - 36);
    }];
    
    UILabel *coinLabel = [[UILabel alloc] init];
    coinLabel.textAlignment = NSTextAlignmentCenter;
    coinLabel.textColor = UIColorHex(0xFEAE05);
    coinLabel.font = H24;
    [topContentView addSubview:coinLabel];
    
    [coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(27);
        make.top.mas_equalTo(iconImageView.mas_bottom).offset(12);
    }];
    self.coinLabel = coinLabel;
    
//    UILabel *descLabel = [[UILabel alloc] init];
//    descLabel.textAlignment = NSTextAlignmentCenter;
//    descLabel.textColor = kDefaultGrayTextColor;
//    descLabel.font = H13;
//    descLabel.numberOfLines = 0;
//    descLabel.text = @"星医分用途可以写在这里";
//    [topContentView addSubview:descLabel];
//
//    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(12);
//        make.right.mas_equalTo(-12);
//        make.bottom.mas_equalTo(-16);
//        make.top.mas_equalTo(coinLabel.mas_bottom).offset(12);
//    }];
    
    UIView *centerContentView = [[UIView alloc] init];
    centerContentView.backgroundColor = [UIColor whiteColor];
    centerContentView.layer.cornerRadius = 4;
    centerContentView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    centerContentView.layer.shadowOffset = CGSizeMake(0,2);
    centerContentView.layer.shadowOpacity = 1;
    centerContentView.layer.shadowRadius = 6;
    [contentView addSubview:centerContentView];
    
    [centerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(topContentView.mas_bottom).offset(10);
        make.height.mas_equalTo(194);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.font = HM18;
    titleLabel.text = @"每日任务";
    [centerContentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(25);
        make.top.mas_equalTo(16);
        make.width.mas_equalTo(100);
    }];
    
   
    GHNTaskView *commentTaskView = [[GHNTaskView alloc] initWithTaskTitle:@"每日首次写优质点评" withCoin:@"30"];
    [centerContentView addSubview:commentTaskView];
    
    [commentTaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(72);
        make.top.mas_equalTo(49);
    }];
    [commentTaskView.actionButton addTarget:self action:@selector(clickFinishCommentAction:) forControlEvents:UIControlEventTouchUpInside];
    self.commentsTaskView = commentTaskView;
    
    
    GHNTaskView *shareTaskView = [[GHNTaskView alloc] initWithTaskTitle:@"每日首次分享内容(疾病/医生/资讯)" withCoin:@"30"];
    [centerContentView addSubview:shareTaskView];
    
    [shareTaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(72);
        make.top.mas_equalTo(commentTaskView.mas_bottom);
    }];
    [shareTaskView.actionButton addTarget:self action:@selector(clickFinishShareAction:) forControlEvents:UIControlEventTouchUpInside];
    self.shareTaskView = shareTaskView;
    
    UIView *bottomContentView = [[UIView alloc] init];
    bottomContentView.backgroundColor = [UIColor whiteColor];
    bottomContentView.layer.cornerRadius = 4;
    bottomContentView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    bottomContentView.layer.shadowOffset = CGSizeMake(0,2);
    bottomContentView.layer.shadowOpacity = 1;
    bottomContentView.layer.shadowRadius = 6;
    [contentView addSubview:bottomContentView];
    
    [bottomContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(centerContentView.mas_bottom).offset(10);
        make.height.mas_equalTo(122);
    }];
    
    UILabel *titleLabel2 = [[UILabel alloc] init];
    titleLabel2.textColor = kDefaultBlackTextColor;
    titleLabel2.font = HM18;
    titleLabel2.text = @"新手任务";
    [bottomContentView addSubview:titleLabel2];
    
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(25);
        make.top.mas_equalTo(16);
        make.width.mas_equalTo(100);
    }];
    
    
    GHNTaskView *infoTaskView = [[GHNTaskView alloc] initWithTaskTitle:@"完善个人信息" withCoin:@"100"];
    [bottomContentView addSubview:infoTaskView];
    
    [infoTaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(72);
        make.top.mas_equalTo(49);
    }];
    [infoTaskView.actionButton addTarget:self action:@selector(clickFinishInfoAction:) forControlEvents:UIControlEventTouchUpInside];
    self.infoTaskView = infoTaskView;
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bottomContentView.mas_bottom).offset(20);
    }];
    
}

- (void)clickFinishCommentAction:(UIButton *)sender {
    
    if (((GHNTaskView *)sender.superview).finishButton.selected == false) {

        [((GHTabBarControllerController *)self.tabBarController) addButtonClickAction];
        
//        GHNSearchDoctorViewController *vc = [[GHNSearchDoctorViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:true];
        
    }
    
}

- (void)clickFinishInfoAction:(UIButton *)sender {
    
    if (((GHNTaskView *)sender.superview).finishButton.selected == false) {
        
        GHEditUserInfoViewController *vc = [[GHEditUserInfoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:true];
        
    }
    
    
}

- (void)clickFinishShareAction:(UIButton *)sender {
    
    [self.navigationController.tabBarController setSelectedIndex:0];
    
    [self.navigationController popToRootViewControllerAnimated:false];
    
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//    });
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self setupNavigationStyle:GHNavigationBarStyleWhite];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
}


@end

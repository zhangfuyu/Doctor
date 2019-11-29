//
//  GHNPersonCenterHeaderView.m
//  掌上优医
//
//  Created by GH on 2019/2/19.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNPersonCenterHeaderView.h"


#import "GHNPersonCenterButtonView.h"

#import "GHNPersonCenterCellView.h"

#import "GHSetupViewController.h"
#import "GHAboutMeViewController.h"

#import "GHNoticeMessageSystemViewController.h"

#import "GHNCoinRecordViewController.h"

#import "GHEditUserInfoViewController.h"

#import "GHMyCommentsListViewController.h"

#import "GHNMyCollectionViewController.h"

#import "GHZuJiViewController.h"

#import "GHFeedbackViewController.h"

#import "GHNInvoiceCodeViewController.h"

#import "GHTaskListViewController.h"

#import "GHContributionViewController.h"

@interface GHNPersonCenterHeaderView ()

@property (nonatomic, strong) UIImageView *headPortraitImageView;

@property (nonatomic, strong) UILabel *loginLabel;

@property (nonatomic, strong) UILabel *nameLabel;

/**
 星医分
 */
@property (nonatomic, strong) UILabel *coinLabel;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIButton *noticeButton;

@property (nonatomic, strong) UILabel *badgeLabel;

@end

@implementation GHNPersonCenterHeaderView

- (instancetype)init {
    
    if (self = [super init]) {
        self.backgroundColor = UIColorHex(0xF5F5F5);
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupBadgeStatus) name:kNotificationWillEnterForeground object:nil];
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.contentMode = UIViewContentModeScaleToFill;
    bgImageView.image = [UIImage imageNamed:@"personcenter_bg"];
    [self addSubview:bgImageView];
    
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(250);
    }];
    

    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 8;
    contentView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    contentView.layer.shadowOffset = CGSizeMake(0,2);
    contentView.layer.shadowOpacity = 1;
    contentView.layer.shadowRadius = 4;
    [self addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(64 + Height_StatusBar);
        make.height.mas_equalTo(201);
    }];
    
//    UIImageView *recommendBannerImageView = [[UIImageView alloc] init];
//    recommendBannerImageView.contentMode = UIViewContentModeScaleAspectFit;
//
//    if ([GHUserModelTool shareInstance].isZheng) {
//
//        recommendBannerImageView.image = [UIImage imageNamed:@"personcenter_banner_zheng"];
//
//    } else {
//        recommendBannerImageView.image = [UIImage imageNamed:@"personcenter_banner"];
//    }
//
//    [self addSubview:recommendBannerImageView];
//
//    [recommendBannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(contentView.mas_bottom).offset(12);
//        make.left.mas_equalTo(8);
//        make.right.mas_equalTo(-8);
//        make.height.mas_equalTo(HScaleHeight(86));
//    }];
//
//    UIButton *recommendButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self addSubview:recommendButton];
//
//    [recommendButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.mas_equalTo(recommendBannerImageView);
//    }];
//    [recommendButton addTarget:self action:@selector(clickRecommendAction) forControlEvents:UIControlEventTouchUpInside];
//
    
    UIImageView *headPortraitImageView = [[UIImageView alloc] init];
    headPortraitImageView.contentMode = UIViewContentModeScaleAspectFill;
    headPortraitImageView.layer.cornerRadius = 47;
    headPortraitImageView.layer.masksToBounds = true;
//    headPortraitImageView.layer.borderColor = [UIColor whiteColor].CGColor;
//    headPortraitImageView.layer.borderWidth = 2;
    [self addSubview:headPortraitImageView];
    
    [headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(94);
        make.centerX.mas_equalTo(contentView);
        make.centerY.mas_equalTo(contentView.mas_top);
    }];
    self.headPortraitImageView = headPortraitImageView;
    
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.backgroundColor = kDefaultGaryViewColor;
    infoLabel.text = @"个人信息";
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.textColor = kDefaultGrayTextColor;
    infoLabel.layer.cornerRadius = 14;
    infoLabel.layer.masksToBounds = true;
    infoLabel.font = H13;
    [self addSubview:infoLabel];
    
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(28);
        make.top.mas_equalTo(contentView).offset(20);
        make.width.mas_equalTo(80);
        make.right.mas_equalTo(contentView);
    }];
    
    UIView *infoArrowView = [[UIView alloc] init];
    infoArrowView.backgroundColor = kDefaultGaryViewColor;
    [self addSubview:infoArrowView];
    
    [infoArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15);
        make.right.mas_equalTo(contentView).offset(2);
        make.height.mas_equalTo(infoLabel);
        make.top.mas_equalTo(infoLabel);
    }];
    
    UIImageView *infoArrowImageView = [[UIImageView alloc] init];
    infoArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    infoArrowImageView.image = [UIImage imageNamed:@"personcenter_user_right_arrow"];
    [infoArrowView addSubview:infoArrowImageView];
    
    [infoArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(6);
        make.center.mas_equalTo(infoArrowView);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kDefaultBlackTextColor;
    nameLabel.font = H24;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.numberOfLines = 2;
    [contentView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headPortraitImageView.mas_bottom).offset(8);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(42);
        make.left.mas_equalTo(0);
    }];
    self.nameLabel = nameLabel;
    
    UILabel *coinLabel = [[UILabel alloc] init];
    coinLabel.textColor = kDefaultGrayTextColor;
    coinLabel.textAlignment = NSTextAlignmentCenter;
    coinLabel.font = H15;
    [contentView addSubview:coinLabel];
    
    [coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLabel.mas_bottom);
        make.right.mas_equalTo(0);
//        make.centerX.mas_equalTo(contentView);
        make.height.mas_equalTo(21);
        make.left.mas_equalTo(0);
    }];
    self.coinLabel = coinLabel;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = UIColorHex(0xEEEEEE);
    [contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(130);
        make.height.mas_equalTo(0.5);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(headPortraitImageView);
        make.bottom.mas_equalTo(coinLabel.mas_top);
    }];
    [button addTarget:self action:@selector(clickPersonInfoAction) forControlEvents:UIControlEventTouchUpInside];

    UIButton *coinActionbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:coinActionbutton];

    [coinActionbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(button.mas_bottom);
        make.bottom.mas_equalTo(lineLabel);
    }];
    [coinActionbutton addTarget:self action:@selector(clickCoinAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    

    
    UIButton *noticeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [noticeButton setImage:[UIImage imageNamed:@"personcenter_icon_notice"] forState:UIControlStateNormal];
    [self addSubview:noticeButton];
    
    [noticeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(54);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(Height_StatusBar);
    }];
    [noticeButton addTarget:self action:@selector(clickNoticeAction) forControlEvents:UIControlEventTouchUpInside];
    self.noticeButton = noticeButton;
    
    UILabel *badgeLabel = [[UILabel alloc] init];
    badgeLabel.font = H12;
    badgeLabel.textAlignment = NSTextAlignmentCenter;
    badgeLabel.textColor = [UIColor whiteColor];
    badgeLabel.layer.cornerRadius = 8;
    badgeLabel.layer.masksToBounds = true;
    badgeLabel.backgroundColor = [UIColor redColor];
    [self addSubview:badgeLabel];
    
    [badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16);
        make.right.mas_equalTo(-9);
        make.bottom.mas_equalTo(contentView.mas_top).offset(-44);
        make.width.mas_equalTo(16);
    }];
    self.badgeLabel = badgeLabel;
    
    
    NSArray *imageArray = @[@"personcenter_icon_comments", @"personcenter_icon_collection", @"personcenter_icon_zuji"];
    NSArray *titleArray = @[@"点评", @"收藏", @"足迹"];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        
        GHNPersonCenterButtonView *buttonView = [[GHNPersonCenterButtonView alloc] initWithImageName:[imageArray objectOrNilAtIndex:index] withTitle:[titleArray objectOrNilAtIndex:index]];
        
        [contentView addSubview:buttonView];
        
        [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lineLabel.mas_bottom).offset(13);
            make.bottom.mas_equalTo(-12);
            make.width.mas_equalTo((SCREENWIDTH - 32 - 56) / 3.f);
            
            make.left.mas_equalTo(28 + (SCREENWIDTH - 32 - 56) / 3.f * index);
            
        }];
        
        switch (index) {
            case 0:
                [buttonView.actionButton addTarget:self action:@selector(clickCommentsAction) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 1:
                [buttonView.actionButton addTarget:self action:@selector(clickCollectionAction) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 2:
                [buttonView.actionButton addTarget:self action:@selector(clickRecordAction) forControlEvents:UIControlEventTouchUpInside];
                break;
                
            default:
                break;
        }
        
    }
    
    
    
    UIView *cellContentView = [[UIView alloc] init];
    cellContentView.backgroundColor = [UIColor whiteColor];
    cellContentView.layer.cornerRadius = 4;
    cellContentView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    cellContentView.layer.shadowOffset = CGSizeMake(0,2);
    cellContentView.layer.shadowOpacity = 1;
    cellContentView.layer.shadowRadius = 4;
    [self addSubview:cellContentView];
    
    [cellContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
//        make.top.mas_equalTo(262 + Height_StatusBar + 12 + HScaleHeight(86) + 15);
        make.top.mas_equalTo(262 + Height_StatusBar + 12);
        make.height.mas_equalTo(208 - 52);
    }];
    
    NSArray *cellImageArray = @[/*@"ic_personcenter_gongxian",*/ @"personcenter_icon_aboutus", @"personcenter_icon_feedback", @"personcenter_icon_setup"];
    NSArray *cellTitleArray = @[/*@"贡献信息",*/ @"关于我们", @"意见反馈", @"设置"];
    NSArray *descTitleArray = @[/*@"",*/ @"让我们做的更好", @"",@""];
    
    for (NSInteger index = 0; index < cellTitleArray.count; index++) {
        
        GHNPersonCenterCellView *buttonView = [[GHNPersonCenterCellView alloc] initWithImageName:[cellImageArray objectOrNilAtIndex:index] withTitle:[cellTitleArray objectOrNilAtIndex:index] withDesc:[descTitleArray objectOrNilAtIndex:index]];
        
//        buttonView.layer.masksToBounds = true;
        
        [cellContentView addSubview:buttonView];
        
        [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(52);
            make.top.mas_equalTo(52 * index);
        }];
        
        switch (index) {
            case 0:
//                [buttonView.actionButton addTarget:self action:@selector(clickContributionAction) forControlEvents:UIControlEventTouchUpInside];
                [buttonView.actionButton addTarget:self action:@selector(clickAboutUsAction) forControlEvents:UIControlEventTouchUpInside];


                break;
            case 1:
//                [buttonView.actionButton addTarget:self action:@selector(clickAboutUsAction) forControlEvents:UIControlEventTouchUpInside];
                [buttonView.actionButton addTarget:self action:@selector(clickFeedbackAction) forControlEvents:UIControlEventTouchUpInside];


                break;
            case 2:
//                [buttonView.actionButton addTarget:self action:@selector(clickFeedbackAction) forControlEvents:UIControlEventTouchUpInside];
                [buttonView.actionButton addTarget:self action:@selector(clickSetupAction) forControlEvents:UIControlEventTouchUpInside];
                               buttonView.lineLabel.hidden = true;

                break;
            case 3:
                [buttonView.actionButton addTarget:self action:@selector(clickSetupAction) forControlEvents:UIControlEventTouchUpInside];
                buttonView.lineLabel.hidden = true;
                break;
                
            default:
                break;
        }
        
    }
    
}

- (void)clickRecommendAction {
    

    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        if ([GHUserModelTool shareInstance].isZheng) {
            
            GHTaskListViewController *vc = [[GHTaskListViewController alloc] init];
            [self.viewController.navigationController pushViewController:vc animated:true];
            
        } else {
        
            GHNInvoiceCodeViewController *vc = [[GHNInvoiceCodeViewController alloc] init];
            [self.viewController.navigationController pushViewController:vc animated:true];
        
        }
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self.viewController presentViewController:vc animated:true completion:nil];
        
    }
    
}

- (void)clickNoticeAction {
    
    [self setupBadgeStatus];
    
    GHNoticeMessageSystemViewController *vc = [[GHNoticeMessageSystemViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:true];
    
}

- (void)clickAboutUsAction {
    
    GHAboutMeViewController *vc = [[GHAboutMeViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:true];
    
}

- (void)clickContributionAction {

    if ([GHUserModelTool shareInstance].isLogin) {
        
        NSLog(@"贡献信息");
        
        GHContributionViewController *vc = [[GHContributionViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:true];
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self.viewController presentViewController:vc animated:true completion:nil];
        
    }
    
}

- (void)clickFeedbackAction {
 
    if ([GHUserModelTool shareInstance].isLogin) {
        
        GHFeedbackViewController *vc = [[GHFeedbackViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:true];
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self.viewController presentViewController:vc animated:true completion:nil];
        
    }
    
}

- (void)clickSetupAction {
 
    GHSetupViewController *vc = [[GHSetupViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:true];
    
}

// 点评
- (void)clickCommentsAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        GHMyCommentsListViewController *vc = [[GHMyCommentsListViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:true];
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self.viewController presentViewController:vc animated:true completion:nil];
        
    }
    
}

// 收藏
- (void)clickCollectionAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        GHNMyCollectionViewController *vc = [[GHNMyCollectionViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:true];
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self.viewController presentViewController:vc animated:true completion:nil];
        
    }
    
}

// 足迹
- (void)clickRecordAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        GHZuJiViewController *vc = [[GHZuJiViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:true];
    }
    else
    {
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self.viewController presentViewController:vc animated:true completion:nil];
    }
    
    
   
    
}


// 星医分
- (void)clickCoinAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        GHNCoinRecordViewController *vc = [[GHNCoinRecordViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:true];
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self.viewController presentViewController:vc animated:true completion:nil];
        
    }
    
}

/**
 个人信息
 */
- (void)clickPersonInfoAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        GHEditUserInfoViewController *vc = [[GHEditUserInfoViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:true];
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self.viewController presentViewController:vc animated:true completion:nil];
        
    }
    
}

- (void)reloadData {
    
    [self setupBadgeStatus];
    
    if ([GHUserModelTool shareInstance].isLogin) {
        // 已登录
        
        [self.headPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL([GHUserModelTool shareInstance].userInfoModel.avatar)) placeholderImage:[UIImage imageNamed:@"personcenter_user_default"]];
        self.nameLabel.text = ISNIL([GHUserModelTool shareInstance].userInfoModel.nickName).length ? [GHUserModelTool shareInstance].userInfoModel.nickName : ISNIL([GHUserModelTool shareInstance].userInfoModel.showPhoneNum);
        NSLog(@"------>%@",[GHUserModelTool shareInstance].userInfoModel.nickName);
        self.coinLabel.text = [NSString stringWithFormat:@"星医分: %ld", [[GHUserModelTool shareInstance].userInfoModel.virtualCoinBalance integerValue]];
        self.coinLabel.textColor = UIColorHex(0xFEAE05);
        
        if ([self.nameLabel.text widthForFont:H24] > (SCREENWIDTH - 40)) {
            
            self.nameLabel.font = H17;
            
        } else {
            
            self.nameLabel.font = H24;
            
        }
        
    
    } else {
        // 未登录

        self.nameLabel.font = H24;
        
        self.nameLabel.text = @"点击登录";
        
        self.coinLabel.text = @"登录更精彩";
        
        self.coinLabel.textColor = kDefaultGrayTextColor;
        
        self.headPortraitImageView.image = [UIImage imageNamed:@"personcenter_user_default"];
        
    }
    
}

- (void)setupBadgeStatus {
    
    NSInteger badge = [[UIApplication sharedApplication] applicationIconBadgeNumber];
    if (badge == 0) {
        self.badgeLabel.hidden = true;
    } else {
        self.badgeLabel.hidden = false;
        self.badgeLabel.text = [NSString stringWithFormat:@"%ld", badge];
        
        if (badge > 99) {
            self.badgeLabel.text = @"...";
            [self.badgeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-4);
                make.width.mas_equalTo(24);
            }];
        } else if (badge > 9) {
            [self.badgeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-4);
                make.width.mas_equalTo(24);
            }];
        } else {
            [self.badgeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-9);
                make.width.mas_equalTo(16);
            }];
        }
    }
    
    
}

@end

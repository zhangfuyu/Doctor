//
//  GHNPersonCenterFooterView.m
//  掌上优医
//
//  Created by GH on 2019/2/25.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNPersonCenterFooterView.h"
#import "GHNTaskView.h"
#import "GHNSearchDoctorViewController.h"
#import "GHTaskListViewController.h"
#import "GHTabBarControllerController.h"

@interface GHNPersonCenterFooterView ()

/**
 <#Description#>
 */
@property (nonatomic, strong) GHNTaskView *commentsTaskView;

@property (nonatomic, strong) GHNTaskView *shareTaskView;

@end

@implementation GHNPersonCenterFooterView

- (instancetype)init {
    
    if (self = [super init]) {
        self.backgroundColor = kDefaultGaryViewColor;
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 4;
    contentView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    contentView.layer.shadowOffset = CGSizeMake(0,2);
    contentView.layer.shadowOpacity = 1;
    contentView.layer.shadowRadius = 4;
    [self addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(2);
        make.height.mas_equalTo(194);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.font = HM18;
    titleLabel.text = @"每日任务";
    [contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(25);
        make.top.mas_equalTo(16);
        make.width.mas_equalTo(100);
    }];
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.contentMode = UIViewContentModeCenter;
    arrowImageView.image = [UIImage imageNamed:@"personcenter_right_arrow"];
    [contentView addSubview:arrowImageView];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(13);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(titleLabel);
    }];
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.textColor = kDefaultGrayTextColor;
    descLabel.font = H14;
    descLabel.textAlignment = NSTextAlignmentRight;
    descLabel.text = @"查看更多";
    [contentView addSubview:descLabel];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-35);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(titleLabel);
        make.width.mas_equalTo(100);
    }];
    GHNTaskView *commentTaskView = [[GHNTaskView alloc] initWithTaskTitle:@"每日首次写优质点评" withCoin:@"30"];
    [contentView addSubview:commentTaskView];
    
    [commentTaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(72);
        make.top.mas_equalTo(49);
    }];
    [commentTaskView.actionButton addTarget:self action:@selector(clickFinishCommentAction:) forControlEvents:UIControlEventTouchUpInside];
    self.commentsTaskView = commentTaskView;
    

    GHNTaskView *shareTaskView = [[GHNTaskView alloc] initWithTaskTitle:@"每日首次分享内容(疾病/医生/资讯)" withCoin:@"30"];
    [contentView addSubview:shareTaskView];
    
    [shareTaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(72);
        make.top.mas_equalTo(commentTaskView.mas_bottom);
    }];
    [shareTaskView.actionButton addTarget:self action:@selector(clickFinishShareAction:) forControlEvents:UIControlEventTouchUpInside];
    self.shareTaskView = shareTaskView;
    
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addSubview:moreButton];
    
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(commentTaskView.mas_top);
    }];
    [moreButton addTarget:self action:@selector(clickMoreAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickMoreAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        GHTaskListViewController *vc = [[GHTaskListViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:true];
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self.viewController presentViewController:vc animated:true completion:nil];
        
    }
    

    
}

- (void)clickFinishCommentAction:(UIButton *)sender {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        [((GHTabBarControllerController *)self.viewController.tabBarController) addButtonClickAction];
        
//        GHNSearchDoctorViewController *vc = [[GHNSearchDoctorViewController alloc] init];
//        [self.viewController.navigationController pushViewController:vc animated:true];
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self.viewController presentViewController:vc animated:true completion:nil];
        
    }
    
}

- (void)clickFinishShareAction:(UIButton *)sender {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        [self.viewController.tabBarController setSelectedIndex:0];
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self.viewController presentViewController:vc animated:true completion:nil];
        
    }
    
    
    
}

- (void)setIsCanCommentTask:(BOOL)task {
    
    if (task) {
        
        self.commentsTaskView.finishButton.userInteractionEnabled = true;
        self.commentsTaskView.finishButton.selected = false;
        self.commentsTaskView.finishButton.backgroundColor = kDefaultBlueColor;
        
        self.commentsTaskView.actionButton.userInteractionEnabled = true;
        self.commentsTaskView.actionButton.selected = false;
        
    } else {
        
        self.commentsTaskView.finishButton.userInteractionEnabled = false;
        self.commentsTaskView.finishButton.selected = true;
        self.commentsTaskView.finishButton.backgroundColor = UIColorHex(0xBDBDBD);
        
        self.commentsTaskView.actionButton.userInteractionEnabled = false;
        self.commentsTaskView.actionButton.selected = true;
        
    }
    
}

- (void)setIsCanShareTask:(BOOL)task {
    
    if (task) {
        
        self.shareTaskView.finishButton.userInteractionEnabled = true;
        self.shareTaskView.finishButton.selected = false;
        self.shareTaskView.finishButton.backgroundColor = kDefaultBlueColor;
        
        self.shareTaskView.actionButton.userInteractionEnabled = true;
        self.shareTaskView.actionButton.selected = false;
        
    } else {
        
        self.shareTaskView.finishButton.userInteractionEnabled = false;
        self.shareTaskView.finishButton.selected = true;
        self.shareTaskView.finishButton.backgroundColor = UIColorHex(0xBDBDBD);
        
        self.shareTaskView.actionButton.userInteractionEnabled = false;
        self.shareTaskView.actionButton.selected = true;
        
    }
    
}

- (void)reloadData {
    
}

@end

//
//  GHContributionViewController.m
//  掌上优医
//
//  Created by GH on 2019/5/30.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHContributionViewController.h"
#import "GHAddDoctorViewController.h"
#import "GHAddHospitalViewController.h"
#import "GHInformationCompletionViewController.h"
#import "GHContributionListViewController.h"

@implementation GHContributionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"贡献信息";
    
    [self setupUI];
    
}

- (void)setupUI {
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    UIView *userInfoView = [[UIView alloc] init];
    userInfoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:userInfoView];
    
    [userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(80);
    }];
    
    UIImageView *headPortraitImageView = [[UIImageView alloc] init];
    headPortraitImageView.contentMode = UIViewContentModeScaleAspectFill;
    headPortraitImageView.layer.cornerRadius = 20;
    headPortraitImageView.layer.masksToBounds = true;
    [userInfoView addSubview:headPortraitImageView];
    
    [headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(userInfoView);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kDefaultBlackTextColor;
    nameLabel.font = HM18;
    [userInfoView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(15);
        make.centerY.mas_equalTo(userInfoView);
        make.height.mas_equalTo(42);
        make.right.mas_equalTo(-95);
    }];
    
    [headPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL([GHUserModelTool shareInstance].userInfoModel.profilePhoto)) placeholderImage:[UIImage imageNamed:@"personcenter_user_default"]];
    nameLabel.text = ISNIL([GHUserModelTool shareInstance].userInfoModel.nickName).length ? [GHUserModelTool shareInstance].userInfoModel.nickName : ISNIL([GHUserModelTool shareInstance].userInfoModel.showPhoneNum);
    
    UIButton *submitListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitListButton.titleLabel.font = H14;
    [submitListButton setTitle:@"贡献记录" forState:UIControlStateNormal];
    [submitListButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    submitListButton.layer.cornerRadius = 15;
    submitListButton.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
    submitListButton.layer.borderWidth = .5;
    submitListButton.layer.masksToBounds = true;
    [userInfoView addSubview:submitListButton];
    
    [submitListButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(userInfoView);
        make.width.mas_equalTo(90);
    }];
    [submitListButton addTarget:self action:@selector(clickSubmitListAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSArray *imageNameArray = @[@"ic_xinxibuquan_tianjiayisheng", @"ic_xinxiibuquan_tianjiayiyuan", @"ic_xinxinbuquan_xinxibuquan"];
    NSArray *titleArray = @[@"添加医生", @"添加医院", @"信息补全"];
    
    for (NSInteger index = 0; index < titleArray.count; index ++) {
        
        NSString *title = [titleArray objectOrNilAtIndex:index];
        NSString *imageName = [imageNameArray objectOrNilAtIndex:index];
        
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius = 4;
        contentView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
        contentView.layer.shadowOffset = CGSizeMake(0,2);
        contentView.layer.shadowOpacity = 1;
        contentView.layer.shadowRadius = 4;
        [self.view addSubview:contentView];
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15 + ((SCREENWIDTH - 30 - 14) / 3.f + 7) * index);
            make.width.mas_equalTo((SCREENWIDTH - 30 - 14) / 3.f);
            make.top.mas_equalTo(userInfoView.mas_bottom).offset(20);
            make.height.mas_equalTo(70);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = kDefaultBlackTextColor;
        titleLabel.font = H16;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = ISNIL(title);
        [contentView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(39);
        }];
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.contentMode = UIViewContentModeCenter;
        iconImageView.image = [UIImage imageNamed:imageName];
        [contentView addSubview:iconImageView];
        
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(22);
            make.centerX.mas_equalTo(contentView);
            make.top.mas_equalTo(9);
        }];
        
        UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        actionButton.tag = index;
        [contentView addSubview:actionButton];
        
        [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
        
        [actionButton addTarget:self action:@selector(clickAddAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    
    
}

- (void)clickAddAction:(UIButton *)sender {
    
    if (sender.tag == 0) {
        
        GHAddDoctorViewController *vc = [[GHAddDoctorViewController alloc] init];
        [self.navigationController pushViewController:vc animated:true];
        
    } else if (sender.tag == 1) {
        
        GHAddHospitalViewController *vc = [[GHAddHospitalViewController alloc] init];
        [self.navigationController pushViewController:vc animated:true];
        
    } else if (sender.tag == 2) {
        
        GHInformationCompletionViewController *vc = [[GHInformationCompletionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:true];
        
    }
    
}

- (void)clickSubmitListAction {
    
    NSLog(@"提交记录");
    
    GHContributionListViewController *vc = [[GHContributionListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
    
}

@end

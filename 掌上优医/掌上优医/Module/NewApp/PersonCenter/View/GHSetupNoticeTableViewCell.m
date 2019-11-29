//
//  GHSetupNoticeTableViewCell.m
//  掌上优医
//
//  Created by GH on 2018/11/1.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHSetupNoticeTableViewCell.h"

@interface GHSetupNoticeTableViewCell ()

@property (nonatomic, strong) UIButton *switchButton;

/**
 <#Description#>
 */
@property (nonatomic, strong) UISwitch *mySwitch;

@end

@implementation GHSetupNoticeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.font = H16;
    titleLabel.text = @"接受新消息通知";
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
//    UILabel *lineLabel = [[UILabel alloc] init];
//    lineLabel.backgroundColor = kDefaultLineViewColor;
//    [self.contentView addSubview:lineLabel];
//    
//    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(titleLabel.mas_bottom);
//        make.height.mas_equalTo(1);
//        make.left.mas_equalTo(15);
//        make.right.mas_equalTo(-15);
//    }];
    
    
//    UILabel *descLabel = [[UILabel alloc] init];
//    descLabel.textColor = kDefaultGrayTextColor;
//    descLabel.text = @"请在设置中修改";
//    descLabel.font = H13;
//    [self.contentView addSubview:descLabel];
//
//    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.top.mas_equalTo(lineLabel.mas_bottom);
//        make.bottom.mas_equalTo(0);
//    }];
//
//
//    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    titleButton.titleLabel.font = H12;
//    [titleButton setTitle:@"去设置" forState:UIControlStateNormal];
//    [titleButton setTitleColor:kDefaultBlueColor forState:UIControlStateNormal];
//    [self.contentView addSubview:titleButton];
//
//    [titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.mas_equalTo(descLabel);
//        make.left.mas_equalTo(descLabel.mas_right);
//    }];
//    [titleButton addTarget:self action:@selector(clickSetupNoticeAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(SCREENWIDTH - 50 - 16, 10, 50, 30)];
    mySwitch.onTintColor = kDefaultBlueColor;
    mySwitch.tintColor = kDefaultGaryViewColor;

    [self.contentView addSubview:mySwitch];
    
    self.mySwitch = mySwitch;
    
    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [imageButton setImage:[UIImage imageNamed:@"btn_shezhi_xiaoxitongzhi_unselected"] forState:UIControlStateNormal];
//    [imageButton setImage:[UIImage imageNamed:@"btn_shezhi_xiaoxitongzhi_selected"] forState:UIControlStateSelected];
    [self.contentView addSubview:imageButton];
    
    [imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(titleLabel);
        make.width.mas_equalTo(39);
        make.right.mas_equalTo(-12);
    }];
    [imageButton addTarget:self action:@selector(clickSetupNoticeAction) forControlEvents:UIControlEventTouchUpInside];
    self.switchButton = imageButton;
    
}

- (void)clickSetupNoticeAction {
    
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    
    if (@available(iOS 10.0, *)) {
        
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
        
    } else {
        
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
        
    }
    
}

- (void)checkState {
    
    self.mySwitch.on = [self isUserNotificationEnable];
    
    self.switchButton.selected = [self isUserNotificationEnable];
    
}


- (BOOL)isUserNotificationEnable { // 判断用户是否允许接收通知
    BOOL isEnable = NO;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f) { // iOS版本 >=8.0 处理逻辑
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        isEnable = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
    } else { // iOS版本 <8.0 处理逻辑
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        isEnable = (UIRemoteNotificationTypeNone == type) ? NO : YES;
    }
    return isEnable;
}


@end

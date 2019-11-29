//
//  GHNSicknessDoctorTopTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/2/28.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNSicknessDoctorTopTableViewCell.h"

@implementation GHNSicknessDoctorTopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.backgroundColor = kDefaultGaryViewColor;
    self.contentView.backgroundColor = kDefaultGaryViewColor;
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = UIColorHex(0x54D8E0);
    contentView.layer.cornerRadius = 4;
    [self.contentView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-3);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = HM15;
    titleLabel.textColor = [UIColor whiteColor];
    [contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(13);
        make.left.mas_equalTo(11);
        make.height.mas_equalTo(21);
        make.right.mas_equalTo(-11);
    }];
    self.titleLabel = titleLabel;
    
    UILabel *departmentLabel = [[UILabel alloc] init];
    departmentLabel.font = H13;
    departmentLabel.textColor = [UIColor whiteColor];
    [contentView addSubview:departmentLabel];
    
    [departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(11);
        make.height.mas_equalTo(19);
        make.right.mas_equalTo(-11);
    }];
    self.departmentLabel = departmentLabel;
    
}

@end

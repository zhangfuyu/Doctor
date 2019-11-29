//
//  GHSicknessLibraryDepartmentTableViewCell.m
//  掌上优医
//
//  Created by GH on 2018/10/30.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHSicknessLibraryDepartmentTableViewCell.h"

@interface GHSicknessLibraryDepartmentTableViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation GHSicknessLibraryDepartmentTableViewCell

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
    
    
    self.backgroundColor = kDefaultGaryViewColor;
    self.contentView.backgroundColor = [UIColor clearColor];

//    UIView *iconBgImageView = [[UIView alloc] init];
//    iconBgImageView.backgroundColor = [UIColor clearColor];
//    iconBgImageView.layer.cornerRadius = 5;
//    iconBgImageView.layer.masksToBounds = true;
//    [self.contentView addSubview:iconBgImageView];
//
//    [iconBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(15);
//        make.width.height.mas_equalTo(40);
//        make.centerX.mas_equalTo(self.contentView);
//    }];

    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:iconImageView];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(15);
    }];
    self.iconImageView = iconImageView;
    
//    UIImageView *iconImageView = [[UIImageView alloc] init];
//    iconImageView.contentMode = UIViewContentModeScaleAspectFill;
//    [self.contentView addSubview:iconImageView];
//
//    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(16);
//        make.width.height.mas_equalTo(35);
//        make.centerX.mas_equalTo(self.contentView);
//    }];
//    self.iconImageView = iconImageView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.font = H13;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(16);
        make.bottom.mas_equalTo(-13);
    }];
    self.titleLabel = titleLabel;
    
}

- (void)setModel:(GHDepartmentModel *)model {
    
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.departmentsIconUrl))];
    
    self.titleLabel.text = ISNIL(model.departmentName);
    
}


@end

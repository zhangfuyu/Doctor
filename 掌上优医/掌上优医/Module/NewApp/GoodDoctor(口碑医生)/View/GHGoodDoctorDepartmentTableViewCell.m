//
//  GHGoodDoctorDepartmentTableViewCell.m
//  掌上优医
//
//  Created by GH on 2018/10/30.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHGoodDoctorDepartmentTableViewCell.h"

@interface GHGoodDoctorDepartmentTableViewCell ()

@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation GHGoodDoctorDepartmentTableViewCell

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
    
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    iconImageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:iconImageView];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.left.mas_equalTo(18);
        make.centerY.mas_equalTo(self.contentView);
    }];
    self.iconImageView = iconImageView;
    
    UILabel *numberLabel = [[UILabel alloc] init];
    numberLabel.font = H16;
    numberLabel.textColor = [UIColor whiteColor];
    numberLabel.layer.cornerRadius = 4;
    numberLabel.layer.masksToBounds = true;
    numberLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:numberLabel];
    
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(iconImageView);
    }];
    self.numberLabel = numberLabel;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = H16;
    titleLabel.textColor = kDefaultBlackTextColor;
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(iconImageView);
        make.left.mas_equalTo(iconImageView.mas_right).offset(19);
        make.right.mas_equalTo(-38);
    }];
    self.titleLabel = titleLabel;

    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.font = H16;
    descLabel.textColor = kDefaultGrayTextColor;
    descLabel.textAlignment = NSTextAlignmentRight;
    descLabel.hidden = true;
    [self.contentView addSubview:descLabel];

    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(120);
        make.right.mas_equalTo(-38);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    self.descLabel = descLabel;
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.contentMode = UIViewContentModeCenter;
    arrowImageView.image = [UIImage imageNamed:@"personcenter_right_arrow"];
    [self.contentView addSubview:arrowImageView];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(13);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(titleLabel);
    }];
    self.arrowImageView = arrowImageView;
    
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultGaryViewColor;
    [self.contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
 
    self.numberLabel.hidden = true;
}

- (void)setModel:(GHNewDepartMentModel *)model {
    
    _model = model;
    
    self.titleLabel.text = ISNIL(model.departmentName);
    [self.iconImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.iconUrl))];
    
//    self.descLabel.text = [NSString stringWithFormat:@"(%ld位)", [model. integerValue]];
    
    if ([model.isOpen integerValue] == false) {
        self.arrowImageView.image = [UIImage imageNamed:@"personcenter_right_arrow"];
    } else {
        self.arrowImageView.image = [UIImage imageNamed:@"personcenter_down_arrow"];
    }
    
}



@end

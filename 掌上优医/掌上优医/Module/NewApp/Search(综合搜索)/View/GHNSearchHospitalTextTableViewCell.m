//
//  GHNSearchHospitalTextTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/5/16.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNSearchHospitalTextTableViewCell.h"

@interface GHNSearchHospitalTextTableViewCell ()

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation GHNSearchHospitalTextTableViewCell

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
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-75);
    }];
    self.titleLabel = titleLabel;
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.textColor = kDefaultGrayTextColor;
    descLabel.font = H14;
    [self.contentView addSubview:descLabel];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(70);
    }];
    self.descLabel = descLabel;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultGaryViewColor;
    [self.contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
}

- (void)setModel:(GHSearchHospitalModel *)model {
    
    self.titleLabel.text = ISNIL(model.hospitalName);
    
    self.descLabel.text = ISNIL(model.hospitalGrade);
    
}

@end

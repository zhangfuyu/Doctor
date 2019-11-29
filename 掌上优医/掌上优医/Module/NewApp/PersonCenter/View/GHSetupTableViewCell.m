//
//  GHSetupTableViewCell.m
//  掌上优医
//
//  Created by GH on 2018/11/1.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHSetupTableViewCell.h"

@implementation GHSetupTableViewCell

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
    
 
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.contentMode = UIViewContentModeCenter;
    arrowImageView.image = [UIImage imageNamed:@"personcenter_right_arrow"];
    arrowImageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:arrowImageView];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.width.height.mas_equalTo(16);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    self.arrowImageView = arrowImageView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.font = H16;
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(arrowImageView.mas_left);
        make.top.bottom.mas_equalTo(0);
    }];
    self.titleLabel = titleLabel;
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.textColor = kDefaultGrayTextColor;
    descLabel.font = H12;
    [self.contentView addSubview:descLabel];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.top.bottom.mas_equalTo(0);
    }];
    self.descLabel = descLabel;
    
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [self.contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
    }];
    
    
    
    
}


@end

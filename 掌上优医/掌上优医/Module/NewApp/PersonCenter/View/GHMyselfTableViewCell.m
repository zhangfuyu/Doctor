//
//  GHMyselfTableViewCell.m
//  掌上优医
//
//  Created by GH on 2018/10/25.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHMyselfTableViewCell.h"

@interface GHMyselfTableViewCell ()



@end

@implementation GHMyselfTableViewCell

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
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(24);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    self.iconImageView = imageView;
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    arrowImageView.image = [UIImage imageNamed:@"personcenter_right_arrow"];
    arrowImageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:arrowImageView];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.width.height.mas_equalTo(16);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.font = H17;
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(6);
        make.right.mas_equalTo(arrowImageView.mas_left);
        make.top.bottom.mas_equalTo(0);
    }];
    self.titleLabel = titleLabel;

    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [self.contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    

    
}

@end

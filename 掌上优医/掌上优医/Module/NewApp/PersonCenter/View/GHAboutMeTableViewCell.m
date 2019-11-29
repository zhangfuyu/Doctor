//
//  GHAboutMeTableViewCell.m
//  掌上优医
//
//  Created by GH on 2018/11/21.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHAboutMeTableViewCell.h"

@implementation GHAboutMeTableViewCell

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
    titleLabel.font = H17;
    titleLabel.textColor = kDefaultBlackTextColor;
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
    }];
    
    self.titleLabel = titleLabel;
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.contentMode = UIViewContentModeCenter;
    arrowImageView.image = [UIImage imageNamed:@"personcenter_right_arrow"];
    arrowImageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:arrowImageView];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(45);
        make.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [self.contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(1);
    }];
    
}

@end

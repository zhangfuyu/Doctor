//
//  GHCommonChooseTableViewCell.m
//  掌上优医
//
//  Created by GH on 2018/10/31.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHCommonChooseTableViewCell.h"

@implementation GHCommonChooseTableViewCell

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
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = H14;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.highlightedTextColor = kDefaultBlueColor;
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(0);
    }];
    
    self.titleLabel = titleLabel;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [self.contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
    lineLabel.hidden = true;
    self.lineLabel = lineLabel;

}

@end

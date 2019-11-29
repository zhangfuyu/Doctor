//
//  GHLocationAreaTableViewCell.m
//  掌上优医
//
//  Created by GH on 2018/10/29.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHLocationAreaTableViewCell.h"

@interface GHLocationAreaTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation GHLocationAreaTableViewCell

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
    titleLabel.font = H14;
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.bottom.mas_equalTo(0);
    }];
    self.titleLabel = titleLabel;
    

    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [self.contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
}

- (void)setModel:(GHAreaModel *)model {
    
    _model = model;
    
    if (self.isSearch) {
        self.titleLabel.attributedText = [NSAttributedString rangeSearchLight:ISNIL(model.areaName) searchString:ISNIL(self.searchText)];
    } else {
        self.titleLabel.attributedText = [NSAttributedString rangeSearchLight:ISNIL(model.areaName) searchString:@""];
    }
    

    
}


@end

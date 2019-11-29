//
//  GHNCommonChooseTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/2/26.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNCommonChooseTableViewCell.h"

@interface GHNCommonChooseTableViewCell ()

/**
 <#Description#>
 */
@property (nonatomic, strong) UIImageView *iconImageView;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation GHNCommonChooseTableViewCell

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
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:@"search_check_icon"];
    [self.contentView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.width.height.mas_equalTo(12);
        make.centerY.mas_equalTo(self);
    }];
    
    self.iconImageView = imageView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = H14;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = kDefaultBlueColor;
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.mas_equalTo(0);
//        make.left.mas_equalTo(56);
    }];
    
    self.titleLabel = titleLabel;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [self.contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
    
}

- (void)setModel:(GHNCommonChooseModel *)model {
    
    _model = model;
    
    self.titleLabel.text = ISNIL(model.title);
//    self.iconImageView.hidden = !model.isCheck;//新版本暂时不要 打勾
    self.iconImageView.hidden = YES;
    
    if (model.isCheck) {
        self.titleLabel.textColor = kDefaultBlueColor;
    } else {
        self.titleLabel.textColor = kDefaultBlackTextColor;
    }
    
}






@end

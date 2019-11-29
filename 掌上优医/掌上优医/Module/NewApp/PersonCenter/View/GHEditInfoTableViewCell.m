//
//  GHEditInfoTableViewCell.m
//  掌上优医
//
//  Created by GH on 2018/11/2.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHEditInfoTableViewCell.h"

@interface GHEditInfoTableViewCell ()

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UILabel *lineLabel;

@end

@implementation GHEditInfoTableViewCell

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
    
    UIImageView *headPortraitImageView = [[UIImageView alloc] init];
    headPortraitImageView.contentMode = UIViewContentModeScaleAspectFill;
    headPortraitImageView.layer.cornerRadius = 19;
    headPortraitImageView.layer.masksToBounds = true;
    [self.contentView addSubview:headPortraitImageView];
    
    [headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(38);
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    self.headPortraitImageView = headPortraitImageView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.font = H16;
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.bottom.mas_equalTo(0);
    }];
    self.titleLabel = titleLabel;
    
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.textColor = kDefaultGrayTextColor;
    descLabel.font = H14;
    descLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:descLabel];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(titleLabel.mas_right).offset(5);
    }];
    self.descLabel = descLabel;
    
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.contentMode = UIViewContentModeCenter;
    arrowImageView.image = [UIImage imageNamed:@"personcenter_right_arrow"];
    arrowImageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:arrowImageView];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.width.height.mas_equalTo(16);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    self.arrowImageView = arrowImageView;
    
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [self.contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(1);
    }];
    self.lineLabel = lineLabel;
    
}

- (void)setStyle:(GHEditInfoTableViewCellStyle)style {
    
    _style = style;
    
    if (style == GHEditInfoTableViewCellStyle_HeadPortrait) {
        
        self.lineLabel.hidden = true;
        
        self.titleLabel.hidden = true;
        
        self.arrowImageView.hidden = false;
        
        [self.descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-40);
        }];
        
    } else if (style == GHEditInfoTableViewCellStyle_Arrow) {
        
        self.lineLabel.hidden = false;
        
        self.headPortraitImageView.hidden = true;
        
        self.arrowImageView.hidden = false;
        
        [self.descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-40);
        }];
        
    } else {
        
        self.lineLabel.hidden = false;
        
        self.arrowImageView.hidden = true;
        
        self.headPortraitImageView.hidden = true;
        
    }
    
    
}

@end

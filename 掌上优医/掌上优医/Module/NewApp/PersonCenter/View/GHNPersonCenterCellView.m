//
//  GHNPersonCenterCellView.m
//  掌上优医
//
//  Created by GH on 2019/2/20.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNPersonCenterCellView.h"

@interface GHNPersonCenterCellView ()

/**
 <#Description#>
 */
@property (nonatomic, strong) NSString *imageName;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSString *title;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSString *desc;

@end

@implementation GHNPersonCenterCellView

- (instancetype)initWithImageName:(NSString *)imageName withTitle:(NSString *)title withDesc:(NSString *)desc{
    
    if (self = [super init]) {
        self.imageName = imageName;
        self.title = title;
        self.desc = desc;
        self.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.image = [UIImage imageNamed:ISNIL(self.imageName)];
    [self addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
    }];
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.contentMode = UIViewContentModeCenter;
    arrowImageView.image = [UIImage imageNamed:@"personcenter_right_arrow"];
    [self addSubview:arrowImageView];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(13);
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = H16;
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.text = ISNIL(self.title);
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(16);
        make.right.mas_equalTo(arrowImageView.mas_left).offset(-16);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.font = H14;
    descLabel.textColor = kDefaultGrayTextColor;
    descLabel.text = ISNIL(self.desc);
    descLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:descLabel];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(16);
        make.right.mas_equalTo(arrowImageView.mas_left).offset(-8);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = UIColorHex(0xF5F5F5);
    [self addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    self.lineLabel = lineLabel;
    
    imageView.backgroundColor = [UIColor whiteColor];
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:actionButton];
    
    [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    self.actionButton = actionButton;
    
    
    
}

@end

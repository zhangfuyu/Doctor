//
//  GHNPersonCenterButtonView.m
//  掌上优医
//
//  Created by GH on 2019/2/20.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNPersonCenterButtonView.h"

@interface GHNPersonCenterButtonView ()

/**
 <#Description#>
 */
@property (nonatomic, strong) NSString *imageName;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSString *title;

@end

@implementation GHNPersonCenterButtonView

- (instancetype)initWithImageName:(NSString *)imageName withTitle:(NSString *)title {
    
    if (self = [super init]) {
        self.imageName = imageName;
        self.title = title;
        self.backgroundColor = [UIColor whiteColor];
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
        make.width.height.mas_equalTo(HScaleHeight(19));
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = H13;
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.text = ISNIL(self.title);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(16);
    }];
    
    imageView.backgroundColor = [UIColor whiteColor];
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:actionButton];
    
    [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    self.actionButton = actionButton;
    
}


@end

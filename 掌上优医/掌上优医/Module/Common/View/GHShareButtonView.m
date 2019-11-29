//
//  GHShareButtonView.m
//  掌上优医
//
//  Created by GH on 2018/11/9.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHShareButtonView.h"

@interface GHShareButtonView ()

@property (nonatomic, copy) NSString *iconName;

@property (nonatomic, copy) NSString *title;

@end

@implementation GHShareButtonView

- (instancetype)initWithIconName:(NSString *)iconName withTitle:(NSString *)title {
    
    if (self = [super init]) {
        
        self.iconName = iconName;
        self.title = title;
        
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    imageView.layer.masksToBounds = true;
    imageView.image = [UIImage imageNamed:ISNIL(self.iconName)];
    [self addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.width.height.mas_equalTo(HScaleHeight(50));
        make.centerX.mas_equalTo(self);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = H11;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.text = ISNIL(self.title);
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(imageView.mas_bottom).offset(9);
    }];
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:actionButton];
    
    [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    self.actionButton = actionButton;
    
}

@end

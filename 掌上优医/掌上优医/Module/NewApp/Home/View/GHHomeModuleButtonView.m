//
//  GHHomeModuleButtonView.m
//  掌上优医
//
//  Created by GH on 2019/2/18.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHomeModuleButtonView.h"

@interface GHHomeModuleButtonView ()

/**
 <#Description#>
 */
@property (nonatomic, strong) NSString *imageName;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSString *title;

@end

@implementation GHHomeModuleButtonView

- (instancetype)initWithImageName:(NSString *)imageName withTitle:(NSString *)title {
    
    if (self = [super init]) {
        self.imageName = imageName;
        self.title = title;
//        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [UIImage imageNamed:ISNIL(self.imageName)];
    [self addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(HScaleHeight(44));
        make.top.mas_equalTo(HScaleHeight(0));
        make.centerX.mas_equalTo(self);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = HScaleFont(13);
    titleLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    titleLabel.text = ISNIL(self.title);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(imageView.mas_bottom).with.offset(HScaleHeight(3));/*(HScaleHeight(-16))*/;
        make.height.mas_equalTo(HScaleHeight(13));
    }];
    
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:actionButton];
    
    [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    self.actionButton = actionButton;
    
}

@end

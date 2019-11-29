//
//  GHSearchTagHeaderCollectionReusableView.m
//  掌上优医
//
//  Created by GH on 2018/10/26.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHSearchTagHeaderCollectionReusableView.h"

@implementation GHSearchTagHeaderCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
    
}

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = HM18;
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    self.titleLabel = titleLabel;
    
    UIButton *cleanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cleanButton setImage:[UIImage imageNamed:@"collection_delete"] forState:UIControlStateNormal];
    [cleanButton setImage:[UIImage imageNamed:@"collection_delete"] forState:UIControlStateDisabled];
    cleanButton.hidden = true;
    [self addSubview:cleanButton];
    
    [cleanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(48);
    }];
    self.cleanButton = cleanButton;
    
}



@end

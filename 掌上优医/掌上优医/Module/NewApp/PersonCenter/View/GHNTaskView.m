//
//  GHNTaskView.m
//  掌上优医
//
//  Created by GH on 2019/2/25.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNTaskView.h"

@interface GHNTaskView ()

/**
 <#Description#>
 */
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *coin;

@end

@implementation GHNTaskView

- (instancetype)initWithTaskTitle:(NSString *)title withCoin:(NSString *)coin {
    
    if (self = [super init]) {
        
        self.title = title;
        self.coin = coin;
        
        [self setupUI];
        
    }
    return self;
    
}

- (void)setupUI {

    self.backgroundColor = [UIColor whiteColor];

    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = UIColorHex(0xF5F5F5);
    [self addSubview:lineLabel];

    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = self.title;
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.font = HScaleFont(14);
    [self addSubview:titleLabel];

    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-95);
        make.left.mas_equalTo(16);
    }];

    UILabel *coinLabel = [[UILabel alloc] init];
    coinLabel.textColor = UIColorHex(0xFEAE05);
    coinLabel.font = H13;
    coinLabel.text = [NSString stringWithFormat:@"+%@星医分", self.coin];
    [self addSubview:coinLabel];

    [coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom);
        make.right.mas_equalTo(titleLabel.mas_right);
        make.height.mas_equalTo(21);
        make.left.mas_equalTo(16);
    }];
    
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    finishButton.titleLabel.font = H14;
    [finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finishButton setBackgroundColor:kDefaultBlueColor];
    [finishButton setTitle:@"去完成" forState:UIControlStateNormal];
    [finishButton setTitle:@"已完成" forState:UIControlStateSelected];
    finishButton.layer.cornerRadius = 4;
    finishButton.layer.masksToBounds = true;
    [self addSubview:finishButton];
    
    [finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(67);
        make.height.mas_equalTo(34);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(12);
    }];
    self.finishButton = finishButton;
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:actionButton];
    
    [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    self.actionButton = actionButton;

}

@end

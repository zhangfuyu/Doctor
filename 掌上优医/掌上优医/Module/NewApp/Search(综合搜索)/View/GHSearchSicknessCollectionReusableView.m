//
//  GHSearchSicknessCollectionReusableView.m
//  掌上优医
//
//  Created by GH on 2018/10/29.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHSearchSicknessCollectionReusableView.h"

@implementation GHSearchSicknessCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"大家都在搜";
    titleLabel.font = HM18;
    titleLabel.textColor = kDefaultBlackTextColor;
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(24);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(25);
    }];

    NSArray *titleArray = @[@"性功能障碍", @"盆腔炎", @"阴道炎", @"过敏", @"乳腺增生", @"鼻炎", @"抑郁症", @"前列腺炎"];;
    
    CGFloat width = 16;
    NSInteger line = 0;
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        
        NSString *str = [titleArray objectOrNilAtIndex:index];
        
        UIButton *sicknessButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [sicknessButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
        sicknessButton.layer.cornerRadius = 4;
        sicknessButton.backgroundColor = kDefaultGaryViewColor;
        sicknessButton.titleLabel.font = H14;
        
        [sicknessButton setTitle:str forState:UIControlStateNormal];
        
        [self addSubview:sicknessButton];
        
        [sicknessButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(width);
            make.width.mas_equalTo([str widthForFont:sicknessButton.titleLabel.font] + 20);
            make.top.mas_equalTo(line * 49 + 64);
            make.height.mas_equalTo(32);
        }];
        
        width += [str widthForFont:sicknessButton.titleLabel.font] + 42;
        
        if (width > SCREENWIDTH) {
            line += 1;
            width = 16;
            [sicknessButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(width);
                make.top.mas_equalTo(line * 49 + 64);
            }];
            width += [str widthForFont:sicknessButton.titleLabel.font] + 42;
        }
        
        [sicknessButton addTarget:self action:@selector(clickSicknessAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultGaryViewColor;
    [self addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(-50);
    }];
    
    
    UILabel *bottomTitleLabel = [[UILabel alloc] init];
    bottomTitleLabel.text = @"按科室查疾病";
    bottomTitleLabel.font = HM18;
    bottomTitleLabel.textColor = kDefaultBlackTextColor;
    [self addSubview:bottomTitleLabel];
    
    [bottomTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(25);
    }];
    
}

- (void)clickSicknessAction:(UIButton *)sender {
    
    NSLog(@"%@", sender.currentTitle);
    
    if ([self.delegate respondsToSelector:@selector(finishSearchKeyWithText:)]) {
        [self.delegate finishSearchKeyWithText:sender.currentTitle];
    }
    

    
}


@end

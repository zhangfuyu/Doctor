//
//  GHSearchHearView.m
//  掌上优医
//
//  Created by apple on 2019/10/28.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHSearchHearView.h"

@interface GHSearchHearView ()

/**
 <#Description#>
 */
@property (nonatomic, strong) NSArray *titleArray;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation GHSearchHearView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithTitleArray:(NSArray *)titleArray {
    
    if (self = [super init]) {
        self.titleArray = titleArray;
        self.buttonArray = [NSMutableArray arrayWithCapacity:0];
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    for (NSInteger index = 0; index < self.titleArray.count; index++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.titleLabel.font = H16;
        
        
        button.tag = index;
        
        button.backgroundColor = [UIColor whiteColor];
        
        [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [button setTitle:ISNIL([self.titleArray objectOrNilAtIndex:index]) forState:UIControlStateNormal];
        
        if (button.currentTitle.length == 4 && self.titleArray.count > 2) {
            button.titleLabel.font = H14;
        }
        
        button.layer.cornerRadius = 4;
        button.layer.masksToBounds = true;
        
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.height.mas_equalTo(28);
            
            if (self.titleArray.count == 2) {
                make.width.mas_equalTo(80);
                make.left.mas_equalTo((((SCREENWIDTH - 32) / self.titleArray.count) * (index + 0.5)) - 40 + 16);
            } else {
                make.width.mas_equalTo(64);
                make.left.mas_equalTo((((SCREENWIDTH - 32) / self.titleArray.count) * (index + 0.5)) - 32 + 16);
            }
            

            make.centerY.mas_equalTo(self).offset(-1);
            
            
        }];
        
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.buttonArray addObject:button];
        
    }
    
    [self clickAction:[self.buttonArray firstObject]];
    
}

- (void)clickAction:(UIButton *)sender {
    
    for (NSInteger index = 0; index < self.titleArray.count; index++) {
        
        UIButton *button = [self.buttonArray objectOrNilAtIndex:index];
        
        button.backgroundColor = [UIColor whiteColor];
        
        button.selected = false;
        
    }
    
    sender.backgroundColor = kDefaultBlueColor;
    sender.selected = true;
    
    if (self.clickTypeBlock) {
        self.clickTypeBlock(sender.tag);
    }
    
}
- (void)setSelectBtnTag:(NSInteger)selectBtnTag
{
    _selectBtnTag = selectBtnTag;
    
    for (NSInteger index = 0; index < self.titleArray.count; index++) {
           
           UIButton *button = [self.buttonArray objectOrNilAtIndex:index];
           
           button.backgroundColor = [UIColor whiteColor];
           
           button.selected = false;
        if (index == selectBtnTag) {
             button.backgroundColor = kDefaultBlueColor;
                   
             button.selected = true;
        }
           
     
    }
}
@end

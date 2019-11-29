//
//  CBTKeyboardCollectionViewCell.m
//  chebutou
//
//  Created by chebutou on 2017/12/19.
//  Copyright © 2017年 chebutou. All rights reserved.
//

#import "CBTKeyboardCollectionViewCell.h"
#import "UIButton+touch.h"

@implementation CBTKeyboardCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.contentView.layer.borderColor = kDefaultGaryViewColor.CGColor;
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.cornerRadius = 5;
    self.contentView.clipsToBounds = true;
    [self keyboardBtn];
}

- (UIButton *)keyboardBtn
{
    if (!_keyboardBtn)
    {
        _keyboardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _keyboardBtn.isIgnore = true;
        
//        [_keyboardBtn setBackgroundImage:[UIImage imageNamed:@"keyboard_key"] forState:UIControlStateNormal];
        [_keyboardBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
//        [_keyboardBtn setBackgroundImage:[UIImage imageNamed:@"orange_bg"] forState:UIControlStateHighlighted];
        [_keyboardBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
//        [_keyboardBtn setBackgroundImage:[UIImage imageNamed:@"orange_bg"] forState:UIControlStateSelected];
        [_keyboardBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [_keyboardBtn addTarget:self action:@selector(KeyboardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_keyboardBtn];
        _keyboardBtn.frame = self.contentView.bounds;
    }
    return _keyboardBtn;
}

- (void)KeyboardBtnClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(KeyBoardCellBtnClick:)])
    {
        [self.delegate KeyBoardCellBtnClick:self.tag - 100];
    }
    
    sender.selected = true;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.selected = false;
    });
}

- (void)setModel:(CBTKeyboardModel *)model
{
    if (_model != model)
    {
        _model = model;
        
        if(!model.isUpper && self.tag > 9 + 100)
        {
            NSString * string = [model.key lowercaseString];
            
            [self.keyboardBtn setTitle:string forState:UIControlStateNormal];
        }
        else
        {
            [self.keyboardBtn setTitle:model.key forState:UIControlStateNormal];
        }
    }
}

@end

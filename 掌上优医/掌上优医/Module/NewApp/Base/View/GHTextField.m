//
//  GHTextField.m
//  掌上优医
//
//  Created by GH on 2018/10/25.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHTextField.h"

@interface GHTextField ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *leftSpaceView;

@property (nonatomic, strong) UIView *rightSpaceView;

@end

@implementation GHTextField

- (UIView *)leftSpaceView{
    
    if (!_leftSpaceView) {
        _leftSpaceView = [[UIView alloc] init];
    }
    return _leftSpaceView;
    
}

- (UIView *)rightSpaceView{
    
    if (!_rightSpaceView) {
        _rightSpaceView = [[UIView alloc] init];
    }
    return _rightSpaceView;
    
}

- (void)setMaxInputDigit:(NSUInteger)maxInputDigit{
    
    _maxInputDigit = maxInputDigit;
    
    if (maxInputDigit > 0) {
        [self setupMaxInputDigit];
    }
    
}


- (void)setupMaxInputDigit{
    
    self.delegate = self;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (string.length > 0) {    //如果 string 为@"",那么选择的删除
        
        if (textField.text.length == self.maxInputDigit) {
            return NO;
        }
        
    }
    
    return YES;
    
}


- (void)setEndEditingDigit:(NSUInteger)endEditingDigit{
    
    _endEditingDigit = endEditingDigit;
    
    if (endEditingDigit > 0) {
        [self addTarget:self  action:@selector(textFieldEndEditing:) forControlEvents:UIControlEventEditingChanged];
    }
    
}

- (void)textFieldEndEditing:(UITextField *)textField{
    
    if (textField.text.length == self.endEditingDigit) {
        [self resignFirstResponder];
    }
    
}

- (void)setLeftSpace:(CGFloat)leftSpace{
    _leftSpace = leftSpace;
    
    if (leftSpace > 0) {
        self.leftSpaceView.frame = CGRectMake(0, 0, leftSpace, 1);
        self.leftView = self.leftSpaceView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }else{
        self.leftViewMode = UITextFieldViewModeNever;
    }
    
}

- (void)setRightSpace:(CGFloat)rightSpace{
    _rightSpace = rightSpace;
    
    if (rightSpace > 0) {
        self.rightSpaceView.frame = CGRectMake(0, 0, rightSpace, 1);
        self.rightView = self.rightSpaceView;
        self.rightViewMode = UITextFieldViewModeAlways;
    }else{
        self.rightViewMode = UITextFieldViewModeNever;
    }
    
}

@end

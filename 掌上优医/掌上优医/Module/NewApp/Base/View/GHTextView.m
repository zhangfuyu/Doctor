//
//  GHTextView.m
//  掌上优医
//
//  Created by GH on 2018/11/6.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHTextView.h"

@interface GHTextView () <UITextViewDelegate>

@property (nonatomic, copy) NSString *tempPlaceHolder;

@end

@implementation GHTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholderColor = [UIColor lightGrayColor];
        self.placeholder = @"请输入内容";
        self.delegate = self;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    
    [self.placeholder drawInRect:CGRectMake(6, 8, self.frame.size.width - 12 , self.frame.size.height - 14) withAttributes:attrs];
}

// 布局子控件的时候需要重绘
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
    
}
// 设置属性的时候需要重绘，所以需要重写相关属性的set方法
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    if (placeholder.length) {
        self.tempPlaceHolder = placeholder;
    }
    [self setNeedsDisplay];
    
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
    
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    if (text.length) { // 因为是在文本改变的代理方法中判断是否显示placeholder，而通过代码设置text的方式又不会调用文本改变的代理方法，所以再此根据text是否不为空判断是否显示placeholder。
        self.placeholder = @"";
    }
    [self setNeedsDisplay];
    
    // 手动模拟触发通知
    NSNotification *notification = [NSNotification notificationWithName:UITextViewTextDidChangeNotification object:self];
    
    [self textViewChanged:notification];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    if (attributedText.length) {
        self.placeholder = @"";
    }
    [self setNeedsDisplay];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}

- (void)setMaxLength:(NSUInteger)maxLength {
    
    _maxLength = maxLength;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChanged:) name:UITextViewTextDidChangeNotification object:self];
    
}

#pragma mark - NSNotification
- (void)textViewChanged:(NSNotification *)notification
{
    // 通知回调的实例的不是当前实例的话直接返回
    if (notification.object != self) return;
    
    
//    // 禁止第一个字符输入空格或者换行
//    if (self.text.length == 1) {
//
//        if ([self.text isEqualToString:@" "] || [self.text isEqualToString:@"\n"]) {
//
//            self.text = @"";
//        }
//    }
    
    // 只有当maxLength字段的值不为无穷大整型也不为0时才计算限制字符数.
    if (_maxLength != NSUIntegerMax && _maxLength != 0 && self.text.length > 0) {
        
        if (!self.markedTextRange && self.text.length > _maxLength) {
            
            self.text = [self.text substringToIndex:_maxLength]; // 截取最大限制字符数.
            [self.undoManager removeAllActions]; // 达到最大字符数后清空所有 undoaction, 以免 undo 操作造成crash.
        }
    }
    
}

- (void)textViewDidChange:(UITextView *)textView {

    if (((GHTextView *)textView).hasText) { // textView.text.length
        ((GHTextView *)textView).placeholder = @"";
    } else {
        ((GHTextView *)textView).placeholder = ISNIL(self.tempPlaceHolder);
    }
    
}


@end


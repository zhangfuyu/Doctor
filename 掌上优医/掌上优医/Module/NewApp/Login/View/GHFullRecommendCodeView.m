//
//  GHFullRecommendCodeView.m
//  掌上优医
//
//  Created by GH on 2019/2/19.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHFullRecommendCodeView.h"

#import "GHTextField.h"

#import "CBTKeyboardView.h"

static const NSUInteger MaxCount = 6;

@interface GHFullRecommendCodeView ()<UITextFieldDelegate>

/**
 
 */
@property (nonatomic, strong) NSMutableArray *dotLabelArray;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *textFieldArray;



/**
 <#Description#>
 */
@property (nonatomic, assign) NSUInteger index;

@end

@implementation GHFullRecommendCodeView

- (NSMutableArray *)textFieldArray {
    
    if (!_textFieldArray) {
        _textFieldArray = [[NSMutableArray alloc] init];
    }
    return _textFieldArray;
    
}

- (instancetype)init {
    
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickClearAction) name:@"kNotificationRecommendCodeClear" object:nil];
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    for (NSInteger index = 0; index < MaxCount; index++) {
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = kDefaultLineViewColor;
        lineLabel.layer.cornerRadius = 2.5;
        lineLabel.layer.masksToBounds = true;
        [self addSubview:lineLabel];
        
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo((SCREENWIDTH - 32 - 42 - 12 * (MaxCount - 1)) / MaxCount);
            make.height.mas_equalTo(5);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(((SCREENWIDTH - 32 - 42 - 12 * (MaxCount - 1)) / MaxCount + 12) * index);
        }];
        
//        UILabel *dotLabel = [[UILabel alloc] init];
//        dotLabel.backgroundColor = kDefaultLineViewColor;
//        dotLabel.layer.cornerRadius = 7;
//        dotLabel.layer.masksToBounds = true;
//        [self addSubview:dotLabel];
//
//        [dotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.height.mas_equalTo(14);
//            make.centerX.mas_equalTo(lineLabel);
//            make.centerY.mas_equalTo(self).offset(-5);
//        }];
//
//        [self.dotLabelArray addObject:dotLabel];
        
        UITextField *textField = [[UITextField alloc] init];
        textField.textAlignment = NSTextAlignmentCenter;
        textField.font = HScaleFont(35);
        textField.textColor = kDefaultBlackTextColor;
        textField.placeholder = @"•";

        textField.keyboardType = UIKeyboardTypeASCIICapable;
        textField.tag = index + 100;
        textField.delegate = self;
        [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
        [self addSubview:textField];
        
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(lineLabel.mas_top);
            make.left.right.mas_equalTo(lineLabel);
        }];
        
        CBTKeyboardView * KBView = [[CBTKeyboardView alloc] init];
        
        textField.inputView = KBView;
        KBView.inputSource = textField;
        
        
        
        switch (index) {
            case 0:
                self.textfield01 = textField;
                break;
            case 1:
                self.textfield02 = textField;
                break;
            case 2:
                self.textfield03 = textField;
                break;
            case 3:
                self.textfield04 = textField;
                break;
            case 4:
                self.textfield05 = textField;
                break;
            case 5:
                self.textfield06 = textField;
                break;
                
            default:
                break;
        }
        
        [self.textFieldArray addObject:textField];
        
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (string.length == 1 && self.index == 0) {
        _textfield01.text = string;
        self.index = [self forinArr:1];
        return NO;
    }else if(string.length == 1 && self.index == 1){
        _textfield02.text = [string uppercaseString];
        self.index = [self forinArr:2];
        return NO;
    }else if(string.length == 1 && self.index == 2){
        _textfield03.text = [string uppercaseString];
        self.index = [self forinArr:3];
        return NO;
    }else if(string.length == 1 && self.index == 3){
        _textfield04.text = [string uppercaseString];
        self.index = [self forinArr:4];
        return NO;
    }else if(string.length == 1 && self.index == 4){
        _textfield05.text = [string uppercaseString];
        self.index = [self forinArr:5];
        return NO;
    }else if(string.length == 1 && self.index == 5){
        _textfield06.text = [string uppercaseString];
        self.index = [self forinArr:6];
        return NO;
    }
    return YES;
    
}

- (void)clickClearAction {
    
    if (self.textfield06.isFirstResponder) {
        
        if (self.textfield06.text.length) {
            self.textfield06.text = @"";
        } else {
            
            if (self.textfield05.text.length) {
                self.textfield05.text = @"";
            }
            
            [self.textfield05 becomeFirstResponder];
            
        }
        
    } else if (self.textfield05.isFirstResponder) {
        
        if (self.textfield05.text.length) {
            self.textfield05.text = @"";
        } else {
            
            if (self.textfield04.text.length) {
                self.textfield04.text = @"";
            }
            
            [self.textfield04 becomeFirstResponder];
            
        }
        
    } else if (self.textfield04.isFirstResponder) {
        
        if (self.textfield04.text.length) {
            self.textfield04.text = @"";
        } else {
            
            if (self.textfield03.text.length) {
                self.textfield03.text = @"";
            }
            
            [self.textfield03 becomeFirstResponder];
            
        }
        
    } else if (self.textfield03.isFirstResponder) {
        
        if (self.textfield03.text.length) {
            self.textfield03.text = @"";
        } else {
            
            if (self.textfield02.text.length) {
                self.textfield02.text = @"";
            }
            
            [self.textfield02 becomeFirstResponder];
            
        }
        
    } else if (self.textfield02.isFirstResponder) {
        
        if (self.textfield02.text.length) {
            self.textfield02.text = @"";
        } else {
            
            if (self.textfield01.text.length) {
                self.textfield01.text = @"";
            }
            
            [self.textfield01 becomeFirstResponder];
            
        }
        
    } else if (self.textfield01.isFirstResponder) {
        
        if (self.textfield01.text.length) {
            self.textfield01.text = @"";
        } else {
            
            if (self.textfield06.text.length) {
                self.textfield06.text = @"";
            }
            
            [self.textfield06 becomeFirstResponder];
            
        }
        
    }
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    if (textField.tag == 100) {
        
    } else {
        
        if (textField.text.length == 0) {
            UITextField *lastTextField = [self.textFieldArray objectOrNilAtIndex:textField.tag - 100];
            [lastTextField becomeFirstResponder];
            return NO;
        }
    
    }
    
    return YES;
    
}

- (NSInteger)forinArr:(NSInteger )j{
    NSInteger k = 0;
    BOOL isChang = NO;
    for (NSInteger i = j; i < self.textFieldArray.count; i++) {
        if([self.textFieldArray[i] text].length == 0)
        {
            if (i == 0) {
                break;
            }
            k = i;
            [self.textFieldArray[i] becomeFirstResponder];
            NSLog(@"%lu",k);
            isChang = YES;
            break;
        };
    }
    if (!isChang) {
        for (NSInteger i = 0; i < self.textFieldArray.count; i++) {
            if (i == 0) {
                break;
            }
            if([self.textFieldArray[i] text].length == 0)
            {
                k = i;
                [self.textFieldArray[i] becomeFirstResponder];
                NSLog(@"%lu",[self.textFieldArray[i] text].length);
                isChang = YES;
                break;
            };
        }
    }
    NSLog(@"%ld",(long)k);
    if (!isChang) {
        [self endEditing:YES];
        return 7;
    }else
        return k;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.index = textField.tag - 100;
    NSLog(@"%ld",(long)textField.tag);
    textField.text = @"";
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (NSString *)getFullRecommendCode {
    
    if (self.textfield01.text.length != 1 ||
        self.textfield02.text.length != 1 ||
        self.textfield03.text.length != 1 ||
        self.textfield04.text.length != 1 ||
        self.textfield05.text.length != 1 ||
        self.textfield06.text.length != 1) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的邀请码"];
        return @"";
    }
    
    NSMutableString *str = [[NSMutableString alloc] init];
    
    for (UITextField *textField in self.textFieldArray) {
        [str appendString:ISNIL(textField.text)];
    }
    
    return [str copy];
    
}


@end

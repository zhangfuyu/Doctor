//
//  GHHospitalDetailInfoErrorAddPhoneView.m
//  掌上优医
//
//  Created by GH on 2019/5/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHospitalDetailInfoErrorAddPhoneView.h"
#import "GHTextField.h"

@interface GHHospitalDetailInfoErrorAddPhoneView () <UITextFieldDelegate>

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *phoneArray;

@property (nonatomic, strong) NSMutableArray *textFieldArray;

@property (nonatomic, strong) NSMutableArray *lineLabelArray;

@end

@implementation GHHospitalDetailInfoErrorAddPhoneView

- (NSMutableArray *)phoneArray {
    
    if (!_phoneArray) {
        _phoneArray = [[NSMutableArray alloc] init];
    }
    return _phoneArray;
    
}

- (NSMutableArray *)textFieldArray {
    
    if (!_textFieldArray) {
        _textFieldArray = [[NSMutableArray alloc] init];
    }
    return _textFieldArray;
    
}

- (NSMutableArray *)lineLabelArray {
    
    if (!_lineLabelArray) {
        _lineLabelArray = [[NSMutableArray alloc] init];
    }
    return _lineLabelArray;
    
}

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitleColor:kDefaultBlueColor forState:UIControlStateNormal];
    [addButton setTitle:@"添加医院电话" forState:UIControlStateNormal];
    addButton.titleLabel.font = H15;
    [addButton setImage:[UIImage imageNamed:@"ic_yiyuanbaocuo_tianjia"] forState:UIControlStateNormal];
    [self addSubview:addButton];
    
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(48);
    }];
    
    [addButton addTarget:self action:@selector(clickAddPhoneAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickAddPhoneAction {
    
    NSLog(@"加一个电话");
    
    [self.phoneArray addObject:@""];
    
    [self updateUI];
    
}

- (void)setupPhoneArray:(NSArray *)array {
    
    [self.phoneArray addObjectsFromArray:array];
    
    [self updateUI];
    
}

- (void)updateUI {
    
    
    for (NSInteger index = 0; index < self.phoneArray.count; index++) {
        
        GHTextField *textField = [self.textFieldArray objectOrNilAtIndex:index];
        
        if (textField != nil) {
            
            textField.tag = index;
            
            [textField mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(0);
                make.left.mas_equalTo(2);
                make.height.mas_equalTo(50);
                make.top.mas_equalTo(index * 60 + 10);
            }];
            
            continue;
        }
        
        textField = [[GHTextField alloc] init];
        textField.backgroundColor = [UIColor whiteColor];
        textField.returnKeyType = UIReturnKeyDone;
        textField.font = H16;
        textField.keyboardType = UIKeyboardTypePhonePad;
        textField.textColor = kDefaultBlackTextColor;
        textField.placeholder = @"请输入医院电话";
        textField.text = ISNIL([self.phoneArray objectOrNilAtIndex:index]);
        textField.clearButtonMode = UITextFieldViewModeAlways;
        textField.tag = index;
        textField.delegate = self;
        
        [self addSubview:textField];
        
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(2);
            make.height.mas_equalTo(50);
            make.top.mas_equalTo(index * 60 + 10);
        }];
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = kDefaultLineViewColor;
        [self addSubview:lineLabel];
        
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(textField);
        }];
        
        [self.textFieldArray addObject:textField];
        [self.lineLabelArray addObject:lineLabel];
        
    }
    
    if ([self.delegate respondsToSelector:@selector(updateAddPhoneViewWithHeight:)]) {
        
        if (self.phoneArray.count == 0) {
            [self.delegate updateAddPhoneViewWithHeight:60];
        } else {
            [self.delegate updateAddPhoneViewWithHeight:(48 + self.phoneArray.count * 60)];
        }
        
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(108);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(0);
        if (self.phoneArray.count == 0) {
            if (self.isAdd) {
                make.height.mas_equalTo(60);
            } else {
                make.height.mas_equalTo(60);
            }
            
        } else {
            make.height.mas_equalTo(48 + self.phoneArray.count * 60);
        }
        
    }];
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    GHTextField *textF = [self.textFieldArray objectOrNilAtIndex:textField.tag];
    UILabel *lineLabel = [self.lineLabelArray objectOrNilAtIndex:textField.tag];
    
    [self.textFieldArray removeObject:textF];
    [self.lineLabelArray removeObject:lineLabel];
    
    if (self.phoneArray.count > textField.tag) {
        [self.phoneArray removeObjectAtIndex:textField.tag];
    }
    
    
    [textF removeFromSuperview];
    [lineLabel removeFromSuperview];
    
    [self updateUI];
    
    return true;
    
}

- (void)endAllEditing {
    
    for (UITextField *textField in self.textFieldArray) {
        [textField resignFirstResponder];
    }
    
}

- (NSString *)getContactNumberString {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (UITextField *textField in self.textFieldArray) {
        
        if (textField.text.length > 0) {
            [array addObject:textField.text];
        }
        
    }
    
    return [array componentsJoinedByString:@","];
    
}

@end

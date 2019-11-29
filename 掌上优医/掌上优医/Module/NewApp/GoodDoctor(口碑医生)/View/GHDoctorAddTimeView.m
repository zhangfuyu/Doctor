//
//  GHDoctorAddTimeView.m
//  掌上优医
//
//  Created by GH on 2019/5/24.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHDoctorAddTimeView.h"
#import "GHTextField.h"
#import "GHDoctorTimeChooseView.h"

@interface GHDoctorAddTimeView () <UITextFieldDelegate, GHDoctorTimeChooseViewDelegate>

@property (nonatomic, strong) NSMutableArray *timeArray;

@property (nonatomic, strong) NSMutableArray *textFieldArray;

@property (nonatomic, strong) NSMutableArray *lineLabelArray;

@property (nonatomic, strong) GHDoctorTimeChooseView *timeView;

@end

@implementation GHDoctorAddTimeView

- (GHDoctorTimeChooseView *)timeView {
    
    if (!_timeView) {
        _timeView = [[GHDoctorTimeChooseView alloc] init];
        _timeView.delegate = self;
        [self.viewController.view addSubview:_timeView];
        
        [_timeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _timeView;
    
}

- (NSMutableArray *)timeArray {
    
    if (!_timeArray) {
        _timeArray = [[NSMutableArray alloc] init];
    }
    return _timeArray;
    
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
    [addButton setTitle:@" 添加出诊时间" forState:UIControlStateNormal];
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
    
    NSLog(@"加一个时间");
    
    self.timeView.hidden = false;
    
    
}

- (void)chooseTimeFinishWithTime:(NSString *)time {
    
    if (time.length > 2) {
        
        NSString *qian = [time substringToIndex:2];
        
        BOOL isHave = false;
        
        for (NSInteger index = 0; index < self.timeArray.count; index ++) {
            
            NSString *title = [self.timeArray objectOrNilAtIndex:index];
            
            if ([title hasPrefix:qian]) {
                
                GHTextField *textField = [self.textFieldArray objectOrNilAtIndex:index];
                
                textField.text = ISNIL(time);
                
                isHave = true;
                
                break;
            }
            
        }
        
        if (isHave == false) {
            
            [self.timeArray addObject:time];
            [self updateUI];
            
        }
        

        
    }
    
}

- (void)setupTimeArray:(NSArray *)array {
    
    [self.timeArray addObjectsFromArray:array];
    
    [self updateUI];
    
}

- (void)updateUI {
    
    
    for (NSInteger index = 0; index < self.timeArray.count; index++) {
        
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
        textField.text = ISNIL([self.timeArray objectOrNilAtIndex:index]);
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
    
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(108);
        make.right.mas_equalTo(-16);
        
        if (self.isAdd) {
            make.top.mas_equalTo(147);
        } else {
            make.top.mas_equalTo(313);
        }
        
        
        if (self.timeArray.count == 0) {
            make.height.mas_equalTo(60);
        } else {
            make.height.mas_equalTo(48 + self.timeArray.count * 60);
        }
        
    }];
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    GHTextField *textF = [self.textFieldArray objectOrNilAtIndex:textField.tag];
    UILabel *lineLabel = [self.lineLabelArray objectOrNilAtIndex:textField.tag];
    
    [self.textFieldArray removeObject:textF];
    [self.lineLabelArray removeObject:lineLabel];
    
    if (self.timeArray.count > textField.tag) {
        [self.timeArray removeObjectAtIndex:textField.tag];
    }
    
    
    
    [textF removeFromSuperview];
    [lineLabel removeFromSuperview];
    
    [self updateUI];
    
    return true;
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"这里返回为NO。则为禁止编辑");
    return NO;
}

- (void)endAllEditing {
    
    for (UITextField *textField in self.textFieldArray) {
        [textField resignFirstResponder];
    }
    
}

- (NSString *)getTimeString {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (UITextField *textField in self.textFieldArray) {
        
        if (textField.text.length > 0) {
            [array addObject:textField.text];
        }
        
    }
    
    return [array componentsJoinedByString:@","];
    
}

@end

//
//  GHDoctorTimeChooseView.m
//  掌上优医
//
//  Created by GH on 2019/5/24.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHDoctorTimeChooseView.h"
#import "UIButton+touch.h"

@interface GHDoctorTimeChooseView ()

@property (nonatomic, strong) NSMutableArray *dayButtonArray;

@property (nonatomic, strong) NSMutableArray *timeButtonArray;

@end

@implementation GHDoctorTimeChooseView

- (NSMutableArray *)dayButtonArray {
    
    if (!_dayButtonArray) {
        _dayButtonArray = [[NSMutableArray alloc] init];
    }
    return _dayButtonArray;
    
}

- (NSMutableArray *)timeButtonArray {
    
    if (!_timeButtonArray) {
        _timeButtonArray = [[NSMutableArray alloc] init];
    }
    return _timeButtonArray;
    
}

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.backgroundColor = RGBACOLOR(51, 51, 51, 0.1);
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.cornerRadius = 4;
    bottomView.layer.masksToBounds = true;
    [self addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(10);
        make.height.mas_equalTo((330 - kBottomSafeSpace));
    }];
    
    UIButton *contentView = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addTarget:self action:@selector(clickNoneAction) forControlEvents:UIControlEventTouchUpInside];
    contentView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.titleLabel.font = H16;
    [cancelButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [bottomView addSubview:cancelButton];
    
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.height.mas_equalTo(56);
        make.width.mas_equalTo(83);
    }];
    [cancelButton addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.titleLabel.font = H16;
    [confirmButton setTitleColor: kDefaultBlueColor forState:UIControlStateNormal];
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [bottomView addSubview:confirmButton];
    
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.height.mas_equalTo(56);
        make.width.mas_equalTo(83);
    }];
    
    [confirmButton addTarget:self action:@selector(clickConfirmAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [bottomView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(6);
        make.right.mas_equalTo(-6);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(56);
    }];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = HB18;
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"出诊时间";
    [bottomView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cancelButton.mas_right);
        make.right.mas_equalTo(confirmButton.mas_left);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(56);
    }];
    
    NSArray *dayArray = @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    NSArray *timeArray = @[@"上午", @"下午", @"全天"];
    
    NSArray *titleArray = @[@"出诊日", @"出诊时间"];
    NSArray *dataArray = @[dayArray, timeArray];
    
    
    for (NSInteger index = 0; index < dataArray.count; index++) {
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = H15;
        titleLabel.textColor = kDefaultBlackTextColor;
        titleLabel.text = [titleArray objectOrNilAtIndex:index];
        [bottomView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(17);
        }];
        
        NSArray *array = [dataArray objectOrNilAtIndex:index];
        
        for (NSInteger indexY = 0; indexY < array.count; indexY++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
            [button setTitleColor:kDefaultBlueColor forState:UIControlStateSelected];
            [button setTitle:ISNIL([array objectOrNilAtIndex:indexY]) forState:UIControlStateNormal];
            
            
            button.titleLabel.font = H14;
            button.layer.cornerRadius = 5;
            button.layer.masksToBounds = true;
            button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
            button.backgroundColor = [UIColor whiteColor];
            button.layer.borderWidth = 0.5;
            button.isIgnore = true;
            
            [button setBackgroundColor:[UIColor clearColor]];
            
            [bottomView addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(27);
                make.width.mas_equalTo((SCREENWIDTH - 40 - 30) / 4);
                make.left.mas_equalTo(20 + (indexY % 4) * ((SCREENWIDTH - 40 - 30) / 4 + 10));
                make.top.mas_equalTo(titleLabel.mas_bottom).offset((indexY / 4) * (27 + 10) + 20);
                
            }];
            
            if (index == 0) {
                
                button.tag = indexY;
                [self.dayButtonArray addObject:button];
                
            } else if (index == 1) {
                
                button.tag = 10 + indexY;
                [self.timeButtonArray addObject:button];
                
            }
            
            [button addTarget:self action:@selector(clickTagAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        if (index == 0) {
            
            [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(80);
            }];
            
        } else if (index == 1) {
            
            [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(210);
            }];
            
        }
        
    }
    
    
    
    UIButton *tapView = [UIButton buttonWithType:UIButtonTypeCustom];
    tapView.backgroundColor = [UIColor clearColor];
    [tapView addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tapView];
    
    [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(bottomView.mas_top);
    }];
    
}

- (void)clickTagAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        sender.layer.borderColor = kDefaultBlueColor.CGColor;
        sender.backgroundColor = UIColorHex(0xEFF0FD);
        
    } else {
        sender.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
        sender.backgroundColor = [UIColor whiteColor];
    }
    
    NSArray *buttonArray;
    
    if (sender.tag < 10) {
        
        buttonArray = self.dayButtonArray;
        
    } else if (sender.tag < 100) {
        
        buttonArray = self.timeButtonArray;
        
    }
    
    
    for (UIButton *button in buttonArray) {
        
        if (button == sender) {
            continue;
        }
        
        button.selected = false;
        button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
        button.backgroundColor = [UIColor whiteColor];
        
    }
    
}


- (void)clickConfirmAction {
    
    
    
    NSString *day;
    
    NSString *time;
    
    for (UIButton *button in self.dayButtonArray) {
        
        if (button.selected) {
            day = button.currentTitle;
        }
        
    }
    
    for (UIButton *button in self.timeButtonArray) {
        
        if (button.selected) {
            time = button.currentTitle;
        }
        
    }
    
    if (day.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择出诊日"];
        return;
    }
    
    if (time.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择出诊时间"];
        return;
    }
    
    self.hidden = true;
    
    if ([self.delegate respondsToSelector:@selector(chooseTimeFinishWithTime:)]) {
        [self.delegate chooseTimeFinishWithTime:[NSString stringWithFormat:@"%@(%@)", day, time]];
    }
    
}

/**
 只是为了不做任何响应
 */
- (void)clickNoneAction {
    
}

- (void)clickCancelAction {
    
    self.hidden = true;
    
}


@end

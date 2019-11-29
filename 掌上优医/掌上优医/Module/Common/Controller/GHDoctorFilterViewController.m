//
//  GHDoctorFilterViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/26.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHDoctorFilterViewController.h"
#import "UIButton+touch.h"

@interface GHDoctorFilterViewController ()

@property (nonatomic, strong) NSMutableArray *positionButtonArray;

@property (nonatomic, strong) NSMutableArray *positionArray;

@property (nonatomic, strong) NSMutableArray *typeButtonArray;

@property (nonatomic, strong) NSMutableArray *typeArray;

@property (nonatomic, strong) NSMutableArray *levelButtonArray;

@property (nonatomic, strong) NSMutableArray *levelArray;

@end

@implementation GHDoctorFilterViewController

- (NSMutableArray *)positionArray {
    
    if (!_positionArray) {
        _positionArray = [[NSMutableArray alloc] init];
    }
    return _positionArray;
    
}

- (NSMutableArray *)positionButtonArray {
    
    if (!_positionButtonArray) {
        _positionButtonArray = [[NSMutableArray alloc] init];
    }
    return _positionButtonArray;
    
}

- (NSMutableArray *)typeArray {
    
    if (!_typeArray) {
        _typeArray = [[NSMutableArray alloc] init];
    }
    return _typeArray;
    
}

- (NSMutableArray *)typeButtonArray {
    
    if (!_typeButtonArray) {
        _typeButtonArray = [[NSMutableArray alloc] init];
    }
    return _typeButtonArray;
    
}

- (NSMutableArray *)levelArray {
    
    if (!_levelArray) {
        _levelArray = [[NSMutableArray alloc] init];
    }
    return _levelArray;
    
}

- (NSMutableArray *)levelButtonArray {
    
    if (!_levelButtonArray) {
        _levelButtonArray = [[NSMutableArray alloc] init];
    }
    return _levelButtonArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self.positionArray addObjectsFromArray:@[@"主任医师", @"副主任医师", @"主治医师", @"住院医师", @"普通医师"]];
    
    [self.positionArray addObjectsFromArray:@[@"主任医师", @"副主任医师", @"主治医师", @"医师"]];
    
    [self.typeArray addObjectsFromArray:@[@"中医", @"西医", @"中西医结合"]];
    
    [self.levelArray addObjectsFromArray:@[@"一级/诊所", @"二级", @"三级"]];
    
    [self setupUI];
    

    
}

- (void)setupUI {
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = H15;
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.text = @"医生职称";
    [self.view addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(16);
    }];
    
    for (NSInteger index = 0; index < self.positionArray.count; index++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
        [button setTitleColor:kDefaultBlueColor forState:UIControlStateSelected];
        [button setTitle:ISNIL([self.positionArray objectOrNilAtIndex:index]) forState:UIControlStateNormal];
        
        
        button.titleLabel.font = H14;
        button.tag = index + 1;
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = true;
        button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderWidth = 0.5;
        button.isIgnore = true;
        
        [button setBackgroundColor:[UIColor clearColor]];
        
        
        
        [self.view addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(32);
            make.width.mas_equalTo((SCREENWIDTH - 20 - 20) / 3);
            make.left.mas_equalTo(10 + (index % 3) * ((SCREENWIDTH - 20 - 20) / 3 + 10));
            make.top.mas_equalTo(titleLabel.mas_bottom).offset((index / 3) * (32 + 12) + 12);
            
        }];
        
        [self.positionButtonArray addObject:button];
        
        [button addTarget:self action:@selector(clickTagAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    
    
    
    UILabel *titleLabel2 = [[UILabel alloc] init];
    titleLabel2.font = H15;
    titleLabel2.textColor = kDefaultBlackTextColor;
    titleLabel2.text = @"医生类型";
    [self.view addSubview:titleLabel2];
    
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(137);
    }];
    
    
    for (NSInteger index = 0; index < self.typeArray.count; index++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
        [button setTitleColor:kDefaultBlueColor forState:UIControlStateSelected];
        [button setTitle:ISNIL([self.typeArray objectOrNilAtIndex:index]) forState:UIControlStateNormal];
        
        
        button.titleLabel.font = H14;
        button.tag = index + 10;
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = true;
        button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderWidth = 0.5;
        button.isIgnore = true;
        
        [button setBackgroundColor:[UIColor clearColor]];
        
        
        
        [self.view addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(32);
            make.width.mas_equalTo((SCREENWIDTH - 20 - 20) / 3);
            make.left.mas_equalTo(10 + (index % 3) * ((SCREENWIDTH - 20 - 20) / 3 + 10));
            make.top.mas_equalTo(titleLabel2.mas_bottom).offset((index / 3) * (32 + 12) + 12);
            
        }];
        
        [self.typeButtonArray addObject:button];
        
        [button addTarget:self action:@selector(clickTagAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    UILabel *titleLabel3 = [[UILabel alloc] init];
    titleLabel3.font = H15;
    titleLabel3.textColor = kDefaultBlackTextColor;
    titleLabel3.text = @"医院等级";
    [self.view addSubview:titleLabel3];
    
    [titleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(222);
    }];
    
    
    for (NSInteger index = 0; index < self.levelArray.count; index++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
        [button setTitleColor:kDefaultBlueColor forState:UIControlStateSelected];
        [button setTitle:ISNIL([self.levelArray objectOrNilAtIndex:index]) forState:UIControlStateNormal];
        
        
        button.titleLabel.font = H14;
        button.tag = index + 100;
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = true;
        button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderWidth = 0.5;
        button.isIgnore = true;
        
        [button setBackgroundColor:[UIColor clearColor]];
        
        
        
        [self.view addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(32);
            make.width.mas_equalTo((SCREENWIDTH - 20 - 20) / 3);
            make.left.mas_equalTo(10 + (index % 3) * ((SCREENWIDTH - 20 - 20) / 3 + 10));
            make.top.mas_equalTo(titleLabel3.mas_bottom).offset((index / 3) * (32 + 12) + 12);
            
        }];
        
        [self.levelButtonArray addObject:button];
        
        [button addTarget:self action:@selector(clickTagAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [self.view addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(317);
    }];
    
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    resetButton.titleLabel.font = H14;
    [resetButton setTitle:@"重置" forState:UIControlStateNormal];
    [resetButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    [self.view addSubview:resetButton];
    
    [resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(87);
        make.top.mas_equalTo(lineLabel.mas_bottom);
    }];
    [resetButton addTarget:self action:@selector(clickResetAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    finishButton.titleLabel.font = H14;
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finishButton setBackgroundColor:kDefaultBlueColor];
    finishButton.layer.cornerRadius = 4;
    finishButton.layer.masksToBounds = true;
    [self.view addSubview:finishButton];
    
    [finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(34);
        make.right.mas_equalTo(-16);
        make.width.mas_equalTo(67);
        make.top.mas_equalTo(lineLabel.mas_bottom).offset(8);
    }];
    [finishButton addTarget:self action:@selector(clickFinishAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickResetAction {
    
    for (UIButton *button in self.positionButtonArray) {
        
        button.selected = false;
        button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
        button.backgroundColor = [UIColor whiteColor];
        
    }
    
    for (UIButton *button in self.typeButtonArray) {
        
        button.selected = false;
        button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
        button.backgroundColor = [UIColor whiteColor];
        
    }
    
    for (UIButton *button in self.levelButtonArray) {
        
        button.selected = false;
        button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
        button.backgroundColor = [UIColor whiteColor];
        
    }
    
}

- (void)clickFinishAction {
    
    
    
    NSMutableArray *positionArray = [[NSMutableArray alloc] init];

    for (UIButton *button in self.positionButtonArray) {

        if (button.selected) {
            
            [positionArray addObject:button.currentTitle];

            [MobClick event:@"Filter_Doctor" label:[NSString stringWithFormat:@"医生_%@", ISNIL(button.currentTitle)]];

        }

    }
    
    NSMutableArray *typeArray = [[NSMutableArray alloc] init];
    
    for (UIButton *button in self.typeButtonArray) {
        
        if (button.selected) {
            
            [typeArray addObject:button.currentTitle];
            
            [MobClick event:@"Filter_Doctor" label:[NSString stringWithFormat:@"医生_%@", ISNIL(button.currentTitle)]];
            
        }
        
    }
    
    NSMutableArray *levelArray = [[NSMutableArray alloc] init];
    
    for (UIButton *button in self.levelButtonArray) {
        
        if (button.selected) {
            
            if ([button.currentTitle isEqualToString:@"三级"]) {
                [levelArray addObject:@"3"];
            } else if ([button.currentTitle isEqualToString:@"二级"]) {
                [levelArray addObject:@"2"];
            } else {
                [levelArray addObject:@"1"];
            }
            
//            [levelArray addObject:button.currentTitle];
            
            [MobClick event:@"Filter_Doctor" label:[NSString stringWithFormat:@"医生_%@", ISNIL(button.currentTitle)]];
            
        }
        
    }
    
    if ([self.delegate respondsToSelector:@selector(chooseFinishDoctorPosition:doctorType:hospitalLevel:)]) {
        [self.delegate chooseFinishDoctorPosition:[positionArray componentsJoinedByString:@","] doctorType:[typeArray componentsJoinedByString:@","] hospitalLevel:[levelArray componentsJoinedByString:@","]];
    }
    
//
//    if ([self.delegate respondsToSelector:@selector(chooseFinishDoctorFilter:)]) {
//        [self.delegate chooseFinishDoctorFilter:[titleArray componentsJoinedByString:@","]];
//    }
    
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
    
    //    sender.selected = true;
    //
    //    sender.layer.borderColor = kDefaultBlueColor.CGColor;
    //    sender.backgroundColor = UIColorHex(0xEFF0FD);
    //
    //    self.type = sender.tag;
    
}

@end



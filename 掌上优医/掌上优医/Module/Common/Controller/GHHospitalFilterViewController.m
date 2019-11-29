//
//  GHHospitalFilterViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/26.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHospitalFilterViewController.h"
#import "UIButton+touch.h"

@interface GHHospitalFilterViewController ()

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *levelButtonArray;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *levelDataArray;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *typeButtonArray;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *typeDataArray;

@end

@implementation GHHospitalFilterViewController

- (NSMutableArray *)levelButtonArray {
    
    if (!_levelButtonArray) {
        _levelButtonArray = [[NSMutableArray alloc] init];
    }
    return _levelButtonArray;
    
}

- (NSMutableArray *)levelDataArray {
    
    if (!_levelDataArray) {
        _levelDataArray = [[NSMutableArray alloc] init];
    }
    return _levelDataArray;
    
}

- (NSMutableArray *)typeButtonArray {
    
    if (!_typeButtonArray) {
        _typeButtonArray = [[NSMutableArray alloc] init];
    }
    return _typeButtonArray;
    
}

- (NSMutableArray *)typeDataArray {
    
    if (!_typeDataArray) {
        _typeDataArray = [[NSMutableArray alloc] init];
    }
    return _typeDataArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self.levelDataArray addObjectsFromArray:@[@"三级医院", @"二级医院", @"一级医院"]];
    [self.typeDataArray addObjectsFromArray:@[@"综合医院", @"中医医院", @"中西医结合医院", @"专科医院", @"康复医院", @"民族医院", @"诊所", @"中医诊所", @"西医诊所"]];
    
    [self setupUI];
    
}


- (void)setupUI {
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = H15;
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.text = @"医院等级";
    [self.view addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(16);
    }];
    
    for (NSInteger index = 0; index < self.levelDataArray.count; index++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
        [button setTitleColor:kDefaultBlueColor forState:UIControlStateSelected];
        [button setTitle:ISNIL([self.levelDataArray objectOrNilAtIndex:index]) forState:UIControlStateNormal];
        
        
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
        
        [self.levelButtonArray addObject:button];
        
        [button addTarget:self action:@selector(clickTagAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    UILabel *titleLabel2 = [[UILabel alloc] init];
    titleLabel2.font = H15;
    titleLabel2.textColor = kDefaultBlackTextColor;
    titleLabel2.text = @"医院类型";
    [self.view addSubview:titleLabel2];
    
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(109);
    }];
    
    for (NSInteger index = 0; index < self.typeDataArray.count; index++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
        [button setTitleColor:kDefaultBlueColor forState:UIControlStateSelected];
        [button setTitle:ISNIL([self.typeDataArray objectOrNilAtIndex:index]) forState:UIControlStateNormal];
        
        
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
            make.top.mas_equalTo(titleLabel2.mas_bottom).offset((index / 3) * (32 + 12) + 12);
            
        }];
        
        [self.typeButtonArray addObject:button];
        
        [button addTarget:self action:@selector(clickTagAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [self.view addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(278);
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

- (void)clickFinishAction {
    
    NSMutableArray *levelArray = [[NSMutableArray alloc] init];
    
    for (UIButton *button in self.levelButtonArray) {
        
        if (button.selected) {
            [levelArray addObject:button.currentTitle];
            
            [MobClick event:@"Filter_Hospital" label:[NSString stringWithFormat:@"医院_%@", ISNIL(button.currentTitle)]];
        }
        
    }
    
    NSMutableArray *typeArray = [[NSMutableArray alloc] init];
    
    for (UIButton *button in self.typeButtonArray) {
        
        if (button.selected) {
            [typeArray addObject:button.currentTitle];
            
            [MobClick event:@"Filter_Hospital" label:[NSString stringWithFormat:@"医院_%@", ISNIL(button.currentTitle)]];
        }
        
    }
    
    if ([self.delegate respondsToSelector:@selector(chooseFinishHospitalType:level:)]) {
        [self.delegate chooseFinishHospitalType:[typeArray componentsJoinedByString:@","] level:[levelArray componentsJoinedByString:@","]];
    }
    
}

- (void)clickResetAction {
    
    for (UIButton *button in self.levelButtonArray) {
        
        button.selected = false;
        button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
        button.backgroundColor = [UIColor whiteColor];
        
    }
    
    for (UIButton *button in self.typeButtonArray) {
        
        button.selected = false;
        button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
        button.backgroundColor = [UIColor whiteColor];
        
    }
    
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

    
}


@end

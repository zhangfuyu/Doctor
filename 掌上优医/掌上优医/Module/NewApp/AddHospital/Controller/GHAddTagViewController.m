//
//  GHAddTagViewController.m
//  掌上优医
//
//  Created by GH on 2019/5/31.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHAddTagViewController.h"

@interface GHAddTagViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation GHAddTagViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"添加标签";
    
    [self setupUI];
    
    [self.textField becomeFirstResponder];
    
    [self addRightButton:@selector(clickFinishAction) title:@"确定"];
    
}

- (void)setupUI {
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.textColor = kDefaultBlackTextColor;
    textField.font = H15;
    textField.placeholder = @"请输入医院标签";
    [contentView addSubview:textField];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.bottom.mas_equalTo(0);
    }];
    self.textField = textField;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
}

- (void)clickFinishAction {
    
    if (self.textField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入医院标签"];
        return;
    }
    
    if ([NSString stringContainsEmoji:self.textField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的医院标签,请勿输入特殊字符"];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(finishAddTag:)]) {
        [self.delegate finishAddTag:self.textField.text];
        [self.navigationController popViewControllerAnimated:true];
    }
    
}


@end

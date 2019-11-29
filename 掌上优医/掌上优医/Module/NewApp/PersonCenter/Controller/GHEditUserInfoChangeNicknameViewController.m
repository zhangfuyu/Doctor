//
//  GHEditUserInfoChangeNicknameViewController.m
//  掌上优医
//
//  Created by GH on 2018/11/2.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHEditUserInfoChangeNicknameViewController.h"
#import "GHTextField.h"

@interface GHEditUserInfoChangeNicknameViewController ()

@property (nonatomic, strong) GHTextField *textField;

@end

@implementation GHEditUserInfoChangeNicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"更换昵称";
    
    [self addRightButton:@selector(clickSaveAction) title:@"确定"];
    // Do any additional setup after loading the view.
    [self setupUI];
    
    self.navigationController.navigationBar.barTintColor = kDefaultGaryViewColor;
    self.navigationController.navigationBar.backgroundColor = kDefaultGaryViewColor;
}

- (void)clickSaveAction {
    
    if (self.textField.text.length == 0) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入您的昵称"];
        
        return;
    }
    
    if (self.textField.text.length > 12) {
        
        [SVProgressHUD showErrorWithStatus:@"昵称不得超过12个字符"];
        
        return;
    }
    
    if ([NSString isEmpty:ISNIL(self.textField.text)]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的昵称"];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(finishEditNicknameWithText:)]) {
        [self.delegate finishEditNicknameWithText:self.textField.text];
        [self.navigationController popViewControllerAnimated:true];
    }
    
}

- (void)setupUI {
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    GHTextField *textField = [[GHTextField alloc] init];
    textField.backgroundColor = [UIColor whiteColor];
    textField.returnKeyType = UIReturnKeyDone;
    textField.font = H14;
    textField.textColor = kDefaultBlackTextColor;
    textField.placeholder = @"请输入您的昵称";
//    textField.maxInputDigit = 13;
//    textField.endEditingDigit = 13;
    textField.text = ISNIL(self.string);
    textField.rightSpace = 16;
    
    [self.view addSubview:textField];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(10);
    }];
    self.textField = textField;
    
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.textColor = kDefaultGrayTextColor;
    leftLabel.font = H14;
    leftLabel.text = @"昵称";
    leftLabel.frame = CGRectMake(0, 0, 58, 50);
    
    textField.leftView = leftLabel;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    
    [textField addTarget:self action:@selector(textChanged:)forControlEvents:UIControlEventEditingChanged];
    
  
    
}

-(void)textChanged:(UITextField *)textField{
    
//    if (textField.text.length > 13) {
//        textField.text = [textField.text substringToIndex:13];
//    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.textField resignFirstResponder];
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.barTintColor = kDefaultGaryViewColor;
    self.navigationController.navigationBar.backgroundColor = kDefaultGaryViewColor;
    
    //        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //        [self.navigationController.navigationBar setShadowImage:nil];
    
    ((UILabel *)self.navigationItem.titleView).textColor = UIColorHex(0x333333);
    
    
//    [self setupNavigationStyle:GHNavigationBarStyleWhite];
//
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

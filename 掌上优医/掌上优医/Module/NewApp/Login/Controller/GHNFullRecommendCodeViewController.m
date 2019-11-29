//
//  GHNFullRecommendCodeViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/19.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNFullRecommendCodeViewController.h"
#import "GHFullRecommendCodeView.h"

@interface GHNFullRecommendCodeViewController ()

/**
 <#Description#>
 */
@property (nonatomic, strong) GHFullRecommendCodeView *codeView;

@end

@implementation GHNFullRecommendCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"兑换邀请码";
    
    [self addLeftButton:@selector(clickBackAction) image:[UIImage imageNamed:@"login_back"]];
    
    if (self.type != GHNFullRecommendCodeViewController_PersonCenter) {
        [self addRightButton:@selector(clickBackAction) title:@"跳过"];
    }
    
    
    
    [self setupUI];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.codeView.textfield01 becomeFirstResponder];
    });
    
}

- (void)setupUI {
    
    self.view.backgroundColor = UIColorHex(0xF5F5F5);
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 13;
    contentView.layer.shadowColor = kDefaultBlackTextColor.CGColor;
    contentView.layer.shadowOffset = CGSizeMake(0,8);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    contentView.layer.shadowOpacity = 0.2;//阴影透明度，默认0
    contentView.layer.shadowRadius = 5;//阴影半径，默认3
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        
//        if (self.type == GHNFullRecommendCodeViewController_BindPhone) {
//            make.top.mas_equalTo(Height_NavBar + 10);
//        } else {
//
//        }
        make.top.mas_equalTo(10);
        
        make.height.mas_equalTo(314);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = H13;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = kDefaultGrayTextColor;
    titleLabel.text = @"请输入好友的邀请码，如没有可直接跳过";
    [contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(0);
        make.height.mas_equalTo(75);
    }];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.backgroundColor = kDefaultBlueColor;
    submitButton.titleLabel.font = H18;
    submitButton.layer.cornerRadius = HScaleHeight(25);
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [contentView addSubview:submitButton];
    
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(34);
        make.right.mas_equalTo(-34);
        make.height.mas_equalTo(HScaleHeight(50));
        make.bottom.mas_equalTo(-40);
    }];
    [submitButton addTarget:self action:@selector(clickSubmitAction) forControlEvents:UIControlEventTouchUpInside];
    
    GHFullRecommendCodeView *codeView = [[GHFullRecommendCodeView alloc] init];
    [contentView addSubview:codeView];
    
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(21);
        make.right.mas_equalTo(-21);
        make.height.mas_equalTo(100);
        make.top.mas_equalTo(titleLabel.mas_bottom);
    }];
    self.codeView = codeView;
    
}

- (void)clickSubmitAction {
    
    NSString *code = [self.codeView getFullRecommendCode];
    
    if (code.length != 6) {
        return;
    }
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"invitationCode"] = code;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiUserInvitationcode withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
       
        if (isSuccess) {
            
            [SVProgressHUD showSuccessWithStatus:@"恭喜您,邀请码兑换成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self clickBackAction];
            });
            
        }
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    ((UILabel *)self.navigationItem.titleView).textColor = UIColorHex(0x333333);
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    //    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setShadowImage:nil];
    //
    //    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
}



- (void)clickBackAction{
    
    if (self.type == GHNFullRecommendCodeViewController_BindPhone) {
        [self.navigationController.presentingViewController.presentingViewController dismissViewControllerAnimated:true completion:nil];
    } else if (self.type == GHNFullRecommendCodeViewController_Register) {
        [self.navigationController.presentingViewController.presentingViewController dismissViewControllerAnimated:true completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:true];
    }
    
    
    
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

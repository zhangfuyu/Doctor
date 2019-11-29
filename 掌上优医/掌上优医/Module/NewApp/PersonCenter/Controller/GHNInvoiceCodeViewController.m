//
//  GHNInvoiceCodeViewController.m
//  掌上优医
//
//  Created by GH on 2019/4/1.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNInvoiceCodeViewController.h"

#import "GHCommonShareView.h"

#import "GHNFullRecommendCodeViewController.h"

@interface GHNInvoiceCodeViewController ()

@property (nonatomic, strong) UILabel *titleLabel1;

@property (nonatomic, strong) UILabel *titleLabel2;

@property (nonatomic, strong) UILabel *recommendCodeLabel;

@property (nonatomic, strong) GHCommonShareView *shareView;

@property (nonatomic, strong) NSString *urlStr;

@end

@implementation GHNInvoiceCodeViewController


- (GHCommonShareView *)shareView {
    
    if (!_shareView) {
        _shareView = [[GHCommonShareView alloc] init];
        
        
        if ([GHUserModelTool shareInstance].isZheng) {
            _shareView.title = @"您的好友邀请你注册";
            _shareView.desc = @"邀您一同打造全新的寻医体验";
        } else {
            _shareView.title = @"您的好友邀请你领星医分";
            _shareView.desc = @"你的好友送你200星医分，并邀您一同打造全新的寻医体验";
        }
        
        
        _shareView.urlString = self.urlStr;
        [self.view addSubview:_shareView];
        
        [_shareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        _shareView.hidden = true;
    }
    return _shareView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"邀请有奖";
    
    [self addLeftButton:@selector(clickBackAction) image:[UIImage imageNamed:@"login_back"]];
    
    
    
    
    [self setupUI];
    
    [self getRecommendInfoAction];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiUserInviter withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            if (((NSString *)response).length == 0) {
                [self addRightButton:@selector(clickFullRecommendCodeAction) title:@"兑换邀请码"];
            } else {
                [self addRightButton:@selector(clickNoneAction) title:@""];
            }
            
        }
        
    }];
    
}

- (void)clickNoneAction {
    
}

- (void)getRecommendInfoAction {
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiUserInvitationcode withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            self.recommendCodeLabel.text = ISNIL(response);
            
            self.urlStr = [[GHNetworkTool shareInstance] getRecommendCodeURLWithCode:self.recommendCodeLabel.text];
            
        }
        
    }];
    
    
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
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-40 + kBottomSafeSpace);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.clipsToBounds = true;
    imageView.image = [UIImage imageNamed:@"recommendcode_bg"];
    [contentView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(HScaleHeight(280));
    }];
    
    UILabel *titleLabel1 = [[UILabel alloc] init];
    titleLabel1.font = HM17;
    titleLabel1.textColor = [UIColor whiteColor];
    titleLabel1.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:titleLabel1];
    
    [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(HScaleHeight(90));
    }];
    self.titleLabel1 = titleLabel1;
    
    UILabel *titleLabel2 = [[UILabel alloc] init];
    titleLabel2.font = HM17;
    titleLabel2.textColor = [UIColor whiteColor];
    titleLabel2.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:titleLabel2];
    
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(titleLabel1.mas_bottom).offset(20);
    }];
    self.titleLabel2 = titleLabel2;
    
    
    
    UILabel *recommentTitleLabel = [[UILabel alloc] init];
    recommentTitleLabel.font = H18;
    recommentTitleLabel.textColor = kDefaultGrayTextColor;
    recommentTitleLabel.text = @"邀请码";
    recommentTitleLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:recommentTitleLabel];
    
    [recommentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(contentView.mas_centerX);
        make.width.mas_equalTo(56 + 36);
        make.top.mas_equalTo(imageView.mas_bottom).offset(HScaleHeight(37));
    }];
    
    UILabel *recommentLabel = [[UILabel alloc] init];
    recommentLabel.font = H18;
    recommentLabel.textColor = kDefaultBlackTextColor;
    
    [contentView addSubview:recommentLabel];
    
    [recommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25);
        make.left.mas_equalTo(contentView.mas_centerX);
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(recommentTitleLabel);
    }];
    self.recommendCodeLabel = recommentLabel;
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.backgroundColor = kDefaultBlueColor;
    shareButton.titleLabel.font = H18;
    shareButton.layer.cornerRadius = HScaleHeight(25);
    [shareButton setTitle:@"立即分享" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [contentView addSubview:shareButton];
    
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(34);
        make.right.mas_equalTo(-34);
        make.height.mas_equalTo(HScaleHeight(50));
        make.bottom.mas_equalTo(HScaleHeight(-70));
    }];
    [shareButton addTarget:self action:@selector(clickShareAction) forControlEvents:UIControlEventTouchUpInside];
    
    if ([GHUserModelTool shareInstance].isZheng) {
        
        titleLabel1.text = @"邀请一位好友注册";

        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"好友注册成功后 您将获得200星医分"attributes: @{NSFontAttributeName: HM17,NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];

        [string addAttributes:@{NSFontAttributeName: HM17, NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:237/255.0 blue:46/255.0 alpha:1.0]} range:NSMakeRange(12, 3)];

        titleLabel2.attributedText = string;
        
    } else {
        
        titleLabel1.text = @"邀请一位好友注册";
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"你和你的好友将各得 200 星医分"attributes: @{NSFontAttributeName: HM17,NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
        
        [string addAttributes:@{NSFontAttributeName: HM17, NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:237/255.0 blue:46/255.0 alpha:1.0]} range:NSMakeRange(10, 3)];
        
        titleLabel2.attributedText = string;
        
    }
    

    
    if (kiPhone4 || iPad) {
        [titleLabel1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60);
        }];
        
        [recommentTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imageView.mas_bottom).offset(10);
        }];
        
        [shareButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-30);
        }];
        
    }
    
    
    
}

- (void)clickShareAction {
    
    self.shareView.hidden = false;
    
}

- (void)clickFullRecommendCodeAction {
    
    GHNFullRecommendCodeViewController *vc = [[GHNFullRecommendCodeViewController alloc] init];
    vc.type = GHNFullRecommendCodeViewController_PersonCenter;
    [self.navigationController pushViewController:vc animated:true];
    
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
    
    [self.navigationController popViewControllerAnimated:true];
    
    //    [self.navigationController.presentingViewController.presentingViewController dismissViewControllerAnimated:true completion:nil];
    
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

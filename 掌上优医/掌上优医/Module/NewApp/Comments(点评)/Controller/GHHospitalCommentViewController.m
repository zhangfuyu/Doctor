//
//  GHHospitalCommentViewController.m
//  掌上优医
//
//  Created by GH on 2019/5/13.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHospitalCommentViewController.h"

#import "XHStarRateView.h"
#import "GHTextView.h"
#import "JFMorePhotoView.h"

#import "GHEmojiRateView.h"


@interface GHHospitalCommentViewController ()<XHStarRateViewDelegate, UITextViewDelegate, UITextFieldDelegate, GHEmojiRateViewDelegate>


@property (nonatomic, assign) NSUInteger currentScore;

@property (nonatomic, strong) GHTextView *textView;

@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, strong) UIView *commentSuccessView;

@property (nonatomic, strong) XHStarRateView *starRateView;

@property (nonatomic, strong) GHEmojiRateView *environmentRateView;

@property (nonatomic, assign) NSUInteger currentEnvironmentScore;

@property (nonatomic, strong) GHEmojiRateView *severRateView;

@property (nonatomic, assign) NSUInteger currentSeverScore;

@property (nonatomic, strong) JFMorePhotoView *photoView;

@property (nonatomic, strong) UILabel *collectionLabel;

@property (nonatomic, strong) UILabel *environmentLabel;

@property (nonatomic, strong) UILabel *severLabel;

@end

@implementation GHHospitalCommentViewController

- (UIView *)commentSuccessView {
    
    if (!_commentSuccessView) {
        
        _commentSuccessView = [[UIView alloc] init];
        _commentSuccessView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        iconImageView.image = [UIImage imageNamed:@"img_tijiaochenggong_mormal"];
        [_commentSuccessView addSubview:iconImageView];
        
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(104);
            make.height.mas_equalTo(125);
            make.left.mas_equalTo(SCREENWIDTH / 2.f - 52);
            make.top.mas_equalTo(100);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = H16;
        titleLabel.textColor = kDefaultBlackTextColor;
        titleLabel.text = @"提交评价成功";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_commentSuccessView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(iconImageView.mas_bottom);
            make.height.mas_equalTo(40);
        }];
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.titleLabel.font = HB16;
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if (self.isNotHaveDetail) {
            [backButton setTitle:@"返回" forState:UIControlStateNormal];
        } else {
            [backButton setTitle:@"返回医院详情" forState:UIControlStateNormal];
        }
        
        backButton.backgroundColor = kDefaultBlueColor;
        backButton.layer.cornerRadius = 5;
        backButton.layer.masksToBounds = true;
        [_commentSuccessView addSubview:backButton];
        
        [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(54);
            make.right.mas_equalTo(-54);
            make.height.mas_equalTo(40);
            if (kiPhone4) {
                make.top.mas_equalTo(titleLabel.mas_bottom).offset(40);
            } else {
                make.top.mas_equalTo(titleLabel.mas_bottom).offset(108);
            }
            
        }];
        
        [backButton addTarget:self action:@selector(clickBackAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _commentSuccessView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = ISNIL(self.model.hospitalName);
    
    self.currentScore = 0;
    
    [self setupUI];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [self.view addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(0);
    }];
    
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.bounces = false;
    scrollView.showsVerticalScrollIndicator = false;
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-30 + kBottomSafeSpace - 30);
    }];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
        make.height.greaterThanOrEqualTo(@0.f);//此处保证容器View高度的动态变化 大于等于0.f的高度
    }];
    
    UILabel *collectionTitleLabel = [[UILabel alloc] init];
    collectionTitleLabel.font = H18;
    collectionTitleLabel.textColor = kDefaultBlackTextColor;
    collectionTitleLabel.text = @"综合";
    [contentView addSubview:collectionTitleLabel];
    
    [collectionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(30);
    }];
    
    
    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(60, 20, HScaleHeight(240), 33)];
    starRateView.isAnimation = YES;
    starRateView.isNotHaveText = YES;
    starRateView.rateStyle = HalfStar;
    starRateView.tag = 1;
    starRateView.delegate = self;
    [contentView addSubview:starRateView];
    self.starRateView = starRateView;
    
    UILabel *collectionValueLabel = [[UILabel alloc] init];
    collectionValueLabel.font = H13;
    collectionValueLabel.textColor = kDefaultBlackTextColor;
    collectionValueLabel.text = @"非常满意";
    [contentView addSubview:collectionValueLabel];
    
    [collectionValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(collectionTitleLabel);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(HScaleHeight(310));
    }];
    self.collectionLabel = collectionValueLabel;
    
    
    UILabel *environmentTitleLabel = [[UILabel alloc] init];
    environmentTitleLabel.font = H15;
    environmentTitleLabel.textColor = kDefaultBlackTextColor;
    environmentTitleLabel.text = @"环境";
    [contentView addSubview:environmentTitleLabel];
    
    [environmentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(25);
        make.top.mas_equalTo(80);
    }];
    
    GHEmojiRateView *environmentRateView = [[GHEmojiRateView alloc] initWithFrame:CGRectMake(70, 80, HScaleHeight(240), 25)];
    environmentRateView.isAnimation = YES;
    environmentRateView.rateStyle = EmojiWholeStar;
    environmentRateView.tag = 1;
    environmentRateView.delegate = self;
    [contentView addSubview:environmentRateView];
    self.environmentRateView = environmentRateView;
    
    
    UILabel *environmentLabel = [[UILabel alloc] init];
    environmentLabel.font = H13;
    environmentLabel.textColor = kDefaultBlackTextColor;
    environmentLabel.text = @"非常满意";
    [contentView addSubview:environmentLabel];
    
    [environmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(environmentTitleLabel);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(collectionValueLabel);
    }];
    self.environmentLabel = environmentLabel;
    
    UILabel *severTitleLabel = [[UILabel alloc] init];
    severTitleLabel.font = H15;
    severTitleLabel.textColor = kDefaultBlackTextColor;
    severTitleLabel.text = @"服务";
    [contentView addSubview:severTitleLabel];
    
    [severTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(25);
        make.top.mas_equalTo(128);
    }];
    
    GHEmojiRateView *severRateView = [[GHEmojiRateView alloc] initWithFrame:CGRectMake(70, 128, HScaleHeight(240), 25)];
    severRateView.isAnimation = YES;
    severRateView.rateStyle = EmojiWholeStar;
    severRateView.tag = 1;
    severRateView.delegate = self;
    [contentView addSubview:severRateView];
    self.severRateView = severRateView;
    
    
    UILabel *severLabel = [[UILabel alloc] init];
    severLabel.font = H13;
    severLabel.textColor = kDefaultBlackTextColor;
    severLabel.text = @"非常满意";
    [contentView addSubview:severLabel];
    
    [severLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(severTitleLabel);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(collectionValueLabel);
    }];
    self.severLabel = severLabel;
    
    
    
    UIView *textContentView = [[UIView alloc] init];
    textContentView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:textContentView];
    
    [textContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(185);
    }];
    
    
    GHTextView *textView = [[GHTextView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH - 32, 120)];
    textView.maxLength = 500;
    textView.placeholder = @"可详细介绍一下医院的服务、环境怎么样，花费的情况，是否需要排队等信息";
    textView.placeholderColor = UIColorHex(0xAAAAAA);
    textView.font = H14;
    textView.textColor = kDefaultBlackTextColor;
    textView.backgroundColor = [UIColor whiteColor];
    textView.layer.masksToBounds = true;
    textView.delegate = self;
    [textContentView addSubview:textView];
    
    self.textView = textView;
    
    JFMorePhotoView *photoView = [[JFMorePhotoView alloc] initWithCount:6];
    photoView.canAddCount = 6;
    photoView.fileType = @"pinglunPic";
    [textContentView addSubview:photoView];
    self.photoView = photoView;
    
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-8);
        make.top.mas_equalTo(textView.mas_bottom).offset(8);
        make.height.mas_equalTo(90);
    }];
    
    [textContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(photoView.mas_bottom).offset(22);
    }];
    
    // 设置过渡视图的底边距（此设置将影响到scrollView的contentSize）
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(textContentView.mas_bottom).offset(30);
    }];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.titleLabel.font = H18;
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton setTitle:@"提交评价" forState:UIControlStateNormal];
    submitButton.backgroundColor = kDefaultBlueColor;
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = true;
    [self.view addSubview:submitButton];
    
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(47);
        make.bottom.mas_equalTo(-12 + kBottomSafeSpace);
    }];
    self.submitButton = submitButton;
    
    [submitButton addTarget:self action:@selector(clickSubmitAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.collectionLabel.hidden = true;
    self.environmentLabel.hidden = true;
    self.severLabel.hidden = true;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    [self.textView resignFirstResponder];
    
}

- (void)clickNoneAction {
    
}

- (void)clickSubmitAction {
    
    
    if (self.currentScore == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择综合评分"];
        return;
    }

    if (self.currentEnvironmentScore == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择环境评分"];
        return;
    }

    if (self.currentSeverScore == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择服务评分"];
        return;
    }

    if ([NSString isEmpty:self.textView.text] || [NSString stringContainsEmoji:self.textView.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的医院的服务、环境怎么样，花费的情况，是否需要排队等信息,请勿输入特殊字符"];
        return;
    }

    if (self.textView.text.length < 5 || self.textView.text.length > 500) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的医院的服务、环境怎么样，花费的情况，是否需要排队等信息,不得小于5个字符,不得大于500个字符"];
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"commentObjtype"] = @(2);
    params[@"commentObjId"] = self.model.modelId;
    params[@"commentObjName"] = self.model.hospitalName;
    params[@"userId"] =  [GHUserModelTool shareInstance].userInfoModel.modelId;
    params[@"score"] = @(self.currentScore * 10);
    params[@"serviceScore"] = @(self.currentSeverScore * 2 * 10);
    params[@"envScore"] = @(self.currentEnvironmentScore * 2 * 10);
    params[@"userNickName"] = [GHUserModelTool shareInstance].userInfoModel.nickName;
    params[@"userImgUrl"] = [GHUserModelTool shareInstance].userInfoModel.avatar;
    
//    NSData *data=[NSJSONSerialization dataWithJSONObject:self.photoView.uploadImageUrlArray options:NSJSONWritingPrettyPrinted error:nil];
//
//    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];

    
    params[@"commentImg"] = self.photoView.uploadImageUrlArray.count ? [self.photoView.uploadImageUrlArray jsonStringEncoded] : nil;
    params[@"commentContent"] = self.textView.text;
    
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    [[GHNetworkTool shareInstance]  requestWithMethod:GHRequestMethod_POST withUrl:kApiDoctorComment withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            [self submitSuccessAction];
            [self addRightButton:@selector(clickNoneAction) title:@""];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationHospitalCommentSuccess object:nil];
                
            });
            
        }
        
    }];
    
    
//    if (self.currentScore == 0) {
//        [SVProgressHUD showErrorWithStatus:@"请选择综合评分"];
//        return;
//    }
//    
//    if (self.currentEnvironmentScore == 0) {
//        [SVProgressHUD showErrorWithStatus:@"请选择环境评分"];
//        return;
//    }
//    
//    if (self.currentSeverScore == 0) {
//        [SVProgressHUD showErrorWithStatus:@"请选择服务评分"];
//        return;
//    }
//    
//    if ([NSString isEmpty:self.textView.text] || [NSString stringContainsEmoji:self.textView.text]) {
//        [SVProgressHUD showErrorWithStatus:@"请输入正确的医院的服务、环境怎么样，花费的情况，是否需要排队等信息,请勿输入特殊字符"];
//        return;
//    }
//    
//    if (self.textView.text.length < 5 || self.textView.text.length > 500) {
//        [SVProgressHUD showErrorWithStatus:@"请输入正确的医院的服务、环境怎么样，花费的情况，是否需要排队等信息,不得小于5个字符,不得大于500个字符"];
//        return;
//    }
//    
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    params[@"score"] = @(self.starRateView.currentScore * 2);
//    params[@"envScore"] = @(self.environmentRateView.currentScore * 2);
//    params[@"serviceScore"] = @(self.severRateView.currentScore * 2);
//    params[@"commentContent"] = ISNIL(self.textView.text).length > 0 ? self.textView.text : nil;
//    
//    params[@"commentObjId"] = ISNIL(self.model.modelId);
//    params[@"commentObjName"] = ISNIL(self.model.hospitalName);
//    params[@"commentObjType"] = @(2);
//    
//    params[@"userId"] = [GHUserModelTool shareInstance].userInfoModel.modelId;
//    params[@"userNickName"] = ISNIL([GHUserModelTool shareInstance].userInfoModel.nickName).length ? [GHUserModelTool shareInstance].userInfoModel.nickName : ISNIL([GHUserModelTool shareInstance].userInfoModel.showPhoneNum);
//    params[@"userProfileUrl"] = [GHUserModelTool shareInstance].userInfoModel.profilePhoto.length ? [GHUserModelTool shareInstance].userInfoModel.profilePhoto : nil;
//    
//    
//    params[@"pictures"] = self.photoView.uploadImageUrlArray.count ? [self.photoView.uploadImageUrlArray jsonStringEncoded] : nil;
//    
//    [SVProgressHUD showWithStatus:kDefaultTipsText];
//    
//    [[GHNetworkTool shareInstance]  requestWithMethod:GHRequestMethod_POST withUrl:kApiHospitalComment withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
//        
//        if (isSuccess) {
//            [self submitSuccessAction];
//            [self addRightButton:@selector(clickNoneAction) title:@""];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationHospitalCommentSuccess object:nil];
//            });
//            
//        }
//        
//    }];
//    
}

- (void)submitSuccessAction {
    
    
    self.navigationItem.title = @"提交成功";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.view addSubview:self.commentSuccessView];
    
    [self.commentSuccessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    //    self.commentSuccessView.hidden = false;
    
}

- (void)clickBackAction {
    
    if (self.isNotHaveDetail == true) {
        [self.navigationController popViewControllerAnimated:true];
        return;
    }
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:NSClassFromString(@"GHNewHospitalViewController")]) {
            [self.navigationController popToViewController:vc animated:true];
        }
        
    }
    
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (((GHTextView *)textView).hasText) { // textView.text.length
        ((GHTextView *)textView).placeholder = @"";
    } else {
        ((GHTextView *)textView).placeholder = @"可详细介绍一下医院的服务、环境怎么样，花费的情况，是否需要排队等信息";
    }
    
    self.submitButton.enabled = true;
    self.submitButton.backgroundColor = kDefaultBlueColor;
}


- (void)starRateView:(XHStarRateView *)starRateView currentScore:(CGFloat)currentScore{
    NSLog(@"%ld----  %f",starRateView.tag,currentScore * 2);
    self.currentScore = (currentScore * 2);
    self.submitButton.enabled = true;
    self.submitButton.backgroundColor = kDefaultBlueColor;
    
    self.collectionLabel.hidden = false;
    
    self.collectionLabel.text = [NSString stringWithFormat:@"%ld", self.currentScore];
    
}

- (void)emojiRateView:(GHEmojiRateView *)starRateView currentScore:(CGFloat)currentScore {
    
    NSLog(@"%ld----  %f",starRateView.tag,currentScore * 2);
    
    if (starRateView == self.environmentRateView) {
        self.currentEnvironmentScore = currentScore;
        
        self.environmentLabel.hidden = false;
        
        if (currentScore * 2 == 1 || currentScore * 2 == 2) {
            self.environmentLabel.text = @"差";
        } else if (currentScore * 2 == 3 || currentScore * 2 == 4) {
            self.environmentLabel.text = @"较差";
        } else if (currentScore * 2 == 5 || currentScore * 2 == 6) {
            self.environmentLabel.text = @"一般";
        } else if (currentScore * 2 == 7 || currentScore * 2 == 8) {
            self.environmentLabel.text = @"满意";
        } else if (currentScore * 2 == 9 || currentScore * 2 == 10) {
            self.environmentLabel.text = @"非常满意";
        }
        
    } else if (starRateView == self.severRateView) {
        self.currentSeverScore = currentScore;
        
        self.severLabel.hidden = false;
        
        if (currentScore * 2 == 1 || currentScore * 2 == 2) {
            self.severLabel.text = @"差";
        } else if (currentScore * 2 == 3 || currentScore * 2 == 4) {
            self.severLabel.text = @"较差";
        } else if (currentScore * 2 == 5 || currentScore * 2 == 6) {
            self.severLabel.text = @"一般";
        } else if (currentScore * 2 == 7 || currentScore * 2 == 8) {
            self.severLabel.text = @"满意";
        } else if (currentScore * 2 == 9 || currentScore * 2 == 10) {
            self.severLabel.text = @"非常满意";
        }
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    [self setupNavigationStyle:GHNavigationBarStyleWhite];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    
    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
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

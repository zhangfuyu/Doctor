//
//  GHDoctorCommentViewController.m
//  掌上优医
//
//  Created by GH on 2019/1/15.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHDoctorCommentViewController.h"
#import "XHStarRateView.h"
#import "GHTextView.h"
#import "GHDoctorCommentTagView.h"
#import "GHDoctorCommentModel.h"
#import "JFMorePhotoView.h"


@interface GHDoctorCommentViewController ()<XHStarRateViewDelegate, UITextViewDelegate, GHDoctorCommentTagViewDelegate, UITextFieldDelegate>


/**
 <#Description#>
 */
@property (nonatomic, assign) NSUInteger currentScore;

@property (nonatomic, strong) GHTextView *textView;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHDoctorCommentTagView *conditionTagView;

@property (nonatomic, strong) GHDoctorCommentTagView *treatmentTypeTagView;

@property (nonatomic, strong) UIView *commentSuccessView;


/**
 <#Description#>
 */
@property (nonatomic, strong) UITextField *sicknessTextField;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIButton *submitButton;

/**
 <#Description#>
 */
@property (nonatomic, strong) XHStarRateView *starRateView;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *scoreLabel;

@property (nonatomic, strong) JFMorePhotoView *photoView;


@end

@implementation GHDoctorCommentViewController

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
            [backButton setTitle:@"返回医生详情" forState:UIControlStateNormal];
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
    
    self.navigationItem.title = @"点评医生";
    
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
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = H16;
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.text = @"治疗效果";
    [contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(45);
    }];
    
    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(10, 54, 270, 33)];
//        XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(10, 54, 270, 33 + 36)];
    starRateView.isAnimation = YES;
    starRateView.isNotHaveText = YES;
    starRateView.rateStyle = HalfStar;
    starRateView.tag = 1;
    starRateView.delegate = self;
    [contentView addSubview:starRateView];
    self.starRateView = starRateView;
    
    UILabel *scoreLabel = [[UILabel alloc] init];
    scoreLabel.font = H13;
    scoreLabel.textColor = kDefaultBlackTextColor;
    scoreLabel.textAlignment = NSTextAlignmentRight;
    [contentView addSubview:scoreLabel];
    
    [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(starRateView);
        make.right.mas_equalTo(-16);
    }];
    self.scoreLabel = scoreLabel;
    
    UIView *textContentView = [[UIView alloc] init];
    textContentView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:textContentView];
    
    [textContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(starRateView.mas_bottom).offset(15);
    }];
    
    GHTextView *textView = [[GHTextView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH - 32, 120)];
    textView.maxLength = 500;
    textView.placeholder = @"可以介绍一下就诊过程和治疗效果等";
    textView.placeholderColor = UIColorHex(0xAAAAAA);
    textView.font = H15;
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
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(textContentView.mas_bottom);
    }];
    
    
    UILabel *sicknessTitleLabel = [[UILabel alloc] init];
    sicknessTitleLabel.font = H18;
    sicknessTitleLabel.textColor = kDefaultBlackTextColor;
    sicknessTitleLabel.text = @"所患疾病";
    [contentView addSubview:sicknessTitleLabel];
    
    [sicknessTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(lineLabel.mas_bottom).offset(15);
    }];
    
    UILabel *sicknessValueLabel = [[UILabel alloc] init];
    sicknessValueLabel.font = H14;
    sicknessValueLabel.textColor = kDefaultGrayTextColor;
    sicknessValueLabel.text = @"(选填)";
    [contentView addSubview:sicknessValueLabel];
    
    [sicknessValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.height.mas_equalTo(sicknessTitleLabel);
    }];
    
    UITextField *sicknessTextField = [[UITextField alloc] init];
    sicknessTextField.returnKeyType = UIReturnKeyDone;
    sicknessTextField.textColor = kDefaultBlackTextColor;
    sicknessTextField.font = H14;
    sicknessTextField.placeholder = @"如：糖尿病";
    sicknessTextField.layer.cornerRadius = 4;
    sicknessTextField.layer.borderColor = kDefaultLineViewColor.CGColor;
    sicknessTextField.layer.masksToBounds = true;
    sicknessTextField.layer.borderWidth = 1;
    [contentView addSubview:sicknessTextField];
    
    [sicknessTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(sicknessTitleLabel.mas_bottom).offset(7.5);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
    }];
    self.sicknessTextField = sicknessTextField;
    
    UIView *sicknessTextFieldLeftView = [[UIView alloc] init];
    sicknessTextFieldLeftView.frame = CGRectMake(0, 0, 10, 10);
    
    sicknessTextField.leftView = sicknessTextFieldLeftView;
    sicknessTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *conditionTitleLabel = [[UILabel alloc] init];
    conditionTitleLabel.font = H18;
    conditionTitleLabel.textColor = kDefaultBlackTextColor;
    conditionTitleLabel.text = @"治愈状态";
    [contentView addSubview:conditionTitleLabel];
    
    [conditionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(sicknessTextField.mas_bottom).offset(10);
    }];
    
    UILabel *conditionValueLabel = [[UILabel alloc] init];
    conditionValueLabel.font = H14;
    conditionValueLabel.textColor = kDefaultGrayTextColor;
    conditionValueLabel.text = @"(选填)";
    [contentView addSubview:conditionValueLabel];
    
    [conditionValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.height.mas_equalTo(conditionTitleLabel);
    }];
    
    
    GHDoctorCommentTagView *conditionTagView = [[GHDoctorCommentTagView alloc] initWithTitleArray:@[@"已痊愈", @"有好转", @"观察中", @"无效果"] imageArray:@[@"ic_yonghupingjia_yiquanyu1", @"ic_yonghupingjia_youhaozhuan", @"ic_yonghupingjia_fufa", @"ic_yonghupingjia_wuxiaoguo"]];
    conditionTagView.type = GHDoctorCommentTagType_SingleSelection;
    conditionTagView.delegate = self;
    [contentView addSubview:conditionTagView];
    
    [conditionTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(57);
        make.top.mas_equalTo(conditionTitleLabel.mas_bottom);
    }];
    self.conditionTagView = conditionTagView;
   
    
    UILabel *treatmentTypeTitleLabel = [[UILabel alloc] init];
    treatmentTypeTitleLabel.font = H18;
    treatmentTypeTitleLabel.textColor = kDefaultBlackTextColor;
    treatmentTypeTitleLabel.text = @"治疗方式";
    [contentView addSubview:treatmentTypeTitleLabel];
    
    [treatmentTypeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(conditionTagView.mas_bottom).offset(10);
    }];
    
    UILabel *treatmentTypeValueLabel = [[UILabel alloc] init];
    treatmentTypeValueLabel.font = H14;
    treatmentTypeValueLabel.textColor = kDefaultGrayTextColor;
    treatmentTypeValueLabel.text = @"(选填)";
    [contentView addSubview:treatmentTypeValueLabel];
    
    [treatmentTypeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.height.mas_equalTo(treatmentTypeTitleLabel);
    }];
    
    
    GHDoctorCommentTagView *treatmentTypeTagView = [[GHDoctorCommentTagView alloc] initWithTitleArray:@[@"手术", @"静养", @"药物", @"其他"] imageArray:@[@"ic_yonghupingjia_yaowuduihao", @"ic_yonghupingjia_yaowuduihao", @"ic_yonghupingjia_yaowuduihao", @"ic_yonghupingjia_yaowuduihao"]];
    treatmentTypeTagView.type = GHDoctorCommentTagType_SingleSelection;
    treatmentTypeTagView.delegate = self;
    [contentView addSubview:treatmentTypeTagView];
    
    [treatmentTypeTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(57);
        make.top.mas_equalTo(treatmentTypeTitleLabel.mas_bottom);
    }];
    self.treatmentTypeTagView = treatmentTypeTagView;
    
    
    
    // 设置过渡视图的底边距（此设置将影响到scrollView的contentSize）
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(treatmentTypeTagView.mas_bottom).offset(30);
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
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    [self.textView resignFirstResponder];
    
    [self.sicknessTextField resignFirstResponder];
    
}

- (void)clickSubmitAction {
    
    
    if (self.currentScore == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择治疗效果"];
        return;
    }

    if ([NSString isEmpty:self.textView.text] || [NSString stringContainsEmoji:self.textView.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的就诊过程和治疗效果,请勿输入特殊字符"];
        return;
    }

    if (self.textView.text.length < 5 || self.textView.text.length > 500) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的就诊过程和治疗效果,不得小于5个字符,不得大于500个字符"];
        return;
    }

    if (self.sicknessTextField.text.length > 0) {

        if ([NSString isEmpty:self.sicknessTextField.text] || [NSString stringContainsEmoji:self.sicknessTextField.text]) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的所患疾病,请勿输入特殊字符"];
            return;
        }

        if (self.sicknessTextField.text.length > 15) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的所患疾病,不得大于15个字符"];
            return;
        }

    }
//
//
//
//    [self.textView resignFirstResponder];
//    [self.sicknessTextField resignFirstResponder];
//
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//
//    params[@"score"] = @(self.starRateView.currentScore * 2);
//    params[@"commentContent"] = ISNIL(self.textView.text).length > 0 ? self.textView.text : nil;
//
//    params[@"commentObjId"] = ISNIL(self.model.modelId);
//    params[@"commentObjName"] = ISNIL(self.model.doctorName);
//    params[@"commentObjType"] = @(1);
//
//    params[@"userId"] = [GHUserModelTool shareInstance].userInfoModel.modelId;
//    params[@"userNickName"] = ISNIL([GHUserModelTool shareInstance].userInfoModel.nickName).length ? [GHUserModelTool shareInstance].userInfoModel.nickName : ISNIL([GHUserModelTool shareInstance].userInfoModel.showPhoneNum);
//    params[@"userProfileUrl"] = [GHUserModelTool shareInstance].userInfoModel.profilePhoto.length ? [GHUserModelTool shareInstance].userInfoModel.profilePhoto : nil;
//
//
//    params[@"pictures"] = self.photoView.uploadImageUrlArray.count ? [self.photoView.uploadImageUrlArray jsonStringEncoded] : nil;
//
//    NSMutableDictionary *sonParams = [[NSMutableDictionary alloc] init];
//    sonParams[@"curativeEffect"] = [[self.conditionTagView getChooseResultArray] componentsJoinedByString:@","].length ? [[self.conditionTagView getChooseResultArray] componentsJoinedByString:@","] : nil;
//    sonParams[@"treatment"] = [[self.treatmentTypeTagView getChooseResultArray] componentsJoinedByString:@","].length ? [[self.treatmentTypeTagView getChooseResultArray] componentsJoinedByString:@","] : nil;
//    sonParams[@"diseaseName"] = ISNIL(self.sicknessTextField.text).length ? self.sicknessTextField.text : nil;
//
//    if (sonParams.allKeys.count > 0) {
//        params[@"extAttributes"] = [sonParams jsonStringEncoded];
//    }
    
    
    
//    params[@"doctorId"] = ISNIL(self.model.modelId);
//    params[@"doctorName"] = ISNIL(self.model.doctorName);
////    params[@"medicalFee"] = [self.treatmentCostsTextField.text integerValue] > 0 ? @([self.treatmentCostsTextField.text integerValue]) : nil;
//    params[@"score"] = @(self.starRateView.currentScore * 2);
//    params[@"comment"] = ISNIL(self.textView.text).length > 0 ? self.textView.text : nil;
//    params[@"curativeEffect"] = [[self.conditionTagView getChooseResultArray] componentsJoinedByString:@","];
//    params[@"treatment"] = [[self.treatmentTypeTagView getChooseResultArray] componentsJoinedByString:@","].length ? [[self.treatmentTypeTagView getChooseResultArray] componentsJoinedByString:@","] : nil;
//    params[@"userId"] = [GHUserModelTool shareInstance].userInfoModel.modelId;
//    params[@"userNickName"] = ISNIL([GHUserModelTool shareInstance].userInfoModel.nickName).length ? [GHUserModelTool shareInstance].userInfoModel.nickName : ISNIL([GHUserModelTool shareInstance].userInfoModel.showPhoneNum);
//    params[@"userProfileUrl"] = [GHUserModelTool shareInstance].userInfoModel.profilePhoto.length ? [GHUserModelTool shareInstance].userInfoModel.profilePhoto : nil;
//    params[@"pictures"] = self.photoView.uploadImageUrlArray.count ? [self.photoView.uploadImageUrlArray jsonStringEncoded] : nil;
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"commentObjtype"] = @(1);
    params[@"commentObjId"] = self.model.modelId;
    params[@"commentObjName"] = self.model.doctorName;
    params[@"userId"] = [GHUserModelTool shareInstance].userInfoModel.modelId;
    params[@"score"] = @(self.starRateView.currentScore * 2 * 10) ;
    params[@"userNickName"] = [GHUserModelTool shareInstance].userInfoModel.nickName;
    params[@"commentImg"] = self.photoView.uploadImageUrlArray.count ? [self.photoView.uploadImageUrlArray jsonStringEncoded] : nil;
    params[@"commentContent"] = ISNIL(self.textView.text).length > 0 ? self.textView.text : nil;
    params[@"userImgUrl"] = [GHUserModelTool shareInstance].userInfoModel.avatar;
    
    params[@"diseaseName"] = ISNIL(self.sicknessTextField.text).length ? self.sicknessTextField.text : nil;
    NSString *cureMethod = [[self.treatmentTypeTagView getChooseResultArray] componentsJoinedByString:@","];

    cureMethod = [cureMethod stringByReplacingOccurrencesOfString:@"手术" withString:@"1"];
    cureMethod = [cureMethod stringByReplacingOccurrencesOfString:@"静养" withString:@"2"];
    cureMethod = [cureMethod stringByReplacingOccurrencesOfString:@"药物" withString:@"3"];
    cureMethod = [cureMethod stringByReplacingOccurrencesOfString:@"其他" withString:@"4"];

    params[@"cureMethod"] = cureMethod;
    NSString *cureState = [[self.conditionTagView getChooseResultArray] componentsJoinedByString:@","];
    cureState = [cureState stringByReplacingOccurrencesOfString:@"已痊愈" withString:@"1"];
    cureState = [cureState stringByReplacingOccurrencesOfString:@"有好转" withString:@"2"];
    cureState = [cureState stringByReplacingOccurrencesOfString:@"观察中" withString:@"3"];
    cureState = [cureState stringByReplacingOccurrencesOfString:@"无效果" withString:@"4"];
  
    params[@"cureState"] = cureState;
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    [[GHNetworkTool shareInstance]  requestWithMethod:GHRequestMethod_POST withUrl:kApiDoctorComment withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            [self submitSuccessAction];
            [self addRightButton:@selector(clickNoneAction) title:@""];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDoctorCommentSuccess object:nil];
            });

        }
        else
        {
            [SVProgressHUD dismiss];
        }
        
    }];
    
}

- (void)clickNoneAction {
    
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
        
        if ([vc isKindOfClass:NSClassFromString(@"GHNewDoctorDetailViewController")]) {
            [self.navigationController popToViewController:vc animated:true];
        }
        
    }
    
}

-(void)textChanged:(UITextField *)textField{
    
    self.submitButton.enabled = true;
    self.submitButton.backgroundColor = kDefaultBlueColor;
    
    if (textField.text.length > 6) {
        textField.text = [textField.text substringToIndex:6];
    }
    
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//
//    self.submitButton.enabled = true;
//    self.submitButton.backgroundColor = kDefaultBlueColor;
//
//    return YES;
//
//}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (((GHTextView *)textView).hasText) { // textView.text.length
        ((GHTextView *)textView).placeholder = @"";
    } else {
        ((GHTextView *)textView).placeholder = @"可以介绍一下就诊过程和治疗效果等";
    }
    
    self.submitButton.enabled = true;
    self.submitButton.backgroundColor = kDefaultBlueColor;
}

- (void)chooseTagAction {
    self.submitButton.enabled = true;
    self.submitButton.backgroundColor = kDefaultBlueColor;
}

- (void)starRateView:(XHStarRateView *)starRateView currentScore:(CGFloat)currentScore{
    NSLog(@"%ld----  %f",starRateView.tag,currentScore * 2);
    self.currentScore = (currentScore * 2);
    self.submitButton.enabled = true;
    self.submitButton.backgroundColor = kDefaultBlueColor;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld", self.currentScore];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self setupNavigationStyle:GHNavigationBarStyleWhite];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
}

@end

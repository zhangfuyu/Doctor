//
//  GHQuestionViewController.m
//  掌上优医
//
//  Created by GH on 2019/5/27.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHQuestionViewController.h"
#import "GHTextField.h"
#import "GHTextView.h"

@interface GHQuestionViewController ()

/**
 <#Description#>
 */
@property (nonatomic, strong) GHTextField *questionTitleTextField;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHTextView *questionDescriptionTextView;

@end

@implementation GHQuestionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"提问";
    
    [self setupUI];
    
}

- (void)setupUI {
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.bounces = false;
    scrollView.showsVerticalScrollIndicator = false;
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.backgroundColor = kDefaultGaryViewColor;
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-47 + kBottomSafeSpace - 60);
    }];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = kDefaultGaryViewColor;
    [scrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
        make.height.greaterThanOrEqualTo(@0.f);//此处保证容器View高度的动态变化 大于等于0.f的高度
    }];
    
    
    UILabel *questionTitleTitleLabel = [[UILabel alloc] init];
    questionTitleTitleLabel.font = H15;
    questionTitleTitleLabel.textColor = kDefaultBlackTextColor;
    questionTitleTitleLabel.text = @"提出问题：";
    [contentView addSubview:questionTitleTitleLabel];
    
    [questionTitleTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(21);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(25);
    }];
    
    GHTextField *questionTextField = [[GHTextField alloc] init];
    questionTextField.backgroundColor = [UIColor whiteColor];
    questionTextField.returnKeyType = UIReturnKeyDone;
    questionTextField.font = H15;
    questionTextField.textColor = kDefaultBlackTextColor;
    questionTextField.placeholder = @"请输入您的问题主题（20个字以内）";
    questionTextField.maxInputDigit = 20;
    questionTextField.endEditingDigit = 20;
    questionTextField.rightSpace = 7;
    questionTextField.leftSpace = 7;
    
    questionTextField.layer.cornerRadius = 4;
    questionTextField.layer.masksToBounds = true;
    
    [self.view addSubview:questionTextField];
    
    [questionTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(46);
        make.top.mas_equalTo(questionTitleTitleLabel.mas_bottom).offset(14);
    }];
    self.questionTitleTextField = questionTextField;
    
    UILabel *questionDescTitleLabel = [[UILabel alloc] init];
    questionDescTitleLabel.font = H15;
    questionDescTitleLabel.textColor = kDefaultBlackTextColor;
    questionDescTitleLabel.text = @"问题描述：";
    [contentView addSubview:questionDescTitleLabel];
    
    [questionDescTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(21);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(questionTextField.mas_bottom).offset(20);
    }];
    
    GHTextView *questionDescriptionTextView = [[GHTextView alloc] initWithFrame:CGRectMake(16, 160, SCREENWIDTH - 32, 200)];
    questionDescriptionTextView.font = H15;
    questionDescriptionTextView.textColor = kDefaultBlackTextColor;
    questionDescriptionTextView.backgroundColor = [UIColor whiteColor];
    questionDescriptionTextView.bounces = false;
    questionDescriptionTextView.placeholder = @"请描述您的问题";
    questionDescriptionTextView.placeholderColor = UIColorHex(0xcccccc);
    questionDescriptionTextView.layer.cornerRadius = 4;
    questionDescriptionTextView.layer.masksToBounds = true;
    
    
    [contentView addSubview:questionDescriptionTextView];
    
    self.questionDescriptionTextView = questionDescriptionTextView;
    
    [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(questionDescriptionTextView.mas_bottom);
    }];
    
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.titleLabel.font = H18;
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    submitButton.backgroundColor = kDefaultBlueColor;
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = true;
    [self.view addSubview:submitButton];
    
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(47);
        make.bottom.mas_equalTo(-40 + kBottomSafeSpace);
    }];
    
    [submitButton addTarget:self action:@selector(clickSubmitAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}


- (void)clickSubmitAction {
    
    if (self.questionTitleTextField.text.length == 0 || self.questionTitleTextField.text.length  > 20) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的问题主题（20个字以内）"];
        return;
    }
    
    if ([NSString isEmpty:self.questionTitleTextField.text] || [NSString stringContainsEmoji:self.questionTitleTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的问题主题"];
        return;
    }
    
    if (self.questionDescriptionTextView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的问题描述"];
        return;
    }
    
    if (self.questionDescriptionTextView.text.length) {
        if ([NSString isEmpty:self.questionDescriptionTextView.text] || [NSString stringContainsEmoji:self.questionDescriptionTextView.text]) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的问题描述"];
            return;
        }
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"ownerType"] = @(2);
    
    
    params[@"authorId"] = [GHUserModelTool shareInstance].userInfoModel.modelId;
    params[@"authorName"] = ISNIL([GHUserModelTool shareInstance].userInfoModel.nickName).length ? [GHUserModelTool shareInstance].userInfoModel.nickName : ISNIL([GHUserModelTool shareInstance].userInfoModel.showPhoneNum);
    params[@"authorHeaderUrl"] = [GHUserModelTool shareInstance].userInfoModel.avatar.length ? [GHUserModelTool shareInstance].userInfoModel.profilePhoto : nil;
    
    params[@"content"] = self.questionDescriptionTextView.text.length ? self.questionDescriptionTextView.text : nil;
    params[@"title"] = self.questionTitleTextField.text;
    
    params[@"ownerId"] = self.doctorId;
    
    
//    params[@"ownerName"] = ISNIL(self.doctorName);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiCirclePost withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
       
        if (isSuccess) {
            [SVProgressHUD showSuccessWithStatus:@"提问成功,请耐心的等待回答哟..."];
            [self.navigationController popViewControllerAnimated:true];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDoctorQuestionSuccess object:nil];
        }
        
    }];
    
}

@end

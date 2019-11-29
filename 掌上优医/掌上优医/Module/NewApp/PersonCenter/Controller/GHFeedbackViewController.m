//
//  GHFeedbackViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHFeedbackViewController.h"
#import "GHDoctorCommentTagView.h"
#import "UIButton+touch.h"
#import "GHTextView.h"
#import "JFMorePhotoView.h"

@interface GHFeedbackViewController ()<UITextViewDelegate>

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *tagButtonArray;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHTextView *textView;

/**
 <#Description#>
 */
@property (nonatomic, strong) JFMorePhotoView *photoView;

/**
 <#Description#>
 */
@property (nonatomic, assign) NSInteger type;

@end

@implementation GHFeedbackViewController

- (NSMutableArray *)tagButtonArray {
    
    if (!_tagButtonArray) {
        _tagButtonArray = [[NSMutableArray alloc] init];
    }
    return _tagButtonArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"意见反馈";
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    [self setupUI];
    
}

- (void)setupUI {
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.bounces = false;
    scrollView.showsVerticalScrollIndicator = false;
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-30 + kBottomSafeSpace - 45);
    }];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
        make.height.greaterThanOrEqualTo(@0.f);//此处保证容器View高度的动态变化 大于等于0.f的高度
    }];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = H15;
    titleLabel.textColor = UIColorHex(0x999999);
    titleLabel.text = @"请描述你遇到的问题";
    [contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineLabel.mas_bottom);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(45);
    }];
    
    NSArray *titleArray = @[@"疾病数据", @"医生数据", @"医院数据", @"用户体验", @"显示异常", @"其他"];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
        [button setTitleColor:kDefaultBlueColor forState:UIControlStateSelected];
        [button setTitle:ISNIL([titleArray objectOrNilAtIndex:index]) forState:UIControlStateNormal];
        
        
        button.titleLabel.font = H14;
        button.tag = index + 1;
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = true;
        button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderWidth = 0.5;
        button.isIgnore = true;
        
        [button setBackgroundColor:[UIColor clearColor]];
        
        
        
        [contentView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(32);
            make.width.mas_equalTo((SCREENWIDTH - 30 - 32) / 3);
            make.left.mas_equalTo(16 + (index % 3) * ((SCREENWIDTH - 30 - 32) / 3 + 16));
            make.top.mas_equalTo(titleLabel.mas_bottom).offset((index / 3) * (32 + 12));
            
        }];
        
        [self.tagButtonArray addObject:button];
        
        [button addTarget:self action:@selector(clickTagAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    UILabel *titleLabel2 = [[UILabel alloc] init];
    titleLabel2.font = H15;
    titleLabel2.textColor = UIColorHex(0x999999);
    titleLabel2.text = @"你的建议与反馈是我们前进的动力";
    [contentView addSubview:titleLabel2];
    
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(104);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(21);
    }];
    
    GHTextView *textView = [[GHTextView alloc] initWithFrame:CGRectMake(16, 195, SCREENWIDTH - 32, 120)];
    textView.maxLength = 200;
    textView.placeholder = @"请输入您的内容";
    textView.placeholderColor = UIColorHex(0xAAAAAA);
    textView.font = H15;
    textView.textColor = kDefaultBlackTextColor;
    textView.backgroundColor = [UIColor whiteColor];
    textView.layer.masksToBounds = true;
    textView.delegate = self;
    textView.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
    textView.layer.borderWidth = 0.5;
    textView.layer.cornerRadius = 4;
    textView.layer.masksToBounds = true;
    [contentView addSubview:textView];
    
    self.textView = textView;
    
    JFMorePhotoView *photoView = [[JFMorePhotoView alloc] initWithCount:6];
    photoView.canAddCount = 6;
    photoView.fileType = @"yijianPic";
    [contentView addSubview:photoView];
    self.photoView = photoView;
    
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(textView.mas_bottom).offset(8);
        make.height.mas_equalTo(90);
    }];
    
    // 设置过渡视图的底边距（此设置将影响到scrollView的contentSize）
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(photoView.mas_bottom).offset(30);
    }];
    
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.titleLabel.font = H18;
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton setTitle:@"发送" forState:UIControlStateNormal];
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
    
    [submitButton addTarget:self action:@selector(clickSubmitAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (((GHTextView *)textView).hasText) { // textView.text.length
        ((GHTextView *)textView).placeholder = @"";
    } else {
        ((GHTextView *)textView).placeholder = @"请输入您的内容";
    }
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    [self.textView resignFirstResponder];
    
}

- (void)clickSubmitAction {
    
    if (self.type == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择您遇到的问题"];
        return;
    }
    
    if (self.textView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的建议或反馈"];
        return;
    }
    
    if ([NSString stringContainsEmoji:self.textView.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的建议或反馈"];
        return;
    }
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"content"] = ISNIL(self.textView.text);
    
    if (self.photoView.uploadImageUrlArray.count) {
        NSMutableArray *uriArry = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in self.photoView.uploadImageUrlArray) {
            [uriArry addObject:dic[@"url"]];
        }
        params[@"pictures"] = [uriArry componentsJoinedByString:@","];
    }
    
//    params[@"pictures"] = self.photoView.uploadImageUrlArray.count ? [self.photoView.uploadImageUrlArray jsonStringEncoded] : nil;
    params[@"contentType"] = @(self.type);

    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiMySuggestionfeedback withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        [SVProgressHUD dismiss];
        if (isSuccess) {
            [SVProgressHUD showSuccessWithStatus:@"您的反馈已提交,感谢您对本产品的支持!"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:true];
            });
            
        }
        
    }];
    
}

- (void)clickTagAction:(UIButton *)sender {
    
    for (UIButton *button in self.tagButtonArray) {
        
        button.selected = false;
        button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
        button.backgroundColor = [UIColor whiteColor];
        
    }
    
//    sender.selected = !sender.selected;
//
//    if (sender.selected) {
//
//
//
//    } else {
//        sender.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
//        sender.backgroundColor = kDefaultGaryViewColor;
//    }
    
    sender.selected = true;
    
    sender.layer.borderColor = kDefaultBlueColor.CGColor;
    sender.backgroundColor = UIColorHex(0xEFF0FD);
    
    self.type = sender.tag;
    
}


@end

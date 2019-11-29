//
//  GHAddHospitalAuthenticationViewController.m
//  掌上优医
//
//  Created by GH on 2019/6/1.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHAddHospitalAuthenticationViewController.h"
#import "JFMorePhotoView.h"
#import "GHTextView.h"
#import "GHTextField.h"
#import "GHChooseHospitalAuthenticationTimeView.h"

@interface GHAddHospitalAuthenticationViewController () <GHChooseHospitalAuthenticationTimeViewDelegate>

@property (nonatomic, strong) GHTextField *idNumberTextField;

@property (nonatomic, strong) GHTextView *hospitalNameTextView;

@property (nonatomic, strong) GHTextView *hospitalAddressTextView;

@property (nonatomic, strong) GHTextField *legalRepresentativeTextField;

@property (nonatomic, strong) GHTextField *periodOfValidityTextField;

@property (nonatomic, strong) GHTextView *businessScopeTextView;

@property (nonatomic, strong) JFMorePhotoView *medicalQualificationCertificatePhotoView;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHChooseHospitalAuthenticationTimeView *chooseTimeView;

@end

@implementation GHAddHospitalAuthenticationViewController

- (GHChooseHospitalAuthenticationTimeView *)chooseTimeView {
    
    if (!_chooseTimeView) {
        _chooseTimeView = [[GHChooseHospitalAuthenticationTimeView alloc] init];
        _chooseTimeView.delegate = self;
        [self.view addSubview:_chooseTimeView];
        
        [_chooseTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    
    return _chooseTimeView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupUI];
    
    [self addRightButton:@selector(clickDeleteAction) title:@"删除"];
    
    self.navigationItem.title = @"资质认证";
    
}

- (void)clickDeleteAction {
        
    self.idNumberTextField.text = @"";
    self.hospitalNameTextView.text = @"";
    self.hospitalAddressTextView.text = @"";
    self.legalRepresentativeTextField.text = @"";
    self.periodOfValidityTextField.text = @"";
    
    self.businessScopeTextView.text = @"";
    
    self.hospitalNameTextView.placeholder = @"请输入医院名称";
    self.hospitalAddressTextView.placeholder = @"请输入医院地址";
    self.businessScopeTextView.placeholder = @"请输入经营范围";
    
    if (self.medicalQualificationCertificatePhotoView.deleteButtonArray.count > 0) {
        [self.medicalQualificationCertificatePhotoView clickDeleteAction:[self.medicalQualificationCertificatePhotoView.deleteButtonArray firstObject]];
    }
    
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
        make.bottom.mas_equalTo(-60 + kBottomSafeSpace);
    }];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [self.view addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
        make.height.greaterThanOrEqualTo(@0.f);//此处保证容器View高度的动态变化 大于等于0.f的高度
    }];
    

    
    NSDictionary *qualificationDic = [self.qualityCertifyMaterials jsonValueDecoded];
    
    NSString *idNumber = qualificationDic[@"idNumber"];
    NSString *certificateHospitalName = qualificationDic[@"certificateHospitalName"];
    NSString *certificateHospitalAddress = qualificationDic[@"certificateHospitalAddress"];
    
    NSString *legalRepresentative = qualificationDic[@"legalRepresentative"];
    NSString *periodOfValidity = qualificationDic[@"periodOfValidity"];
    NSString *businessScope = qualificationDic[@"businessScope"];
    
    NSString *pics = [qualificationDic[@"pics"] firstObject][@"url"];
    
    
    NSArray *titleArray = @[@"证件号码:", @"医院名称:", @"医院地址:", @"法定代表人:", @"有效期:", @"经营范围"];
    NSArray *valueArray = @[ISNIL(idNumber), ISNIL(certificateHospitalName), ISNIL(certificateHospitalAddress), ISNIL(legalRepresentative), ISNIL(periodOfValidity), ISNIL(businessScope)];
    
    NSArray *topArray = @[@(18), @(68), @(138), @(218), @(268), @(318)];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = H16;
        titleLabel.textColor = kDefaultBlackTextColor;
        titleLabel.text = ISNIL([titleArray objectOrNilAtIndex:index]);
        titleLabel.frame = CGRectMake(16, [[topArray objectOrNilAtIndex:index] floatValue], 110, 16);
        [contentView addSubview:titleLabel];
        
        UILabel *valueLabel = [[UILabel alloc] init];
        valueLabel.font = H15;
        valueLabel.textColor = kDefaultBlackTextColor;
        valueLabel.numberOfLines = 0;
        
        [contentView addSubview:valueLabel];
        
        if (index == 0) {
            
            GHTextField *textField = [[GHTextField alloc] init];
            textField.backgroundColor = [UIColor whiteColor];
            textField.returnKeyType = UIReturnKeyDone;
            textField.font = H15;
            textField.textColor = kDefaultBlackTextColor;
            textField.leftSpace = 6;
            
            textField.placeholder = @"请输入证件号码";
            textField.keyboardType = UIKeyboardTypeASCIICapable;
            textField.text = [valueArray objectOrNilAtIndex:index];
            textField.frame = CGRectMake(135, [[topArray objectOrNilAtIndex:index] floatValue] - 8, SCREENWIDTH - 135 - 47, 50);
            textField.centerY = titleLabel.centerY;
            [contentView addSubview:textField];
            
            self.idNumberTextField = textField;

        } else if (index == 1) {
            
            GHTextView *textView = [[GHTextView alloc] initWithFrame:CGRectMake(135, [[topArray objectOrNilAtIndex:index] floatValue] - 9, SCREENWIDTH - 135 - 47, 50)];
            textView.font = H15;
            textView.textColor = kDefaultBlackTextColor;
            textView.backgroundColor = [UIColor whiteColor];
            textView.bounces = false;
            textView.placeholder = @"请输入医院名称";
            textView.placeholderColor = UIColorHex(0xcccccc);
            textView.text = [valueArray objectOrNilAtIndex:index];
            [contentView addSubview:textView];
            
            self.hospitalNameTextView = textView;

        } else if (index == 2) {
            
            GHTextView *textView = [[GHTextView alloc] initWithFrame:CGRectMake(135, [[topArray objectOrNilAtIndex:index] floatValue] - 9, SCREENWIDTH - 135 - 47, 50)];
            textView.font = H15;
            textView.textColor = kDefaultBlackTextColor;
            textView.backgroundColor = [UIColor whiteColor];
            textView.bounces = false;
            textView.placeholder = @"请输入医院地址";
            textView.placeholderColor = UIColorHex(0xcccccc);
            textView.text = [valueArray objectOrNilAtIndex:index];
            [contentView addSubview:textView];
            
            self. hospitalAddressTextView = textView;
            
        } else if (index == 3) {
            
            GHTextField *textField = [[GHTextField alloc] init];
            textField.backgroundColor = [UIColor whiteColor];
            textField.returnKeyType = UIReturnKeyDone;
            textField.font = H15;
            textField.textColor = kDefaultBlackTextColor;
            textField.leftSpace = 6;
            
            textField.placeholder = @"请输入法定代表人姓名";
            textField.text = [valueArray objectOrNilAtIndex:index];
            textField.frame = CGRectMake(135, [[topArray objectOrNilAtIndex:index] floatValue] - 8, SCREENWIDTH - 135 - 47, 50);
            textField.centerY = titleLabel.centerY;
            [contentView addSubview:textField];
            
            self.legalRepresentativeTextField = textField;
            
        } else if (index == 4) {
            
            GHTextField *textField = [[GHTextField alloc] init];
            textField.backgroundColor = [UIColor whiteColor];
            textField.returnKeyType = UIReturnKeyDone;
            textField.font = H15;
            textField.textColor = kDefaultBlackTextColor;
            textField.leftSpace = 6;
            
            textField.placeholder = @"请选择有效期";
            textField.text = [valueArray objectOrNilAtIndex:index];
            textField.frame = CGRectMake(135, [[topArray objectOrNilAtIndex:index] floatValue] - 8, SCREENWIDTH - 135 - 47, 50);
            textField.centerY = titleLabel.centerY;
            [contentView addSubview:textField];
            
            self.periodOfValidityTextField = textField;
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = textField.frame;
            [contentView addSubview:button];
            
            [button addTarget:self action:@selector(clickPeriodAction) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = kDefaultLineViewColor;
        [contentView addSubview:lineLabel];
        
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(127);
            make.height.mas_equalTo(1);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo([[topArray objectOrNilAtIndex:index + 1] floatValue] - 18);
        }];
        
        UIButton *cleanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cleanButton setImage:[UIImage imageNamed:@"ic_yiyuanbaocuo_quxiao"] forState:UIControlStateNormal];
        cleanButton.tag = index;
        [contentView addSubview:cleanButton];
        
        [cleanButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(42);
            make.right.mas_equalTo(-5);
            make.centerY.mas_equalTo(titleLabel);
        }];
        [cleanButton addTarget:self action:@selector(clickCleanAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (index == 5) {
            cleanButton.hidden = true;
            lineLabel.hidden = true;
        }
        
    }
    
    GHTextView *textView = [[GHTextView alloc] initWithFrame:CGRectMake(16, 351, SCREENWIDTH - 32, 128)];
    textView.font = H15;
    textView.textColor = kDefaultBlackTextColor;
    textView.backgroundColor = [UIColor whiteColor];
    textView.bounces = false;
    textView.placeholder = @"请输入经营范围";
    textView.placeholderColor = UIColorHex(0xcccccc);
    textView.layer.borderColor = UIColorHex(0xcccccc).CGColor;
    textView.layer.cornerRadius = 4;
    textView.layer.borderWidth = .5;
    textView.layer.masksToBounds = true;
    textView.text = businessScope;
    [contentView addSubview:textView];
    
    self.businessScopeTextView = textView;
    
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(textView.mas_bottom);
        make.height.mas_equalTo(150);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = @"营业执照图片";
    [view addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(25);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(16);
    }];
    
    JFMorePhotoView *picsPhotoView = [[JFMorePhotoView alloc] initWithCount:1];
    picsPhotoView.canAddCount = 1;
    
    if (pics.length) {
        picsPhotoView.imageUrlArray = @[pics];
    }
    
    [view addSubview:picsPhotoView];
    self.medicalQualificationCertificatePhotoView = picsPhotoView;
    
    [picsPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(90);
        make.top.mas_equalTo(60);
    }];
    
    [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(view.mas_bottom).offset(40);
    }];
    
    
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.backgroundColor = kDefaultBlueColor;
    submitButton.titleLabel.font = H18;
    submitButton.layer.cornerRadius = 4;
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:submitButton];
    
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(-20 + kBottomSafeSpace);
    }];
    [submitButton addTarget:self action:@selector(clickSubmitAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickCleanAction:(UIButton *)sender {
    
    if (sender.tag == 0) {
        self.idNumberTextField.text = @"";
    } else if (sender.tag == 1) {
        self.hospitalNameTextView.text = @"";
        self.hospitalNameTextView.placeholder = @"请输入医院名称";
    } else if (sender.tag == 2) {
        self.hospitalAddressTextView.text = @"";
        self.hospitalAddressTextView.placeholder = @"请输入医院地址";
    } else if (sender.tag == 3) {
        self.legalRepresentativeTextField.text = @"";
    } else if (sender.tag == 4) {
        self.periodOfValidityTextField.text = @"";
    }
    
}

- (void)clickPeriodAction {
    
    [self.idNumberTextField resignFirstResponder];
    [self.hospitalNameTextView resignFirstResponder];
    [self.hospitalAddressTextView resignFirstResponder];
    [self.legalRepresentativeTextField resignFirstResponder];
    [self.periodOfValidityTextField resignFirstResponder];
    
    [self.businessScopeTextView resignFirstResponder];
 
    self.chooseTimeView.hidden = false;
    
}

- (void)chooseFinishWithHospitalAuthenticationTime:(NSString *)time {
    
    self.periodOfValidityTextField.text = ISNIL(time);
    
}

- (void)clickSubmitAction {
    
    if (self.idNumberTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入证件号码"];
        return;
    }
    
    if ([NSString stringContainsEmoji:self.idNumberTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的证件号码,请勿输入特殊字符"];
        return;
    }
    
    if (self.hospitalNameTextView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入医院名称"];
        return;
    }
    
    if ([NSString stringContainsEmoji:self.hospitalNameTextView.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的医院名称,请勿输入特殊字符"];
        return;
    }
    
    if (self.hospitalAddressTextView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入医院地址"];
        return;
    }
    
    if ([NSString stringContainsEmoji:self.hospitalAddressTextView.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的医院地址,请勿输入特殊字符"];
        return;
    }
    
    if (self.legalRepresentativeTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入法定代表人姓名"];
        return;
    }
    
    if ([NSString stringContainsEmoji:self.legalRepresentativeTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的法定代表人姓名,请勿输入特殊字符"];
        return;
    }
    
    if (self.periodOfValidityTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择有效期"];
        return;
    }
    
    if (self.businessScopeTextView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入经营范围"];
        return;
    }
    
    if ([NSString stringContainsEmoji:self.businessScopeTextView.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的经营范围,请勿输入特殊字符"];
        return;
    }
    
    if ([self.medicalQualificationCertificatePhotoView getOnlyImageUrlArray].count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请上传营业执照"];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(uploadHospitalAuthenticationWithMaterials:)]) {
        
        NSMutableDictionary *qualityCertifyMaterials = [[NSMutableDictionary alloc] init];
        
        qualityCertifyMaterials[@"idNumber"] = self.idNumberTextField.text;
        qualityCertifyMaterials[@"certificateHospitalName"] = self.hospitalNameTextView.text;
        qualityCertifyMaterials[@"certificateHospitalAddress"] = self.hospitalAddressTextView.text;
        qualityCertifyMaterials[@"legalRepresentative"] = self.legalRepresentativeTextField.text;
        qualityCertifyMaterials[@"periodOfValidity"] = self.periodOfValidityTextField.text;
        qualityCertifyMaterials[@"businessScope"] = self.businessScopeTextView.text;
        
        qualityCertifyMaterials[@"pics"] = @[@{@"url": ISNIL([[self.medicalQualificationCertificatePhotoView getOnlyImageUrlArray] firstObject])}];
        
        [self.delegate uploadHospitalAuthenticationWithMaterials:[qualityCertifyMaterials jsonStringEncoded]];
        
        [self.navigationController popViewControllerAnimated:true];
        
    }
    
}


//    string
//    认证材料，JSON格式 ,{"":"证件号码",
//        "":"医院名称",
//        "":"医院地址",
//        "":"法人代表",
//        "":"有效期",
//        "":"经营范围",
//        "":[{"url":"照片URL"}, {"url":"照片2URL"}]}


@end

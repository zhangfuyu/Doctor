//
//  GHAddDoctorAuthenticationViewController.m
//  掌上优医
//
//  Created by GH on 2019/5/30.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHAddDoctorAuthenticationViewController.h"
#import "JFMorePhotoView.h"

@interface GHAddDoctorAuthenticationViewController ()

@property (nonatomic, strong) JFMorePhotoView *medicalQualificationCertificatePhotoView;

@property (nonatomic, strong) JFMorePhotoView *medicalPracticeCertificatePhotoView;

@end

@implementation GHAddDoctorAuthenticationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupUI];
    
    [self addRightButton:@selector(clickSaveAction) title:@"保存"];
    
    self.navigationItem.title = @"资质认证";
    
}

- (void)setupUI {
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [self.view addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    
//    NSDictionary *qualityCertifyMaterials = [self.qualityCertifyMaterials jsonValueDecoded];
    
    NSString *medicalQualificationCertificate = self.qualityCertifyMaterials[@"certificateUrl"];
    
    NSString *medicalPracticeCertificate = self.qualityCertifyMaterials[@"vocationalCertificateUrl"];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(150);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = @"执业医生资格证";
    [view addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(25);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(16);
    }];
    
    JFMorePhotoView *medicalQualificationCertificatePhotoView = [[JFMorePhotoView alloc] initWithCount:1];
    medicalQualificationCertificatePhotoView.canAddCount = 1;
    
    if (medicalQualificationCertificate.length) {
        medicalQualificationCertificatePhotoView.imageUrlArray = @[medicalQualificationCertificate];
    }
    
    [view addSubview:medicalQualificationCertificatePhotoView];
    self.medicalQualificationCertificatePhotoView = medicalQualificationCertificatePhotoView;
    
    [medicalQualificationCertificatePhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(90);
        make.top.mas_equalTo(60);
    }];
    
    
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view2];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(view.mas_bottom).offset(0);
        make.height.mas_equalTo(150);
    }];
    
    UILabel *titleLabel2 = [[UILabel alloc] init];
    titleLabel2.textColor = kDefaultBlackTextColor;
    titleLabel2.font = [UIFont systemFontOfSize:15];
    titleLabel2.text = @"医生执业证书";
    [view2 addSubview:titleLabel2];
    
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(25);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(16);
    }];
    
    
    JFMorePhotoView *medicalPracticeCertificatePhotoView = [[JFMorePhotoView alloc] initWithCount:1];
    medicalPracticeCertificatePhotoView.canAddCount = 1;
    
    if (medicalPracticeCertificate.length) {
        medicalPracticeCertificatePhotoView.imageUrlArray = @[medicalPracticeCertificate];
    }
    
    [view2 addSubview:medicalPracticeCertificatePhotoView];
    self.medicalPracticeCertificatePhotoView = medicalPracticeCertificatePhotoView;
    
    [medicalPracticeCertificatePhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(90);
        make.top.mas_equalTo(60);
    }];
    
}

- (void)clickSaveAction {
    
    if ([self.medicalQualificationCertificatePhotoView getOnlyImageUrlArray].count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请上传执业医生资格证"];
        return;
    }
    
    if ([self.medicalPracticeCertificatePhotoView getOnlyImageUrlArray].count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请上传医生执业证书"];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(uploadDoctorAuthenticationWithMaterials:)]) {
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        
        
        NSArray *certificateUrlIamgeArry =[self.medicalQualificationCertificatePhotoView getOnlyImageUrlArray];
        
        NSDictionary *imagedic = [certificateUrlIamgeArry firstObject];
        params[@"certificateUrl"] = imagedic[@"url"];
        
        
        NSArray *vocationalCertificateUrlArry = [self.medicalPracticeCertificatePhotoView getOnlyImageUrlArray];
            
        NSDictionary *vocationalCertificateUrlDic = [vocationalCertificateUrlArry firstObject];
        params[@"vocationalCertificateUrl"] = vocationalCertificateUrlDic[@"url"];
        
        [self.delegate uploadDoctorAuthenticationWithMaterials:params];

        
//        params[@"medicalQualificationCertificate"] = [[self.medicalQualificationCertificatePhotoView getOnlyImageUrlArray] firstObject];
//
//        params[@"medicalPracticeCertificate"] = [[self.medicalPracticeCertificatePhotoView getOnlyImageUrlArray] firstObject];
        
//        [self.delegate uploadDoctorAuthenticationWithMaterials:[params jsonStringEncoded]];
        
        [self.navigationController popViewControllerAnimated:true];
        
    }
    
}

@end

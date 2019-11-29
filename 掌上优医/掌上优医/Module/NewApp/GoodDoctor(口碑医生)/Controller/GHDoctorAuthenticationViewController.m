//
//  GHDoctorAuthenticationViewController.m
//  掌上优医
//
//  Created by GH on 2019/5/24.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHDoctorAuthenticationViewController.h"

@interface GHDoctorAuthenticationViewController ()

@end

@implementation GHDoctorAuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"资质认证";
    
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
        make.bottom.mas_equalTo(kBottomSafeSpace);
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
    
    //    {"medicalQualificationCertificate":"医师资格证书 - 照片URL",
    // “medicalPracticeCertificate":"医师执业证书 - 照片URL”
    NSString *medicalQualificationCertificate = self.qualification[@"medicalQualificationCertificate"];
    NSString *medicalPracticeCertificate = self.qualification[@"medicalPracticeCertificate"];
    
    UIImageView *medicalQualificationCertificateImageView;
    
    if (medicalQualificationCertificate.length) {
        
        UILabel *medicalQualificationCertificateTitleLabel = [[UILabel alloc] init];
        medicalQualificationCertificateTitleLabel.font = HB18;
        medicalQualificationCertificateTitleLabel.textColor = kDefaultBlueColor;
        medicalQualificationCertificateTitleLabel.text = @"执业医师资格证";
        [contentView addSubview:medicalQualificationCertificateTitleLabel];
        
        [medicalQualificationCertificateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(26);
            make.right.mas_equalTo(-26);
            make.height.mas_equalTo(52);
            make.top.mas_equalTo(0);
        }];
        
        medicalQualificationCertificateImageView = [[UIImageView alloc] init];
        medicalQualificationCertificateImageView.contentMode = UIViewContentModeScaleAspectFill;
        medicalQualificationCertificateImageView.userInteractionEnabled = true;
        [contentView addSubview:medicalQualificationCertificateImageView];
        
        [medicalQualificationCertificateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(16);
            make.right.mas_equalTo(-16);
            make.top.mas_equalTo(medicalQualificationCertificateTitleLabel.mas_bottom);
            make.height.mas_equalTo(1);
            
        }];
        
        [medicalQualificationCertificateImageView sd_setImageWithURL:kGetBigImageURLWithString(medicalQualificationCertificate) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (image.size.width > 0) {
                
                    [medicalQualificationCertificateImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.mas_equalTo(16);
                        make.right.mas_equalTo(-16);
                        make.top.mas_equalTo(medicalQualificationCertificateTitleLabel.mas_bottom);
                        make.height.mas_equalTo(((SCREENWIDTH - 32) / image.size.width)  * image.size.height);
                        
                    }];
                
            }
            
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickQualificationCertificateAction)];
        [medicalQualificationCertificateImageView addGestureRecognizer:tapGR];
        
        

        
    }
    
    if (medicalPracticeCertificate.length) {


        UILabel *medicalPracticeCertificateTitleLabel = [[UILabel alloc] init];
        medicalPracticeCertificateTitleLabel.font = HB18;
        medicalPracticeCertificateTitleLabel.textColor = kDefaultBlueColor;
        medicalPracticeCertificateTitleLabel.text = @"医师执业证书";
        [contentView addSubview:medicalPracticeCertificateTitleLabel];

        [medicalPracticeCertificateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(26);
            make.right.mas_equalTo(-26);
            if (medicalQualificationCertificateImageView == nil) {
                make.height.mas_equalTo(52);
                make.top.mas_equalTo(0);
            } else {
                make.height.mas_equalTo(52);
                make.top.mas_equalTo(medicalQualificationCertificateImageView.mas_bottom).offset(5);
            }

        }];

        UIImageView *medicalPracticeCertificateImageView = [[UIImageView alloc] init];
        medicalPracticeCertificateImageView.contentMode = UIViewContentModeScaleAspectFill;
        medicalPracticeCertificateImageView.userInteractionEnabled = true;
        [contentView addSubview:medicalPracticeCertificateImageView];

        [medicalPracticeCertificateImageView sd_setImageWithURL:kGetBigImageURLWithString(medicalPracticeCertificate) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

            if (image.size.width > 0) {

                [medicalPracticeCertificateImageView mas_makeConstraints:^(MASConstraintMaker *make) {

                    make.left.mas_equalTo(16);
                    make.right.mas_equalTo(-16);
                    make.top.mas_equalTo(medicalPracticeCertificateTitleLabel.mas_bottom);
                    make.height.mas_equalTo(((SCREENWIDTH - 32) / image.size.width)  * image.size.height);

                }];

            }

        }];

        [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(medicalPracticeCertificateImageView.mas_bottom).offset(16);
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPracticeCertificateAction)];
        [medicalPracticeCertificateImageView addGestureRecognizer:tapGR];


    } else {
        
        [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(medicalQualificationCertificateImageView.mas_bottom).offset(16);
        }];
        
    }
    
}

- (void)clickQualificationCertificateAction {
    
    kWeakSelf
    
    [[GHPhotoTool shareInstance] showBigImage:@[self.qualification[@"medicalQualificationCertificate"]] currentIndex:0 viewController:weakSelf cancelBtnText:@"取消"];
    
}


- (void)clickPracticeCertificateAction {
    
    kWeakSelf
    
    [[GHPhotoTool shareInstance] showBigImage:@[self.qualification[@"medicalPracticeCertificate"]] currentIndex:0 viewController:weakSelf cancelBtnText:@"取消"];
    
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

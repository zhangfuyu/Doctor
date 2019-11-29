//
//  GHHospitlAuthenticationViewController.m
//  掌上优医
//
//  Created by GH on 2019/5/25.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHospitlAuthenticationViewController.h"

@implementation GHHospitlAuthenticationViewController

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
    
//    string
//    认证材料，JSON格式 ,{"idNumber":"证件号码",
//        "certificateHospitalName":"医院名称",
//        "certificateHospitalAddress":"医院地址",
//        "legalRepresentative":"法人代表",
//        "periodOfValidity":"有效期",
//        "businessScope":"经营范围",
//        "pics":[{"url":"照片URL"}, {"url":"照片2URL"}]}
    
    NSString *idNumber = self.qualification[@"idNumber"];
    NSString *certificateHospitalName = self.qualification[@"certificateHospitalName"];
    NSString *certificateHospitalAddress = self.qualification[@"certificateHospitalAddress"];
    
    NSString *legalRepresentative = self.qualification[@"legalRepresentative"];
    NSString *periodOfValidity = self.qualification[@"periodOfValidity"];
    NSString *businessScope = self.qualification[@"businessScope"];
   
    NSString *pics;
    if ([self.qualification[@"pics"] isKindOfClass:[NSArray class]]) {
        pics = [self.qualification[@"pics"] firstObject][@"url"];
    }
    
    
    
    
    NSArray *titleArray = @[@"证件号码:", @"医院名称:", @"医院地址:", @"法定代表人:", @"有效期:", @"经营范围:"];
    NSArray *valueArray = @[ISNIL(idNumber), ISNIL(certificateHospitalName), ISNIL(certificateHospitalAddress), ISNIL(legalRepresentative), ISNIL(periodOfValidity), ISNIL(businessScope)];
    
    CGFloat top = 0;
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = H16;
        titleLabel.textColor = kDefaultGrayTextColor;
        titleLabel.text = ISNIL([titleArray objectOrNilAtIndex:index]);
        titleLabel.frame = CGRectMake(16, top, 110, 50);
        [contentView addSubview:titleLabel];
        
        UILabel *valueLabel = [[UILabel alloc] init];
        valueLabel.font = H15;
        valueLabel.textColor = kDefaultBlackTextColor;
        valueLabel.numberOfLines = 0;
        
        [contentView addSubview:valueLabel];
        
        NSString *value = [valueArray objectOrNilAtIndex:index];
        valueLabel.text = value;
        CGFloat height = [value heightForFont:valueLabel.font width:SCREENWIDTH - 130 - 16];
        
        if (height < 20) {
            height = 50;
        } else {
            height += 34;
        }
        
        valueLabel.frame = CGRectMake(130, top, SCREENWIDTH - 130 - 16, height);
        
        top += height;
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = kDefaultLineViewColor;
        [contentView addSubview:lineLabel];
        
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.height.mas_equalTo(1);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(top);
        }];
        
    }
    
    UIImageView *picImageView;
    
    if (pics.length) {
        
        picImageView = [[UIImageView alloc] init];
        picImageView.contentMode = UIViewContentModeScaleAspectFill;
        picImageView.userInteractionEnabled = true;
        [contentView addSubview:picImageView];
        
        [picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(16);
            make.right.mas_equalTo(-16);
            make.top.mas_equalTo(top + 8);
            make.height.mas_equalTo(1);
            
        }];
        
        [picImageView sd_setImageWithURL:kGetBigImageURLWithString(pics) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (image.size.width > 0) {
                
                [picImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.mas_equalTo(16);
                    make.right.mas_equalTo(-16);
                    make.top.mas_equalTo(top + 8);
                    make.height.mas_equalTo(((SCREENWIDTH - 32) / image.size.width)  * image.size.height);
                    
                }];
                
            } else {
                
                [picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.mas_equalTo(16);
                    make.right.mas_equalTo(-16);
                    make.top.mas_equalTo(top + 8);
                    make.height.mas_equalTo(1);
                    
                }];
                
            }
            
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPicAction)];
        [picImageView addGestureRecognizer:tapGR];
        
        
    }
    
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.font = H12;
    tipsLabel.text = @"注：以上资质信息，来源于商家自行申报及工商系统数据，具体以工商部门登记为准．商家需保证信息真实有效，平台也将定期核查，如与实际不符，如有疑问，请联系平台客服";
    tipsLabel.textColor = kDefaultGrayTextColor;
    tipsLabel.numberOfLines = 0;
    [contentView addSubview:tipsLabel];
    
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        
        if (picImageView == nil) {
            make.top.mas_equalTo(top);
        } else {
            make.top.mas_equalTo(picImageView.mas_bottom);
        }
        
        make.height.mas_equalTo([tipsLabel.text heightForFont:tipsLabel.font width:SCREENWIDTH - 32] + 30);
        
    }];
    
    [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(tipsLabel.mas_bottom);
    }];
    
    
    
}

- (void)clickPicAction {
    
    kWeakSelf
    NSString *pics;
    if ([self.qualification[@"pics"] isKindOfClass:[NSArray class]]) {
        pics = [self.qualification[@"pics"] firstObject][@"url"];
    }
    
    if (pics.length) {
            [[GHPhotoTool shareInstance] showBigImage:@[pics] currentIndex:0 viewController:weakSelf cancelBtnText:@"取消"];
    }
    
}

@end

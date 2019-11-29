//
//  GHNewHospitalSecondViewController.m
//  掌上优医
//
//  Created by apple on 2019/8/16.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewHospitalSecondViewController.h"

@interface GHNewHospitalSecondViewController ()

@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, strong)NSMutableArray *departmentTitleArray;//科室数组

@property (nonatomic, strong)UILabel *hospitalContentLabel;

@property (nonatomic, strong)UIButton *arrowButton;

@property (nonatomic, assign)float contentTextHeight;

@property (nonatomic, strong)UIScrollView *bigContentView;


@end

@implementation GHNewHospitalSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = @"医院信息";
    
    [self setupUI];
}

- (void)setupUI {
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT);
    
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    
    UIView *lineview1 = [[UIView alloc]init];
    lineview1.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
    [contentView addSubview:lineview1];
    
    [lineview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);

        make.height.mas_equalTo(5);
    }];
    
    self.contentHeight += 5;

    self.contentHeight += 15;


    UIImageView *hospitalIntrudeIconImageView = [[UIImageView alloc] init];
    hospitalIntrudeIconImageView.contentMode = UIViewContentModeCenter;
    hospitalIntrudeIconImageView.image = [UIImage imageNamed:@"hospital_left"];
    [contentView addSubview:hospitalIntrudeIconImageView];
    
    [hospitalIntrudeIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(19);
        make.height.mas_equalTo(19);
        make.top.mas_equalTo(15);
    }];
    
    UILabel *hospitalIntruderTitleLabel = [[UILabel alloc] init];
    hospitalIntruderTitleLabel.font = HM18;
    hospitalIntruderTitleLabel.textColor = kDefaultBlackTextColor;
    hospitalIntruderTitleLabel.text = @"医院简介";
    [contentView addSubview:hospitalIntruderTitleLabel];
    
    [hospitalIntruderTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(hospitalIntrudeIconImageView.mas_right).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);

        make.height.mas_equalTo(18);
    }];
    
    self.contentHeight +=19;
    
    self.contentHeight += 17;
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.maximumLineHeight = 21;
    paragraphStyle.minimumLineHeight = 21;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:ISNIL(self.model.introduction)];
    
    [attr addAttributes:@{NSFontAttributeName: H15} range:NSMakeRange(0, attr.string.length)];
    [attr addAttributes:@{NSForegroundColorAttributeName: kDefaultBlackTextColor} range:NSMakeRange(0, attr.string.length)];
    
    [attr addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, attr.string.length)];
    
    CGFloat shouldHeight = [ISNIL(self.model.introduction) getShouldHeightWithContent:attr.string withFont:H15 withWidth:SCREENWIDTH - 30 withLineHeight:21];
    
    self.contentTextHeight = shouldHeight;
    
    self.hospitalContentLabel = [[UILabel alloc] init];
    self.hospitalContentLabel.numberOfLines = 0;
    self.hospitalContentLabel.textColor = kDefaultBlackTextColor;
    self.hospitalContentLabel.attributedText = attr;
    self.hospitalContentLabel.font = H15;
    [contentView addSubview:self.hospitalContentLabel];
    
    self.arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.arrowButton setImage:[UIImage imageNamed:@"ic_yiyuanzhuye_gengduo"] forState:UIControlStateNormal];
    [self.arrowButton setImage:[UIImage imageNamed:@"ic_yiyuanzhuye_shouqi"] forState:UIControlStateSelected];
    self.arrowButton.backgroundColor = [UIColor whiteColor];
    [self.arrowButton addTarget:self action:@selector(clickOpenAction:) forControlEvents:UIControlEventTouchUpInside];

    [contentView addSubview:self.arrowButton];
    
    
    if (shouldHeight > 50) {
        shouldHeight = 50;
        
        self.contentHeight += 38;
        self.arrowButton.hidden = NO;


    }
    else
    {
        self.arrowButton.hidden = YES;
    }
    
    self.contentHeight += shouldHeight;
    
    self.contentHeight += 15;
   
    
    [self.hospitalContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.top.mas_equalTo(hospitalIntrudeIconImageView.mas_bottom).offset(17);
        make.height.mas_equalTo(shouldHeight);
    }];
    
    [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.hospitalContentLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(38);
        
    }];
    
    
    UIView *lineview2 = [[UIView alloc]init];
    lineview2.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
    [contentView addSubview:lineview2];
    
    [lineview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        if (self.arrowButton.hidden) {
            make.top.mas_equalTo(self.hospitalContentLabel.mas_bottom).offset(15);

        }
        else
        {
            make.top.mas_equalTo(self.arrowButton.mas_bottom);

        }
        make.height.mas_equalTo(5);
    }];
    
    
    self.contentHeight += 5;
    
    self.contentHeight += 15;
    
    UIImageView *leftImageview = [[UIImageView alloc]init];
    leftImageview.image = [UIImage imageNamed:@"hospital_detail"];
    [contentView addSubview:leftImageview];
    
    [leftImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(19, 19));
        make.top.mas_equalTo(lineview2.mas_bottom).offset(15);
    }];
    
    UILabel *menzhenTime = [[UILabel alloc]init];
    menzhenTime.font = H15;
    menzhenTime.text = [NSString stringWithFormat:@"门诊：%@", ISNIL(self.model.outpatientDepartmentTime)];
    menzhenTime.textColor = kDefaultBlackTextColor;
    [contentView addSubview:menzhenTime];
    
    [menzhenTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftImageview.mas_right).offset(15);
        make.top.mas_equalTo(lineview2.mas_bottom).offset(18);
        make.right.mas_equalTo(self.view.mas_right);

        make.height.mas_equalTo(15);
    }];
    
    
    self.contentHeight += 15;

    self.contentHeight += 10;

    
    UILabel *jizhenTime = [[UILabel alloc]init];
    jizhenTime.font = H15;
    jizhenTime.text = [NSString stringWithFormat:@"急诊：%@", ISNIL(self.model.emergencyTreatmentTime)];
    jizhenTime.textColor = kDefaultBlackTextColor;
    [contentView addSubview:jizhenTime];
    
    [jizhenTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftImageview.mas_right).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.top.mas_equalTo(menzhenTime.mas_bottom).offset(10);
        make.height.mas_equalTo(15);
    }];
    
    self.contentHeight += 15;

    self.contentHeight += 15;

    UIView *lineview3 = [[UIView alloc]init];
    lineview3.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
    [contentView addSubview:lineview3];
    
    [lineview3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(jizhenTime.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    
    self.contentHeight += 1;
    
    self.contentHeight += 15;

    
    UIImageView *hospitalSheshiIconImageView = [[UIImageView alloc] init];
    hospitalSheshiIconImageView.contentMode = UIViewContentModeCenter;
    hospitalSheshiIconImageView.image = [UIImage imageNamed:@"hospital_detail"];
    [contentView addSubview:hospitalSheshiIconImageView];
    
    [hospitalSheshiIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(19, 19));
        make.top.mas_equalTo(lineview3.mas_bottom).offset(15);
    }];
    
    UILabel *hospitalfuwu = [[UILabel alloc] init];
    hospitalfuwu.font = HM15;
    hospitalfuwu.textColor = kDefaultBlackTextColor;
    hospitalfuwu.text = @"医院服务";
    [contentView addSubview:hospitalfuwu];
    
    [hospitalfuwu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineview3.mas_bottom).offset(18);
        make.left.mas_equalTo(hospitalSheshiIconImageView.mas_right).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.height.mas_equalTo(15);
    }];
    
    self.contentHeight += 19;
    
    
    NSArray *shesheSelectedArray = [self.model.hospitalFacility componentsSeparatedByString:@","];
    
    UIView *hotContentView = [[UIView alloc] init];
    hotContentView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:hotContentView];
    
    [hotContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(hospitalSheshiIconImageView.mas_bottom).offset(15);
    }];
    
    self.contentHeight += 15;

    
    float newX = 15;
    float newMaxHeigt = 0;
    
    for (NSInteger index =0; index < shesheSelectedArray.count; index ++) {
        UILabel *subLabel = [[UILabel alloc]init];
        subLabel.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
        subLabel.font = H12;
        subLabel.textAlignment = NSTextAlignmentCenter;
        subLabel.textColor = [UIColor colorWithHexString:@"999999"];
        subLabel.layer.cornerRadius = 2;
        subLabel.layer.masksToBounds = YES;
        subLabel.text = shesheSelectedArray[index];
        [hotContentView addSubview:subLabel];
        
        if (SCREENWIDTH - newX > [subLabel.text widthForFont:subLabel.font] + 24 + 10) {
            subLabel.frame = CGRectMake(newX, newMaxHeigt, [ subLabel.text widthForFont:subLabel.font] + 24, 20);
            newX += [ subLabel.text widthForFont:subLabel.font] + 24 + 10;
        }
        else
        {
            newMaxHeigt += 20 +10;
            newX = 15;
            
            subLabel.frame = CGRectMake(newX, newMaxHeigt, [ subLabel.text widthForFont:subLabel.font] + 24, 20);

        }
    }
    
    self.contentHeight += newMaxHeigt + 20 + 15;

    
    [hotContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(newMaxHeigt + 20 + 15);

    }];
    
    UIView *lineview4 = [[UIView alloc]init];
    lineview4.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
    [contentView addSubview:lineview4];
    
    [lineview4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(hotContentView.mas_bottom).offset(1);
        make.height.mas_equalTo(1);
    }];
    
    self.contentHeight += 1;
    
    self.contentHeight += 15;

    
    UIImageView *tesekeshi = [[UIImageView alloc] init];
    tesekeshi.contentMode = UIViewContentModeCenter;
    tesekeshi.image = [UIImage imageNamed:@"hospital_detail"];
    [contentView addSubview:tesekeshi];
    
    [tesekeshi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(19, 19));
        make.top.mas_equalTo(lineview4.mas_bottom).offset(15);
    }];
    
    UILabel *tesekeshiLabel = [[UILabel alloc] init];
    tesekeshiLabel.font = HM15;
    tesekeshiLabel.textColor = kDefaultBlackTextColor;
    tesekeshiLabel.text = @"特色科室";
    [contentView addSubview:tesekeshiLabel];
    
    [tesekeshiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineview4.mas_bottom).offset(18);
        make.left.mas_equalTo(hospitalSheshiIconImageView.mas_right).offset(15);
        make.height.mas_equalTo(15);
    }];
    
    self.contentHeight += 15;
    
    UIView *departmentView = [[UIView alloc]init];
    departmentView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:departmentView];
    [departmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(tesekeshi.mas_bottom).offset(15);
    }];
    
    
    float departX = 15;
    float departY = 0;
    
    for (NSInteger index = 0; index < self.departmentTitleArray.count; index ++) {
        
        
        NSString *str = self.departmentTitleArray[index];
        
        UIButton *sicknessButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sicknessButton.layer.cornerRadius = 3;
        sicknessButton.layer.borderWidth = 1;
        sicknessButton.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
        sicknessButton.titleLabel.font = H11;
        sicknessButton.tag = index;
        
        [sicknessButton setTitle:str forState:UIControlStateNormal];
        [sicknessButton setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        sicknessButton.layer.masksToBounds = true;
        
        [departmentView addSubview:sicknessButton];
        
        if (SCREENHEIGHT - departX > [str widthForFont:sicknessButton.titleLabel.font] + 30 + 10) {
            
            sicknessButton.frame = CGRectMake(departX, departX, [str widthForFont:sicknessButton.titleLabel.font] + 30, 27);
            departX += [str widthForFont:sicknessButton.titleLabel.font] + 30 + 10;
        }
        else
        {
            departY += 27 +10;
            departX = 15;
            
            sicknessButton.frame = CGRectMake(departX, departX, [str widthForFont:sicknessButton.titleLabel.font] + 30, 27);

            
        }
    }
    
    [departmentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(departY + 27 + 15);
        
    }];
    
    self.contentHeight += departY + 27 + 15;
    
    
    UIView *lineview5 = [[UIView alloc]init];
    lineview5.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
    [contentView addSubview:lineview5];
    
    [lineview5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(departmentView.mas_bottom).offset(1);
        make.height.mas_equalTo(1);
    }];
    
    self.contentHeight += 1;
    
    self.contentHeight += 15;
    
    
    UIImageView *zizhirenzheng = [[UIImageView alloc] init];
    zizhirenzheng.contentMode = UIViewContentModeCenter;
    zizhirenzheng.image = [UIImage imageNamed:@"hospital_detail"];
    [contentView addSubview:zizhirenzheng];
    
    [zizhirenzheng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(19, 19));
        make.top.mas_equalTo(lineview5.mas_bottom).offset(15);
    }];
    
    UILabel *zizhirenzhengLabel = [[UILabel alloc] init];
    zizhirenzhengLabel.font = HM15;
    zizhirenzhengLabel.textColor = kDefaultBlackTextColor;
    zizhirenzhengLabel.text = @"资质认证";
    [contentView addSubview:zizhirenzhengLabel];
    
    [zizhirenzhengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineview5.mas_bottom).offset(18);
        make.left.mas_equalTo(zizhirenzheng.mas_right).offset(15);
        make.height.mas_equalTo(15);
    }];
    
    self.contentHeight += 19;
    
    self.contentHeight += 15;

    
    NSDictionary *qualification = [self.model.qualityCertifyMaterials jsonValueDecoded];
    NSString *idNumber = qualification[@"idNumber"];
    NSString *certificateHospitalName = qualification[@"certificateHospitalName"];
    NSString *certificateHospitalAddress = qualification[@"certificateHospitalAddress"];
    
    NSString *legalRepresentative = qualification[@"legalRepresentative"];
    NSString *periodOfValidity = qualification[@"periodOfValidity"];
    NSString *businessScope = qualification[@"businessScope"];
    
    NSString *pics;
    if ([qualification[@"pics"] isKindOfClass:[NSArray class]]) {
        pics = [qualification[@"pics"] firstObject][@"url"];
    }
    
    
    
    
    NSArray *titleArray = @[@"证件号码:", @"医院名称:", @"医院地址:", @"法定代表人:", @"有效期:", @"经营范围:"];
    NSArray *valueArray = @[ISNIL(idNumber), ISNIL(certificateHospitalName), ISNIL(certificateHospitalAddress), ISNIL(legalRepresentative), ISNIL(periodOfValidity), ISNIL(businessScope)];
    
    self.contentHeight += 15;
    
    UIView *titleBigView = [[UIView alloc]init];
    titleBigView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:titleBigView];
    
    [titleBigView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(zizhirenzheng.mas_bottom).offset(15);
    }];
    
    float bigviewY = 0;
    
    for (NSInteger index = 0; index < titleArray.count; index ++) {
        
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(15, bigviewY, SCREENHEIGHT - 10, 12)];
        titleLable.textColor = [UIColor colorWithHexString:@"333333"];
        titleLable.font = H12;
        titleLable.text = [NSString stringWithFormat:@"%@%@",titleArray[index],valueArray[index]];
        [titleBigView addSubview:titleLable];
        
        bigviewY += 12;
        
        bigviewY += 15;

    }
    
    [titleBigView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(bigviewY);
    }];
    
    self.contentHeight += bigviewY;
    
    UIView *lineview6 = [[UIView alloc]init];
    lineview6.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
    [contentView addSubview:lineview6];
    
    [lineview6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(titleBigView.mas_bottom).offset(1);
        make.height.mas_equalTo(1);
    }];
    
    self.contentHeight += 1;
    
    self.contentHeight += 15;

    
    UIImageView *picImageView;
    
    if (pics.length) {
        
        picImageView = [[UIImageView alloc] init];
        picImageView.contentMode = UIViewContentModeScaleAspectFill;
        picImageView.userInteractionEnabled = true;
        [contentView addSubview:picImageView];
        
        [picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(lineview6.mas_bottom).offset(15);
            make.height.mas_equalTo(1);
            
        }];
        
        [picImageView sd_setImageWithURL:kGetBigImageURLWithString(pics) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (image.size.width > 0) {
                
                [picImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.mas_equalTo(15);
                    make.right.mas_equalTo(self.view.mas_right).offset(-15);
                    make.top.mas_equalTo(lineview6.mas_bottom).offset(15);
                    make.height.mas_equalTo(((SCREENWIDTH - 30) / image.size.width)  * image.size.height);
                    
                    
                }];
                self.contentHeight += ((SCREENWIDTH - 30) / image.size.width)  * image.size.height + 10;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    contentView.contentSize = CGSizeMake(SCREENWIDTH, self.contentHeight);
                    
                });

                
            } else {
                
                [picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.mas_equalTo(15);
                    make.right.mas_equalTo(self.view.mas_right).offset(-15);
                    make.top.mas_equalTo(lineview6.mas_bottom).offset(15);
                    make.height.mas_equalTo(1);
                    
                }];
                dispatch_async(dispatch_get_main_queue(), ^{
                    contentView.contentSize = CGSizeMake(SCREENWIDTH, self.contentHeight);

                });

            }
            
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPicAction)];
        [picImageView addGestureRecognizer:tapGR];
        
    }
    
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.font = H12;
    tipsLabel.text = @"注：以上资质信息，来源于商家自行申报及工商系统数据，具体以工商部门登记为准．商家需保证信息真实有效，平台也将定期核查，如与实际不符，如有疑问，请联系平台客服";
    tipsLabel.textColor = [UIColor colorWithHexString:@"999999"];
    tipsLabel.numberOfLines = 0;
    [contentView addSubview:tipsLabel];
    
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        if (picImageView == nil) {
            make.top.mas_equalTo(lineview6.mas_bottom).offset(15);
        } else {
            make.top.mas_equalTo(picImageView.mas_bottom).offset(30);
        }
        
        make.height.mas_equalTo([tipsLabel.text heightForFont:H12 width:SCREENWIDTH - 30]);
        
    }];
    
    if (picImageView == Nil) {
        self.contentHeight += [tipsLabel.text heightForFont:tipsLabel.font width:SCREENWIDTH - 30];

    }
    else
    {
        self.contentHeight += [tipsLabel.text heightForFont:tipsLabel.font width:SCREENWIDTH - 30] + 30;

    }
    
    
    contentView.contentSize = CGSizeMake(SCREENWIDTH, self.contentHeight);
    self.bigContentView = contentView;

    
    
}

- (void)clickOpenAction:(UIButton *)sender {
    
    if (sender.selected == false) {
        
        [self.hospitalContentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.contentTextHeight);
        }];
        
        sender.selected = true;
        
        self.bigContentView.contentSize = CGSizeMake(SCREENWIDTH, self.contentHeight - 50 + self.contentTextHeight);
//        self.tableView.tableHeaderView = self.headerView;
        
    } else {
        
        [self.hospitalContentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
        }];
        
        sender.selected = false;
        self.bigContentView.contentSize = CGSizeMake(SCREENWIDTH, self.contentHeight);

//        self.headerView.frame = CGRectMake(0, 0, SCREENWIDTH, self.contentHeight);
//        self.tableView.tableHeaderView = self.headerView;
        
    }
    
}

- (void)clickPicAction {
    
    kWeakSelf
    NSDictionary *qualification = [self.model.qualityCertifyMaterials jsonValueDecoded];

    NSString *pics;
    if ([qualification[@"pics"] isKindOfClass:[NSArray class]]) {
        pics = [qualification[@"pics"] firstObject][@"url"];
    }
    
    if (pics.length) {
        [[GHPhotoTool shareInstance] showBigImage:@[pics] currentIndex:0 viewController:weakSelf cancelBtnText:@"取消"];
    }
    
}

- (NSMutableArray *)departmentTitleArray {
    
    if (!_departmentTitleArray) {
        _departmentTitleArray = [[NSMutableArray alloc] init];
    }
    return _departmentTitleArray;
    
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

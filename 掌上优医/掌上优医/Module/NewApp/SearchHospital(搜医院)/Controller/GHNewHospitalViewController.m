//
//  GHNewHospitalViewController.m
//  掌上优医
//
//  Created by apple on 2019/8/15.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewHospitalViewController.h"
#import "GHHospitalCommentViewController.h"//点评医院
#import "GHMyCommentsModel.h"
#import "GHHospitalDetailCommentTableViewCell.h"
#import "GHHospitalCommentListViewController.h"
#import "GHHospitalCommentDetailViewController.h"
#import "GHHospitalDetailInfoErrorViewController.h"
#import "GHNewHospitalSecondViewController.h"

#import "GHSearchDoctorModel.h"//医生cellmodel
#import "GHDoctorCommentModel.h"//评论model
#import <MapKit/MapKit.h>
#import "GHNewDepartMentModel.h"//科室model
#import "GHCommonShareView.h"
#import "GHNewDoctorTableViewCell.h"
#import "GHNewDoctorDetailViewController.h"
#import "GHHospitalDepartmentViewController.h"
#import "GHHospitalDepartmentDoctorListViewController.h"

#define ForegroundStarImage @"ic_xingxing_all_selected"
#define BackgroundStarImage @"ic_xingxing_all_unselected"

@interface GHNewHospitalViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) GHCommonShareView *shareView;

@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, strong) UITableView *dataTabelview;

@property (nonatomic, strong) NSMutableArray *commentArry;

@property (nonatomic, strong) UIView *moreCommentView;

@property (nonatomic, strong) UILabel *commentTotalLabel;

@property (nonatomic, strong) UILabel *departmentTotalLabel;

@property (nonatomic, strong) UILabel *timerLabel;

@property (nonatomic, strong) NSMutableArray *doctorListArry;

@property (nonatomic, strong) UIButton *collectionButton;

@property (nonatomic, strong) NSMutableArray *departmentArray;

@property (nonatomic, strong) NSString *departmentName;//科室name

@property (nonatomic, strong) NSString *departmentid;//科室id

@property (nonatomic, strong) UIView *departmentView;

@property (nonatomic, strong) UIView *departmentFootView;

@property (nonatomic, strong) UIButton *moredoctor;
@end

@implementation GHNewHospitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"医院主页";
    
    [self addNavigationRightView];
    [self getDataAction];
    [self getCommentDataAction];
//    [self getDepartmentDate];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCommentDataAction) name:kNotificationHospitalCommentSuccess object:nil];

    
}
- (void)addNavigationRightView {
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 86, 44);
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:[UIImage imageNamed:@"icon_hospital_share"] forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(0, 0, 50, 44);
    
    [shareButton addTarget:self action:@selector(clickShareAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectionButton setImage:[UIImage imageNamed:@"icon_hospital_uncollection"] forState:UIControlStateNormal];
    [collectionButton setImage:[UIImage imageNamed:@"icon_hospital_collection"] forState:UIControlStateSelected];
    collectionButton.frame = CGRectMake(0, 0, 30, 44);
    self.collectionButton = collectionButton;
    
    [collectionButton addTarget:self action:@selector(clickCollectionAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBtn1 = [[UIBarButtonItem alloc] initWithCustomView:collectionButton];
    UIBarButtonItem *rightBtn2 = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItems = @[rightBtn2, rightBtn1];
    
    
}

- (void)ctratUI
{

    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.backgroundColor = kDefaultBlueColor;
    [commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commentButton setImage:[UIImage imageNamed:@"doctor_comment_new"] forState:UIControlStateNormal];
    [commentButton setTitle:@"写评价" forState:UIControlStateNormal];
    commentButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
    commentButton.titleLabel.font = H17;
    [commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:commentButton];
    
    [commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(47);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    [commentButton addTarget:self action:@selector(clickCommentAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.dataTabelview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.dataTabelview.delegate = self;
    self.dataTabelview.dataSource = self;
    [self.view addSubview:self.dataTabelview];
    
    
    [self.dataTabelview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(commentButton.mas_top);
    }];
    
    
    [self setupTableHeaderView];
    
    
}
- (void)setupTableHeaderView {

    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    
    
    self.contentHeight = 0;
    
    UIScrollView *infoScrollView = [[UIScrollView alloc] init];
    infoScrollView.frame = CGRectMake(0, 0, SCREENWIDTH, HScaleHeight(184));
    infoScrollView.backgroundColor = [UIColor whiteColor];
    infoScrollView.showsVerticalScrollIndicator = false;
    infoScrollView.showsHorizontalScrollIndicator = false;
    [contentView addSubview:infoScrollView];
    
    NSMutableArray *urlArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in [self.model.pictures jsonValueDecoded]) {
        [urlArray addObject:ISNIL(dic[@"url"])];
    }
    
    if (urlArray.count > 0) {
        [urlArray insertObject:self.model.profilePhoto atIndex:0];
    }
    else
    {
        if (self.model.profilePhoto.length > 0) {
            [urlArray addObject:ISNIL(self.model.profilePhoto)];

        }
    }
    
    
    for (NSInteger index = 0; index < urlArray.count; index++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.tag = index;
        
        imageView.userInteractionEnabled = true;
        imageView.width = SCREENWIDTH - 15 - 26;
        imageView.height = HScaleHeight(160);
        imageView.mj_y = HScaleHeight(10);
        imageView.mj_x = 15 + (SCREENWIDTH - 15 - 26 + 10) * index;
        [imageView sd_setImageWithURL:kGetBigImageURLWithString([urlArray objectOrNilAtIndex:index]) placeholderImage:[UIImage imageNamed:@"hospital_detail_placeholder"]];
        
        [infoScrollView addSubview:imageView];
        
        if (urlArray.count == 1) {
            imageView.width = SCREENWIDTH - 15 - 15;
        }
        
        imageView.layer.cornerRadius = 4;
        imageView.layer.masksToBounds = true;
        
        UIButton *signButton = [UIButton buttonWithType:UIButtonTypeCustom];
        signButton = signButton;
        signButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        signButton.titleLabel.font = H14;
        
        [signButton setImage:[UIImage imageNamed:@"hospital_image_sign"] forState:UIControlStateNormal];
        [signButton setTitle:[NSString stringWithFormat:@" %lu", (unsigned long)urlArray.count] forState:UIControlStateNormal];
        
        signButton.layer.cornerRadius = 12.5;
        signButton.layer.masksToBounds = true;
        
        signButton.width = 50;
        signButton.height = 25;
        signButton.mj_y = MaxY(imageView) - 25 - 8;
        signButton.mj_x = MaxX(imageView) - 50 - 8;
        [infoScrollView addSubview:signButton];
        
        UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPhotoAction:)];
        [imageView addGestureRecognizer:tapGr];
        
    }
    
    if (urlArray.count == 0) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.layer.cornerRadius = 4;
        imageView.layer.masksToBounds = true;
        imageView.size = CGSizeMake(SCREENWIDTH - 15 - 15, HScaleHeight(160));
        imageView.mj_y = HScaleHeight(10);
        imageView.mj_x = 16;
        imageView.image = [UIImage imageNamed:@"hospital_detail_placeholder"];
        [infoScrollView addSubview:imageView];
        
        infoScrollView.contentSize = CGSizeMake(SCREENWIDTH, HScaleHeight(180));
        
    } else if (urlArray.count == 1) {
        
        infoScrollView.contentSize = CGSizeMake(SCREENWIDTH, HScaleHeight(180));
        
    } else {
        infoScrollView.contentSize = CGSizeMake(30 - 10 + (SCREENWIDTH - 15 - 26 + 10) * urlArray.count, HScaleHeight(180));
    }
    
    self.contentHeight += HScaleHeight(180);
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kDefaultBlackTextColor;
    nameLabel.font = [UIFont boldSystemFontOfSize:20];
    nameLabel.text = self.model.hospitalName;//[GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.hospitalName)];
    nameLabel.numberOfLines = 0;
    nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [contentView addSubview:nameLabel];
    
//    CGFloat nameLabelHeight = [self.model.hospitalName heightForFont:nameLabel.font width:(SCREENWIDTH - 30)];
    
    CGFloat nameLabelHeight =  [nameLabel sizeThatFits:CGSizeMake(SCREENWIDTH - 30,CGFLOAT_MAX)].height;
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(nameLabelHeight);
        make.top.mas_equalTo(infoScrollView.mas_bottom).offset(15);
    }];
    
    self.contentHeight += 15;
    self.contentHeight += nameLabelHeight;
    self.contentHeight += 15;

    
    
//    NSArray *imageNameArray = @[@"icon_hospital_level", @"icon_hospital_category", @"icon_hospital_yibao", @"icon_hospital_sigong",@"icon_hospital_level"];
    NSArray *imageNameArray = @[@"left_sub", @"left_sub", @"left_sub", @"left_sub",@"left_sub"];
    
    
    NSMutableArray *titleArray = [NSMutableArray arrayWithCapacity:0];
    [titleArray addObject:ISNIL(self.model.hospitalGrade)];
    [titleArray addObject:ISNIL(self.model.category)];
    [titleArray addObject:[self.model.medicalInsuranceFlag integerValue] == 1 ? @"支持医保" : @"不支持医保"];
    if (self.model.governmentalHospitalFlag.length > 0) {
         [titleArray addObject:self.model.governmentalHospitalFlag];
    }

    
    if (self.model.medicineType.length != 0) {
        [titleArray addObject:self.model.medicineType];

    }
//    NSArray *titleArray = @[ISNIL(self.model.hospitalGrade),
//                            ISNIL(self.model.category),
//                            [self.model.medicalInsuranceFlag integerValue] == 1 ? @"支持医保" : @"不支持医保",
//                            [self.model.governmentalHospitalFlag integerValue] == 1 ? @"私立" : @"公立",
//                            self.model.medicineType.length == 0 ? @"": self.model.medicineType,
//                            ];
    
    CGFloat shouldX = 15;
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        
//        shouldX += 8;
        
        NSString *subStr = [titleArray objectAtIndex:index];
        
        if (kScreenWidth - 15- 15 - shouldX - 5 <  [subStr widthForFont:H12] + 12) {
            
            self.contentHeight += 12;
            
            self.contentHeight += 10;
            
            
            
            
            shouldX = 15;
        }
        
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        iconImageView.image = [UIImage imageNamed:ISNIL([imageNameArray objectOrNilAtIndex:index])];
        iconImageView.mj_x = shouldX;
        iconImageView.width = 12;
        iconImageView.height = 12;
        iconImageView.mj_y = self.contentHeight;
        [contentView addSubview:iconImageView];
        
        shouldX += 12;
        
        shouldX += 5;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = H12;
        titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        titleLabel.text = ISNIL([titleArray objectOrNilAtIndex:index]);
        titleLabel.mj_x = shouldX;
        titleLabel.width = [titleLabel.text widthForFont:H12];
        titleLabel.height = 12;
        titleLabel.mj_y = iconImageView.mj_y;
        [contentView addSubview:titleLabel];
        
        shouldX += [titleLabel.text widthForFont:H12];
        
        shouldX += HScaleHeight(15);;

    }
    self.contentHeight += 12;

    
    self.contentHeight += 10;
    
    
    
    UIImageView *backgroundStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:BackgroundStarImage]];
    backgroundStarView.contentMode = UIViewContentModeLeft;
    backgroundStarView.clipsToBounds = true;
    [contentView addSubview:backgroundStarView];
    
    [backgroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(15 * 5);
        make.top.mas_equalTo(self.contentHeight);
    }];
    
    UIImageView *foregroundStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:ForegroundStarImage]];
    foregroundStarView.contentMode = UIViewContentModeLeft;
    foregroundStarView.clipsToBounds = true;
    [contentView addSubview:foregroundStarView];
    
    [foregroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(15 * .5 * [self.model.comprehensiveScore floatValue]);
        make.top.mas_equalTo(self.contentHeight);
    }];
    
    self.contentHeight += 15;
    
    UILabel *hospitalScoreLabel = [[UILabel alloc] init];
    hospitalScoreLabel.textColor = UIColorHex(0xFF6188);
    hospitalScoreLabel.font = HM14;
    hospitalScoreLabel.text = [NSString stringWithFormat:@"%.1f分", [self.model.comprehensiveScore floatValue]];
    [contentView addSubview:hospitalScoreLabel];
    
    [hospitalScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.left.mas_equalTo(backgroundStarView.mas_right).offset(5);
        make.top.bottom.mas_equalTo(backgroundStarView);
    }];
    
    UILabel *hospitalOtherScoreLabel = [[UILabel alloc] init];
    hospitalOtherScoreLabel.font = H12;
    hospitalOtherScoreLabel.textColor = kDefaultGrayTextColor;
    hospitalOtherScoreLabel.text = [NSString stringWithFormat:@"环境: %.1f分   服务: %.1f分", [self.model.environmentScore floatValue], [self.model.serviceScore floatValue]];
    [contentView addSubview:hospitalOtherScoreLabel];
    
    [hospitalOtherScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hospitalScoreLabel.mas_right);
        make.top.bottom.mas_equalTo(hospitalScoreLabel);
        make.right.mas_equalTo(0);
    }];
    
    self.contentHeight += 15;

    
    UILabel *lineLabel2 = [[UILabel alloc] init];
    lineLabel2.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel2];
    
    [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(self.contentHeight);
    }];
    
    self.contentHeight += 10;
    
    
    
    UIView *timerview = [[UIView alloc]init];
    timerview.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:timerview];
    [timerview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel2.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    
    
    
    
    UIImageView *leftImageview = [[UIImageView alloc]init];
    leftImageview.image = [UIImage imageNamed:@"hospital_detail"];
    [timerview addSubview:leftImageview];
    
    [leftImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.equalTo(timerview.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(19, 19));
    }];
    
    
    UIImageView *rightimageView = [[UIImageView alloc]init];
    rightimageView.image = [UIImage imageNamed:@"click_right"];
    [timerview addSubview:rightimageView];
    
    [rightimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(8, 13));
        make.centerY.equalTo(timerview.mas_centerY);
    }];
    
    
    
    self.timerLabel = [[UILabel alloc]init];
    self.timerLabel.font = [UIFont systemFontOfSize:15];
    self.timerLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [timerview addSubview:self.timerLabel];
    
    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(leftImageview.mas_right).offset(10);
        make.right.mas_equalTo(rightimageView.mas_right).offset(-10);
    }];
    
    
    
    self.timerLabel.text = [NSString stringWithFormat:@"门诊：%@ 急诊：%@", ISNIL(self.model.outpatientDepartmentTime),ISNIL(self.model.emergencyTreatmentTime)];
    if (!self.model.outpatientDepartmentTime.length) {
        self.timerLabel.text = [NSString stringWithFormat:@"门诊：                 急诊：%@",ISNIL(self.model.emergencyTreatmentTime)];
    }
    
    UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [clickBtn addTarget:self action:@selector(toSecondHospitalDetail) forControlEvents:UIControlEventTouchUpInside];
    [timerview addSubview:clickBtn];
    
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    
    UILabel *lineLabel3 = [[UILabel alloc] init];
    lineLabel3.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel3];
    
    [lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(timerview.mas_bottom);
    }];
    
    self.contentHeight += 50;
    
    
    
    UIView *addressView = [[UIView alloc]init];
    addressView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:addressView];
    
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(timerview.mas_bottom);
        make.height.mas_equalTo(105);
    }];
    
    
    UIImageView *leftImageview2 = [[UIImageView alloc]init];
    leftImageview2.image = [UIImage imageNamed:@"hospital_Distance"];
    [addressView addSubview:leftImageview2];
    
    [leftImageview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(19, 19));
    }];
    
    UIView *lineview4 = [[UIView alloc]init];
    lineview4.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
    [addressView addSubview:lineview4];
    
    [lineview4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(-87);
        make.width.mas_equalTo(1);
    }];
    
    UILabel *hospitalAddress = [[UILabel alloc]init];
    hospitalAddress.font = H15;
    hospitalAddress.text = ISNIL(self.model.hospitalAddress);
    hospitalAddress.numberOfLines = 0;
    [addressView addSubview:hospitalAddress];
    
    [hospitalAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftImageview2.mas_right).offset(10);
        make.right.mas_equalTo(lineview4.mas_left).offset(-10);
        make.top.mas_equalTo(15);
    }];
    
    
    UILabel *distanceLabel = [[UILabel alloc]init];
    distanceLabel.font =H12;
    distanceLabel.text = [NSString stringWithFormat:@"%.1fkm",[self.model.distance floatValue] / 1000];
    distanceLabel.textColor = [UIColor colorWithHexString:@"999999"];
    [addressView addSubview:distanceLabel];
    
    
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hospitalAddress.mas_left);
        make.right.equalTo(hospitalAddress.mas_right);
        make.top.mas_equalTo(70);
        make.height.mas_equalTo(13);
    }];
    
    UILabel *lineLabel4 = [[UILabel alloc] init];
    lineLabel4.backgroundColor = kDefaultGaryViewColor;
    [addressView addSubview:lineLabel4];
    
    [lineLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.bottom.mas_equalTo(addressView.mas_bottom);
    }];
    
    UIButton *addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addressBtn addTarget:self action:@selector(clickLocationAction) forControlEvents:UIControlEventTouchUpInside];
    [addressView addSubview:addressBtn];
    
    [addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(0);
        make.right.mas_equalTo(lineview4.mas_left);
    }];
    
    
    UIButton *phonebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [phonebtn setImage:[UIImage imageNamed:@"cll_phone"] forState:UIControlStateNormal];
    [phonebtn addTarget:self action:@selector(clickCallPhone) forControlEvents:UIControlEventTouchUpInside];
    [addressView addSubview:phonebtn];
    
    [phonebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.left.mas_equalTo(lineview4.mas_right);
        make.bottom.mas_equalTo(lineLabel4.mas_top);
    }];
    
    
    
    
    self.contentHeight += 105;
    
    
    
//    [self.view addSubview:contentView];
    contentView.frame = CGRectMake(0, 0, SCREENWIDTH, self.contentHeight);

//    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(self.contentHeight);
//    }];
    
    self.dataTabelview.tableHeaderView = contentView;
    
    [self setupTableFooterView];

}


- (void)setupTableFooterView {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];//kDefaultGaryViewColor;
    view.frame = CGRectMake(0, 0, SCREENWIDTH, 165);
    
    self.dataTabelview.tableFooterView = view;
    
    UIView *errorBgView = [[UIView alloc] init];
//    errorBgView.backgroundColor = UIColorHex(0xFF9690);
//    errorBgView.alpha = 0.27;
    errorBgView.layer.cornerRadius = 4;
    errorBgView.layer.masksToBounds = true;
    [view addSubview:errorBgView];
    
    [errorBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(50);
    }];
    
    
    UIImageView *leftimage = [[UIImageView alloc]init];
    leftimage.image = [UIImage imageNamed:@"new_icon_hospital_error"];
    [errorBgView addSubview:leftimage];
    
    [leftimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.centerY.mas_equalTo(errorBgView.mas_centerY);
    }];
    
    UILabel *textlabel = [[UILabel alloc]init];
    textlabel.text = @"医院信息补全";
    textlabel.textColor = [UIColor colorWithHexString:@"6A70FD"];
    textlabel.font = H14;
    [errorBgView addSubview:textlabel];
    
    [textlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftimage.mas_right).offset(5);
        make.height.mas_equalTo(14);
        make.centerY.mas_equalTo(leftimage.mas_centerY);

    }];
    
    UIButton *errorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    errorButton.titleLabel.font = H15;
//    [errorButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
//    [errorButton setTitle:@" 更新信息" forState:UIControlStateNormal];
//    [errorButton setImage:[UIImage imageNamed:@"icon_hospital_error"] forState:UIControlStateNormal];
    [view addSubview:errorButton];
    
    [errorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(errorBgView);
    }];
    [errorButton addTarget:self action:@selector(clickErrorAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.textColor = kDefaultGrayTextColor;
    textLabel.font = H11;
    textLabel.text = @"资料来源于网络，仅供参考";
    textLabel.numberOfLines = 0;
    [view addSubview:textLabel];
    textLabel.userInteractionEnabled = YES;
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(errorButton.mas_bottom);
        make.bottom.mas_equalTo(-10);
    }];
    
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickmianze)];
    [textLabel addGestureRecognizer:tapGR];
    
    
}
- (void)clickmianze
{
    GHCommonWebViewController *vc = [[GHCommonWebViewController alloc] init];
    vc.navTitle = @"大众星医用户协议";
        vc.urlStr = [[GHNetworkTool shareInstance] getGdisclaimerURL];
//    vc.urlStr = @"http://share.zsu1.com/relief.html";
    
    [self.navigationController pushViewController:vc animated:true];
}

- (void)toSecondHospitalDetail
{
    NSLog(@"---->点击了医院详情");
    GHNewHospitalSecondViewController *secondHospital = [[GHNewHospitalSecondViewController alloc]init];
    secondHospital.model = self.model;
    [self.navigationController pushViewController:secondHospital animated:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.doctorListArry.count >2 ? 2: self.departmentArray.count;
    }
    return self.commentArry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return [GHNewDoctorTableViewCell getCellHeitghtWithMoel:[self.doctorListArry objectAtIndex:indexPath.row]];
    }
    GHDoctorCommentModel *model = [self.commentArry objectOrNilAtIndex:indexPath.row];
    
    return [model.shouldHeight floatValue];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        if (self.commentArry.count == 0) {
            return 0;
        }
        else{
            return 56;
        }
    }
  
    
    return 58;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.doctorListArry.count > 2) {
            return 56;
        }
        else
        {
            return 0;
        }
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        return self.moreCommentView;

    }
    else
    {
        return self.departmentView;
    }
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        
        return self.departmentFootView;
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        GHHospitalDetailCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHHospitalDetailCommentTableViewCell"];
        
        if (!cell) {
            cell = [[GHHospitalDetailCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHHospitalDetailCommentTableViewCell"];
        }
        
        cell.model = [self.commentArry objectOrNilAtIndex:indexPath.row];
        
        return cell;
    }
    else
    {
        GHNewDoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNSearchDoctorTableViewCell"];
        
        if (!cell) {
            cell = [[GHNewDoctorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNSearchDoctorTableViewCell"];
            
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        
        cell.model = [self.doctorListArry objectOrNilAtIndex:indexPath.row];
        
        return cell;
    }
    return nil;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        GHHospitalCommentDetailViewController *vc = [[GHHospitalCommentDetailViewController alloc] init];
        
        GHDoctorCommentModel *commentModel = [self.commentArry objectOrNilAtIndex:indexPath.row];

        vc.model = [[GHMyCommentsModel alloc] initWithDictionary:[commentModel toDictionary] error:nil];
        
        vc.model.pictures = commentModel.pictures;
        vc.model.userProfileUrl = commentModel.userProfileUrl;
        vc.model.score = [NSString stringWithFormat:@"%ld",[commentModel.score integerValue] *10];
        vc.model.envScore = [NSString stringWithFormat:@"%ld",[commentModel.envScore integerValue] *10];
        vc.model.serviceScore = [NSString stringWithFormat:@"%ld",[commentModel.serviceScore integerValue] *10];
        vc.model.modelId = self.model.modelId;
        vc.hospitalModel = self.model;
        [self.navigationController pushViewController:vc animated:true];
    }
    else
    {
        GHNewDoctorDetailViewController *vc = [[GHNewDoctorDetailViewController alloc] init];
        GHNewDoctorModel *model = [self.doctorListArry objectOrNilAtIndex:indexPath.row];
        vc.doctorId = model.doctorId;
        [self.navigationController pushViewController:vc animated:true];
    }
   
    
}
//然后在UITableView的代理方法中加入以下代码
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)getDataAction {
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"lat"] = @([GHUserModelTool shareInstance].locationLatitude > 0 ? [GHUserModelTool shareInstance].locationLatitude : 30.3751);
    params[@"lng"] = @([GHUserModelTool shareInstance].locationLongitude > 0 ? [GHUserModelTool shareInstance].locationLongitude : 120.1236);
    
    if (self.model) {
        params[@"hospitalId"] = self.model.modelId;

    }
    else
    {
        params[@"hospitalId"] = self.hospitalID;

    }
    
    if (self.departmentId.length > 0 && self.departmentId != nil && ![self.departmentId isEqualToString:@"(null)"]) {
        params[@"departmentId"] = self.departmentId;
    }
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiHospital withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            self.model = [[GHSearchHospitalModel alloc] initWithDictionary:response[@"data"][@"hospital"] error:nil];
            self.model.distance = response[@"data"][@"distance"];
            self.timerLabel.text = [NSString stringWithFormat:@"门诊：%@ 急诊：%@", ISNIL(self.model.outpatientDepartmentTime),ISNIL(self.model.emergencyTreatmentTime)];

            self.commentTotalLabel.text = [NSString stringWithFormat:@"(共 %ld 条)", (long)[self.model.commentCount integerValue]];
            
            
            NSArray *departmentDoctorList = response[@"data"][@"departmentDoctorList"];
            for (NSDictionary *dic in departmentDoctorList) {
                GHNewDoctorModel *doctormodel = [[GHNewDoctorModel alloc]initWithDictionary:dic error:nil];
//                [self.doctorListArry addObject:doctormodel];
            }
            
          
            
            [self ctratUI];

            if ([((NSDictionary *)response[@"data"][@"hospitalDepartment"]) allKeys] > 0) {
                self.departmentName =response[@"data"][@"hospitalDepartment"][@"departmentName"];
//                self.departmentTotalLabel.text = self.departmentName;
                self.departmentid = response[@"data"][@"hospitalDepartment"][@"departmentId"];
            }
            if (departmentDoctorList.count > 2) {
//                [self.moredoctor setTitle:[NSString stringWithFormat:@"查看剩余%d位医生>",departmentDoctorList.count - 2] forState:UIControlStateNormal];
            }
            
            [self.dataTabelview reloadData];
            [GHUserModelTool shareInstance].isLogin ? [self addFootprint] : nil;
           
            [self chooseCollection];
        }
        
    }];
    
    
}
- (void)addFootprint
{
    NSMutableDictionary *parmars = [[NSMutableDictionary alloc]init];
    parmars[@"contentType"] = @(3);
    parmars[@"contentId"] = self.model.modelId;
    parmars[@"title"] = self.model.hospitalName;
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiAddFootprint withParameter:parmars withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            NSLog(@"----->添加足迹成功");
        }
    }];
}

- (void)getCommentDataAction {
    
    NSMutableDictionary *questionParams = [[NSMutableDictionary alloc] init];
//    questionParams[@"userId"] = [GHUserModelTool shareInstance].userInfoModel.modelId;
    if (self.model.modelId == nil || self.model.modelId.length == 0) {
        questionParams[@"commentObjId"] = self.hospitalID;

    }
    else{
        questionParams[@"commentObjId"] = self.model.modelId;

    }
    questionParams[@"commentObjType"] = @(2);
//    questionParams[@"choiceFlag"] = @(1);
    questionParams[@"sortType"] = @(1);
    questionParams[@"page"] = @(1);
    questionParams[@"pageSize"] = @(2);
    
    
    
    
    
   
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDoctorComments withParameter:questionParams withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.dataTabelview.mj_header endRefreshing];
        [self.dataTabelview.mj_footer endRefreshing];
        
        [self.commentArry removeAllObjects];
        [SVProgressHUD dismiss];
        if (isSuccess) {
            
            
            
            for (NSDictionary *dicInfo in response[@"data"][@"commentList"]) {
                
                GHDoctorCommentModel *model = [[GHDoctorCommentModel alloc] initWithDictionary:dicInfo[@"comment"] error:nil];
                
                
                NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
                paragraphStyle.maximumLineHeight = 21;
                paragraphStyle.minimumLineHeight = 21;
                paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
                
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:ISNIL(model.comment)];
                
                [attr addAttributes:@{NSFontAttributeName: H12} range:NSMakeRange(0, attr.string.length)];
                [attr addAttributes:@{NSForegroundColorAttributeName: kDefaultBlackTextColor} range:NSMakeRange(0, attr.string.length)];
                
                [attr addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, attr.string.length)];
                
                 model.contentHeight = @([ISNIL(model.comment) getShouldHeightWithContent:attr.string withFont:H12 withWidth:SCREENWIDTH - 30 withLineHeight:21]);
                
                
                
//                model.contentHeight = @([ISNIL(model.comment) heightForFont:H12 width:SCREENWIDTH - 30]);
                
                
                NSArray *pictureArray = [model.pictures jsonValueDecoded];
                
                
                
                NSInteger beishu = pictureArray.count / 3;
                
                NSInteger yushu = pictureArray.count % 3;
                
                
                float imageviewHeight = ((SCREENWIDTH - 15 * 4) / 3.0);
                
                
                if (yushu > 0) {
                    model.shouldHeight = @([model.contentHeight floatValue] + 67 + (imageviewHeight * (beishu + 1))  + ((beishu + 1) * 10) + 15);
                }
                else
                {
                    model.shouldHeight = @([model.contentHeight floatValue] + 67 + (imageviewHeight * beishu) + (beishu * 10)+ 15);
                    
                }
                
               
                
                
                
                [self.commentArry addObject:model];
                
            }
            
            [self.dataTabelview reloadData];
            
            
            
        }
        
    }];
}


- (void)clickMoreCommentAction {
    
    //查看全部评论
    GHHospitalCommentListViewController *vc = [[GHHospitalCommentListViewController alloc] init];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)clickCommentAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        GHHospitalCommentViewController *vc = [[GHHospitalCommentViewController alloc] init];
        
        vc.model = self.model;
        
        [self.navigationController pushViewController:vc animated:true];
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self presentViewController:vc animated:true completion:nil];
        
    }
    
}
- (void)clickCallPhone
{
    
    NSArray *phoneArray = [self.model.contactNumber componentsSeparatedByString:@","];
    
    if (phoneArray.count) {
        
        if (phoneArray.count == 1) {
            
            NSString *contactNumber = [phoneArray firstObject];
            
            if (contactNumber.length) {
                [JFTools callPhone:ISNIL(contactNumber)];
            }
            
        } else {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择您要拨打的电话" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            for (NSString *contactNumber in phoneArray) {
                
                if (contactNumber.length) {
                    
                    UIAlertAction *action = [UIAlertAction actionWithTitle:ISNIL(contactNumber) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [JFTools callPhone:ISNIL(contactNumber)];
                    }];
                    
                    [alert addAction:action];
                    
                }
                
            }
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
                
            }];
            
        }
        
        
    }
    
    
    
}

- (void)clickPhotoAction:(UIGestureRecognizer *)gr {
    
    UIImageView *imageView = (UIImageView *)gr.view;
    
    kWeakSelf
    
    NSMutableArray *urlArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in [self.model.pictures jsonValueDecoded]) {
        [urlArray addObject:ISNIL(dic[@"url"])];
    }
    
    if (urlArray.count > 0) {
        [urlArray insertObject:self.model.profilePhoto atIndex:0];
    }
    else
    {
        [urlArray addObject:self.model.profilePhoto];
    }
    
    [[GHPhotoTool shareInstance] showBigImage:urlArray currentIndex:imageView.tag viewController:weakSelf cancelBtnText:@"取消"];
    
}

- (UIView *)moreCommentView {
    
    if (!_moreCommentView) {
        
        _moreCommentView = [[UIView alloc] init];
        _moreCommentView.backgroundColor = [UIColor whiteColor];
        _moreCommentView.frame = CGRectMake(0, 0, SCREENWIDTH, 56);
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = HM18;
        titleLabel.textColor = kDefaultBlackTextColor;
        titleLabel.text = @"患者评价";
        [_moreCommentView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(75);
        }];
        
        UILabel *totalCountLabel = [[UILabel alloc] init];
        totalCountLabel.font = H12;
        totalCountLabel.textColor = kDefaultGrayTextColor;
        [_moreCommentView addSubview:totalCountLabel];
        
        [totalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabel.mas_right).offset(8);
            make.top.bottom.mas_equalTo(0);
        }];
        self.commentTotalLabel = totalCountLabel;
        
        
        
        UIImageView *arrowImageView = [[UIImageView alloc] init];
        arrowImageView.contentMode = UIViewContentModeCenter;
        arrowImageView.image = [UIImage imageNamed:@"personcenter_right_arrow"];
        [_moreCommentView addSubview:arrowImageView];
        
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(13);
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(arrowImageView.superview);
        }];
        
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.font = H14;
        descLabel.textColor = kDefaultGrayTextColor;
        descLabel.text = @"查看更多";
        descLabel.textAlignment = NSTextAlignmentRight;
        [_moreCommentView addSubview:descLabel];
        
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-34);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(100);
        }];
        
        UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreCommentView addSubview:actionButton];
        
        [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        [actionButton addTarget:self action:@selector(clickMoreCommentAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = kDefaultLineViewColor;
        [_moreCommentView addSubview:lineLabel];
        
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _moreCommentView;
    
}
- (UIView *)departmentView {
    
    if (!_departmentView) {
        
        _departmentView = [[UIView alloc] init];
        _departmentView.backgroundColor = [UIColor whiteColor];
        _departmentView.frame = CGRectMake(0, 0, SCREENWIDTH, 56);
        
        
        UIImageView *leftImageview2 = [[UIImageView alloc]init];
        leftImageview2.image = [UIImage imageNamed:@"hospital_Distance"];
        [_departmentView addSubview:leftImageview2];
        
        [leftImageview2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(19, 19));
        }];
        
        self.departmentTotalLabel = [[UILabel alloc] init];
        self.departmentTotalLabel.font = HM15;
        self.departmentTotalLabel.textColor = kDefaultBlackTextColor;
//        self.departmentTotalLabel.text = self.departmentName;
        self.departmentTotalLabel.text = @"全部科室";

        [_departmentView addSubview:self.departmentTotalLabel];
        
        [self.departmentTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftImageview2.mas_right).offset(10);
            make.width.mas_equalTo(200);
            make.centerY.mas_equalTo(leftImageview2.mas_centerY);
        }];
        
        UILabel *totalCountLabel = [[UILabel alloc] init];
        totalCountLabel.font = H12;
        totalCountLabel.textColor = kDefaultGrayTextColor;
        [_departmentView addSubview:totalCountLabel];
        
        [totalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.departmentTotalLabel.mas_right).offset(8);
            make.top.bottom.mas_equalTo(0);
        }];
        self.departmentTotalLabel = totalCountLabel;
        
        
        
        UIImageView *arrowImageView = [[UIImageView alloc] init];
        arrowImageView.contentMode = UIViewContentModeCenter;
        arrowImageView.image = [UIImage imageNamed:@"personcenter_right_arrow"];
        [_departmentView addSubview:arrowImageView];
        
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(13);
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(arrowImageView.superview);
        }];
        
//        UILabel *descLabel = [[UILabel alloc] init];
//        descLabel.font = H14;
//        descLabel.textColor = kDefaultGrayTextColor;
//        descLabel.text = @"查看更多";
//        descLabel.textAlignment = NSTextAlignmentRight;
//        [_departmentView addSubview:descLabel];
//
//        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(-34);
//            make.top.bottom.mas_equalTo(0);
//            make.width.mas_equalTo(100);
//        }];
//
        UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_departmentView addSubview:actionButton];
        
        [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        [actionButton addTarget:self action:@selector(clickMoreDepartment) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = kDefaultGaryViewColor;
        [_departmentView addSubview:lineLabel];
        
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(10);
        }];
    }
    return _departmentView;
    
}

- (void)clickErrorAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        GHHospitalDetailInfoErrorViewController *vc = [[GHHospitalDetailInfoErrorViewController alloc] init];
        vc.realModel = self.model;
        [self.navigationController pushViewController:vc animated:true];
        NSLog(@"信息报错");
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self presentViewController:vc animated:true completion:nil];
        
    }
    
    
    
}
#pragma mark - 地图导航
- (void)clickLocationAction {
    
    if (self.model.hospitalAddress.length == 0) {
        return;
    }
    
    
    
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[self.model.lat doubleValue] longitude:[self.model.lng doubleValue]];
    
    //终点坐标
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择地图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"用iPhone自带地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //当前位置
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
        //传入目的地，会显示在苹果自带地图上面目的地一栏
        toLocation.name = ISNIL(self.model.hospitalName);
        //导航方式选择
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
    }];
    
    [alert addAction:action];
    
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"用高德地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSURL *myLocationScheme = [NSURL URLWithString:[[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&t=0",@"掌上优医",coordinate.latitude,coordinate.longitude,ISNIL(self.model.hospitalName)] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            if ([[UIDevice currentDevice].systemVersion integerValue] >= 10) {
                //iOS10以后,使用新API
                [[UIApplication sharedApplication] openURL:myLocationScheme options:@{} completionHandler:^(BOOL success) { NSLog(@"scheme调用结束"); }];
                
            } else {
                //iOS10以前,使用旧API
                [[UIApplication sharedApplication] openURL:myLocationScheme];
            }
            
            
        }];
        
        [alert addAction:action];
    }
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"用百度地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSURL *myLocationScheme = [NSURL URLWithString: [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name:%@&mode=driving&coord_type=gcj02",coordinate.latitude, coordinate.longitude, ISNIL(self.model.hospitalName)] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            if ([[UIDevice currentDevice].systemVersion integerValue] >= 10) {
                //iOS10以后,使用新API
                [[UIApplication sharedApplication] openURL:myLocationScheme options:@{} completionHandler:^(BOOL success) { NSLog(@"scheme调用结束"); }];
                
            } else {
                //iOS10以前,使用旧API
                [[UIApplication sharedApplication] openURL:myLocationScheme];
            }
            
            
        }];
        
        [alert addAction:action];
        
    }
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"用腾讯地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSURL *myLocationScheme = [NSURL URLWithString: [[NSString stringWithFormat:@"qqmap://map/routeplan?fromcoord=CurrentLocation&type=drive&to=%@&tocoord=%f,%f&policy=1",ISNIL(self.model.hospitalName), coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            if ([[UIDevice currentDevice].systemVersion integerValue] >= 10) {
                //iOS10以后,使用新API
                [[UIApplication sharedApplication] openURL:myLocationScheme options:@{} completionHandler:^(BOOL success) { NSLog(@"scheme调用结束"); }];
                
            } else {
                //iOS10以前,使用旧API
                [[UIApplication sharedApplication] openURL:myLocationScheme];
            }
            
            
        }];
        
        [alert addAction:action];
        
    }
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
        
    }];
    
    
}


- (void)clickPhoneAction {
    
    NSArray *phoneArray = [self.model.contactNumber componentsSeparatedByString:@","];
    
    if (phoneArray.count) {
        
        if (phoneArray.count == 1) {
            
            NSString *contactNumber = [phoneArray firstObject];
            
            if (contactNumber.length) {
                [JFTools callPhone:ISNIL(contactNumber)];
            }
            
        } else {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择您要拨打的电话" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            for (NSString *contactNumber in phoneArray) {
                
                if (contactNumber.length) {
                    
                    UIAlertAction *action = [UIAlertAction actionWithTitle:ISNIL(contactNumber) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [JFTools callPhone:ISNIL(contactNumber)];
                    }];
                    
                    [alert addAction:action];
                    
                }
                
            }
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
                
            }];
            
        }
        
        
    }
    
    
    
}
- (void)chooseCollection
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"contentType"] = @(2);
    params[@"contentId"] = self.model.modelId;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiIsConllection  withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            if ([response[@"data"][@"isConllection"] boolValue]) {
                self.collectionButton.selected = YES;
                self.model.collectionId = [NSString stringWithFormat:@"%@",response[@"data"][@"id"]];
            }
            else
            {
                self.collectionButton.selected = NO;
            }
        }
        
    }];
}
- (void)clickMoreDepartment
{
    //查看医院下全部科室
    GHHospitalDepartmentViewController *vc = [[GHHospitalDepartmentViewController alloc] init];
    vc.hospitalId = self.model.modelId;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)clickCollectionAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        if (self.collectionButton.selected == true) {
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"id"] = ISNIL(self.model.collectionId);
            
            [SVProgressHUD showWithStatus:kDefaultTipsText];
            
            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiMyDonotConllection  withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
                
                
                
                if (isSuccess) {
                    
                    [SVProgressHUD dismiss];
                    
                    [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
                    
                    self.collectionButton.selected = false;
                    if (self.clickCollectionBlock) {
                        self.clickCollectionBlock(NO);
                    }
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCancelDoctorCollectionSuccess object:nil];
                    
                }
                
            }];
            
        } else {
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"contentId"] = ISNIL(self.model.modelId);
            
            params[@"title"] = ISNIL(self.model.hospitalName);
            params[@"contentType"] = @(2);
            
            [SVProgressHUD showWithStatus:kDefaultTipsText];
            
            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiDoConllection withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
                
                if (isSuccess) {
                    
                    [SVProgressHUD dismiss];
                     self.model.collectionId = [NSString stringWithFormat:@"%@",response[@"data"][@"id"]];
                    [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
                    self.collectionButton.selected = true;
            
                    if (self.clickCollectionBlock) {
                        self.clickCollectionBlock(YES);
                    }
                }
                
            }];
            
        }
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self presentViewController:vc animated:true completion:nil];
        
    }
    
    
}
-(void)getDepartmentDate
{
    
    NSMutableDictionary *parmar = [@{
                                     @"hospitalId":self.hospitalID
                                     }copy];
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSystemparamDepartments withParameter:parmar withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            
            
            for (NSDictionary *info in response[@"data"][@"departmentList"]) {
                
                GHNewDepartMentModel *model = [[GHNewDepartMentModel alloc]initWithDictionary:(NSDictionary *)info[@"firstDepartment"] error:nil];
                
                NSArray *secondDepartmentList = info[@"secondDepartmentList"];
                
                for (NSInteger index = 0; index < secondDepartmentList.count; index ++) {
                    
                    NSDictionary *secondDic = [secondDepartmentList objectAtIndex:index];
                    
                    GHNewDepartMentModel *second = [[GHNewDepartMentModel alloc]initWithDictionary:secondDic error:nil];
                    [model.secondDepartmentList addObject:second];
                }
                
                [self.departmentArray addObject:model];
                
            }
            
            
            
            
            if (self.departmentArray.count == 0) {
                [self loadingEmptyView];
            }else{
                [self hideEmptyView];
            }
            
            [self.dataTabelview reloadData];
            
        }
        
    }];
}

- (void)clickShareAction
{
//    NSString *sharurl = [NSString stringWithFormat:@"%@?hospitalId=%@",@"http://share.zsu1.com/#/hospital",self.model.modelId];
    if (self.model.modelId.length > 0) {
        self.shareView.hidden = NO;

    }
}
- (GHCommonShareView *)shareView {
    
    if (!_shareView) {
        _shareView = [[GHCommonShareView alloc] init];
        _shareView.title = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.hospitalName)];
        _shareView.desc = @"了解医疗知识，关注健康生活。";
        _shareView.urlString = [[GHNetworkTool shareInstance] getHospitalDetailURLWithHospitalId:self.model.modelId];//[NSString stringWithFormat:@"%@?hospitalId=%@",@"http://share.zsu1.com/hospitalInfo.html",self.model.modelId];;
        [self.view addSubview:_shareView];
        
        [_shareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        _shareView.hidden = true;
    }
    return _shareView;
    
}
- (NSMutableArray *)commentArry
{
    if (!_commentArry) {
        _commentArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _commentArry;
}
- (NSMutableArray *)doctorListArry
{
    if (!_doctorListArry) {
        _doctorListArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _doctorListArry;
}
- (NSMutableArray *)departmentArray
{
    if (!_departmentArray) {
        _departmentArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _departmentArray;
}
- (UIView *)departmentFootView
{
    if (!_departmentFootView) {
        _departmentFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 56)];
        _departmentFootView.backgroundColor = [UIColor whiteColor];
        
        UIView *lineview = [[UIView alloc]init];
        lineview.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
        [_departmentFootView addSubview:lineview];
        [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(15);
        }];
        
        [_departmentFootView addSubview:self.moredoctor];
        
        [_moredoctor mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_equalTo(lineview.mas_top);
        }];
        
      
        
    }
    
    return _departmentFootView;
}


- (UIButton *)moredoctor
{
    if (!_moredoctor) {
        _moredoctor = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moredoctor setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        _moredoctor.titleLabel.font = [UIFont systemFontOfSize:12];
        [_moredoctor addTarget:self action:@selector(clickDepartmentAction:) forControlEvents:UIControlEventTouchUpInside];
      
    }
    return _moredoctor;
}

- (void)clickDepartmentAction:(UIButton *)sender {
    
    NSLog(@"科室医生");
    
    GHHospitalDepartmentDoctorListViewController *vc = [[GHHospitalDepartmentDoctorListViewController alloc] init];
    
    
    vc.hospitalId = self.model.modelId;
    
    vc.departmentLevel = @"1";
    
    vc.departmentId = [NSString stringWithFormat:@"%@",self.departmentid];
    
    vc.navigationItem.title = self.departmentName;//ISNIL(departmentInfo[@"departmentName"]);
    
    [self.navigationController pushViewController:vc animated:true];
    
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

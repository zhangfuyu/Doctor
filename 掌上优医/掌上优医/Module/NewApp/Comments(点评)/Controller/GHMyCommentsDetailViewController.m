//
//  GHMyCommentsDetailViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/20.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHMyCommentsDetailViewController.h"
#import "GHNewDoctorDetailViewController.h"

#define ForegroundStarImage @"ic_huanzhepingjia_pingfenxing"
#define BackgroundStarImage @"ic_huanzhepingjia_pingfenxing_unselected"

//#define ForegroundStarImage @"ic_xingxing_all_selected"
//#define BackgroundStarImage @"ic_xingxing_all_unselected"

@interface GHMyCommentsDetailViewController ()


@property (nonatomic, strong) UIImageView *headPortraitImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIView *foregroundStarView;
@property (nonatomic, strong) UIView *backgroundStarView;

@property (nonatomic, strong) UIImageView *doctorHeadPortraitImageView;

@property (nonatomic, strong) UILabel *doctorNameLabel;

@property (nonatomic, strong) UILabel *doctorPositionLabel;

@property (nonatomic, strong) UILabel *doctorHospitalLabel;

@property (nonatomic, strong) UILabel *doctorScoreTitleLabel;

@property (nonatomic, strong) UILabel *doctorScoreValueLabel;

@property (nonatomic, strong) UIView *doctorForegroundStarView;
@property (nonatomic, strong) UIView *doctorBackgroundStarView;

@property (nonatomic, strong) UILabel *doctorDepartmentLabel;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *typeLabel;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIButton *likeButton;

@end

@implementation GHMyCommentsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"点评详情";
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"id"] = self.model.modelId;
    
//    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiCommentId withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:false withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
//
//        if (isSuccess) {
//
//            self.model = [[GHMyCommentsModel alloc] initWithDictionary:response error:nil];
    
    [self setupUI];
    self.doctorNameLabel.text = ISNIL(self.model.doctorName);
    self.doctorPositionLabel.text = ISNIL(self.model.doctorGrade);
    self.doctorHospitalLabel.text = ISNIL(self.model.doctorHospitalName);
    self.doctorScoreValueLabel.text = [NSString stringWithFormat:@"%.1f分", [self.model.commentScore floatValue]];
    self.doctorDepartmentLabel.text = ISNIL(self.model.doctorSecondDepartmentName).length ? self.model.doctorSecondDepartmentName : ISNIL(self.model.doctorFirstDepartmentName);
    
    [self.doctorForegroundStarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(13.5 * .5 * [self.model.commentScore floatValue]);
    }];
    
    [self.doctorHeadPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(self.model.doctorProfilePhoto)) placeholderImage:[UIImage imageNamed:@"doctor_default_portail"]];
    
    [self.doctorPositionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([self.doctorPositionLabel.text widthForFont:self.doctorPositionLabel.font] + 6);
    }];
    
    [self.likeButton setTitle:[NSString stringWithFormat:@"  %ld", [self.model.likeCount integerValue]] forState:UIControlStateNormal];
    
    if ([[GHZoneLikeManager shareInstance].systemCommentLikeIdArray containsObject:self.model.modelId]) {
        self.likeButton.selected = true;
    } else {
        self.likeButton.selected = false;
    }
    
//            [self requestData];
//
//        }
//
//    }];
    
}

- (void)requestData {
    
    NSMutableDictionary *sonParams = [[NSMutableDictionary alloc] init];
    sonParams[@"ids"] = self.model.commentObjId;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDoctorSampleinfoIds withParameter:sonParams withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            for (NSDictionary *dic in response) {
                
                if ([dic[@"id"] longValue] == [self.model.commentObjId longValue]) {
                    
                    self.model.doctorName = ISNIL(dic[@"doctorName"]);
                    self.model.doctorGrade = ISNIL(dic[@"doctorGrade"]);
                    self.model.doctorProfilePhoto = ISNIL(dic[@"profilePhoto"]);
                    self.model.doctorScore = [NSString stringWithFormat:@"%ld", [dic[@"score"] integerValue]];
                    self.model.doctorHospitalName = ISNIL(dic[@"hospitalName"]);
                    self.model.doctorFirstDepartmentName = ISNIL(dic[@"firstDepartmentName"]);
                    self.model.doctorSecondDepartmentName = ISNIL(dic[@"secondDepartmentName"]);
                    
                    self.doctorNameLabel.text = ISNIL(self.model.doctorName);
                    self.doctorPositionLabel.text = ISNIL(self.model.doctorGrade);
                    self.doctorHospitalLabel.text = ISNIL(self.model.doctorHospitalName);
                    self.doctorScoreValueLabel.text = [NSString stringWithFormat:@"%.1f分", [self.model.doctorScore floatValue]];
                    self.doctorDepartmentLabel.text = ISNIL(self.model.doctorSecondDepartmentName).length ? self.model.doctorSecondDepartmentName : ISNIL(self.model.doctorFirstDepartmentName);
                    
                    [self.doctorForegroundStarView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.width.mas_equalTo(13.5 * .5 * [self.model.doctorScore floatValue]);
                    }];
                    
                    [self.doctorHeadPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(self.model.doctorProfilePhoto)) placeholderImage:[UIImage imageNamed:@"doctor_default_portail"]];
                    
                    [self.doctorPositionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.width.mas_equalTo([self.doctorPositionLabel.text widthForFont:self.doctorPositionLabel.font] + 6);
                    }];
                    
                    [self.likeButton setTitle:[NSString stringWithFormat:@"  %ld", [self.model.likeCount integerValue]] forState:UIControlStateNormal];
                    
                    if ([[GHZoneLikeManager shareInstance].systemCommentLikeIdArray containsObject:self.model.modelId]) {
                        self.likeButton.selected = true;
                    } else {
                        self.likeButton.selected = false;
                    }
                    
                    continue;
                    
                }
                
            }
            
            
        }
        
    }];
    
}

- (void)setupUI {
    
    if (self.model.comment.length == 0) {
        self.model.comment = @"未填写";
    }
    
    NSString *commentsContent = ISNIL(self.model.comment);
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.bounces = false;
    scrollView.showsVerticalScrollIndicator = false;
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.backgroundColor = kDefaultGaryViewColor;
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = kDefaultGaryViewColor;
    [scrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
        make.height.greaterThanOrEqualTo(@0.f);//此处保证容器View高度的动态变化 大于等于0.f的高度
    }];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    UIImageView *headPortraitImageView = [[UIImageView alloc] init];
    headPortraitImageView.contentMode = UIViewContentModeScaleAspectFill;
    headPortraitImageView.layer.cornerRadius = 20;
    headPortraitImageView.layer.borderColor = kDefaultLineViewColor.CGColor;
    headPortraitImageView.layer.borderWidth = 1;
    headPortraitImageView.layer.masksToBounds = true;
    headPortraitImageView.backgroundColor = kDefaultGaryViewColor;
    [headPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(self.model.userProfileUrl)) placeholderImage:[UIImage imageNamed:@"personcenter_user_default"]];
    [view addSubview:headPortraitImageView];
    
    [headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.width.height.mas_equalTo(40);
        make.left.mas_equalTo(16);
    }];
    self.headPortraitImageView = headPortraitImageView;
    

    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kDefaultBlackTextColor;
    nameLabel.font = H13;
    nameLabel.text = ISNIL(self.model.userNickName);
    [view addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(10);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(13);
        make.right.mas_equalTo(-16);
    }];
    self.nameLabel = nameLabel;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = kDefaultGrayTextColor;
    timeLabel.font = H12;
    timeLabel.text = [[NSDate dateWithString:ISNIL(self.model.createTime) format:@"yyyy-MM-dd HH:mm:ss"] stringWithFormat:@"yyyy年MM月dd日"];
    [view addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(10);
        make.height.mas_equalTo(17);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(2);
        make.right.mas_equalTo(-16);
    }];
    self.timeLabel = timeLabel;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [view addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(headPortraitImageView.mas_bottom).offset(8);
    }];
    
    
    NSArray *titleArray = @[@"治疗效果:", @"点评话述:", @"所患疾病:", @"治愈状态:", @"治疗方式:"];
    
//    NSDictionary *extAttributes = [self.model.extAttributes jsonValueDecoded];

    NSString *suohuanjibing = self.model.diseaseName;
    NSString *zhiyuzhuangtai = self.model.cureState;//extAttributes[@"curativeEffect"];
    NSString *zhiliaofangshi = self.model.cureMethod;//extAttributes[@"treatment"];
    
    
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = ISNIL([titleArray objectOrNilAtIndex:index]);
        titleLabel.font = H15;
        titleLabel.textColor = UIColorHex(0x999999);
        [view addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.width.mas_equalTo(110);
            make.top.mas_equalTo(headPortraitImageView.mas_bottom).offset(24 + (16 + 21) * index);
            make.height.mas_equalTo(21);
        }];
        
        if (index == 0) {
            self.backgroundStarView = [self createStarViewWithImage:BackgroundStarImage];
            [view addSubview:self.backgroundStarView];
            
            [self.backgroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(22);
                make.left.mas_equalTo(128);
                make.width.mas_equalTo(15 * 5);
                make.centerY.mas_equalTo(titleLabel);
            }];
            
            self.foregroundStarView = [self createStarViewWithImage:ForegroundStarImage];
            self.foregroundStarView.clipsToBounds = true;
            [view addSubview:self.foregroundStarView];
            
            [self.foregroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(22);
                make.left.mas_equalTo(128);
                make.width.mas_equalTo(13.5 * .5 * [self.model.score integerValue]);
                make.centerY.mas_equalTo(titleLabel);
            }];
        } else if (index == 1) {
            
            UILabel *descLabel = [[UILabel alloc] init];
            descLabel.font = H15;
            descLabel.textColor = kDefaultBlackTextColor;
            descLabel.numberOfLines = 0;
            [view addSubview:descLabel];
            
            [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo([commentsContent getShouldHeightWithContent:commentsContent withFont:H15 withWidth:SCREENWIDTH - 16 - 128  withLineHeight:21]);
                make.left.mas_equalTo(128);
                make.right.mas_equalTo(-16);
                make.top.mas_equalTo(titleLabel).offset(-2);
            }];
            
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.maximumLineHeight = 21;
            paragraphStyle.minimumLineHeight = 21;
            paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
            
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:ISNIL(commentsContent)];
            
            [attr addAttributes:@{NSFontAttributeName: H15} range:NSMakeRange(0, attr.string.length)];
            [attr addAttributes:@{NSForegroundColorAttributeName: kDefaultBlackTextColor} range:NSMakeRange(0, attr.string.length)];
            
            [attr addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, attr.string.length)];
            
            descLabel.attributedText = attr;
            
        } else {
            
            [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.top.mas_equalTo(headPortraitImageView.mas_bottom).offset(24 + (16 + 21) * index + [commentsContent getShouldHeightWithContent:commentsContent withFont:H15 withWidth:SCREENWIDTH - 16 - 128  withLineHeight:21] - 23);
                
            }];
            
            UILabel *descLabel = [[UILabel alloc] init];
            descLabel.font = H15;
            descLabel.textColor = kDefaultBlackTextColor;
            
            [view addSubview:descLabel];
            
            [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(22);
                make.left.mas_equalTo(128);
                make.right.mas_equalTo(-16);
                make.centerY.mas_equalTo(titleLabel);
            }];
            
            if (index == 2) {
                descLabel.text = ISNIL(suohuanjibing).length ? suohuanjibing : @"未填写";
            } else if (index == 3) {
                descLabel.text = ISNIL(zhiyuzhuangtai).length ? zhiyuzhuangtai : @"未填写";
            } else if (index == 4) {
                descLabel.text = ISNIL(zhiliaofangshi).length ? zhiliaofangshi : @"未填写";
                self.typeLabel = descLabel;
            }
            
        }
        
    }
    
    NSArray *imageInfoArray = [self.model.pictures jsonValueDecoded];
    
    for (NSInteger index = 0; index < imageInfoArray.count; index++) {
        
        NSString *url = [imageInfoArray objectOrNilAtIndex:index][@"url"];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = kDefaultGaryViewColor;
        imageView.clipsToBounds = true;
        imageView.tag = index;
        imageView.userInteractionEnabled = true;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        if (url.length) {
            [imageView sd_setImageWithURL:kGetImageURLWithString(url)];
        }
        
        [view addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(90);
            make.width.mas_equalTo(90);
            make.left.mas_equalTo(16 + 95 * (index % 3));
            make.top.mas_equalTo(self.typeLabel.mas_bottom).offset((95) * (index / 3) + 15);
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPhotoAction:)];
        [imageView addGestureRecognizer:tapGR];
        
    }
    
    UIView *doctorContentView = [[UIView alloc] init];
    doctorContentView.backgroundColor = [UIColor whiteColor];
    doctorContentView.layer.cornerRadius = 4;
    doctorContentView.layer.borderColor = kDefaultLineViewColor.CGColor;
    doctorContentView.layer.borderWidth = 1;
    doctorContentView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    doctorContentView.layer.shadowOffset = CGSizeMake(0,2);
    doctorContentView.layer.shadowOpacity = 1;
    doctorContentView.layer.shadowRadius = 2;
//    doctorContentView.layer.shadowColor = kDefaultBlackTextColor.CGColor;
//    doctorContentView.layer.shadowOffset = CGSizeMake(0,3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//    doctorContentView.layer.shadowOpacity = 0.2;//阴影透明度，默认0
//    doctorContentView.layer.shadowRadius = 5;//阴影半径，默认3
    [view addSubview:doctorContentView];
    
    [doctorContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(self.typeLabel.mas_bottom).offset(ceil(imageInfoArray.count / 3.f) * 105 + 35);
        make.height.mas_equalTo(115);
    }];
    
    UIImageView *doctorHeadPortraitImageView = [[UIImageView alloc] init];
    doctorHeadPortraitImageView.contentMode = UIViewContentModeScaleAspectFill;
    doctorHeadPortraitImageView.layer.cornerRadius = 2;
    doctorHeadPortraitImageView.layer.masksToBounds = true;
    doctorHeadPortraitImageView.backgroundColor = kDefaultGaryViewColor;
    [doctorContentView addSubview:doctorHeadPortraitImageView];
    
    [doctorHeadPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(45);
        make.left.mas_equalTo(12);
    }];
    self.doctorHeadPortraitImageView = doctorHeadPortraitImageView;
    
    UILabel *doctorNameLabel = [[UILabel alloc] init];
    doctorNameLabel.textColor = kDefaultBlackTextColor;
    doctorNameLabel.font = HM15;
    [doctorContentView addSubview:doctorNameLabel];
    
    [doctorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(doctorHeadPortraitImageView.mas_right).offset(16);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(12);
    }];
    self.doctorNameLabel = doctorNameLabel;
    
    UILabel *doctorPositionLabel = [[UILabel alloc] init];
    doctorPositionLabel.textColor = UIColorHex(0xFEAE05);
    doctorPositionLabel.layer.cornerRadius = 2;
    doctorPositionLabel.layer.masksToBounds = true;
    doctorPositionLabel.layer.borderColor = doctorPositionLabel.textColor.CGColor;
    doctorPositionLabel.layer.borderWidth = 1;
    doctorPositionLabel.font = H12;
    doctorPositionLabel.textAlignment = NSTextAlignmentCenter;
    [doctorContentView addSubview:doctorPositionLabel];
    
    [doctorPositionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(doctorNameLabel.mas_right).offset(8);
        make.height.mas_equalTo(18);
        make.centerY.mas_equalTo(doctorNameLabel);
    }];
    self.doctorPositionLabel = doctorPositionLabel;
    
    self.doctorBackgroundStarView = [self createStarViewWithImage:BackgroundStarImage];
    [doctorContentView addSubview:self.doctorBackgroundStarView];
    
    [self.doctorBackgroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.left.mas_equalTo(doctorNameLabel);
        make.width.mas_equalTo(15 * 5);
        make.top.mas_equalTo(doctorNameLabel.mas_bottom).offset(4);
    }];
    
    self.doctorForegroundStarView = [self createStarViewWithImage:ForegroundStarImage];
    self.doctorForegroundStarView.clipsToBounds = true;
    [doctorContentView addSubview:self.doctorForegroundStarView];
    
    [self.doctorForegroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.left.mas_equalTo(doctorNameLabel);
        make.width.mas_equalTo(15 * 5);
        make.top.mas_equalTo(doctorNameLabel.mas_bottom).offset(4);
    }];
    
    UILabel *doctorScoreLabel = [[UILabel alloc] init];
    doctorScoreLabel.textColor = UIColorHex(0xFF6188);
    doctorScoreLabel.font = HM14;
    [doctorContentView addSubview:doctorScoreLabel];
    
    [doctorScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.left.mas_equalTo(self.doctorBackgroundStarView.mas_right).offset(0);
        make.top.bottom.mas_equalTo(self.doctorBackgroundStarView);
    }];
    self.doctorScoreValueLabel = doctorScoreLabel;
    

    
    UILabel *doctorHospitalLabel = [[UILabel alloc] init];
    doctorHospitalLabel.textColor = kDefaultBlackTextColor;
    doctorHospitalLabel.font = H13;
    [doctorContentView addSubview:doctorHospitalLabel];
    
    [doctorHospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(doctorHeadPortraitImageView.mas_right).offset(16);
        make.height.mas_equalTo(19);
        make.top.mas_equalTo(65);
        make.right.mas_equalTo(-16);
    }];
    self.doctorHospitalLabel = doctorHospitalLabel;
    
    UILabel *doctorDepartmentLabel = [[UILabel alloc] init];
    doctorDepartmentLabel.textColor = kDefaultGrayTextColor;
    doctorDepartmentLabel.font = H12;
    [doctorContentView addSubview:doctorDepartmentLabel];
    
    [doctorDepartmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(doctorNameLabel);
        make.height.mas_equalTo(19);
        make.top.mas_equalTo(88);
        make.right.mas_equalTo(-16);
    }];
    self.doctorDepartmentLabel = doctorDepartmentLabel;
    
    [view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(doctorContentView.mas_bottom).offset(20);
    }];
    
    // 设置过渡视图的底边距（此设置将影响到scrollView的contentSize）
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view.mas_bottom);
    }];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDoctorInfoAction)];
    [doctorContentView addGestureRecognizer:tapGR];
    
    self.doctorNameLabel.text = ISNIL(self.model.doctorName);
    self.doctorPositionLabel.text = ISNIL(self.model.doctorGrade);
    self.doctorHospitalLabel.text = ISNIL(self.model.doctorHospitalName);
    self.doctorScoreValueLabel.text = [NSString stringWithFormat:@"%.1f分", [self.model.commentScore floatValue]];
    self.doctorDepartmentLabel.text = [NSString stringWithFormat:@"%@", ISNIL(self.model.doctorSecondDepartmentName).length ? self.model.doctorSecondDepartmentName : ISNIL(self.model.doctorFirstDepartmentName)];
    
    [self.doctorForegroundStarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(13.5 * .5 * [self.model.commentScore floatValue]);
    }];
    
    [self.doctorHeadPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(self.model.doctorProfilePhoto)) placeholderImage:[UIImage imageNamed:@"doctor_default_portail"]];
    
    [self.doctorPositionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([self.doctorPositionLabel.text widthForFont:self.doctorPositionLabel.font] + 6);
    }];
    
    
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [likeButton setImage:[UIImage imageNamed:@"icon_like_unselected"] forState:UIControlStateNormal];
    [likeButton setImage:[UIImage imageNamed:@"icon_like_selected"] forState:UIControlStateSelected];
    [likeButton setTitleColor:kDefaultGrayTextColor forState:UIControlStateNormal];
    likeButton.titleLabel.font = H12;
    [view addSubview:likeButton];
#warning 暂时去掉点赞
//    [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.mas_equalTo(-16);
//        make.height.mas_equalTo(45);
//        make.bottom.mas_equalTo(doctorContentView.mas_top);
//
//    }];
    [likeButton addTarget:self action:@selector(clickLikeAction:) forControlEvents:UIControlEventTouchUpInside];
    self.likeButton = likeButton;
    
}

- (void)clickLikeAction:(UIButton *)sender {
    
    if ([GHUserModelTool shareInstance].isLogin == false) {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self presentViewController:vc animated:true completion:nil];
        
        return;
        
    }
    
    if (sender.selected == false) {
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"id"] = ISNIL(self.model.modelId);
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiLikeComment withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
            
            if (isSuccess) {
                
                sender.selected = true;
                
                self.model.likeCount = [NSString stringWithFormat:@"%ld", [self.model.likeCount integerValue] + 1];
                
                [self.likeButton setTitle:[NSString stringWithFormat:@"  %ld", [self.model.likeCount integerValue]] forState:UIControlStateNormal];
                
                [[GHZoneLikeManager shareInstance].systemCommentLikeIdArray addObject:[NSString stringWithFormat:@"%ld", [self.model.modelId longValue]]];

                
                [UIView animateWithDuration:.7 delay:0.f usingSpringWithDamping:0.3 initialSpringVelocity:15.0 options:UIViewAnimationOptionCurveLinear animations:^{
                    
                    self.likeButton.size = CGSizeMake(60, 60);
                    
                } completion:^(BOOL finished) {
                    NSLog(@"动画结束");
                }];
                
            }
            
        }];
        
        
        
    }
    
}


- (void)clickDoctorInfoAction {
    
    GHNewDoctorDetailViewController *vc = [[GHNewDoctorDetailViewController alloc] init];
    vc.doctorId = ISNIL(self.model.modelId);
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)clickPhotoAction:(UIGestureRecognizer *)gr {
    
    UIImageView *imageView = (UIImageView *)gr.view;
    
    kWeakSelf
    NSArray *imageInfoArray = [self.model.pictures jsonValueDecoded];
    
    NSMutableArray *imageUrlArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *info in imageInfoArray) {
        [imageUrlArray addObject:ISNIL(info[@"url"])];
    }
    
    [[GHPhotoTool shareInstance] showBigImage:imageUrlArray currentIndex:imageView.tag viewController:weakSelf cancelBtnText:@"取消"];
    
}

- (UIView *)createStarViewWithImage:(NSString *)imageName {
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < 5; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * 13.5, 0, 12, 22);
        imageView.contentMode = UIViewContentModeCenter;
        [view addSubview:imageView];
        
    }
    return view;
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

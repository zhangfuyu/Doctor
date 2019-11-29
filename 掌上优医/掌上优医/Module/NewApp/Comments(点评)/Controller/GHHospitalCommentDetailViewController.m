//
//  GHHospitalCommentDetailViewController.m
//  掌上优医
//
//  Created by GH on 2019/5/15.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHospitalCommentDetailViewController.h"

#import "GHHospitalDetailViewController.h"

#define ForegroundStarImage @"ic_huanzhepingjia_pingfenxing"
#define BackgroundStarImage @"ic_huanzhepingjia_pingfenxing_unselected"

#define StarForegroundStarImage @"ic_yonghuaming_xingxing_selected"
#define StarBackgroundStarImage @"ic_yonghuming_xingxing_unselected"

#define EmojiForegroundStarImage @"ic_dianping_selected"
#define EmojiBackgroundStarImage @"ic_dianping_unselected"

#import "GHNewHospitalViewController.h"

@interface GHHospitalCommentDetailViewController ()


@property (nonatomic, strong) UIImageView *headPortraitImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIView *foregroundStarView;
@property (nonatomic, strong) UIView *backgroundStarView;

@property (nonatomic, strong) UIView *environmentEmojiForegroundStarView;
@property (nonatomic, strong) UIView *environmentEmojiBackgroundStarView;

@property (nonatomic, strong) UIView *serverEmojiForegroundStarView;
@property (nonatomic, strong) UIView *serverEmojiBackgroundStarView;

@property (nonatomic, strong) UILabel *collectionScoreLabel;

@property (nonatomic, strong) UILabel *environmentScoreLabel;

@property (nonatomic, strong) UILabel *severScoreLabel;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIImageView *hospitalYibaoImageView;

@property (nonatomic, strong) UIImageView *hospitalHeadPortraitImageView;

@property (nonatomic, strong) UILabel *hospitalNameLabel;

@property (nonatomic, strong) UILabel *hospitalLevelLabel;

@property (nonatomic, strong) UILabel *hospitalTypeLabel;

@property (nonatomic, strong) UILabel *governmentLabel;

@property (nonatomic, strong) UILabel *mediaTypeLabel;

@property (nonatomic, strong) UILabel *hospitalAddressLabel;

@property (nonatomic, strong) UILabel *hospitalHospitalScoreValueLabel;

@property (nonatomic, strong) UIView *hospitalForegroundStarView;
@property (nonatomic, strong) UIView *hospitalBackgroundStarView;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIButton *likeButton;


@end

@implementation GHHospitalCommentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"点评详情";
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    [self setupUI];
    [self updateUI];
    
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    params[@"id"] = self.model.modelId;
//
//    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiCommentId withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:false withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
//
//        if (isSuccess) {
//
//            self.model = [[GHMyCommentsModel alloc] initWithDictionary:response error:nil];
//
//            [self setupUI];
//
//            [self requestData];
//
//        }
//
//    }];
//
    
}

//- (void)requestData {
//
//    NSMutableDictionary *sonParams = [[NSMutableDictionary alloc] init];
//    sonParams[@"ids"] = self.model.commentObjId;
//
//    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiHospitalSampleinfoIds withParameter:sonParams withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
//
//        if (isSuccess) {
//
//            for (NSDictionary *dic in response) {
//
//                if ([dic[@"id"] longValue] == [self.model.commentObjId longValue]) {
//
//                    self.model.hospitalCategory = dic[@"category"];
//                    self.model.hospitalGovernmentalHospitalFlag = dic[@"governmentalHospitalFlag"];
//
//                    self.model.hospitalProfilePhoto = dic[@"profilePhoto"];
//
//                    self.model.hospitalGrade = dic[@"grade"];
//                    self.model.hospitalAddress = dic[@"hospitalAddress"];
//                    self.model.hospitalName = dic[@"hospitalName"];
//                    self.model.hospitalMedicalInsuranceFlag = dic[@"medicalInsuranceFlag"];
//                    self.model.hospitalMedicineType = dic[@"medicineType"];
//                    self.model.hospitalScore = dic[@"score"];
//
//
//
//                    continue;
//
//                }
//
//            }
//
//             [self updateUI];
//
//        }
//
//    }];
//

    
//}

- (void)updateUI {
    
    
    [self.headPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(self.model.userProfileUrl)) placeholderImage:[UIImage imageNamed:@"personcenter_user_default"]];
    self.nameLabel.text = ISNIL(self.model.userNickName);
    self.timeLabel.text = [[NSDate dateWithString:ISNIL(self.model.createTime) format:@"yyyy-MM-dd HH:mm:ss"] stringWithFormat:@"yyyy年MM月dd日"];
    

    
    [self.foregroundStarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(6 + 22 * .5 * ([self.model.score integerValue] - 1));
    }];
    
    [self.environmentEmojiForegroundStarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(22 * .5 * [self.model.envScore integerValue]);
    }];
    
    for (id subview in self.environmentEmojiForegroundStarView.subviews) {
        
        if ([subview isKindOfClass:[UIImageView class]]) {
            
            ((UIImageView *)subview).image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%ld", EmojiForegroundStarImage, [self.model.envScore integerValue] / 2]];
            
        }
        
    }
    
    [self.serverEmojiForegroundStarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(22 * .5 * [self.model.serviceScore integerValue]);
    }];
    
    for (id subview in self.serverEmojiForegroundStarView.subviews) {
        
        if ([subview isKindOfClass:[UIImageView class]]) {
            
            ((UIImageView *)subview).image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%.0f", EmojiForegroundStarImage, [self.model.serviceScore integerValue] / 2.f]];
            
        }
        
    }
    
    self.collectionScoreLabel.text = [NSString stringWithFormat:@"%ld", [self.model.score integerValue]];

    NSInteger currentScore = [self.model.envScore integerValue];
    
    if (currentScore == 1 || currentScore == 2) {
        self.environmentScoreLabel.text = @"差";
    } else if (currentScore == 3 || currentScore == 4) {
        self.environmentScoreLabel.text = @"较差";
    } else if (currentScore == 5 || currentScore == 6) {
        self.environmentScoreLabel.text = @"一般";
    } else if (currentScore == 7 || currentScore == 8) {
        self.environmentScoreLabel.text = @"满意";
    } else if (currentScore == 9 || currentScore == 10) {
        self.environmentScoreLabel.text = @"非常满意";
    }
    
    currentScore = [self.model.serviceScore integerValue];;
    
    if (currentScore == 1 || currentScore == 2) {
        self.severScoreLabel.text = @"差";
    } else if (currentScore == 3 || currentScore == 4) {
        self.severScoreLabel.text = @"较差";
    } else if (currentScore == 5 || currentScore == 6) {
        self.severScoreLabel.text = @"一般";
    } else if (currentScore == 7 || currentScore == 8) {
        self.severScoreLabel.text = @"满意";
    } else if (currentScore == 9 || currentScore == 10) {
        self.severScoreLabel.text = @"非常满意";
    }
    
    [self.hospitalHeadPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(self.hospitalModel.profilePhoto)) placeholderImage:[UIImage imageNamed:@"hospital_placeholder"]];
    self.hospitalLevelLabel.text = self.hospitalModel.hospitalGrade;
    self.hospitalTypeLabel.text = self.hospitalModel.category;
    self.hospitalNameLabel.text = self.hospitalModel.hospitalName;
    self.hospitalAddressLabel.text = self.hospitalModel.hospitalAddress;
    
    self.hospitalHospitalScoreValueLabel.text = [NSString stringWithFormat:@"%.1f分", [self.hospitalModel.comprehensiveScore floatValue]];
    
    [self.hospitalForegroundStarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(13.5 * .5 * [self.hospitalModel.comprehensiveScore floatValue] - 1);
    }];
    
    [self.hospitalLevelLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([self.hospitalLevelLabel.text widthForFont:self.hospitalLevelLabel.font] + 8);
    }];
    
    [self.hospitalTypeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([self.hospitalTypeLabel.text widthForFont:self.hospitalTypeLabel.font] + 8);
    }];
    
    self.hospitalYibaoImageView.hidden = ![self.hospitalModel.medicalInsuranceFlag boolValue];
    
    [self.likeButton setTitle:[NSString stringWithFormat:@"  %ld", [self.model.likeCount integerValue]] forState:UIControlStateNormal];
    
    if ([[GHZoneLikeManager shareInstance].systemCommentLikeIdArray containsObject:self.hospitalModel.modelId]) {
        self.likeButton.selected = true;
    } else {
        self.likeButton.selected = false;
    }
    
    
    if ([self.hospitalModel.governmentalHospitalFlag integerValue] == 2) {
        self.governmentLabel.text = @"私立";
    } else {
        self.governmentLabel.text = @"公立";
    }
    
    self.mediaTypeLabel.text = ISNIL(self.model.hospitalMedicineType);
    
    if (self.governmentLabel.text.length) {
        
        self.governmentLabel.hidden = false;
        [self.governmentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([self.governmentLabel.text widthForFont:self.governmentLabel.font] + 8);
        }];
        
    } else {
        
        self.governmentLabel.hidden = true;
        
    }
    
    if (self.mediaTypeLabel.text.length) {
        
        self.mediaTypeLabel.hidden = false;
        [self.mediaTypeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([self.mediaTypeLabel.text widthForFont:self.mediaTypeLabel.font] + 8);
        }];
        
    } else {
        
        self.mediaTypeLabel.hidden = true;
        
    }
    
}


- (void)setupUI {
    
    NSString *commentsContent = ISNIL(self.model.comment);
    
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
        make.top.mas_equalTo(1);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    UIImageView *headPortraitImageView = [[UIImageView alloc] init];
    headPortraitImageView.contentMode = UIViewContentModeScaleAspectFill;
    headPortraitImageView.layer.cornerRadius = 25;
    headPortraitImageView.layer.borderColor = kDefaultLineViewColor.CGColor;
    headPortraitImageView.layer.borderWidth = 1;
    headPortraitImageView.layer.masksToBounds = true;
    headPortraitImageView.backgroundColor = kDefaultGaryViewColor;
//    [headPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(self.model.userProfileUrl)) placeholderImage:[UIImage imageNamed:@"personcenter_user_default"]];
    [view addSubview:headPortraitImageView];
    
    [headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.width.height.mas_equalTo(50);
        make.left.mas_equalTo(12);
    }];
    self.headPortraitImageView = headPortraitImageView;
    
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kDefaultBlackTextColor;
    nameLabel.font = H16;
//    nameLabel.text = ISNIL(self.model.userNickName);
    [view addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(10);
        make.height.mas_equalTo(25);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-16);
    }];
    self.nameLabel = nameLabel;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = kDefaultGrayTextColor;
    timeLabel.font = H13;
//    timeLabel.text = [[NSDate dateWithString:ISNIL(self.model.gmtCreate) format:@"yyyy-MM-dd HH:mm:ss"] stringWithFormat:@"yyyy年MM月dd日"];
    [view addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(10);
        make.height.mas_equalTo(17);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(3);
        make.right.mas_equalTo(-16);
    }];
    self.timeLabel = timeLabel;
    
    
    UILabel *collectionTitleLabel = [[UILabel alloc] init];
    collectionTitleLabel.font = H12;
    collectionTitleLabel.textColor = kDefaultBlackTextColor;
    collectionTitleLabel.text = @"综合:";
    [view addSubview:collectionTitleLabel];
    
    [collectionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(86);
    }];
    
    UILabel *collectionScoreLabel = [[UILabel alloc] init];
    collectionScoreLabel.font = H12;
    collectionScoreLabel.textColor = kDefaultBlackTextColor;
    [view addSubview:collectionScoreLabel];
    
    [collectionScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(184);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(86);
    }];
    self.collectionScoreLabel = collectionScoreLabel;
    
    self.backgroundStarView = [self createOnlyStarViewWithImage:StarBackgroundStarImage];
    [view addSubview:self.backgroundStarView];
    
    [self.backgroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16);
        make.left.mas_equalTo(58);
        make.width.mas_equalTo(30 * 5);
        make.centerY.mas_equalTo(collectionTitleLabel);
    }];
    
    self.foregroundStarView = [self createOnlyStarViewWithImage:StarForegroundStarImage];
    self.foregroundStarView.clipsToBounds = true;
    [view addSubview:self.foregroundStarView];
    
    [self.foregroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16);
        make.left.mas_equalTo(58);
        make.width.mas_equalTo(30 * 5);
        make.centerY.mas_equalTo(collectionTitleLabel);
    }];
    
    UILabel *environmentTitleLabel = [[UILabel alloc] init];
    environmentTitleLabel.font = H12;
    environmentTitleLabel.textColor = kDefaultBlackTextColor;
    environmentTitleLabel.text = @"环境:";
    [view addSubview:environmentTitleLabel];
    
    [environmentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(110);
    }];
    
    UILabel *environmentScoreLabel = [[UILabel alloc] init];
    environmentScoreLabel.font = H12;
    environmentScoreLabel.textColor = kDefaultBlackTextColor;
    [view addSubview:environmentScoreLabel];
    
    [environmentScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(184);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(110);
    }];
    self.environmentScoreLabel = environmentScoreLabel;
    
    self.environmentEmojiBackgroundStarView = [self createEmojiViewWithImage:EmojiBackgroundStarImage];
    [view addSubview:self.environmentEmojiBackgroundStarView];
    
    [self.environmentEmojiBackgroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16);
        make.left.mas_equalTo(58);
        make.width.mas_equalTo(30 * 5);
        make.centerY.mas_equalTo(environmentTitleLabel);
    }];
    
    
    
    self.environmentEmojiForegroundStarView = [self createEmojiViewWithImage:EmojiForegroundStarImage];
    self.environmentEmojiForegroundStarView.clipsToBounds = true;
    [view addSubview:self.environmentEmojiForegroundStarView];
    
    [self.environmentEmojiForegroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16);
        make.left.mas_equalTo(58);
        make.width.mas_equalTo(30 * 5);
        make.centerY.mas_equalTo(environmentTitleLabel);
    }];
    
    UILabel *serverTitleLabel = [[UILabel alloc] init];
    serverTitleLabel.font = H12;
    serverTitleLabel.textColor = kDefaultBlackTextColor;
    serverTitleLabel.text = @"服务:";
    [view addSubview:serverTitleLabel];
    
    [serverTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(131);
    }];
    
    UILabel *serverScoreLabel = [[UILabel alloc] init];
    serverScoreLabel.font = H12;
    serverScoreLabel.textColor = kDefaultBlackTextColor;
    [view addSubview:serverScoreLabel];
    
    [serverScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(184);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(131);
    }];
    self.severScoreLabel = serverScoreLabel;
    
    self.serverEmojiBackgroundStarView = [self createEmojiViewWithImage:EmojiBackgroundStarImage];
    [view addSubview:self.serverEmojiBackgroundStarView];
    
    [self.serverEmojiBackgroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16);
        make.left.mas_equalTo(58);
        make.width.mas_equalTo(30 * 5);
        make.centerY.mas_equalTo(serverTitleLabel);
    }];
    
    self.serverEmojiForegroundStarView = [self createEmojiViewWithImage:EmojiForegroundStarImage];
    self.serverEmojiForegroundStarView.clipsToBounds = true;
    [view addSubview:self.serverEmojiForegroundStarView];
    
    [self.serverEmojiForegroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16);
        make.left.mas_equalTo(58);
        make.width.mas_equalTo(30 * 5);
        make.centerY.mas_equalTo(serverTitleLabel);
    }];
    
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.font = H15;
    descLabel.textColor = kDefaultBlackTextColor;
    descLabel.numberOfLines = 0;
    [view addSubview:descLabel];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([commentsContent getShouldHeightWithContent:commentsContent withFont:H15 withWidth:SCREENWIDTH - 32  withLineHeight:21]);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(168);
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
    
    self.contentLabel = descLabel;
    
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
            make.top.mas_equalTo(descLabel.mas_bottom).offset((95) * (index / 3) + 15);
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPhotoAction:)];
        [imageView addGestureRecognizer:tapGR];
        
    }
    
    
    
    
    UIView *hospitalcontentView = [[UIView alloc] init];
    hospitalcontentView.backgroundColor = [UIColor whiteColor];
    hospitalcontentView.layer.cornerRadius = 4;
    hospitalcontentView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    hospitalcontentView.layer.shadowOffset = CGSizeMake(0,2);
    hospitalcontentView.layer.shadowOpacity = 1;
    hospitalcontentView.layer.shadowRadius = 4;
    [view addSubview:hospitalcontentView];
    
    [hospitalcontentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(descLabel.mas_bottom).offset(ceil(imageInfoArray.count / 3.f) * 105 + 35);
        make.height.mas_equalTo(114);
    }];
    
    UIImageView *hospitalHeadPortraitImageView = [[UIImageView alloc] init];
    hospitalHeadPortraitImageView.contentMode = UIViewContentModeScaleAspectFill;
    hospitalHeadPortraitImageView.layer.cornerRadius = 2;
    hospitalHeadPortraitImageView.layer.masksToBounds = true;
    hospitalHeadPortraitImageView.backgroundColor = kDefaultGaryViewColor;
    [hospitalcontentView addSubview:hospitalHeadPortraitImageView];

    [hospitalHeadPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.width.height.mas_equalTo(90);
        make.left.mas_equalTo(12);
    }];
    self.hospitalHeadPortraitImageView = hospitalHeadPortraitImageView;
    
    UIImageView *hospitalYibaoImageView = [[UIImageView alloc] init];
    hospitalYibaoImageView.contentMode = UIViewContentModeScaleAspectFill;
    hospitalYibaoImageView.image = [UIImage imageNamed:@"hospital_yibao"];
    hospitalYibaoImageView.hidden = true;
    [hospitalcontentView addSubview:hospitalYibaoImageView];
    
    [hospitalYibaoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(23);
    }];
    self.hospitalYibaoImageView = hospitalYibaoImageView;

    UILabel *hospitalNameLabel = [[UILabel alloc] init];
    hospitalNameLabel.textColor = kDefaultBlackTextColor;
    hospitalNameLabel.font = HM15;
    [hospitalcontentView addSubview:hospitalNameLabel];

    [hospitalNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hospitalHeadPortraitImageView.mas_right).offset(16);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(hospitalHeadPortraitImageView.mas_top);
    }];
    self.hospitalNameLabel = hospitalNameLabel;


    self.hospitalBackgroundStarView = [self createStarViewWithImage:BackgroundStarImage];
    [hospitalcontentView addSubview:self.hospitalBackgroundStarView];

    [self.hospitalBackgroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.left.mas_equalTo(hospitalNameLabel);
        make.width.mas_equalTo(15 * 5);
        make.top.mas_equalTo(hospitalNameLabel.mas_bottom).offset(2);
    }];

    self.hospitalForegroundStarView = [self createStarViewWithImage:ForegroundStarImage];
    self.hospitalForegroundStarView.clipsToBounds = true;
    [hospitalcontentView addSubview:self.hospitalForegroundStarView];

    [self.hospitalForegroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.left.mas_equalTo(hospitalNameLabel);
        make.width.mas_equalTo(15 * 5);
        make.top.mas_equalTo(hospitalNameLabel.mas_bottom).offset(2);
    }];

    UILabel *hospitalScoreLabel = [[UILabel alloc] init];
    hospitalScoreLabel.textColor = UIColorHex(0xFF6188);
    hospitalScoreLabel.font = HM14;
    [hospitalcontentView addSubview:hospitalScoreLabel];

    [hospitalScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.left.mas_equalTo(self.hospitalBackgroundStarView.mas_right).offset(0);
        make.top.bottom.mas_equalTo(self.hospitalBackgroundStarView);
    }];
    self.hospitalHospitalScoreValueLabel = hospitalScoreLabel;


    UILabel *levelLabel = [[UILabel alloc] init];
    levelLabel.textColor = UIColorHex(0x999999);
    levelLabel.layer.cornerRadius = 1;
    levelLabel.layer.masksToBounds = true;
    levelLabel.layer.borderColor = levelLabel.textColor.CGColor;
    levelLabel.layer.borderWidth = .5;
    levelLabel.font = H10;
    levelLabel.textAlignment = NSTextAlignmentCenter;
    [hospitalcontentView addSubview:levelLabel];

    [levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hospitalNameLabel);
        make.height.mas_equalTo(18);
        make.top.mas_equalTo(61);
    }];
    self.hospitalLevelLabel = levelLabel;

    UILabel *typeLabel = [[UILabel alloc] init];
    typeLabel.textColor = UIColorHex(0x999999);
    typeLabel.layer.cornerRadius = 1;
    typeLabel.layer.masksToBounds = true;
    typeLabel.layer.borderColor = levelLabel.textColor.CGColor;
    typeLabel.layer.borderWidth = .5;
    typeLabel.font = H10;
    typeLabel.textAlignment = NSTextAlignmentCenter;
    [hospitalcontentView addSubview:typeLabel];

    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(levelLabel.mas_right).offset(5);
        make.height.mas_equalTo(18);
        make.top.mas_equalTo(61);
    }];
    self.hospitalTypeLabel = typeLabel;
    
    UILabel *governmentLabel = [[UILabel alloc] init];
    governmentLabel.textColor = UIColorHex(0x999999);
    governmentLabel.layer.cornerRadius = 1;
    governmentLabel.layer.masksToBounds = true;
    governmentLabel.layer.borderColor = levelLabel.textColor.CGColor;
    governmentLabel.layer.borderWidth = .5;
    governmentLabel.font = H10;
    governmentLabel.textAlignment = NSTextAlignmentCenter;
    [hospitalcontentView addSubview:governmentLabel];
    
    [governmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(typeLabel.mas_right).offset(5);
        make.height.mas_equalTo(18);
        make.top.mas_equalTo(61);
    }];
    self.governmentLabel = governmentLabel;
    
    UILabel *mediaTypeLabel = [[UILabel alloc] init];
    mediaTypeLabel.textColor = UIColorHex(0x999999);
    mediaTypeLabel.layer.cornerRadius = 1;
    mediaTypeLabel.layer.masksToBounds = true;
    mediaTypeLabel.layer.borderColor = levelLabel.textColor.CGColor;
    mediaTypeLabel.layer.borderWidth = .5;
    mediaTypeLabel.font = H10;
    mediaTypeLabel.textAlignment = NSTextAlignmentCenter;
    [hospitalcontentView addSubview:mediaTypeLabel];
    
    [mediaTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(governmentLabel.mas_right).offset(5);
        make.height.mas_equalTo(18);
        make.top.mas_equalTo(61);
    }];
    self.mediaTypeLabel = mediaTypeLabel;
    

    UIImageView *addressIconImageView = [[UIImageView alloc] init];
    addressIconImageView.contentMode = UIViewContentModeCenter;
    addressIconImageView.image = [UIImage imageNamed:@"hospital_address_location_icon"];
    [hospitalcontentView addSubview:addressIconImageView];

    [addressIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(16);
        make.left.mas_equalTo(hospitalNameLabel.mas_left).offset(-2);
        make.top.mas_equalTo(88);
    }];

    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.font = H12;
    addressLabel.textColor = kDefaultGrayTextColor;
    [hospitalcontentView addSubview:addressLabel];

    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(addressIconImageView.mas_right).offset(4);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(85);
    }];
    self.hospitalAddressLabel = addressLabel;

    
    [view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(hospitalcontentView.mas_bottom).offset(20);
    }];
    
    // 设置过渡视图的底边距（此设置将影响到scrollView的contentSize）
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view.mas_bottom);
    }];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHospitalInfoAction)];
    [hospitalcontentView addGestureRecognizer:tapGR];
    
    
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [likeButton setImage:[UIImage imageNamed:@"icon_like_unselected"] forState:UIControlStateNormal];
    [likeButton setImage:[UIImage imageNamed:@"icon_like_selected"] forState:UIControlStateSelected];
    [likeButton setTitleColor:kDefaultGrayTextColor forState:UIControlStateNormal];
    likeButton.titleLabel.font = H12;
    [view addSubview:likeButton];
#warning 点赞暂时去掉
//    [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.mas_equalTo(-16);
//        make.height.mas_equalTo(45);
//        make.bottom.mas_equalTo(hospitalcontentView.mas_top);
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


- (void)clickHospitalInfoAction {
    
    GHSearchHospitalModel *model = [[GHSearchHospitalModel alloc] init];
    model.modelId = self.model.commentObjId;
    model.hospitalName = self.model.hospitalName;
    
    GHNewHospitalViewController *vc = [[GHNewHospitalViewController alloc] init];
    vc.hospitalID = self.model.modelId;
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

- (UIView *)createOnlyStarViewWithImage:(NSString *)imageName {
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < 5; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * 22, 0, 12, 16);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
        
    }
    return view;
}

- (UIView *)createEmojiViewWithImage:(NSString *)imageName {
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < 5; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_%ld", imageName, i + 1]]];
        imageView.frame = CGRectMake(i * 22, 0, 12, 16);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
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

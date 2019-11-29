//
//  GHMyCommentHospitalTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/5/15.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHMyCommentHospitalTableViewCell.h"

#import "GHHospitalDetailViewController.h"
#import "GHNewHospitalViewController.h"

//#define ForegroundStarImage @"ic_huanzhepingjia_pingfenxing"
//#define BackgroundStarImage @"ic_huanzhepingjia_pingfenxing_unselected"

#define ForegroundStarImage @"ic_xingxing_all_selected"
#define BackgroundStarImage @"ic_xingxing_all_unselected"

@interface GHMyCommentHospitalTableViewCell ()

@property (nonatomic, strong) UIImageView *headPortraitImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *scoreValueLabel;

@property (nonatomic, strong) UIImageView *foregroundStarView;
@property (nonatomic, strong) UIImageView *backgroundStarView;

@property (nonatomic, strong) UIImageView *oneImageView;
@property (nonatomic, strong) UIImageView *twoImageView;
@property (nonatomic, strong) UIImageView *threeImageView;
@property (nonatomic, strong) UIImageView *fourImageView;
@property (nonatomic, strong) UIImageView *fiveImageView;
@property (nonatomic, strong) UIImageView *sixImageView;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *imageViewArray;


@property (nonatomic, strong) UIImageView *hospitalHeadPortraitImageView;

@property (nonatomic, strong) UIImageView *hospitalYibaoImageView;

@property (nonatomic, strong) UILabel *hospitalNameLabel;

@property (nonatomic, strong) UILabel *hospitalLevelLabel;

@property (nonatomic, strong) UILabel *hospitalTypeLabel;

@property (nonatomic, strong) UILabel *governmentLabel;

@property (nonatomic, strong) UILabel *mediaTypeLabel;

@property (nonatomic, strong) UILabel *hospitalAddressLabel;

@property (nonatomic, strong) UILabel *hospitalHospitalScoreValueLabel;

@property (nonatomic, strong) UIImageView *hospitalForegroundStarView;
@property (nonatomic, strong) UIImageView *hospitalBackgroundStarView;


@property (nonatomic, strong) UIButton *likeButton;



@end

@implementation GHMyCommentHospitalTableViewCell

- (NSMutableArray *)imageViewArray {
    
    if (!_imageViewArray) {
        _imageViewArray = [[NSMutableArray alloc] init];
    }
    return _imageViewArray;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {

    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-1);
    }];
    
    UIImageView *headPortraitImageView = [[UIImageView alloc] init];
    headPortraitImageView.contentMode = UIViewContentModeScaleAspectFill;
    headPortraitImageView.layer.cornerRadius = 20;
    headPortraitImageView.layer.masksToBounds = true;
    headPortraitImageView.layer.borderColor = kDefaultLineViewColor.CGColor;
    headPortraitImageView.layer.borderWidth = 1;
    headPortraitImageView.backgroundColor = kDefaultGaryViewColor;
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
    [view addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(10);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(13);
        make.right.mas_equalTo(-150);
    }];
    self.nameLabel = nameLabel;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = kDefaultGrayTextColor;
    timeLabel.font = H12;
    [view addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(10);
        make.height.mas_equalTo(17);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(2);
        make.right.mas_equalTo(-16);
    }];
    self.timeLabel = timeLabel;
    
    
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = H14;
    contentLabel.textColor = kDefaultBlackTextColor;
    contentLabel.numberOfLines = 6;
    [view addSubview:contentLabel];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headPortraitImageView.mas_bottom).offset(0);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
    }];
    self.contentLabel = contentLabel;
    
    UILabel *scoreValueLabel = [[UILabel alloc] init];
    scoreValueLabel.font = HM14;
    scoreValueLabel.textColor = UIColorHex(0xFF6188);
    scoreValueLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:scoreValueLabel];
    
    [scoreValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(13);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(22);
    }];
    self.scoreValueLabel = scoreValueLabel;
    
    
    self.backgroundStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:BackgroundStarImage]];
    self.backgroundStarView.contentMode = UIViewContentModeLeft;
    self.backgroundStarView.clipsToBounds = true;
    [view addSubview:self.backgroundStarView];
    
    [self.backgroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.left.mas_equalTo(SCREENWIDTH - 140);
        make.width.mas_equalTo(15 * 5);
        make.centerY.mas_equalTo(scoreValueLabel);
    }];
    
    self.foregroundStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:ForegroundStarImage]];
    self.foregroundStarView.contentMode = UIViewContentModeLeft;
    self.foregroundStarView.clipsToBounds = true;
    [view addSubview:self.foregroundStarView];
    
    [self.foregroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.left.mas_equalTo(SCREENWIDTH - 140);
        make.width.mas_equalTo(15 * 5);
        make.centerY.mas_equalTo(scoreValueLabel);
    }];
    
    
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
        make.bottom.mas_equalTo(-20);
        make.height.mas_equalTo(115);
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
    
    
    self.hospitalBackgroundStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:BackgroundStarImage]];
    self.hospitalBackgroundStarView.contentMode = UIViewContentModeLeft;
    self.hospitalBackgroundStarView.clipsToBounds = true;
    [hospitalcontentView addSubview:self.hospitalBackgroundStarView];
    
    [self.hospitalBackgroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.left.mas_equalTo(hospitalNameLabel);
        make.width.mas_equalTo(15 * 5);
        make.top.mas_equalTo(hospitalNameLabel.mas_bottom).offset(2);
    }];
    
    self.hospitalForegroundStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:ForegroundStarImage]];
    self.hospitalForegroundStarView.contentMode = UIViewContentModeLeft;
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
        make.left.mas_equalTo(self.hospitalBackgroundStarView.mas_right).offset(5);
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
    
    for (NSInteger index = 0; index < 6; index++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = kDefaultGaryViewColor;
        imageView.clipsToBounds = true;
        imageView.tag = index;
        imageView.userInteractionEnabled = true;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(90);
            make.width.mas_equalTo(90);
            make.left.mas_equalTo(16 + 95 * (index % 3));
            make.top.mas_equalTo(contentLabel.mas_bottom).offset((95) * (index / 3) + 4);
        }];
        
        imageView.hidden = YES;
        
        [self.imageViewArray addObject:imageView];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPhotoAction:)];
        [imageView addGestureRecognizer:tapGR];
        
    }
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHospitalInfoAction)];
    [hospitalcontentView addGestureRecognizer:tapGR];
    
//    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [likeButton setImage:[UIImage imageNamed:@"icon_like_unselected"] forState:UIControlStateNormal];
//    [likeButton setImage:[UIImage imageNamed:@"icon_like_selected"] forState:UIControlStateSelected];
//    [likeButton setTitleColor:kDefaultGrayTextColor forState:UIControlStateNormal];
//    likeButton.titleLabel.font = H12;
//    [view addSubview:likeButton];
//    
//    [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.right.mas_equalTo(-16);
//        make.height.mas_equalTo(45);
//        make.bottom.mas_equalTo(hospitalcontentView.mas_top);
//        
//    }];
//    [likeButton addTarget:self action:@selector(clickLikeAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.likeButton = likeButton;
}

- (void)clickLikeAction:(UIButton *)sender {
    
    if ([GHUserModelTool shareInstance].isLogin == false) {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self.viewController presentViewController:vc animated:true completion:nil];
        
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
    
//    GHSearchHospitalModel *model = [[GHSearchHospitalModel alloc] init];
//    model.modelId = self.model.commentObjId;
//    model.hospitalName = self.model.hospitalModel.hospitalName;
    
    GHNewHospitalViewController *vc = [[GHNewHospitalViewController alloc] init];
    vc.hospitalID = self.model.hospitalModel.modelId;;
    [self.viewController.navigationController pushViewController:vc animated:true];
    
}

- (UIView *)createStarViewWithImage:(NSString *)imageName {
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
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

- (void)setModel:(GHDoctorCommentModel *)model {
    
    _model = model;
    
    
    self.nameLabel.text = ISNIL(model.userNickName);
    self.timeLabel.text = [[NSDate dateWithString:ISNIL(model.gmtCreate) format:@"yyyy-MM-dd HH:mm:ss"] stringWithFormat:@"yyyy年MM月dd日"];
    self.contentLabel.text = ISNIL(model.comment);
    
    [self.headPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.userProfileUrl)) placeholderImage:[UIImage imageNamed:@"personcenter_user_default"]];
    
 
    
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([model.contentHeight floatValue]);
    }];
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.maximumLineHeight = 21;
    paragraphStyle.minimumLineHeight = 21;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:ISNIL(model.comment)];
    
    [attr addAttributes:@{NSFontAttributeName: H15} range:NSMakeRange(0, attr.string.length)];
    [attr addAttributes:@{NSForegroundColorAttributeName: kDefaultBlackTextColor} range:NSMakeRange(0, attr.string.length)];
    
    [attr addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, attr.string.length)];
    
    self.contentLabel.attributedText = attr;
    
    self.scoreValueLabel.text = [NSString stringWithFormat:@"%.1f分", [model.score floatValue]];
    
    [self.foregroundStarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(13.5 * .5 * [model.score integerValue]);
    }];
    
    NSArray *imageInfoArray = [model.pictures jsonValueDecoded];
    
    
    for (NSInteger index = 0; index < self.imageViewArray.count; index++) {
        
        UIImageView *imageView = [self.imageViewArray objectOrNilAtIndex:index];
        
        imageView.hidden = true;
        
        NSString *url = [imageInfoArray objectOrNilAtIndex:index][@"url"];
        
        if (url.length) {
            
            imageView.hidden = false;
            
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:kGetImageURLWithString(url) options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {

            } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {

                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        imageView.image = [[image imageByResizeToSize:CGSizeMake(90, 90)] imageByRoundCornerRadius:4];
                    });
                }

            }];
            
//            [imageView sd_setImageWithURL:kGetImageURLWithString(url)];
            
        }
        
    }
    
    [self.hospitalHeadPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.hospitalModel.profilePhoto)) placeholderImage:[UIImage imageNamed:@"hospital_placeholder"]];
    self.hospitalLevelLabel.text = self.model.hospitalModel.hospitalGrade;
    self.hospitalTypeLabel.text = self.model.hospitalModel.category;
    self.hospitalNameLabel.text = self.model.hospitalModel.hospitalName;
    self.hospitalAddressLabel.text = self.model.hospitalModel.hospitalAddress;
    
    self.hospitalHospitalScoreValueLabel.text = [NSString stringWithFormat:@"%.1f分", [self.model.hospitalModel.comprehensiveScore floatValue]];
    
    self.hospitalYibaoImageView.hidden = ![model.hospitalModel.medicalInsuranceFlag boolValue];
    
    [self.hospitalForegroundStarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15 * .5 * [self.model.hospitalModel.comprehensiveScore floatValue]);
    }];
    
    [self.hospitalLevelLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([self.hospitalLevelLabel.text widthForFont:self.hospitalLevelLabel.font] + 8);
    }];
    
    [self.hospitalTypeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([self.hospitalTypeLabel.text widthForFont:self.hospitalTypeLabel.font] + 8);
    }];
    
    [self.likeButton setTitle:[NSString stringWithFormat:@"  %ld", [self.model.likeCount integerValue]] forState:UIControlStateNormal];
    
    if ([[GHZoneLikeManager shareInstance].systemCommentLikeIdArray containsObject:self.model.modelId]) {
        self.likeButton.selected = true;
    } else {
        self.likeButton.selected = false;
    }
    
    if ([model.hospitalModel.governmentalHospitalFlag integerValue] == 0) {
        self.governmentLabel.text = @"私立";
    } else {
        self.governmentLabel.text = @"公立";
    }
    
    self.mediaTypeLabel.text = ISNIL(model.hospitalModel.medicineType);
    
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

- (void)clickPhotoAction:(UIGestureRecognizer *)gr {
    
    UIImageView *imageView = (UIImageView *)gr.view;
    
    kWeakSelf
    NSArray *imageInfoArray = [self.model.pictures jsonValueDecoded];
    
    NSMutableArray *imageUrlArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *info in imageInfoArray) {
        [imageUrlArray addObject:ISNIL(info[@"url"])];
    }
    
    [[GHPhotoTool shareInstance] showBigImage:imageUrlArray currentIndex:imageView.tag viewController:weakSelf.viewController cancelBtnText:@"取消"];
    
}

    
@end

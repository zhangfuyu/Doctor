//
//  GHMyCommentsTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/2/20.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHMyCommentsTableViewCell.h"
#import "GHDocterDetailViewController.h"
#import "GHNewDoctorDetailViewController.h"

//#define ForegroundStarImage @"ic_huanzhepingjia_pingfenxing"
//#define BackgroundStarImage @"ic_huanzhepingjia_pingfenxing_unselected"

#define ForegroundStarImage @"ic_xingxing_all_selected"
#define BackgroundStarImage @"ic_xingxing_all_unselected"

@interface GHMyCommentsTableViewCell ()

@property (nonatomic, strong) UIImageView *headPortraitImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *contentLabel;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *scoreValueLabel;

@property (nonatomic, strong) UIImageView *foregroundStarView;
@property (nonatomic, strong) UIImageView *backgroundStarView;

@property (nonatomic, strong) UIImageView *doctorHeadPortraitImageView;

@property (nonatomic, strong) UILabel *doctorNameLabel;

@property (nonatomic, strong) UILabel *doctorPositionLabel;

@property (nonatomic, strong) UILabel *doctorHospitalLabel;

@property (nonatomic, strong) UILabel *doctorScoreTitleLabel;

@property (nonatomic, strong) UILabel *doctorScoreValueLabel;

@property (nonatomic, strong) UIImageView *doctorForegroundStarView;
@property (nonatomic, strong) UIImageView *doctorBackgroundStarView;

@property (nonatomic, strong) UILabel *doctorDepartmentLabel;

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

/**
 <#Description#>
 */
@property (nonatomic, strong) UIButton *likeButton;

@end

@implementation GHMyCommentsTableViewCell

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
    

    
    UIView *doctorContentView = [[UIView alloc] init];
    doctorContentView.backgroundColor = [UIColor whiteColor];
    doctorContentView.layer.cornerRadius = 4;
    doctorContentView.layer.borderColor = kDefaultLineViewColor.CGColor;
    doctorContentView.layer.borderWidth = 1;
    doctorContentView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    doctorContentView.layer.shadowOffset = CGSizeMake(0,2);
    doctorContentView.layer.shadowOpacity = 1;
    doctorContentView.layer.shadowRadius = 2;
    [view addSubview:doctorContentView];
    
    [doctorContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.bottom.mas_equalTo(-20);
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

    self.doctorBackgroundStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:BackgroundStarImage]];
    self.doctorBackgroundStarView.contentMode = UIViewContentModeLeft;
    self.doctorBackgroundStarView.clipsToBounds = true;
    [doctorContentView addSubview:self.doctorBackgroundStarView];
    
    [self.doctorBackgroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.left.mas_equalTo(doctorNameLabel);
        make.width.mas_equalTo(15 * 5);
        make.top.mas_equalTo(doctorNameLabel.mas_bottom).offset(4);
    }];
    
    self.doctorForegroundStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:ForegroundStarImage]];
    self.doctorForegroundStarView.contentMode = UIViewContentModeLeft;
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
        make.left.mas_equalTo(self.doctorBackgroundStarView.mas_right).offset(5);
        make.top.bottom.mas_equalTo(self.doctorBackgroundStarView);
    }];
    self.doctorScoreValueLabel = doctorScoreLabel;
    
//    UILabel *doctorScoreLabel = [[UILabel alloc] init];
//    doctorScoreLabel.textColor = UIColorHex(0xFF6188);
//    doctorScoreLabel.font = HM14;
//    doctorScoreLabel.textAlignment = NSTextAlignmentRight;
//    [doctorContentView addSubview:doctorScoreLabel];
//
//    [doctorScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-12);
//        make.width.mas_equalTo(26);
//        make.height.mas_equalTo(19);
//        make.centerY.mas_equalTo(doctorNameLabel);
//    }];
//    self.doctorScoreValueLabel = doctorScoreLabel;
//
//    UILabel *doctorScoreTitleLabel = [[UILabel alloc] init];
//    doctorScoreTitleLabel.textColor = kDefaultGrayTextColor;
//    doctorScoreTitleLabel.font = H12;
//    doctorScoreTitleLabel.text = @"评分";
//    [doctorContentView addSubview:doctorScoreTitleLabel];
//
//    [doctorScoreTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(doctorScoreLabel.mas_left);
//        make.width.mas_equalTo(26);
//        make.height.mas_equalTo(19);
//        make.centerY.mas_equalTo(doctorNameLabel);
//    }];
//    self.doctorScoreTitleLabel = doctorScoreTitleLabel;
    
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
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDoctorInfoAction)];
    [doctorContentView addGestureRecognizer:tapGR];
    
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
//        make.bottom.mas_equalTo(doctorContentView.mas_top);
//        
//    }];
//    [likeButton addTarget:self action:@selector(clickLikeAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.likeButton = likeButton;
    
}

- (void)clickDoctorInfoAction {
    
    GHNewDoctorDetailViewController *vc = [[GHNewDoctorDetailViewController alloc] init];
    vc.doctorId = self.model.doctorModel.modelId;
    [self.viewController.navigationController pushViewController:vc animated:true];
    
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
    
    self.doctorNameLabel.text = ISNIL(model.doctorModel.doctorName);
    self.doctorPositionLabel.text = ISNIL(model.doctorModel.doctorGrade);
    self.doctorHospitalLabel.text = ISNIL(model.doctorModel.hospitalName);
    self.doctorScoreValueLabel.text = [NSString stringWithFormat:@"%.1f分", [model.doctorModel.commentScore floatValue]];
    
    self.doctorDepartmentLabel.text = [NSString stringWithFormat:@"%@", ISNIL(model.doctorModel.firstDepartmentName).length ? model.doctorModel.firstDepartmentName : ISNIL(model.doctorModel.secondDepartmentName)];
    
    [self.doctorForegroundStarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15 * .5 * [model.doctorModel.commentScore floatValue]);
    }];
    
    [self.doctorHeadPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.doctorModel.headImgUrl))  placeholderImage:[UIImage imageNamed:@"doctor_default_portail"]];
    
    [self.doctorPositionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([self.doctorPositionLabel.text widthForFont:self.doctorPositionLabel.font] + 6);
    }];
    
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
        make.width.mas_equalTo(15 * .5 * [model.score integerValue]);
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
    
    [self.likeButton setTitle:[NSString stringWithFormat:@"  %ld", [self.model.likeCount integerValue]] forState:UIControlStateNormal];
    
    if ([[GHZoneLikeManager shareInstance].systemCommentLikeIdArray containsObject:self.model.modelId]) {
        self.likeButton.selected = true;
    } else {
        self.likeButton.selected = false;
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


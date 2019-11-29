//
//  GHDoctorCommentTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/1/16.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHDoctorCommentTableViewCell.h"
#import "GHDocterDetailViewController.h"

//#define ForegroundStarImage @"ic_huanzhepingjia_pingfenxing"
//#define BackgroundStarImage @"ic_huanzhepingjia_pingfenxing_unselected"

#define ForegroundStarImage @"ic_xingxing_all_selected"
#define BackgroundStarImage @"ic_xingxing_all_unselected"

@interface GHDoctorCommentTableViewCell ()

@property (nonatomic, strong) UIImageView *headPortraitImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *scoreValueLabel;

//@property (nonatomic, strong) UIView *foregroundStarView;
//@property (nonatomic, strong) UIView *backgroundStarView;

@property (nonatomic, strong) UIImageView *foregroundStarView;
@property (nonatomic, strong) UIImageView *backgroundStarView;

@property (nonatomic, strong) UIImageView *oneImageView;
@property (nonatomic, strong) UIImageView *twoImageView;
@property (nonatomic, strong) UIImageView *threeImageView;
@property (nonatomic, strong) UIImageView *fourImageView;
@property (nonatomic, strong) UIImageView *fiveImageView;
@property (nonatomic, strong) UIImageView *sixImageView;

@property (nonatomic, strong) NSMutableArray *imageViewArray;

@property (nonatomic, strong) UIButton *likeButton;

@end

@implementation GHDoctorCommentTableViewCell

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
    
    
    self.backgroundColor = kDefaultGaryViewColor;
    self.contentView.backgroundColor = kDefaultGaryViewColor;
    
    
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
    headPortraitImageView.layer.cornerRadius = 18;
    headPortraitImageView.layer.masksToBounds = true;
    headPortraitImageView.backgroundColor = kDefaultGaryViewColor;
    [view addSubview:headPortraitImageView];
    
    [headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.width.height.mas_equalTo(36);
        make.left.mas_equalTo(15);
    }];
    self.headPortraitImageView = headPortraitImageView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kDefaultBlackTextColor;
    nameLabel.font = H14;
    [view addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(10);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(self.headPortraitImageView.mas_top);
        make.right.mas_equalTo(-150);
    }];
    self.nameLabel = nameLabel;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = kDefaultGrayTextColor;
    timeLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(10);
        make.height.mas_equalTo(12);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(-15);
    }];
    self.timeLabel = timeLabel;
    
    
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = H12;
    contentLabel.textColor = kDefaultBlackTextColor;
    contentLabel.numberOfLines = 0;
    [view addSubview:contentLabel];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headPortraitImageView.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    self.contentLabel = contentLabel;
    
    
    
    UILabel *scoreValueLabel = [[UILabel alloc] init];
    scoreValueLabel.font = HM14;
    scoreValueLabel.textColor = UIColorHex(0xFF6188);
    scoreValueLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:scoreValueLabel];
    
    [scoreValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(13);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(22);
    }];
    self.scoreValueLabel = scoreValueLabel;
    
    
//    self.backgroundStarView = [self createStarViewWithImage:BackgroundStarImage];
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
    
//    self.foregroundStarView = [self createStarViewWithImage:ForegroundStarImage];
    self.foregroundStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:ForegroundStarImage]];
    self.foregroundStarView.contentMode = UIViewContentModeLeft;
    self.foregroundStarView.clipsToBounds = true;
    self.foregroundStarView.clipsToBounds = true;
    [view addSubview:self.foregroundStarView];
    
    [self.foregroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.left.mas_equalTo(SCREENWIDTH - 140);
        make.width.mas_equalTo(15 * 5);
        make.centerY.mas_equalTo(scoreValueLabel);
    }];

    
    float imageviewHeight = ((SCREENWIDTH - 15 * 4) / 3.0);

    
    for (NSInteger index = 0; index < 6; index++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = kDefaultGaryViewColor;
        imageView.clipsToBounds = true;
        imageView.tag = index;
        imageView.userInteractionEnabled = true;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(imageviewHeight);
            make.width.mas_equalTo(imageviewHeight);
            make.left.mas_equalTo(15 * (index % 3 + 1) + imageviewHeight * (index % 3));
            make.top.mas_equalTo(contentLabel.mas_bottom).offset((imageviewHeight) * (index / 3) +  (index / 3 + 1) *10);
        }];
        
        imageView.hidden = YES;
        
        [self.imageViewArray addObject:imageView];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPhotoAction:)];
        [imageView addGestureRecognizer:tapGR];
        
    }
 
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [likeButton setImage:[UIImage imageNamed:@"icon_like_unselected"] forState:UIControlStateNormal];
    [likeButton setImage:[UIImage imageNamed:@"icon_like_selected"] forState:UIControlStateSelected];
    [likeButton setTitleColor:kDefaultGrayTextColor forState:UIControlStateNormal];
    likeButton.titleLabel.font = H12;
    [view addSubview:likeButton];
    
//    [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.mas_equalTo(-15);
//        make.height.mas_equalTo(45);
//        make.bottom.mas_equalTo(0);
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
    self.timeLabel.text = ISNIL(model.createTime);//[[NSDate dateWithString:ISNIL(model.gmtCreate) format:@"yyyy-MM-dd HH:mm:ss"] stringWithFormat:@"yyyy年MM月dd日"];

    
    [self.headPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.userProfileUrl)) placeholderImage:[UIImage imageNamed:@"personcenter_user_default"]];
    
   
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.maximumLineHeight = 21;
    paragraphStyle.minimumLineHeight = 21;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:ISNIL(model.comment)];
    
    [attr addAttributes:@{NSFontAttributeName: H12} range:NSMakeRange(0, attr.string.length)];
    [attr addAttributes:@{NSForegroundColorAttributeName: kDefaultBlackTextColor} range:NSMakeRange(0, attr.string.length)];
    
    [attr addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, attr.string.length)];
    
    self.contentLabel.attributedText = attr;
    
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([model.contentHeight floatValue]);
    }];
    
    self.scoreValueLabel.text = [NSString stringWithFormat:@"%@分", model.score];
    
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
            
//            [imageView sd_setImageWithURL:kGetImageURLWithString(url)];

            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:kGetImageURLWithString(url) options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {

            } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {

                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        imageView.image = [[image imageByResizeToSize:CGSizeMake(90, 90)] imageByRoundCornerRadius:4];
                    });
                }

            }];

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

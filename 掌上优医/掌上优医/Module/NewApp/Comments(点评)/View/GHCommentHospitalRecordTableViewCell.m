//
//  GHCommentHospitalRecordTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/5/13.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHCommentHospitalRecordTableViewCell.h"
#import "GHNewHospitalViewController.h"
#import "GHHospitalCommentViewController.h"

//#define ForegroundStarImage @"ic_huanzhepingjia_pingfenxing"
//#define BackgroundStarImage @"ic_huanzhepingjia_pingfenxing_unselected"

#define ForegroundStarImage @"ic_xingxing_all_selected"
#define BackgroundStarImage @"ic_xingxing_all_unselected"

@interface GHCommentHospitalRecordTableViewCell ()

@property (nonatomic, strong) UIImageView *hospitalYibaoImageView;

@property (nonatomic, strong) UIImageView *headPortraitImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *levelLabel;

@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UILabel *governmentLabel;

@property (nonatomic, strong) UILabel *mediaTypeLabel;

@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UILabel *hospitalScoreValueLabel;

@property (nonatomic, strong) UIImageView *foregroundStarView;
@property (nonatomic, strong) UIImageView *backgroundStarView;

@end

@implementation GHCommentHospitalRecordTableViewCell

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
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 4;
    contentView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    contentView.layer.shadowOffset = CGSizeMake(0,2);
    contentView.layer.shadowOpacity = 1;
    contentView.layer.shadowRadius = 4;
    [self.contentView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-3);
    }];
    
    UIImageView *headPortraitImageView = [[UIImageView alloc] init];
    headPortraitImageView.contentMode = UIViewContentModeScaleAspectFill;
    headPortraitImageView.layer.cornerRadius = 2;
    headPortraitImageView.layer.masksToBounds = true;
    headPortraitImageView.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:headPortraitImageView];
    
    [headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.width.height.mas_equalTo(90);
        make.left.mas_equalTo(12);
    }];
    self.headPortraitImageView = headPortraitImageView;
    
    UIImageView *hospitalYibaoImageView = [[UIImageView alloc] init];
    hospitalYibaoImageView.contentMode = UIViewContentModeScaleAspectFill;
    hospitalYibaoImageView.image = [UIImage imageNamed:@"hospital_yibao"];
    [contentView addSubview:hospitalYibaoImageView];
    
    [hospitalYibaoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(23);
    }];
    self.hospitalYibaoImageView = hospitalYibaoImageView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kDefaultBlackTextColor;
    nameLabel.font = HM15;
    [contentView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(16);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(headPortraitImageView.mas_top);
    }];
    self.nameLabel = nameLabel;

//    self.backgroundStarView = [self createStarViewWithImage:BackgroundStarImage];
//    self.backgroundStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:BackgroundStarImage]];
//    self.backgroundStarView.contentMode = UIViewContentModeLeft;
//    self.backgroundStarView.clipsToBounds = true;
//    [contentView addSubview:self.backgroundStarView];
//    
//    [self.backgroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(22);
//        make.left.mas_equalTo(nameLabel);
//        make.width.mas_equalTo(15 * 5);
//        make.top.mas_equalTo(nameLabel.mas_bottom).offset(2);
//    }];
//    
////    self.foregroundStarView = [self createStarViewWithImage:ForegroundStarImage];
//    self.foregroundStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:ForegroundStarImage]];
//    self.foregroundStarView.contentMode = UIViewContentModeLeft;
//    self.foregroundStarView.clipsToBounds = true;
//    [contentView addSubview:self.foregroundStarView];
//    
//    [self.foregroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(22);
//        make.left.mas_equalTo(nameLabel);
//        make.width.mas_equalTo(15 * 5);
//        make.top.mas_equalTo(nameLabel.mas_bottom).offset(2);
//    }];
//    
//    UILabel *hospitalScoreLabel = [[UILabel alloc] init];
//    hospitalScoreLabel.textColor = UIColorHex(0xFF6188);
//    hospitalScoreLabel.font = HM14;
//    [contentView addSubview:hospitalScoreLabel];
//    
//    [hospitalScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-12);
//        make.left.mas_equalTo(self.backgroundStarView.mas_right).offset(5);
//        make.top.bottom.mas_equalTo(self.backgroundStarView);
//    }];
//    self.hospitalScoreValueLabel = hospitalScoreLabel;
    

    
    UILabel *levelLabel = [[UILabel alloc] init];
    levelLabel.textColor = UIColorHex(0x999999);
    levelLabel.layer.cornerRadius = 1;
    levelLabel.layer.masksToBounds = true;
    levelLabel.layer.borderColor = levelLabel.textColor.CGColor;
    levelLabel.layer.borderWidth = .5;
    levelLabel.font = H10;
    levelLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:levelLabel];
    
    [levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel);
        make.height.mas_equalTo(18);
        make.top.mas_equalTo(61);
    }];
    self.levelLabel = levelLabel;
    
    UILabel *typeLabel = [[UILabel alloc] init];
    typeLabel.textColor = UIColorHex(0x999999);
    typeLabel.layer.cornerRadius = 1;
    typeLabel.layer.masksToBounds = true;
    typeLabel.layer.borderColor = levelLabel.textColor.CGColor;
    typeLabel.layer.borderWidth = .5;
    typeLabel.font = H10;
    typeLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:typeLabel];
    
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(levelLabel.mas_right).offset(5);
        make.height.mas_equalTo(18);
        make.top.mas_equalTo(61);
    }];
    self.typeLabel = typeLabel;
    
    
    UILabel *governmentLabel = [[UILabel alloc] init];
    governmentLabel.textColor = UIColorHex(0x999999);
    governmentLabel.layer.cornerRadius = 1;
    governmentLabel.layer.masksToBounds = true;
    governmentLabel.layer.borderColor = levelLabel.textColor.CGColor;
    governmentLabel.layer.borderWidth = .5;
    governmentLabel.font = H10;
    governmentLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:governmentLabel];
    
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
    [contentView addSubview:mediaTypeLabel];
    
    [mediaTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(governmentLabel.mas_right).offset(5);
        make.height.mas_equalTo(18);
        make.top.mas_equalTo(61);
    }];
    self.mediaTypeLabel = mediaTypeLabel;
    
    

    

    
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-52);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *addressIconImageView = [[UIImageView alloc] init];
    addressIconImageView.contentMode = UIViewContentModeCenter;
    addressIconImageView.image = [UIImage imageNamed:@"hospital_address_location_icon"];
    [contentView addSubview:addressIconImageView];
    
    [addressIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(16);
        make.left.mas_equalTo(nameLabel).offset(-2);
        make.top.mas_equalTo(88);
    }];
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.font = H12;
    addressLabel.textColor = kDefaultGrayTextColor;
    [contentView addSubview:addressLabel];
    
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(addressIconImageView.mas_right).offset(4);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(85);
    }];
    self.addressLabel = addressLabel;
    
    UIButton *gotoCommentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [gotoCommentButton setTitle:@"去评价" forState:UIControlStateNormal];
    [gotoCommentButton setTitleColor:kDefaultBlueColor forState:UIControlStateNormal];
    gotoCommentButton.titleLabel.font = H14;
    
    gotoCommentButton.layer.cornerRadius = 4;
    gotoCommentButton.layer.borderColor = kDefaultBlueColor.CGColor;
    gotoCommentButton.layer.borderWidth = 1;
    gotoCommentButton.layer.masksToBounds = true;
    
    [contentView addSubview:gotoCommentButton];
    
    [gotoCommentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(65);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-12);
        make.height.mas_equalTo(28);
    }];
    [gotoCommentButton addTarget:self action:@selector(clickGotoCommentAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *gotoDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [gotoDetailButton setTitle:@"查看详情" forState:UIControlStateNormal];
    [gotoDetailButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    gotoDetailButton.titleLabel.font = H14;
    
    gotoDetailButton.layer.cornerRadius = 4;
    gotoDetailButton.layer.borderColor = kDefaultLineViewColor.CGColor;
    gotoDetailButton.layer.borderWidth = 1;
    gotoDetailButton.layer.masksToBounds = true;
    
    [contentView addSubview:gotoDetailButton];
    
    [gotoDetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.right.mas_equalTo(gotoCommentButton.mas_left).offset(-12);
        make.bottom.mas_equalTo(-12);
        make.height.mas_equalTo(28);
    }];
    
    [gotoDetailButton addTarget:self action:@selector(clickGotoDetailAction) forControlEvents:UIControlEventTouchUpInside];
    
    if ([JFTools isLowDevice]) {
        
        [self.levelLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(48);
        }];
        
        [self.typeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(60);
        }];
        
        [self.governmentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(25);
        }];
        
        [self.mediaTypeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(60);
        }];
        
    }
    
}

- (void)clickGotoCommentAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        GHHospitalCommentViewController *vc = [[GHHospitalCommentViewController alloc] init];
        
        vc.model = self.model;
        
        vc.isNotHaveDetail = true;
        
        [self.viewController.navigationController pushViewController:vc animated:true];
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self.viewController presentViewController:vc animated:true completion:nil];
        
    }
    
}

- (void)clickGotoDetailAction {
    
//    GHSearchHospitalModel *model = [[GHSearchHospitalModel alloc] initWithDictionary:[self.model toDictionary] error:nil];
//    model.modelId = self.model.modelId;
    
    GHNewHospitalViewController *vc = [[GHNewHospitalViewController alloc] init];
    vc.model = self.model;
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


- (void)setModel:(GHSearchHospitalModel *)model {
    
    _model = model;
    
    self.nameLabel.text = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.hospitalName) ];
    //    self.nameLabel.attributedText = [NSAttributedString getAttributedStringWithSearchString:ISNIL(model.hospitalName)];
    self.levelLabel.text = ISNIL(model.hospitalGrade);
    self.typeLabel.text = ISNIL(model.category);
    
    if ([self.model.governmentalHospitalFlag integerValue] == 0) {
        self.governmentLabel.text = @"私立";
    } else {
        self.governmentLabel.text = @"公立";
    }
    
    self.mediaTypeLabel.text = ISNIL(model.medicineType);
    
    self.addressLabel.text = ISNIL(model.hospitalAddress);

    
    [self.headPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.profilePhoto)) placeholderImage:[UIImage imageNamed:@"hospital_placeholder"]];
    

    
    self.hospitalYibaoImageView.hidden = ![model.medicalInsuranceFlag boolValue];

//    self.foregroundStarView.width = (13.5 * .5 * [model.score floatValue]);
    [self.foregroundStarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15 * .5 * [self.model.score floatValue]);
    }];
    self.hospitalScoreValueLabel.text = [NSString stringWithFormat:@"%.1f分", [model.score floatValue]];
    
    if (![JFTools isLowDevice]) {
        
        if (self.levelLabel.text.length) {
            
            self.levelLabel.hidden = false;
            [self.levelLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo([self.levelLabel.text widthForFont:self.levelLabel.font] + 8);
            }];
            
        } else {
            
            self.levelLabel.hidden = true;
            
        }
        
        if (self.typeLabel.text.length) {
            
            self.typeLabel.hidden = false;
            [self.typeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo([self.typeLabel.text widthForFont:self.typeLabel.font] + 8);
            }];
            
        } else {
            
            self.typeLabel.hidden = true;
            
        }
        
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
        
    } else {
        
        if (self.levelLabel.text.length) {
            
            self.levelLabel.hidden = false;
            
        } else {
            
            self.levelLabel.hidden = true;
            
        }
        
        if (self.typeLabel.text.length) {
            
            self.typeLabel.hidden = false;
            
        } else {
            
            self.typeLabel.hidden = true;
            
        }
        
        if (self.governmentLabel.text.length) {
            
            self.governmentLabel.hidden = false;
            
        } else {
            
            self.governmentLabel.hidden = true;
            
        }
        
        if (self.mediaTypeLabel.text.length) {
            
            self.mediaTypeLabel.hidden = false;
            
        } else {
            
            self.mediaTypeLabel.hidden = true;
            
        }
        
    }
    
    
//    if (self.levelLabel.text.length) {
//
//        self.levelLabel.hidden = false;
//        [self.levelLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo([self.levelLabel.text widthForFont:self.levelLabel.font] + 8);
//        }];
//
//    } else {
//
//        self.levelLabel.hidden = true;
//
//    }
//
//    if (self.typeLabel.text.length) {
//
//        self.typeLabel.hidden = false;
//        [self.typeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo([self.typeLabel.text widthForFont:self.typeLabel.font] + 8);
//        }];
//
//    } else {
//
//        self.typeLabel.hidden = true;
//
//    }
//
//    if (self.governmentLabel.text.length) {
//
//        self.governmentLabel.hidden = false;
//        [self.governmentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo([self.governmentLabel.text widthForFont:self.governmentLabel.font] + 8);
//        }];
//
//    } else {
//
//        self.governmentLabel.hidden = true;
//
//    }
//
//    if (self.mediaTypeLabel.text.length) {
//
//        self.mediaTypeLabel.hidden = false;
//        [self.mediaTypeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo([self.mediaTypeLabel.text widthForFont:self.mediaTypeLabel.font] + 8);
//        }];
//
//    } else {
//
//        self.mediaTypeLabel.hidden = true;
//
//    }
    
    
}

@end

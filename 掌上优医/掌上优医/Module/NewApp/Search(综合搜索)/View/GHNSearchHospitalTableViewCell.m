//
//  GHNSearchHospitalTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/2/26.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNSearchHospitalTableViewCell.h"
//#define ForegroundStarImage @"ic_huanzhepingjia_pingfenxing"
//#define BackgroundStarImage @"ic_huanzhepingjia_pingfenxing_unselected"

#define ForegroundStarImage @"ic_xingxing_all_selected"
#define BackgroundStarImage @"ic_xingxing_all_unselected"

@interface GHNSearchHospitalTableViewCell ()

@property (nonatomic, strong) UIImageView *headPortraitImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *levelLabel;

@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UILabel *governmentLabel;

@property (nonatomic, strong) UILabel *mediaTypeLabel;

@property (nonatomic, strong) UILabel *distanceLabel;

@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UILabel *hospitalScoreValueLabel;

//@property (nonatomic, strong) UIView *foregroundStarView;
//@property (nonatomic, strong) UIView *backgroundStarView;

@property (nonatomic, strong) UIImageView *foregroundStarView;
@property (nonatomic, strong) UIImageView *backgroundStarView;

@property (nonatomic, strong) UIImageView *hospitalYibaoImageView;

@end

@implementation GHNSearchHospitalTableViewCell

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
    self.backgroundStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:BackgroundStarImage]];
    self.backgroundStarView.contentMode = UIViewContentModeLeft;
    self.backgroundStarView.clipsToBounds = true;
    [contentView addSubview:self.backgroundStarView];
    
    [self.backgroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.left.mas_equalTo(nameLabel);
        make.width.mas_equalTo(15 * 5);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(2);
    }];
    
//    self.foregroundStarView = [self createStarViewWithImage:ForegroundStarImage];
    self.foregroundStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:ForegroundStarImage]];
    self.foregroundStarView.contentMode = UIViewContentModeLeft;
    self.foregroundStarView.clipsToBounds = true;
    [contentView addSubview:self.foregroundStarView];
    
    [self.foregroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.left.mas_equalTo(nameLabel);
        make.width.mas_equalTo(15 * 5);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(2);
    }];
    
    UILabel *hospitalScoreLabel = [[UILabel alloc] init];
    hospitalScoreLabel.textColor = UIColorHex(0xFF6188);
    hospitalScoreLabel.font = HM14;
    [contentView addSubview:hospitalScoreLabel];
    
    [hospitalScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backgroundStarView.mas_right).offset(5);
        make.top.bottom.mas_equalTo(self.backgroundStarView);
        make.width.mas_equalTo(40);
    }];
    self.hospitalScoreValueLabel = hospitalScoreLabel;
    
    
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
    
    
    UILabel *distanceLabel = [[UILabel alloc] init];
    distanceLabel.font = H13;
    distanceLabel.textColor = kDefaultGrayTextColor;
    distanceLabel.textAlignment = NSTextAlignmentRight;
    [contentView addSubview:distanceLabel];
    
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.top.bottom.mas_equalTo(self.backgroundStarView);
        make.left.mas_equalTo(hospitalScoreLabel.mas_right);
    }];
    self.distanceLabel = distanceLabel;
    
    
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
    
    if ([self.model.governmentalHospitalFlag integerValue] == 2) {
        self.governmentLabel.text = @"私立";
    }
    else if ([self.model.governmentalHospitalFlag integerValue] == 1)
    {
        self.governmentLabel.text = @"公立";
    }
    
    self.mediaTypeLabel.text = ISNIL(model.medicineType);
    self.addressLabel.text = ISNIL(model.hospitalAddress);
    NSString *kmyuji = [NSString stringWithFormat:@"%@",model.distance];
    self.distanceLabel.text = [GHUserModelTool shareInstance].isHaveLocation == true ? [ISNIL(kmyuji) getKillMeter] : @"";
    
    [self.headPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.profilePhoto)) placeholderImage:[UIImage imageNamed:@"hospital_placeholder"]];
    
    self.hospitalYibaoImageView.hidden = ![model.medicalInsuranceFlag boolValue];

    [self.foregroundStarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15 * .5 * [self.model.comprehensiveScore floatValue]);
    }];
    self.hospitalScoreValueLabel.text = [NSString stringWithFormat:@"%.1f分", [model.comprehensiveScore floatValue]];
    
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
    

    

    
}


@end

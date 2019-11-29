//
//  GHNSearchDoctorTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/2/26.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNSearchDoctorTableViewCell.h"

//#define ForegroundStarImage @"ic_huanzhepingjia_pingfenxing"
//#define BackgroundStarImage @"ic_huanzhepingjia_pingfenxing_unselected"

#define ForegroundStarImage @"ic_xingxing_all_selected"
#define BackgroundStarImage @"ic_xingxing_all_unselected"

@interface GHNSearchDoctorTableViewCell ()

@property (nonatomic, strong) UIImageView *headPortraitImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *positionLabel;

@property (nonatomic, strong) UILabel *mediaTypeLabel;


@property (nonatomic, strong) UILabel *hospitalLabel;

@property (nonatomic, strong) UILabel *departmentLabel;

@property (nonatomic, strong) UILabel *goodAtLabel;

@property (nonatomic, strong) UILabel *doctorScoreValueLabel;

//@property (nonatomic, strong) UIView *foregroundStarView;
//@property (nonatomic, strong) UIView *backgroundStarView;

@property (nonatomic, strong) UIImageView *foregroundStarView;
@property (nonatomic, strong) UIImageView *backgroundStarView;

@property (nonatomic, strong) UILabel *distanceLabel;

@end

@implementation GHNSearchDoctorTableViewCell


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
    [contentView addSubview:headPortraitImageView];
    
    [headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(45);
        make.left.mas_equalTo(12);
    }];
    self.headPortraitImageView = headPortraitImageView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kDefaultBlackTextColor;
    nameLabel.font = HM15;
    [contentView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(16);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(headPortraitImageView.mas_top);
    }];
    self.nameLabel = nameLabel;
    
    UILabel *doctorPositionLabel = [[UILabel alloc] init];
    doctorPositionLabel.textColor = UIColorHex(0xFEAE05);
    doctorPositionLabel.layer.cornerRadius = 2;
    doctorPositionLabel.layer.masksToBounds = true;
    doctorPositionLabel.layer.borderColor = doctorPositionLabel.textColor.CGColor;
    doctorPositionLabel.layer.borderWidth = 1;
    doctorPositionLabel.font = H12;
    doctorPositionLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:doctorPositionLabel];
    
    [doctorPositionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel.mas_right).offset(8);
        make.height.mas_equalTo(18);
        make.centerY.mas_equalTo(nameLabel);
    }];
    self.positionLabel = doctorPositionLabel;
    
    UILabel *doctorTypeLabel = [[UILabel alloc] init];
    doctorTypeLabel.textColor = UIColorHex(0xFEAE05);
    doctorTypeLabel.layer.cornerRadius = 2;
    doctorTypeLabel.layer.masksToBounds = true;
    doctorTypeLabel.layer.borderColor = doctorPositionLabel.textColor.CGColor;
    doctorTypeLabel.layer.borderWidth = 1;
    doctorTypeLabel.font = H12;
    doctorTypeLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:doctorTypeLabel];
    
    [doctorTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(doctorPositionLabel.mas_right).offset(4);
        make.height.mas_equalTo(18);
        make.centerY.mas_equalTo(doctorPositionLabel);
    }];
    self.mediaTypeLabel = doctorTypeLabel;
    
//    self.backgroundStarView = [self createStarViewWithImage:BackgroundStarImage];
    self.backgroundStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:BackgroundStarImage]];
    self.backgroundStarView.contentMode = UIViewContentModeLeft;
    self.backgroundStarView.clipsToBounds = true;
    [contentView addSubview:self.backgroundStarView];
    
    [self.backgroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.left.mas_equalTo(nameLabel);
        make.width.mas_equalTo(15 * 5);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(4);
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
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(4);
    }];
    
    UILabel *doctorScoreLabel = [[UILabel alloc] init];
    doctorScoreLabel.textColor = UIColorHex(0xFF6188);
    doctorScoreLabel.font = HM14;
    [contentView addSubview:doctorScoreLabel];
    
    [doctorScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backgroundStarView.mas_right).offset(5);
        make.top.bottom.mas_equalTo(self.backgroundStarView);
        make.width.mas_equalTo(50);
    }];
    self.doctorScoreValueLabel = doctorScoreLabel;
    
    UILabel *distanceLabel = [[UILabel alloc] init];
    distanceLabel.textColor = kDefaultGrayTextColor;
    distanceLabel.font = H13;
    distanceLabel.textAlignment = NSTextAlignmentRight;
    [contentView addSubview:distanceLabel];
    
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.top.bottom.mas_equalTo(doctorScoreLabel);
        make.left.mas_equalTo(doctorScoreLabel.mas_right);
    }];
    self.distanceLabel = distanceLabel;
    
    
    
    UILabel *doctorHospitalLabel = [[UILabel alloc] init];
    doctorHospitalLabel.textColor = kDefaultBlackTextColor;
    doctorHospitalLabel.font = H13;
    [contentView addSubview:doctorHospitalLabel];
    
    [doctorHospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(16);
        make.height.mas_equalTo(19);
        make.top.mas_equalTo(65);
        make.right.mas_equalTo(-10);
    }];
    self.hospitalLabel = doctorHospitalLabel;
    
    UILabel *doctorDepartmentLabel = [[UILabel alloc] init];
    doctorDepartmentLabel.textColor = kDefaultGrayTextColor;
    doctorDepartmentLabel.font = H12;
    [contentView addSubview:doctorDepartmentLabel];
    
    [doctorDepartmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(16);
        make.height.mas_equalTo(19);
        make.top.mas_equalTo(88);
        make.right.mas_equalTo(-16);
    }];
    self.departmentLabel = doctorDepartmentLabel;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-54);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *goodAtLabel = [[UILabel alloc] init];
    goodAtLabel.textColor = kDefaultGrayTextColor;
    goodAtLabel.font = H12;
    goodAtLabel.numberOfLines = 2;
    [contentView addSubview:goodAtLabel];
    
    [goodAtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel.mas_bottom);
        make.right.mas_equalTo(-12);
    }];
    self.goodAtLabel = goodAtLabel;
    
    if ([JFTools isLowDevice]) {
        
        [self.positionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(70);
        }];
        
        [self.mediaTypeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(70);
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

- (void)setModel:(GHSearchDoctorModel *)model {
    
    _model = model;
    
    [self.headPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.profilePhoto)) placeholderImage:[UIImage imageNamed:@"doctor_default_portail"]];
    
    
    self.positionLabel.text = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.doctorGrade)];
    self.hospitalLabel.text = [NSString stringWithFormat:@"%@", ISNIL(model.hospitalName)];
    self.departmentLabel.text = [NSString stringWithFormat:@"%@", ISNIL(model.secondDepartmentName).length ? model.secondDepartmentName : ISNIL(model.firstDepartmentName)];
    
    self.distanceLabel.text = [GHUserModelTool shareInstance].isHaveLocation == true ? [ISNIL(model.distance) getKillMeter] : @"";
    self.doctorScoreValueLabel.text = [NSString stringWithFormat:@"%.1f分", [model.score floatValue]];
    
    
    self.goodAtLabel.text = [GHFilterHTMLTool filterHTMLEMTag:[NSString stringWithFormat:@"擅长:%@", ISNIL(model.specialize)] ];
    self.nameLabel.text = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.doctorName) ];
    
    self.mediaTypeLabel.text = ISNIL(model.medicineType);
    
    
    if (model.doctorGrade.length == 0 && model.hospitalName.length == 0) {
        
        self.hospitalLabel.text = @"医生信息已删除";
        self.hospitalLabel.textColor = UIColorHex(0xAAAAAA);
        self.hospitalLabel.font = H14;
        
    } else {
        
        self.hospitalLabel.textColor = kDefaultBlackTextColor;
        self.hospitalLabel.font = H13;
        
    }
    
    [self.foregroundStarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15 * .5 * [model.score floatValue]);
    }];
    
    if (![JFTools isLowDevice]) {
        
        if (self.positionLabel.text.length) {
            
            self.positionLabel.hidden = false;
            [self.positionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo([self.positionLabel.text widthForFont:self.positionLabel.font] + 6);
            }];
            
        } else {
            
            self.positionLabel.hidden = true;
            
        }
        
        if (self.mediaTypeLabel.text.length) {
            
            self.mediaTypeLabel.hidden = false;
            [self.mediaTypeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo([self.mediaTypeLabel.text widthForFont:self.mediaTypeLabel.font] + 6);
            }];
            
        } else {
            
            self.mediaTypeLabel.hidden = true;
            
        }
        
    } else {
        
        if (self.positionLabel.text.length) {
            
            self.positionLabel.hidden = false;

        } else {
            
            self.positionLabel.hidden = true;
            
        }
        
        if (self.mediaTypeLabel.text.length) {
            
            self.mediaTypeLabel.hidden = false;
            
        } else {
            
            self.mediaTypeLabel.hidden = true;
            
        }
        
        
    }
    


    
}



@end


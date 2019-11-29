//
//  GHDoctorInfoHeaderView.m
//  掌上优医
//
//  Created by GH on 2018/10/30.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHDoctorInfoHeaderView.h"
#import "UIButton+touch.h"
#import <MapKit/MapKit.h>

//#define ForegroundStarImage @"ic_huanzhepingjia_pingfenxing"
//#define BackgroundStarImage @"ic_huanzhepingjia_pingfenxing_unselected"

#define ForegroundStarImage @"ic_xingxing_all_selected"
#define BackgroundStarImage @"ic_xingxing_all_unselected"

@interface GHDoctorInfoHeaderView ()

@property (nonatomic, strong) UIImageView *authenticationImageView;

@property (nonatomic, strong) UIImageView *headPortraitImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *positionLabel;

@property (nonatomic, strong) UILabel *mediaTypeLabel;


@property (nonatomic, strong) UILabel *hospitalLabel;

@property (nonatomic, strong) UILabel *departmentLabel;

@property (nonatomic, strong) UILabel *doctorScoreValueLabel;

@property (nonatomic, strong) UIImageView *foregroundStarView;
@property (nonatomic, strong) UIImageView *backgroundStarView;

@end

@implementation GHDoctorInfoHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 4;
    contentView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    contentView.layer.shadowOffset = CGSizeMake(0,2);
    contentView.layer.shadowOpacity = 1;
    contentView.layer.shadowRadius = 6;
    [self addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(16);
        make.bottom.mas_equalTo(-16);
    }];
    
    UIImageView *headPortraitImageView = [[UIImageView alloc] init];
    headPortraitImageView.contentMode = UIViewContentModeScaleAspectFill;
    headPortraitImageView.layer.cornerRadius = 2;
    headPortraitImageView.layer.masksToBounds = true;
    [contentView addSubview:headPortraitImageView];
    
    [headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.width.mas_equalTo(HScaleHeight(90));
        make.height.mas_equalTo(HScaleHeight(90));
        make.left.mas_equalTo(HScaleHeight(16));
    }];
    self.headPortraitImageView = headPortraitImageView;
    
    UIImageView *authenticationImageView = [[UIImageView alloc] init];
    authenticationImageView.contentMode = UIViewContentModeScaleAspectFill;
    authenticationImageView.image = [UIImage imageNamed:@"doctor_detail_authentication"];
    [self addSubview:authenticationImageView];
    
    [authenticationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(27);
        make.width.mas_equalTo(63);
        make.height.mas_equalTo(21);
        make.left.mas_equalTo(14);
    }];
    self.authenticationImageView = authenticationImageView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kDefaultBlackTextColor;
    nameLabel.font = HM18;
    [contentView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(HScaleHeight(16));
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
    
    headPortraitImageView.userInteractionEnabled = true;
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageAction)];
    [headPortraitImageView addGestureRecognizer:tapGr];
    
    self.backgroundStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:BackgroundStarImage]];
    self.backgroundStarView.contentMode = UIViewContentModeLeft;
    self.backgroundStarView.clipsToBounds = true;
    [contentView addSubview:self.backgroundStarView];
    
    [self.backgroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.left.mas_equalTo(nameLabel);
        make.width.mas_equalTo(15 * 5);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(10);
    }];
    
    self.foregroundStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:ForegroundStarImage]];
    self.foregroundStarView.contentMode = UIViewContentModeLeft;
    self.foregroundStarView.clipsToBounds = true;
    [contentView addSubview:self.foregroundStarView];
    
    [self.foregroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.left.mas_equalTo(nameLabel);
        make.width.mas_equalTo(15 * 5);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(10);
    }];
    
    UILabel *doctorScoreLabel = [[UILabel alloc] init];
    doctorScoreLabel.textColor = UIColorHex(0xFF6188);
    doctorScoreLabel.font = HM14;
    [contentView addSubview:doctorScoreLabel];
    
    [doctorScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.left.mas_equalTo(self.backgroundStarView.mas_right).offset(5);
        make.top.bottom.mas_equalTo(self.backgroundStarView);
    }];
    self.doctorScoreValueLabel = doctorScoreLabel;
    
    UILabel *doctorHospitalLabel = [[UILabel alloc] init];
    doctorHospitalLabel.textColor = kDefaultBlackTextColor;
    doctorHospitalLabel.font = H13;
    doctorHospitalLabel.numberOfLines = 2;
    [contentView addSubview:doctorHospitalLabel];
    
    [doctorHospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(16);
        make.top.mas_equalTo(doctorScoreLabel.mas_bottom).offset(10);
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
        make.top.mas_equalTo(doctorHospitalLabel.mas_bottom).offset(8);
        make.right.mas_equalTo(-16);
    }];
    self.departmentLabel = doctorDepartmentLabel;
    
}

- (void)clickImageAction {
    
    [[GHPhotoTool shareInstance] showBigImage:@[ISNIL(self.model.profilePhoto)] currentIndex:0 viewController:self.viewController cancelBtnText:@"取消"];
    
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
    
    if ([self.model.qualityCertifyFlag integerValue] == 3) {

        self.authenticationImageView.hidden = false;

    } else {
        self.authenticationImageView.hidden = true;
    }
    
    [self.headPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.profilePhoto)) placeholderImage:[UIImage imageNamed:@"doctor_default_portail"]];
    
    
    self.positionLabel.text = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.doctorGrade)];
    self.hospitalLabel.text = [NSString stringWithFormat:@"%@", ISNIL(model.hospitalName)];
    self.departmentLabel.text = [NSString stringWithFormat:@"%@", ISNIL(model.secondDepartmentName).length ? model.secondDepartmentName : ISNIL(model.firstDepartmentName)];
    
    self.doctorScoreValueLabel.text = [NSString stringWithFormat:@"%.1f分", [model.score floatValue]];

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
    
    [self.foregroundStarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15 * .5 * [model.score floatValue]);
    }];

//    self.foregroundStarView.width = (13.5 * .5 * [model.score floatValue]);
    
}

@end

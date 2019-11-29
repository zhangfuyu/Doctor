//
//  GHCommentDoctorRecordTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/5/13.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHCommentDoctorRecordTableViewCell.h"

#import "GHDoctorCommentViewController.h"
#import "GHNewDoctorDetailViewController.h"

//#define ForegroundStarImage @"ic_huanzhepingjia_pingfenxing"
//#define BackgroundStarImage @"ic_huanzhepingjia_pingfenxing_unselected"

#define ForegroundStarImage @"ic_xingxing_all_selected"
#define BackgroundStarImage @"ic_xingxing_all_unselected"

@interface GHCommentDoctorRecordTableViewCell ()

@property (nonatomic, strong) UIImageView *headPortraitImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *positionLabel;

@property (nonatomic, strong) UILabel *mediaTypeLabel;

@property (nonatomic, strong) UILabel *voteLabel;

@property (nonatomic, strong) UILabel *hospitalLabel;

@property (nonatomic, strong) UILabel *departmentLabel;

@property (nonatomic, strong) UILabel *doctorScoreValueLabel;

@property (nonatomic, strong) UIImageView *foregroundStarView;
@property (nonatomic, strong) UIImageView *backgroundStarView;

@end

@implementation GHCommentDoctorRecordTableViewCell

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
        make.right.mas_equalTo(-12);
        make.left.mas_equalTo(self.backgroundStarView.mas_right).offset(5);
        make.top.bottom.mas_equalTo(self.backgroundStarView);
    }];
    self.doctorScoreValueLabel = doctorScoreLabel;
    
    UILabel *doctorHospitalLabel = [[UILabel alloc] init];
    doctorHospitalLabel.textColor = kDefaultBlackTextColor;
    doctorHospitalLabel.font = H13;
    [contentView addSubview:doctorHospitalLabel];
    
    [doctorHospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(16);
        make.height.mas_equalTo(19);
        make.top.mas_equalTo(65);
        make.right.mas_equalTo(-16);
    }];
    self.hospitalLabel = doctorHospitalLabel;

    
//    UILabel *doctorScoreLabel = [[UILabel alloc] init];
//    doctorScoreLabel.textColor = UIColorHex(0xFF6188);
//    doctorScoreLabel.font = HM14;
//    doctorScoreLabel.textAlignment = NSTextAlignmentRight;
//    [contentView addSubview:doctorScoreLabel];
//
//    [doctorScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-12);
//        make.width.mas_equalTo(26);
//        make.height.mas_equalTo(19);
//        make.centerY.mas_equalTo(nameLabel);
//    }];
//    self.doctorScoreValueLabel = doctorScoreLabel;
//
//    UILabel *doctorScoreTitleLabel = [[UILabel alloc] init];
//    doctorScoreTitleLabel.textColor = kDefaultGrayTextColor;
//    doctorScoreTitleLabel.font = H12;
//    doctorScoreTitleLabel.text = @"评分";
//    [contentView addSubview:doctorScoreTitleLabel];
//
//    [doctorScoreTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(doctorScoreLabel.mas_left);
//        make.width.mas_equalTo(26);
//        make.height.mas_equalTo(19);
//        make.centerY.mas_equalTo(nameLabel);
//    }];
//    self.doctorScoreTitleLabel = doctorScoreTitleLabel;

    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-52);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *doctorDepartmentLabel = [[UILabel alloc] init];
    doctorDepartmentLabel.textColor = kDefaultGrayTextColor;
    doctorDepartmentLabel.font = H12;
    [contentView addSubview:doctorDepartmentLabel];
    
    [doctorDepartmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(16);
        make.height.mas_equalTo(19);
        make.bottom.mas_equalTo(lineLabel.mas_top).offset(-11);
        make.right.mas_equalTo(-16);
    }];
    self.departmentLabel = doctorDepartmentLabel;
    
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
    
    
//    UIButton *gotoDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
//
//    [gotoDetailButton setTitle:@"查看详情" forState:UIControlStateNormal];
//    [gotoDetailButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
//    gotoDetailButton.titleLabel.font = H14;
//
//    gotoDetailButton.layer.cornerRadius = 4;
//    gotoDetailButton.layer.borderColor = kDefaultLineViewColor.CGColor;
//    gotoDetailButton.layer.borderWidth = 1;
//    gotoDetailButton.layer.masksToBounds = true;
//
//    [contentView addSubview:gotoDetailButton];
//
//    [gotoDetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(80);
//        make.right.mas_equalTo(gotoCommentButton.mas_left).offset(-12);
//        make.bottom.mas_equalTo(-12);
//        make.height.mas_equalTo(28);
//    }];
//    
//    [gotoDetailButton addTarget:self action:@selector(clickGotoDetailAction) forControlEvents:UIControlEventTouchUpInside];
    
    if ([JFTools isLowDevice]) {
        
        [self.positionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(70);
        }];
        
        [self.mediaTypeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(70);
        }];
        
    }
    
}

- (void)clickGotoCommentAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        GHDoctorCommentViewController *vc = [[GHDoctorCommentViewController alloc] init];
        
        GHSearchDoctorModel *model = [[GHSearchDoctorModel alloc] initWithDictionary:[self.model toDictionary] error:nil];
        
        model.modelId = self.model.modelId;
        
        vc.model = model;
        
        vc.isNotHaveDetail = true;
        
        [self.viewController.navigationController pushViewController:vc animated:true];
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self.viewController presentViewController:vc animated:true completion:nil];
        
    }

    
}

- (void)clickGotoDetailAction {
    
    GHNewDoctorDetailViewController *vc = [[GHNewDoctorDetailViewController alloc] init];
    vc.doctorId = self.model.modelId;
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

- (void)setModel:(GHSearchDoctorModel *)model {
    
    _model = model;
    
    [self.headPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.headImgUrl)) placeholderImage:[UIImage imageNamed:@"doctor_default_portail"]];
    
    self.doctorScoreValueLabel.text = [NSString stringWithFormat:@"%.1f分", [model.score floatValue]];
    
    self.nameLabel.text = ISNIL(model.doctorName);
    self.positionLabel.text = ISNIL(model.doctorGrade);
    self.hospitalLabel.text = [NSString stringWithFormat:@"%@", ISNIL(model.hospitalName)];
    self.departmentLabel.text = ISNIL(model.secondDepartmentName).length ? model.secondDepartmentName : ISNIL(model.firstDepartmentName);
    
    self.mediaTypeLabel.text = ISNIL(model.medicineType);
    
    if (model.doctorGrade.length == 0 && model.hospitalName.length == 0) {
        
        self.hospitalLabel.text = @"医生信息已删除";
        self.hospitalLabel.textColor = UIColorHex(0xAAAAAA);
        self.hospitalLabel.font = H14;
        
    } else {
        
        self.hospitalLabel.textColor = kDefaultBlackTextColor;
        self.hospitalLabel.font = H13;
        
    }

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
    
//    if (self.positionLabel.text.length) {
//
//        self.positionLabel.hidden = false;
//        [self.positionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo([self.positionLabel.text widthForFont:self.positionLabel.font] + 6);
//        }];
//
//    } else {
//
//        self.positionLabel.hidden = true;
//
//    }
//
//    if (self.mediaTypeLabel.text.length) {
//
//        self.mediaTypeLabel.hidden = false;
//        [self.mediaTypeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo([self.mediaTypeLabel.text widthForFont:self.mediaTypeLabel.font] + 6);
//        }];
//
//    } else {
//
//        self.mediaTypeLabel.hidden = true;
//
//    }
    
//    [self.positionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo([self.positionLabel.text widthForFont:self.positionLabel.font] + 6);
//    }];

//    self.foregroundStarView.width = (13.5 * .5 * [model.score floatValue]);
    [self.foregroundStarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15 * .5 * [model.score floatValue]);
    }];
    
}



@end

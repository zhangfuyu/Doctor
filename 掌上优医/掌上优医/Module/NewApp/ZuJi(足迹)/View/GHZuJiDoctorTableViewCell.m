//
//  GHZuJiDoctorTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/2/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHZuJiDoctorTableViewCell.h"

@interface GHZuJiDoctorTableViewCell ()

@property (nonatomic, strong) UIImageView *headPortraitImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *positionLabel;

@property (nonatomic, strong) UILabel *voteLabel;

@property (nonatomic, strong) UILabel *hospitalLabel;

@property (nonatomic, strong) UILabel *departmentLabel;

@end

@implementation GHZuJiDoctorTableViewCell

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
    
    UILabel *doctorHospitalLabel = [[UILabel alloc] init];
    doctorHospitalLabel.textColor = kDefaultBlackTextColor;
    doctorHospitalLabel.font = H13;
    [contentView addSubview:doctorHospitalLabel];
    
    [doctorHospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(16);
        make.height.mas_equalTo(19);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(4);
        make.right.mas_equalTo(-16);
    }];
    self.hospitalLabel = doctorHospitalLabel;
    
    UILabel *doctorDepartmentLabel = [[UILabel alloc] init];
    doctorDepartmentLabel.textColor = kDefaultGrayTextColor;
    doctorDepartmentLabel.font = H12;
    [contentView addSubview:doctorDepartmentLabel];
    
    [doctorDepartmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(16);
        make.height.mas_equalTo(19);
        make.bottom.mas_equalTo(-13);
        make.right.mas_equalTo(-16);
    }];
    self.departmentLabel = doctorDepartmentLabel;
    
}

- (void)setModel:(GHSearchDoctorModel *)model {
    
    _model = model;
    
//    [self.headPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.profilePhoto)) placeholderImage:[UIImage imageNamed:@"doctor_default_portail"]];
    
    [self.headPortraitImageView sd_setImageWithURL:[NSURL URLWithString:ISNIL(model.profilePhoto).length >0 ? model.profilePhoto : model.headImgUrl] placeholderImage:[UIImage imageNamed:@"doctor_default_portail"]];
    
    self.nameLabel.text = ISNIL(model.doctorName);
    self.positionLabel.text = ISNIL(model.doctorGrade);
    self.hospitalLabel.text = [NSString stringWithFormat:@"%@", ISNIL(model.hospitalName)];
    self.departmentLabel.text = ISNIL(model.hospitalDepartment);//.length ? model.secondDepartmentName : ISNIL(model.firstDepartmentName);
    
    if (model.doctorGrade.length == 0 && model.hospitalName.length == 0) {
        
        self.hospitalLabel.text = @"医生信息已删除";
        self.hospitalLabel.textColor = UIColorHex(0xAAAAAA);
        self.hospitalLabel.font = H14;
        
    } else {
        
        self.hospitalLabel.textColor = kDefaultBlackTextColor;
        self.hospitalLabel.font = H13;
        
    }
    
    [self.positionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([self.positionLabel.text widthForFont:self.positionLabel.font] + 6);
    }];
    
}



@end

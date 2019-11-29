//
//  GHContributeListTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/6/5.
//  Copyright © 2019 GH. All rights reserved.
//
//  由于接口问题, 抛弃原有 UI, 留下医生/医院两个板块

#import "GHContributeListTableViewCell.h"

@interface GHContributeListTableViewCell ()

@property (nonatomic, strong) UIImageView *iconTypeImageView;

@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UIImageView *auditPassImageView;

@property (nonatomic, strong) UIImageView *headPortraitImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation GHContributeListTableViewCell

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
        make.bottom.mas_equalTo(-2);
    }];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(36);
    }];
    
    UIImageView *iconTypeImageView = [[UIImageView alloc] init];
    iconTypeImageView.contentMode = UIViewContentModeScaleAspectFill;
    [contentView addSubview:iconTypeImageView];
    
    [iconTypeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(9);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
        make.left.mas_equalTo(12);
    }];
    self.iconTypeImageView = iconTypeImageView;
    
    UILabel *typeLabel = [[UILabel alloc] init];
    typeLabel.textColor = kDefaultGrayTextColor;
    typeLabel.font = H13;
    [contentView addSubview:typeLabel];
    
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconTypeImageView.mas_right).offset(9);
        make.width.mas_equalTo(120);
        make.top.bottom.mas_equalTo(iconTypeImageView);
    }];
    self.typeLabel = typeLabel;
    
    UILabel *statusLabel = [[UILabel alloc] init];
    statusLabel.textColor = kDefaultBlackTextColor;
    statusLabel.font = H14;
    statusLabel.textAlignment = NSTextAlignmentRight;
    [contentView addSubview:statusLabel];
    
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.left.mas_equalTo(typeLabel.mas_right);
        make.top.bottom.mas_equalTo(iconTypeImageView);
    }];
    self.statusLabel = statusLabel;
    
    
    UIImageView *headPortraitImageView = [[UIImageView alloc] init];
    headPortraitImageView.contentMode = UIViewContentModeScaleAspectFill;
    headPortraitImageView.layer.cornerRadius = 2;
    headPortraitImageView.layer.masksToBounds = true;
    [contentView addSubview:headPortraitImageView];
    
    [headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-12);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(90);
        make.left.mas_equalTo(12);
    }];
    self.headPortraitImageView = headPortraitImageView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kDefaultBlackTextColor;
    nameLabel.font = HM15;
    [contentView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(headPortraitImageView.mas_top);
    }];
    self.nameLabel = nameLabel;
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.textColor = kDefaultGrayTextColor;
    descLabel.font = H12;
    [contentView addSubview:descLabel];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(17);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(6);
    }];
    self.descLabel = descLabel;
    
    
    UIImageView *auditPassImageView = [[UIImageView alloc] init];
    auditPassImageView.contentMode = UIViewContentModeCenter;
    auditPassImageView.image = [UIImage imageNamed:@"contribute_audit_pass"];
    [contentView addSubview:auditPassImageView];
    
    [auditPassImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(75);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(12);
    }];
    self.auditPassImageView = auditPassImageView;
    
}

- (void)setDoctorModel:(GHDataCollectionDoctorModel *)doctorModel {
    
    _doctorModel = doctorModel;
    
    self.iconTypeImageView.image = [UIImage imageNamed:@"contribute_audit_doctor"];
    
    /**
     数据采集类型 1：报错 2：补全 3：新增
     */
    if ([doctorModel.dataCollectionType integerValue] == 1) {
        self.typeLabel.text = @"核实医生";
    } else if ([doctorModel.dataCollectionType integerValue] == 2) {
        self.typeLabel.text = @"补全医生";
    } else if ([doctorModel.dataCollectionType integerValue] == 3) {
        self.typeLabel.text = @"新增医生";
    }
    
    if ([doctorModel.status integerValue] == 0) {
        self.auditPassImageView.hidden = true;
        self.statusLabel.hidden = false;
        self.statusLabel.textColor = UIColorHex(0xFEAE05);
        self.statusLabel.text = @"审核中";
    } else if ([doctorModel.status integerValue] == 1) {
        // 通过
        self.auditPassImageView.hidden = false;
        self.statusLabel.hidden = true;
    } else if ([doctorModel.status integerValue] ==  2) {
        // 拒绝
        self.auditPassImageView.hidden = true;
        self.statusLabel.hidden = false;
        self.statusLabel.textColor = UIColorHex(0xFF6188);
        self.statusLabel.text = @"未采纳";
    }
    
    [self.headPortraitImageView sd_setImageWithURL:kGetBigImageURLWithString(doctorModel.profilePhoto) placeholderImage:[UIImage imageNamed:@"doctor_default_portail"]];
    
    self.nameLabel.text = ISNIL(doctorModel.doctorName);
    
}

- (void)setHospitalModel:(GHDataCollectionHospitalModel *)hospitalModel {
    
    _hospitalModel = hospitalModel;
    
    self.iconTypeImageView.image = [UIImage imageNamed:@"contribute_audit_hospital"];
    
    /**
     数据采集类型 1：报错 2：补全 3：新增
     */
    if ([hospitalModel.dataCollectionType integerValue] == 1) {
        self.typeLabel.text = @"核实医院";
    } else if ([hospitalModel.dataCollectionType integerValue] == 2) {
        self.typeLabel.text = @"补全医院";
    } else if ([hospitalModel.dataCollectionType integerValue] == 3) {
        self.typeLabel.text = @"新增医院";
    }
    
    if ([hospitalModel.status integerValue] == 0) {
        self.auditPassImageView.hidden = true;
        self.statusLabel.hidden = false;
        self.statusLabel.textColor = UIColorHex(0xFEAE05);
        self.statusLabel.text = @"审核中";
    } else if ([hospitalModel.status integerValue] == 1) {
        // 通过
        self.auditPassImageView.hidden = false;
        self.statusLabel.hidden = true;
    } else if ([hospitalModel.status integerValue] ==  2) {
        // 拒绝
        self.auditPassImageView.hidden = true;
        self.statusLabel.hidden = false;
        self.statusLabel.textColor = UIColorHex(0xFF6188);
        self.statusLabel.text = @"未采纳";
    }
    
    [self.headPortraitImageView sd_setImageWithURL:kGetBigImageURLWithString(hospitalModel.profilePhoto) placeholderImage:[UIImage imageNamed:@"hospital_placeholder"]];
    
    self.nameLabel.text = ISNIL(hospitalModel.hospitalName);
    
}

@end

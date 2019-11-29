//
//  GHInformationCompletionHospitalListTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/6/4.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHInformationCompletionHospitalListTableViewCell.h"

@interface GHInformationCompletionHospitalListTableViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UILabel *levelLabel;

@property (nonatomic, strong) UILabel *yibaoLabel;

@property (nonatomic, strong) UILabel *distanceLabel;

@property (nonatomic, strong) UILabel *addressLabel;

@end

@implementation GHInformationCompletionHospitalListTableViewCell

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
    
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kDefaultBlackTextColor;
    nameLabel.font = HM17;
    [self.contentView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(10);
    }];
    self.nameLabel = nameLabel;
    
    UILabel *typeLabel = [[UILabel alloc] init];
    typeLabel.textColor = UIColorHex(0xFFB925);
    typeLabel.layer.cornerRadius = 1;
    typeLabel.layer.masksToBounds = true;
    typeLabel.layer.borderColor = typeLabel.textColor.CGColor;
    typeLabel.layer.borderWidth = .5;
    typeLabel.font = H10;
    typeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:typeLabel];
    
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(18);
        make.top.mas_equalTo(42);
    }];
    self.typeLabel = typeLabel;
    
    UILabel *levelLabel = [[UILabel alloc] init];
    levelLabel.textColor = UIColorHex(0xFFB925);
    levelLabel.layer.cornerRadius = 1;
    levelLabel.layer.masksToBounds = true;
    levelLabel.layer.borderColor = levelLabel.textColor.CGColor;
    levelLabel.layer.borderWidth = .5;
    levelLabel.font = H10;
    levelLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:levelLabel];
    
    [levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(typeLabel.mas_right).offset(5);
        make.height.mas_equalTo(18);
        make.top.mas_equalTo(42);
    }];
    self.levelLabel = levelLabel;
    

    
    UILabel *yibaoLabel = [[UILabel alloc] init];
    yibaoLabel.textColor = UIColorHex(0xFFB925);
    yibaoLabel.layer.cornerRadius = 1;
    yibaoLabel.layer.masksToBounds = true;
    yibaoLabel.layer.borderColor = levelLabel.textColor.CGColor;
    yibaoLabel.layer.borderWidth = .5;
    yibaoLabel.font = H10;
    yibaoLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:yibaoLabel];
    
    [yibaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(levelLabel.mas_right).offset(5);
        make.height.mas_equalTo(18);
        make.top.mas_equalTo(42);
        make.width.mas_equalTo(50);
    }];
    self.yibaoLabel = yibaoLabel;
   
    
    UILabel *distanceLabel = [[UILabel alloc] init];
    distanceLabel.font = H13;
    distanceLabel.textColor = kDefaultGrayTextColor;
    distanceLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:distanceLabel];
    
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.top.bottom.mas_equalTo(yibaoLabel);
        make.width.mas_equalTo(120);
    }];
    self.distanceLabel = distanceLabel;
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.font = H14;
    addressLabel.textColor = kDefaultGrayTextColor;
    [self.contentView addSubview:addressLabel];
    
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(16);
        make.bottom.mas_equalTo(-7);
    }];
    self.addressLabel = addressLabel;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultGaryViewColor;
    [self.contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
}


- (void)setModel:(GHSearchHospitalModel *)model {
    
    _model = model;
    
    self.nameLabel.text = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.hospitalName) ];
    

    self.levelLabel.text = ISNIL(model.hospitalGrade);
    self.typeLabel.text = ISNIL(model.category);
    self.yibaoLabel.text = @"支持医保";
    
    self.addressLabel.text = ISNIL(model.hospitalAddress);
    self.distanceLabel.text = [GHUserModelTool shareInstance].isHaveLocation == true ? [ISNIL(model.distance) getKillMeter] : @"";
    
    
    
    
    
    self.yibaoLabel.hidden = ![model.medicalInsuranceFlag boolValue];
    
    
    
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
    
    
}


@end

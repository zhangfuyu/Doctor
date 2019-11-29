//
//  GHNewDoctorTableViewCell.m
//  掌上优医
//
//  Created by apple on 2019/8/8.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewDoctorTableViewCell.h"

#define ForegroundStarImage @"ic_xingxing_all_selected"
#define BackgroundStarImage @"ic_xingxing_all_unselected"

@interface GHNewDoctorTableViewCell ()

@property (nonatomic , strong) UIImageView *headerView;

@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , strong) UILabel *doctorTypeLabel;//主任医生

@property (nonatomic , strong) UILabel *doctorInLabel;//已入驻

@property (nonatomic , strong) UILabel *hospitalaAaddress;//医院地址

@property (nonatomic , strong) UILabel *hospitalaDistance;//医院距离

@property (nonatomic , strong) UILabel *hospitalaLevel;//医院等级

@property (nonatomic , strong) UILabel *doctorGoodAt;//医生擅长

@property (nonatomic , strong) UILabel *recommended;//推荐

@property (nonatomic , strong) UILabel *hospitalType;//

@property (nonatomic , strong) NSMutableArray *jibingarry;

@property (nonatomic, strong) UIImageView *foregroundStarView;

@property (nonatomic, strong) UIImageView *backgroundStarView;

@property (nonatomic, strong) UILabel *fenshulabel;

@property (nonatomic, strong) UILabel *Departmentlabel;




@end

@implementation GHNewDoctorTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headerView.mas_right).with.offset(15);
            make.top.equalTo(self.headerView.mas_top);
        }];
        
        [self.doctorTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right).with.offset(15);
            make.bottom.equalTo(self.nameLabel.mas_bottom);
        }];
        
       
        
        
        
        [self.backgroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.height.mas_equalTo(15);
           make.left.equalTo(self.nameLabel.mas_left);
           make.width.mas_equalTo(15 * 5);
           make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
              
        }];
               
               
        [self.foregroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.height.mas_equalTo(15);
           make.left.mas_equalTo(self.nameLabel.mas_left);
           make.width.mas_equalTo(15 * 5);
           make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        }];
        
        
        [self.fenshulabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.backgroundStarView.mas_right).offset(5);
            make.height.mas_equalTo(13);
            make.centerY.mas_equalTo(self.backgroundStarView.mas_centerY);
        }];
        
        
        [self.doctorInLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.equalTo(self.contentView.mas_right).with.offset(-15);
           make.top.equalTo(self.headerView.mas_top);
           make.size.mas_equalTo(CGSizeMake(39, 14));
        }];
        
        
        
        [self.hospitalType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_left);
            make.height.mas_equalTo(14);
            make.top.mas_equalTo(self.backgroundStarView.mas_bottom).offset(10);
        }];
        
        [self.hospitalaDistance mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.doctorInLabel.mas_right);
            make.top.equalTo(self.doctorInLabel.mas_bottom).with.offset(14);
        }];
        
       [self.hospitalaLevel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.equalTo(self.doctorInLabel.mas_right);
//          make.bottom.equalTo(self.headerView.mas_bottom);
           make.top.mas_equalTo(self.hospitalType.mas_bottom).offset(10);
           make.width.mas_equalTo(60);

              
       }];
        
        [self.hospitalaAaddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_left);
//            make.bottom.equalTo(self.headerView.mas_bottom);
            make.top.mas_equalTo(self.hospitalType.mas_bottom).offset(10);
            make.right.equalTo(self.hospitalaLevel.mas_left).with.offset(-10);
        }];
        
        
        [self.doctorGoodAt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_left);
            make.top.equalTo(self.hospitalaAaddress.mas_bottom).with.offset(10);
            make.right.equalTo(self.hospitalaLevel.mas_right);
            make.height.mas_equalTo(30);
        }];
        
        [self.recommended mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.doctorGoodAt.mas_left);
            make.right.equalTo(self.doctorGoodAt.mas_right);
            make.top.equalTo(self.doctorGoodAt.mas_bottom).with.offset(10);
        }];
    }
    return self;
}

- (void)setModel:(GHNewDoctorModel *)model
{
    _model = model;
    
    self.doctorInLabel.hidden = YES;
    self.doctorInLabel.text = @"已入驻";
    
//    self.doctorInLabel.hidden = ![ISNIL(model.isInPlatform) boolValue];
    
     [self.headerView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.headImgUrl)) placeholderImage:[UIImage imageNamed:@"doctor_default_portail"]];
    
    self.nameLabel.text = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.doctorName)];

    [self.foregroundStarView mas_updateConstraints:^(MASConstraintMaker *make) {
         make.width.mas_equalTo(15 * .5 * [model.commentScore floatValue] / 10);
     }];
    
    self.fenshulabel.text = [NSString stringWithFormat:@"%.1f分",[model.commentScore floatValue] / 10];
    
    self.doctorTypeLabel.text = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.doctorGrade)];
    
//    if (model.medicineType.length) {
//        self.hospitalType.text = model.medicineType;
//        self.hospitalType.hidden = NO;
//    }
//    else
//    {
//        self.hospitalType.hidden = YES;
//    }

    if (model.secondDepartmentName.length) {
        self.hospitalType.text = model.secondDepartmentName;
        self.hospitalType.hidden = NO;
    }
    else
    {
        self.hospitalType.hidden = YES;
    }
    
    
    float width = [self.hospitalType.text widthForFont:[UIFont systemFontOfSize:9]];
    
    [self.hospitalType mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width + 10);
    }];
    
    
    self.hospitalaAaddress.text = [NSString stringWithFormat:@"%@", ISNIL(model.hospitalName)];
    
    
    if ([model.distance floatValue] == 0) {
        self.hospitalaDistance.hidden = YES;
    }
    else
    {
        self.hospitalaDistance.hidden = NO;

    }
    self.hospitalaDistance.text = [NSString stringWithFormat:@"%.1fkm",[model.distance floatValue] / 1000];
    self.hospitalaLevel.text = model.hospitalGrade
    ;
    self.hospitalaAaddress.text = [NSString stringWithFormat:@"%@", ISNIL(model.hospitalName)];

//    if (model.specialize.length >0) {
//        self.doctorGoodAt.hidden = NO;
//        self.doctorGoodAt.text = [GHFilterHTMLTool filterHTMLEMTag:[NSString stringWithFormat:@"擅长:%@", ISNIL(model.specialize)] ];
//        [self.doctorGoodAt mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(30);
//        }];
//    }
//    else
//    {
        self.doctorGoodAt.hidden = YES;
        [self.doctorGoodAt mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(.1);
        }];
//    }
    
    [self.jibingarry removeAllObjects];
    
    if (model.doctorRecommendedDisease.length > 0) {
        [self.jibingarry addObject:model.doctorRecommendedDisease];
    }
    if (model.doctorSecondDisease.length > 0) {
         [self.jibingarry addObject:model.doctorSecondDisease];
    }
    if (self.jibingarry.count > 0) {
        
        self.recommended.hidden = NO;
        self.recommended.text = [NSString stringWithFormat:@"推荐:%@",[self.jibingarry componentsJoinedByString:@","]];
        [self.recommended mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(13);
        }];
    }
    else
    {
        self.recommended.hidden = YES;
        
        [self.recommended mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(.1);
        }];
    }
}
+ (float)getCellHeitghtWithMoel:(GHNewDoctorModel *)model
{
    float cellHeight = 75.0;
    
    cellHeight += 10.0;
    
    cellHeight += 25;//j星级高度
    
//    if (model.specialize.length >0) {
//        cellHeight += 30;
//        cellHeight += 10;
//    }
    
    if (model.doctorRecommendedDisease.length > 0 || model.doctorSecondDisease.length > 0) {
        cellHeight += 13;
        cellHeight += 10;
    }
    
    return cellHeight;
}
- (UIImageView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIImageView alloc]init];
        [self.contentView addSubview:_headerView];
    }
    return _headerView;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)doctorTypeLabel
{
    if (!_doctorTypeLabel) {
        _doctorTypeLabel = [[UILabel alloc]init];
        _doctorTypeLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _doctorTypeLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_doctorTypeLabel];
    }
    return _doctorTypeLabel;
}

- (UILabel *)hospitalaAaddress
{
    if (!_hospitalaAaddress) {
        _hospitalaAaddress = [[UILabel alloc]init];
        _hospitalaAaddress.textColor = [UIColor colorWithHexString:@"999999"];
        _hospitalaAaddress.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_hospitalaAaddress];
    }
    return _hospitalaAaddress;
}

- (UILabel *)doctorInLabel
{
    if (!_doctorInLabel) {
        _doctorInLabel = [[UILabel alloc]init];
        _doctorInLabel.textColor = [UIColor colorWithHexString:@"E9930B"];
        _doctorInLabel.font = [UIFont systemFontOfSize:9];
        _doctorInLabel.backgroundColor = [UIColor colorWithHexString:@"FFE7BD"];
        _doctorInLabel.layer.cornerRadius = 2;
        _doctorInLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_doctorInLabel];
    }
    return _doctorInLabel;
}

- (UILabel *)hospitalaDistance
{
    if (!_hospitalaDistance) {
        _hospitalaDistance = [[UILabel alloc]init];
        _hospitalaDistance.textColor = [UIColor colorWithHexString:@"999999"];
        _hospitalaDistance.font = [UIFont systemFontOfSize:12];
        _hospitalaDistance.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_hospitalaDistance];
    }
    return _hospitalaDistance;
}

- (UILabel *)hospitalaLevel
{
    if (!_hospitalaLevel) {
        _hospitalaLevel = [[UILabel alloc]init];
        _hospitalaLevel.textColor = [UIColor colorWithHexString:@"999999"];
        _hospitalaLevel.font = [UIFont systemFontOfSize:12];
        _hospitalaLevel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_hospitalaLevel];
    }
    return _hospitalaLevel;
}

- (UILabel *)doctorGoodAt
{
    if (!_doctorGoodAt) {
        _doctorGoodAt = [[UILabel alloc]init];
        _doctorGoodAt.textColor = [UIColor colorWithHexString:@"333333"];
        _doctorGoodAt.font = [UIFont systemFontOfSize:12];
        _doctorGoodAt.numberOfLines = 0;
        [self.contentView addSubview:_doctorGoodAt];
    }
    return _doctorGoodAt;
}
-(UILabel *)recommended
{
    if (!_recommended) {
        _recommended = [[UILabel alloc]init];
        _recommended.textColor = [UIColor colorWithHexString:@"6A70FD"];
        _recommended.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_recommended];
    }
    return _recommended;
}

- (UILabel *)hospitalType
{
    if (!_hospitalType) {
        _hospitalType = [[UILabel alloc]init];
        _hospitalType.textColor = [UIColor colorWithHexString:@"6A70FD"];
        _hospitalType.textAlignment = NSTextAlignmentCenter;
        _hospitalType.font = [UIFont systemFontOfSize:9];
        _hospitalType.layer.borderWidth = 1;
        _hospitalType.layer.cornerRadius = 2;
        _hospitalType.layer.borderColor = [UIColor colorWithHexString:@"6A70FD"].CGColor;
        [self.contentView addSubview:_hospitalType];
    }
    return _hospitalType;
}

-(UIImageView *)backgroundStarView
{
    if (!_backgroundStarView) {
        _backgroundStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:BackgroundStarImage]];
        _backgroundStarView.contentMode = UIViewContentModeLeft;
        _backgroundStarView.clipsToBounds = true;
        [self addSubview:_backgroundStarView];
    }
    return _backgroundStarView;
}
- (UIImageView *)foregroundStarView
{
    if (!_foregroundStarView) {
        _foregroundStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:ForegroundStarImage]];
        _foregroundStarView.contentMode = UIViewContentModeLeft;
        _foregroundStarView.clipsToBounds = true;
        [self addSubview:_foregroundStarView];
    }
    return _foregroundStarView;
}

- (UILabel *)fenshulabel
{
    if (!_fenshulabel) {
        _fenshulabel = [[UILabel alloc]init];
        _fenshulabel.textColor = [UIColor colorWithHexString:@"FF6188"];
        _fenshulabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_fenshulabel];
    }
    return _fenshulabel;
}
- (NSMutableArray *)jibingarry
{
    if (!_jibingarry) {
        _jibingarry = [NSMutableArray arrayWithCapacity:0];
    }
    return _jibingarry;
}
- (UILabel *)Departmentlabel
{
    if (!_Departmentlabel) {
        _Departmentlabel = [[UILabel alloc]init];
        _Departmentlabel.textColor = [UIColor colorWithHexString:@"6A70FD"];
        _Departmentlabel.layer.borderWidth = 1;
        _Departmentlabel.layer.borderColor = [UIColor colorWithHexString:@"6A70FD"].CGColor;
        _Departmentlabel.layer.cornerRadius = 2;
        
        [self.contentView addSubview:_Departmentlabel];
    }
    return _Departmentlabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

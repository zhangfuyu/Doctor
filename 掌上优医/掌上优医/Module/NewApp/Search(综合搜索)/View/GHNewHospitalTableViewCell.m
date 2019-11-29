//
//  GHNewHospitalTableViewCell.m
//  掌上优医
//
//  Created by apple on 2019/8/13.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewHospitalTableViewCell.h"
#import "GHNewSubView.h"

@interface GHNewHospitalTableViewCell ()

@property (nonatomic , strong) UIImageView *headerImageView;

@property (nonatomic , strong) UIImageView *leftImage;

@property (nonatomic , strong) UILabel *hospitalNameLabel;

@property (nonatomic , strong) UILabel *hospitalInLabel;

@property (nonatomic , strong) UILabel *levelView;//等级

@property (nonatomic , strong) UILabel *typeView;//医院类型

@property (nonatomic , strong) UILabel *governmentView;//政府 or 私立

@property (nonatomic , strong) UILabel *mediaTypeView;//

@property (nonatomic , strong) UILabel *distanceLabel;//距离

@property (nonatomic , strong) UILabel *addressLabel;

@property (nonatomic , strong) UILabel *hospitalScoreValueLabel;//评分

@property (nonatomic , strong) UILabel *hospitalYibaoLabel;

@property (nonatomic , strong) UILabel *hospitaljizhen;




@end

@implementation GHNewHospitalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.clipsToBounds = YES;
    
        [self creattUi];
    }
    return self;
}

- (void)creattUi
{
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(75, 75));
    }];
    
//    [self.hospitalInLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.headerImageView.mas_top);
//        make.size.mas_equalTo(CGSizeMake(39, 14));
//        make.right.mas_equalTo(-15);
//    }];
    
    [self.hospitalNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImageView.mas_top);
        make.left.mas_equalTo(self.headerImageView.mas_right).offset(10);
//        make.right.mas_equalTo(self.hospitalInLabel.mas_left).offset(-5);
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(15);
    }];
    
    [self.hospitalScoreValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.hospitalNameLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.hospitalNameLabel.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(10);
    }];
    
//    [self.levelView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.mas_equalTo(self.hospitalScoreValueLabel.mas_bottom).offset(10);
////        make.left.mas_equalTo(self.hospitalScoreValueLabel.mas_left);
//        make.height.mas_equalTo(12);
//    }];
//
//    [self.typeView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.mas_equalTo(self.hospitalScoreValueLabel.mas_bottom).offset(10);
////        make.left.mas_equalTo(self.levelView.mas_right).offset(15);
//        make.height.mas_equalTo(12);
//    }];
//    [self.governmentView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.mas_equalTo(self.hospitalScoreValueLabel.mas_bottom).offset(10);
////        make.left.mas_equalTo(self.typeView.mas_right).offset(15);
//        make.height.mas_equalTo(12);
//    }];
//    [self.mediaTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.mas_equalTo(self.hospitalScoreValueLabel.mas_bottom).offset(10);
////        make.left.mas_equalTo(self.governmentView.mas_right).offset(15);
//        make.height.mas_equalTo(12);
//    }];
    
    [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.hospitalScoreValueLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 12));
        make.top.mas_equalTo(self.hospitalScoreValueLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(-15);
//        make.bottom.mas_equalTo(self.headerImageView.mas_bottom);
    }];
    
    
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImage.mas_right).offset(5);
        make.right.mas_equalTo(self.distanceLabel.mas_left).offset(5);
        make.top.mas_equalTo(self.hospitalScoreValueLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(12);
    }];
    
//    [self.hospitalYibaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.headerImageView.mas_left);
//        make.top.mas_equalTo(self.headerImageView.mas_bottom).offset(10);
//        make.size.mas_equalTo(CGSizeMake(26, 12));
//    }];
}
- (void)setModel:(GHSearchHospitalModel *)model
{
    _model = model;
    
    
    self.hospitalInLabel.text = @"已入住";
    
    [self.headerImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.profilePhoto)) placeholderImage:[UIImage imageNamed:@"hospital_placeholder"]];
    self.hospitalNameLabel.text = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.hospitalName) ];
    self.addressLabel.text = ISNIL(model.hospitalAddress);
    self.distanceLabel.text = [[NSString stringWithFormat:@"%@",ISNIL(model.distance)] getKillMeter];//[GHUserModelTool shareInstance].isHaveLocation == true ? [ISNIL(model.distance) getKillMeter] : [ISNIL(model.distance) getKillMeter];
    self.hospitalScoreValueLabel.text =[NSString stringWithFormat:@"综合：%.1f分   服务：%.1f分    环境：%.1f分", [model.comprehensiveScore floatValue], [model.serviceScore floatValue], [model.environmentScore floatValue]];
    
    
//    self.hospitalYibaoLabel.hidden = ![model.medicalInsuranceFlag boolValue];
//    self.hospitaljizhen.hidden = model.emergencyTreatmentTime.length > 0? NO :YES;
    
    float widthX = 100;
    
    self.levelView.text = ISNIL(model.hospitalGrade);
    self.typeView.text = ISNIL(model.category);
    self.governmentView.text = ISNIL(model.governmentalHospitalFlag);
//    if ([self.model.governmentalHospitalFlag integerValue] == 0) {
//        self.governmentView.titleText = @"私立";
//    } else {
//        self.governmentView.titleText = @"公立";
//    }
    
    self.mediaTypeView.text = ISNIL(model.medicineType);
    
    
    
    if (self.levelView.text.length) {
        NSLog(@"---->%@",self.levelView.text);
        
        //        self.levelView.size = CGSizeMake([self.levelView.titleText widthForFont:[UIFont systemFontOfSize:12]] + 15, 12);
        
        self.levelView.frame = CGRectMake(widthX, 82, [self.levelView.text widthForFont:[UIFont systemFontOfSize:10]] + 10, 15);
        
        
        widthX += [self.levelView.text widthForFont:[UIFont systemFontOfSize:10]] + 10 + 10;
        
    } else {
        
        self.levelView.frame = CGRectMake(widthX, 82, .1, 15);
        
        widthX +=.1;
    }
    
    
    if (self.typeView.text.length) {
        
        self.typeView.frame = CGRectMake(widthX, 82, [self.typeView.text widthForFont:[UIFont systemFontOfSize:10]] + 10, 15);
        widthX += [self.typeView.text widthForFont:[UIFont systemFontOfSize:10]] + 10 + 10;
        
    } else {
        
        self.typeView.frame = CGRectMake(widthX, 82, .1, 15);
        
        widthX += .1;
    }
    
    if (self.governmentView.text.length) {
        
        self.governmentView.hidden = NO;
        
        
        if (SCREENWIDTH - widthX > [self.governmentView.text widthForFont:[UIFont systemFontOfSize:10]] + 10 + 15) {
            
            self.governmentView.frame = CGRectMake(widthX, 82, [self.governmentView.text widthForFont:[UIFont systemFontOfSize:10]] + 10, 15);
            
            widthX +=[self.governmentView.text widthForFont:[UIFont systemFontOfSize:10]] + 10 + 10;
        }
        else
        {
            
            widthX =  100;

            
            self.governmentView.frame = CGRectMake(widthX, CGRectGetMaxY(self.typeView.frame) + 10, [self.governmentView.text widthForFont:[UIFont systemFontOfSize:10]] + 10, 15);
            
            widthX += [self.governmentView.text widthForFont:[UIFont systemFontOfSize:10]] + 10 + 10;
        }
        
        
        
        
    } else {
        
        self.governmentView.frame = CGRectMake(widthX, 82, .1, 15);
        widthX += .1;
        
        
    }
    if (self.mediaTypeView.text.length) {
        
        self.mediaTypeView.hidden = false;
        
        if (SCREENWIDTH - widthX > [self.mediaTypeView.text widthForFont:[UIFont systemFontOfSize:10]] + 10 + 15) {
        
            self.mediaTypeView.frame = CGRectMake(widthX, CGRectGetMinY(self.governmentView.frame), [self.mediaTypeView.text widthForFont:[UIFont systemFontOfSize:10]] + 10, 15);
            widthX +=[self.mediaTypeView.text widthForFont:[UIFont systemFontOfSize:10]] + 10 + 10;
            
        }
        else
        {
            
            widthX =  100;

            self.mediaTypeView.frame = CGRectMake(widthX, CGRectGetMaxY(self.governmentView.frame) + 10, [self.mediaTypeView.text widthForFont:[UIFont systemFontOfSize:10]] + 10, 15);
            
            widthX += [self.mediaTypeView.text widthForFont:[UIFont systemFontOfSize:10]] + 10 + 10;

            
        }
        
        
        
        
    } else {
        
        self.mediaTypeView.frame = CGRectMake(widthX, 82, .1, 15);
        widthX += .1;
        
    }
    
    if (![model.medicalInsuranceFlag boolValue]) {
        self.hospitalYibaoLabel.frame = CGRectMake(widthX, CGRectGetMinY(self.mediaTypeView.frame), .1, 15);
        widthX += .1;

    }
    else
    {
        
        if (SCREENWIDTH - widthX > [self.hospitalYibaoLabel.text widthForFont:[UIFont systemFontOfSize:10]] + 10 + 15)
        {
            self.hospitalYibaoLabel.frame = CGRectMake(widthX, CGRectGetMinY(self.mediaTypeView.frame), [self.hospitalYibaoLabel.text widthForFont:[UIFont systemFontOfSize:10]] + 10, 15);
            widthX +=[self.hospitalYibaoLabel.text widthForFont:[UIFont systemFontOfSize:10]] + 10 + 10;
        }
        else
        {
            widthX =  100;
            self.hospitalYibaoLabel.frame = CGRectMake(widthX, CGRectGetMaxY(self.mediaTypeView.frame) + 10, [self.hospitalYibaoLabel.text widthForFont:[UIFont systemFontOfSize:10]] + 10, 15);

        }
        
    }
    
    if (model.emergencyTreatmentTime.length == 0) {
        self.hospitaljizhen.frame = CGRectMake(widthX, CGRectGetMinY(self.hospitalYibaoLabel.frame), .1, 15);
        widthX += .1;
    }
    else
    {
        if (SCREENWIDTH - widthX > [self.hospitaljizhen.text widthForFont:[UIFont systemFontOfSize:10]] + 10 + 15)
        {
            self.hospitaljizhen.frame = CGRectMake(widthX, CGRectGetMinY(self.hospitalYibaoLabel.frame), [self.hospitaljizhen.text widthForFont:[UIFont systemFontOfSize:10]] + 10, 15);
            widthX +=[self.hospitalYibaoLabel.text widthForFont:[UIFont systemFontOfSize:10]] + 10 + 10;
        }
        else
        {
            widthX =  100;
            self.hospitaljizhen.frame = CGRectMake(widthX, CGRectGetMaxY(self.hospitalYibaoLabel.frame) + 10, [self.hospitaljizhen.text widthForFont:[UIFont systemFontOfSize:10]] + 10, 15);
        }
    }
    
}
+ (float)getCellHeightFor:(GHSearchHospitalModel *)model
{
    CGFloat cellHeight = 82.0;
    CGFloat widthX = 100.0;
    
    if (model.hospitalGrade.length) {
        
        widthX += [model.hospitalGrade widthForFont:[UIFont systemFontOfSize:10]] + 10 + 10;
        cellHeight += 15;
        
    } else {
        
        widthX +=.1;
    }
    
    if (model.category.length) {
        
        widthX += [model.category widthForFont:[UIFont systemFontOfSize:10]] + 10 + 10;
        
    } else {
        
        widthX += .1;
    }
    if (model.governmentalHospitalFlag.length) {
        
        
        if (SCREENWIDTH - widthX > [model.governmentalHospitalFlag widthForFont:[UIFont systemFontOfSize:10]] + 10 + 15) {
            
            
            widthX +=[model.governmentalHospitalFlag widthForFont:[UIFont systemFontOfSize:10]] + 10 + 10;
        }
        else
        {
            
            widthX =  100;
   
            widthX += [model.governmentalHospitalFlag widthForFont:[UIFont systemFontOfSize:10]] + 10 + 10;
            
            cellHeight += 25;
        }
        
        
        
        
    } else {
        
        widthX += .1;
    }
    
    if (model.medicineType.length) {
        
        if (SCREENWIDTH - widthX > [model.medicineType widthForFont:[UIFont systemFontOfSize:10]] + 10 + 15) {
            
            
            widthX +=[model.medicineType widthForFont:[UIFont systemFontOfSize:10]] + 10 + 10;
            
        }
        else
        {
            
            widthX =  100;
        
            widthX += [model.medicineType widthForFont:[UIFont systemFontOfSize:10]] + 10 + 10;
            
            cellHeight += 25.0;
            
        }
        
        
        
        
    } else {
        
        widthX += .1;
        
    }
    
    if (![model.medicalInsuranceFlag boolValue]) {
        widthX += .1;
        
    }
    else
    {
        
        if (SCREENWIDTH - widthX > [@"医保" widthForFont:[UIFont systemFontOfSize:10]] + 10 + 15)
        {
           
            widthX +=[@"医保" widthForFont:[UIFont systemFontOfSize:10]] + 10 + 10;
        }
        else
        {
            widthX =  100;
            
            cellHeight += 25;
        }
        
    }
    
    if (model.emergencyTreatmentTime.length == 0) {
        widthX += .1;
    }
    else
    {
        if (SCREENWIDTH - widthX > [@"急诊" widthForFont:[UIFont systemFontOfSize:10]] + 10 + 15)
        {
            
            widthX +=[@"急诊" widthForFont:[UIFont systemFontOfSize:10]] + 10 + 10;
        }
        else
        {
            widthX =  100;
            
            cellHeight += 25;
        }
    }
    
    cellHeight += 15;
    
    return cellHeight;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
   
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (UIImageView *)headerImageView
{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_headerImageView];
    }
    return _headerImageView;
}

- (UILabel *)hospitalNameLabel
{
    if (!_hospitalNameLabel) {
        _hospitalNameLabel = [[UILabel alloc]init];
        _hospitalNameLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _hospitalNameLabel.font = H15;
        [self.contentView addSubview:_hospitalNameLabel];
    }
    return _hospitalNameLabel;
}

- (UILabel *)hospitalScoreValueLabel
{
    if (!_hospitalScoreValueLabel) {
        _hospitalScoreValueLabel = [[UILabel alloc]init];
        _hospitalScoreValueLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _hospitalScoreValueLabel.font = [UIFont systemFontOfSize:12];
        _hospitalScoreValueLabel.autoresizesSubviews = YES;
        [self.contentView addSubview:_hospitalScoreValueLabel];
    }
    return _hospitalScoreValueLabel;
}

-(UILabel *)distanceLabel
{
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc]init];
        _distanceLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _distanceLabel.textAlignment = NSTextAlignmentRight;
        _distanceLabel.font = H12;
        [self.contentView addSubview:_distanceLabel];
    }
    return _distanceLabel;
}

- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _addressLabel.font = H12;
        [self.contentView addSubview:_addressLabel];
    }
    return _addressLabel;
    
}

- (UILabel *)levelView
{
    if (!_levelView) {
        _levelView = [[UILabel alloc]init];
        _levelView.backgroundColor = [UIColor colorWithHexString:@"FFE7BD"];
        _levelView.textColor = [UIColor colorWithHexString:@"E9930B"];
        _levelView.font = H10;
        _levelView.layer.cornerRadius = 2;
        _levelView.textAlignment = NSTextAlignmentCenter;
        _levelView.layer.masksToBounds = YES;
        [self.contentView addSubview:_levelView];
    }
    return _levelView;
}

-(UILabel *)typeView
{
    if (!_typeView) {
        _typeView = [[UILabel alloc]init];
        _typeView.backgroundColor = [UIColor colorWithHexString:@"FFE7BD"];
        _typeView.textColor = [UIColor colorWithHexString:@"E9930B"];
        _typeView.font = H10;
        _typeView.layer.cornerRadius = 2;
        _typeView.textAlignment = NSTextAlignmentCenter;
        _typeView.layer.masksToBounds = YES;
        [self.contentView addSubview:_typeView];
    }
    return _typeView;
}
- (UILabel *)governmentView
{
    if (!_governmentView) {
        _governmentView = [[UILabel alloc]init];
        _governmentView.backgroundColor = [UIColor colorWithHexString:@"FFE7BD"];
        _governmentView.textColor = [UIColor colorWithHexString:@"E9930B"];
        _governmentView.font = H10;
        _governmentView.layer.cornerRadius = 2;
        _governmentView.textAlignment = NSTextAlignmentCenter;
        _governmentView.layer.masksToBounds = YES;
        [self.contentView addSubview:_governmentView];
    }
    return _governmentView;
}
- (UILabel *)mediaTypeView
{
    if (!_mediaTypeView) {
        _mediaTypeView = [[UILabel alloc]init];
        _mediaTypeView.backgroundColor = [UIColor colorWithHexString:@"FFE7BD"];
        _mediaTypeView.textColor = [UIColor colorWithHexString:@"E9930B"];
        _mediaTypeView.font = H10;
        _mediaTypeView.layer.cornerRadius = 2;
        _mediaTypeView.textAlignment = NSTextAlignmentCenter;
        _mediaTypeView.layer.masksToBounds = YES;
        [self.contentView addSubview:_mediaTypeView];
    }
    return _mediaTypeView;
}
- (UILabel *)hospitalInLabel
{
    if (!_hospitalInLabel) {
        _hospitalInLabel = [[UILabel alloc]init];
        _hospitalInLabel.textColor = [UIColor colorWithHexString:@"E9930B"];
        _hospitalInLabel.font = [UIFont systemFontOfSize:9];
        _hospitalInLabel.backgroundColor = [UIColor colorWithHexString:@"FFE7BD"];
        _hospitalInLabel.layer.cornerRadius = 2;
        _hospitalInLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_hospitalInLabel];
    }
    return _hospitalInLabel;
}
- (UIImageView *)leftImage
{
    if (!_leftImage) {
        _leftImage = [[UIImageView alloc]init];
        _leftImage.image = [UIImage imageNamed:@"hospital_Distance"];
        [self.contentView addSubview:_leftImage];
    }
    return _leftImage;
}
- (UILabel *)hospitalYibaoLabel
{
    if (!_hospitalYibaoLabel) {
        _hospitalYibaoLabel = [[UILabel alloc]init];
        _hospitalYibaoLabel.text = @"医保";
        _hospitalYibaoLabel.backgroundColor = [UIColor colorWithHexString:@"FFE7BD"];
        _hospitalYibaoLabel.textColor = [UIColor colorWithHexString:@"E9930B"];
        _hospitalYibaoLabel.font = H10;
        _hospitalYibaoLabel.layer.cornerRadius = 2;
        _hospitalYibaoLabel.textAlignment = NSTextAlignmentCenter;
        _hospitalYibaoLabel.layer.masksToBounds = YES;
        [self.contentView addSubview:_hospitalYibaoLabel];
    }
    return _hospitalYibaoLabel;
}
- (UILabel *)hospitaljizhen
{
    if (!_hospitaljizhen) {
        _hospitaljizhen = [[UILabel alloc]init];
        _hospitaljizhen.text = @"急诊";
        _hospitaljizhen.backgroundColor = [UIColor colorWithHexString:@"FFE7BD"];
        _hospitaljizhen.textColor = [UIColor colorWithHexString:@"E9930B"];
        _hospitaljizhen.font = H10;
        _hospitaljizhen.layer.cornerRadius = 2;
        _hospitaljizhen.textAlignment = NSTextAlignmentCenter;
        _hospitaljizhen.layer.masksToBounds = YES;
        [self.contentView addSubview:_hospitaljizhen];
    }
    return _hospitaljizhen;
}
@end

//
//  GHNewDoctorDetailView.m
//  掌上优医
//
//  Created by apple on 2019/8/9.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewDoctorDetailView.h"
#import "NSString+Extension.h"
#import <MapKit/MapKit.h>
#import "GHNewHospitalViewController.h"

#define ForegroundStarImage @"ic_xingxing_all_selected"
#define BackgroundStarImage @"ic_xingxing_all_unselected"

@interface GHNewDoctorDetailView ()

@property (nonatomic , strong)UIImageView *headerView;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic, strong) UIImageView *foregroundStarView;

@property (nonatomic, strong) UIImageView *backgroundStarView;

@property (nonatomic , strong) UILabel *doctorTypeLabel;//主任医生

@property (nonatomic , strong) UILabel *doctorInLabel;//已入驻

@property (nonatomic , strong) UILabel *hospital;//医院

@property (nonatomic , strong) UILabel *doctorGoodAt;//医生擅长

@property (nonatomic , strong) UILabel *recommended;//推荐

@property (nonatomic , strong) UILabel *doctorIntroduceTitleLabel;//职业经历

@property (nonatomic , strong) UILabel *doctorScoreValueLabel;//评分

@property (nonatomic , strong) UILabel *firstDeparLabel;

@property (nonatomic , strong) UILabel *commentLabel;//评论条数

@property (nonatomic , strong) UIButton *arrowButton;

@property (nonatomic , strong) UIView *hospitalView;

@property (nonatomic , strong) UIView *hospitalAdreessView;



@end

@implementation GHNewDoctorDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headerView.mas_right).with.offset(10);
            make.top.mas_equalTo(15);
            make.height.mas_equalTo(15);
        }];
        
        
        [self.doctorInLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(39, 14));
        }];
        
        [self.doctorTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.nameLabel.mas_bottom);
            make.left.equalTo(self.nameLabel.mas_right).with.offset(10);
//            make.right.equalTo(self.doctorInLabel.mas_left);
        }];
        
        [self.backgroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.left.equalTo(self.headerView.mas_right).with.offset(10);
            make.width.mas_equalTo(15 * 5);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        }];
        
        [self.foregroundStarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.left.mas_equalTo(self.backgroundStarView.mas_left);
            make.width.mas_equalTo(15 * 5);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        }];
        
        [self.doctorScoreValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.backgroundStarView.mas_right).offset(5);
            make.height.mas_equalTo(14);
            make.centerY.equalTo(self.backgroundStarView.mas_centerY);
        }];
        [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.doctorScoreValueLabel.mas_right).offset(10);
            make.height.mas_equalTo(10);
            make.centerY.equalTo(self.doctorScoreValueLabel.mas_centerY);
        }];
        
        [self.recommended mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-15);
            make.bottom.mas_equalTo(self.headerView.mas_bottom);
            make.height.mas_equalTo(12);
        }];
        
        [self.hospital mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headerView.mas_right).offset(10);
            make.bottom.mas_equalTo(self.headerView.mas_bottom);
            make.height.mas_equalTo(12);
            make.right.equalTo(self.recommended.mas_left).with.offset(-10);
        }];
        
        [self.doctorGoodAt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.firstDeparLabel.mas_bottom).offset(15);
            make.left.mas_equalTo(self.headerView.mas_left);
            make.right.equalTo(self.mas_right).with.offset(-15);
        }];
        
        [self.doctorIntroduceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(self.doctorGoodAt);
            make.top.mas_equalTo(self.doctorGoodAt.mas_bottom).offset(15);
        }];
        
        [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(35);
            make.top.mas_equalTo(self.doctorIntroduceTitleLabel.mas_bottom);
        }];
        
        UIView *lineview = [[UIView alloc]init];
        lineview.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
        [self addSubview:lineview];
        [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.arrowButton.mas_bottom);
            make.height.mas_equalTo(5);
        }];
        
        [self.hospitalView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(lineview.mas_bottom);
            make.height.mas_equalTo(50);
        }];
        
        [self.hospitalAdreessView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.hospitalView.mas_bottom);
            make.height.mas_equalTo(68);
        }];
        
    }
    return self;
}

- (void)setModel:(GHSearchDoctorModel *)model
{
    
    _model = model;
    [self.headerView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.headImgUrl)) placeholderImage:[UIImage imageNamed:@"doctor_default_portail"]];
    
    self.nameLabel.text = ISNIL(model.doctorName);
    self.doctorInLabel.text= @"已入住";

    if ([model.isinplatform integerValue] == 1) {
        self.doctorInLabel.hidden = NO;

    }
    else
    {
        self.doctorInLabel.hidden = YES;

    }
    self.doctorScoreValueLabel.text = [NSString stringWithFormat:@"%.1f", [model.commentScore floatValue]];
    self.commentLabel.text = [NSString stringWithFormat:@"(%@条评论)",model.commentCount];
    [self.foregroundStarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15 * .5 * [model.commentScore floatValue]);
    }];
    
    self.doctorTypeLabel.text = model.doctorGrade;//[GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.doctorGrade)];
//    self.recommended.text = @"推荐:腹痛,风湿";
    
    float widthr = [self.recommended.text widthForFont:self.recommended.font];
    [self.recommended mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(widthr + 5);
    }];
    
    self.hospital.text = [NSString stringWithFormat:@"%@", ISNIL(model.hospitalName)];
    
    UILabel *subHospital = (UILabel *)[self.hospitalView viewWithTag:10086];
    subHospital.text = [NSString stringWithFormat:@"%@", ISNIL(model.hospitalName)];
    
    UILabel *hospitalAdreess = (UILabel *)[self.hospitalAdreessView viewWithTag:10086];
    hospitalAdreess.text = ISNIL(model.hospitalAddress);
    
    UILabel *hospitalDistanceLabel = (UILabel *)[self.hospitalAdreessView viewWithTag:10087];
    hospitalDistanceLabel.text = [NSString stringWithFormat:@"%.1fkm",[model.distance floatValue] / 1000];
    
    
    float width = [model.firstDepartmentName sizeForFont:self.firstDeparLabel.font size:CGSizeMake(MAXFLOAT, 14) mode:NSLineBreakByCharWrapping].width;
    self.firstDeparLabel.text = model.firstDepartmentName;
    [self.firstDeparLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerView.mas_left);
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(10);
        if (width == 0) {
            make.size.mas_equalTo(CGSizeMake(.1, .1));

        }
        else
        {
            make.size.mas_equalTo(CGSizeMake(width + 10, 14));

        }
    }];
    
    if (width == 0) {
        [self.doctorGoodAt mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headerView.mas_bottom).offset(15);
        }];
    }
    
    if (model.doctorInfo.length > 30) {
        self.doctorIntroduceTitleLabel.numberOfLines = 2;
    }
    
    NSString *doctorGoodAtText = [NSString stringWithFormat:@"擅长：%@",ISNIL(model.specialize)];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.maximumLineHeight = 0;
    paragraphStyle.minimumLineHeight = 0;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:doctorGoodAtText];
    
    [attr addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, doctorGoodAtText.length)];
    [attr addAttributes:@{NSFontAttributeName: self.doctorGoodAt.font} range:NSMakeRange(0, doctorGoodAtText.length)];
    
    
    self.doctorGoodAt.attributedText = attr;
    
    NSString *doctorIntroduceTitleLabelText =  [NSString stringWithFormat:@"职业经历：%@",ISNIL(model.doctorInfo)];
    
    
    NSMutableParagraphStyle *paragraphStyle2 = [NSMutableParagraphStyle new];
    paragraphStyle2.maximumLineHeight = 0;
    paragraphStyle2.minimumLineHeight = 0;
    
    NSMutableAttributedString *attr2 = [[NSMutableAttributedString alloc] initWithString:doctorIntroduceTitleLabelText];
    
    [attr2 addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle2} range:NSMakeRange(0, doctorIntroduceTitleLabelText.length)];
    [attr2 addAttributes:@{NSFontAttributeName: self.doctorGoodAt.font} range:NSMakeRange(0, doctorIntroduceTitleLabelText.length)];
    
    self.doctorIntroduceTitleLabel.attributedText = attr2;
    
    if (model.specialize.length > 0) {
        CGFloat shouldHeight = [doctorGoodAtText getShouldHeightWithContent:doctorGoodAtText withFont:self.doctorGoodAt.font withWidth:SCREENWIDTH - 30 withLineHeight:0];
        if (self.backSelfHeight) {
            self.backSelfHeight(shouldHeight - 14.3);
        }
    }
    if (model.doctorInfo.length > 0) {
        CGFloat shouldHeight = [doctorIntroduceTitleLabelText getShouldHeightWithContent:doctorIntroduceTitleLabelText withFont:self.doctorGoodAt.font withWidth:SCREENWIDTH - 30 withLineHeight:0];
        
        if (shouldHeight > 29) {
            if (self.backSelfHeight) {
                self.backSelfHeight(30);
            }
        }
        else
        {
            [self.arrowButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(.1);
            }];
            if (self.backSelfHeight) {
        
                self.backSelfHeight(10);
            }
        }
        
        
        
    }
    else
    {
        [self.arrowButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(.1);
        }];
        if (self.backSelfHeight) {
            self.backSelfHeight(0);
        }
    }
    
   
    

}

- (void)openMoreText
{
    self.arrowButton.selected = !self.arrowButton.selected;
    NSString *doctorIntroduceTitleLabelText =  [NSString stringWithFormat:@"职业经历：%@",ISNIL(self.model.doctorInfo)];

    if (self.arrowButton.selected) {
        self.doctorIntroduceTitleLabel.numberOfLines = 0;

        CGFloat shouldHeight = [doctorIntroduceTitleLabelText getShouldHeightWithContent:doctorIntroduceTitleLabelText withFont:self.doctorGoodAt.font withWidth:SCREENWIDTH - 30 withLineHeight:0];
        if (self.backSelfHeight) {
            self.backSelfHeight(shouldHeight - 29);
        }
        
    }
    else
    {
        self.doctorIntroduceTitleLabel.numberOfLines = 2;

        CGFloat shouldHeight = [doctorIntroduceTitleLabelText getShouldHeightWithContent:doctorIntroduceTitleLabelText withFont:self.doctorGoodAt.font withWidth:SCREENWIDTH - 30 withLineHeight:0];

        if (self.backSelfHeight) {
            self.backSelfHeight(29 - shouldHeight);
        }

    }
}

- (UIImageView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIImageView alloc]init];
        [self addSubview:_headerView];
    }
    return _headerView;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}
- (UILabel *)doctorTypeLabel
{
    if (!_doctorTypeLabel) {
        _doctorTypeLabel = [[UILabel alloc]init];
        _doctorTypeLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _doctorTypeLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_doctorTypeLabel];
    }
    return _doctorTypeLabel;
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
        [self addSubview:_doctorInLabel];
    }
    return _doctorInLabel;
}

- (UILabel *)hospital
{
    if (!_hospital) {
        _hospital = [[UILabel alloc]init];
        _hospital.textColor = [UIColor colorWithHexString:@"333333"];
        _hospital.font = [UIFont systemFontOfSize:12];
        [self addSubview:_hospital];
    }
    return _hospital;
}
-(UILabel *)recommended
{
    if (!_recommended) {
        _recommended = [[UILabel alloc]init];
        _recommended.textColor = [UIColor colorWithHexString:@"6A70FD"];
        _recommended.textAlignment = NSTextAlignmentRight;
        _recommended.font = [UIFont systemFontOfSize:12];
        [self addSubview:_recommended];
    }
    return _recommended;
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

- (UILabel *)doctorGoodAt
{
    if (!_doctorGoodAt) {
        _doctorGoodAt = [[UILabel alloc]init];
        _doctorGoodAt.textColor = [UIColor colorWithHexString:@"999999"];
        _doctorGoodAt.font = [UIFont systemFontOfSize:12];
        _doctorGoodAt.numberOfLines = 0;
        [self addSubview:_doctorGoodAt];
    }
    return _doctorGoodAt;
}

- (UILabel *)doctorIntroduceTitleLabel
{
    if (!_doctorIntroduceTitleLabel) {
        _doctorIntroduceTitleLabel = [[UILabel alloc]init];
        _doctorIntroduceTitleLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _doctorIntroduceTitleLabel.font = [UIFont systemFontOfSize:12];
        _doctorIntroduceTitleLabel.numberOfLines = 0;
        [self addSubview:_doctorIntroduceTitleLabel];
    }
    return _doctorIntroduceTitleLabel;
}

- (UILabel *)firstDeparLabel
{
    if (!_firstDeparLabel) {
        _firstDeparLabel = [[UILabel alloc]init];
        _firstDeparLabel.textAlignment = NSTextAlignmentCenter;
        _firstDeparLabel.font = [UIFont systemFontOfSize:9];
        _firstDeparLabel.textColor = [UIColor colorWithHexString:@"6A70FD"];
        _firstDeparLabel.layer.cornerRadius = 2;
        _firstDeparLabel.layer.borderWidth = 1;
        _firstDeparLabel.layer.borderColor = [UIColor colorWithHexString:@"6A70FD"].CGColor;
        [self addSubview:_firstDeparLabel];
    }
    return _firstDeparLabel;
}
- (UILabel *)doctorScoreValueLabel
{
    if (!_doctorScoreValueLabel) {
        _doctorScoreValueLabel = [[UILabel alloc]init];
        _doctorScoreValueLabel.textColor = [UIColor colorWithHexString:@"FF6188"];
        _doctorScoreValueLabel.font = [UIFont systemFontOfSize:14];
        _doctorScoreValueLabel.numberOfLines = 0;
        [self addSubview:_doctorScoreValueLabel];
    }
    return _doctorScoreValueLabel;
}

- (UILabel *)commentLabel
{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc]init];
        _commentLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _commentLabel.font = [UIFont systemFontOfSize:9];
        [self addSubview:_commentLabel];
    }
    return _commentLabel;
}
- (UIButton *)arrowButton
{
    if (!_arrowButton) {
        _arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_arrowButton setImage:[UIImage imageNamed:@"ic_yiyuanzhuye_gengduo"] forState:UIControlStateNormal];
        [_arrowButton setImage:[UIImage imageNamed:@"ic_yiyuanzhuye_shouqi"] forState:UIControlStateSelected];
        [_arrowButton addTarget:self action:@selector(openMoreText) forControlEvents:UIControlEventTouchUpInside];
        _arrowButton.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:_arrowButton];
    }
    return _arrowButton;
}

- (UIView *)hospitalView
{
    if (!_hospitalView) {
        _hospitalView = [[UIView alloc]init];
        _hospitalView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_hospitalView];
        
        UIImageView *leftImage = [[UIImageView alloc]init];
        leftImage.image = [UIImage imageNamed:@"hospital_left"];
        [_hospitalView addSubview:leftImage];
        
        [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(19, 19));
            make.left.top.mas_equalTo(15);
            make.centerY.equalTo(self.hospitalView.mas_centerY);
        }];
        
        UILabel *hospitalLabel = [[UILabel alloc]init];
        hospitalLabel.font = [UIFont systemFontOfSize:14];
        hospitalLabel.textColor = [UIColor colorWithHexString:@"333333"];
        hospitalLabel.tag = 10086;
        [_hospitalView addSubview:hospitalLabel];
        [hospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftImage.mas_right).offset(10);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(15);
            make.centerY.equalTo(self.hospitalView.mas_centerY);
        }];
        
        UIView *lineview = [[UIView alloc]init];
        lineview.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
        [_hospitalView addSubview:lineview];
        [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(0);
        }];
        
        UIImageView *rightImage = [[UIImageView alloc]init];
        rightImage.image = [UIImage imageNamed:@"click_right"];
        [_hospitalView addSubview:rightImage];
        [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.hospitalView.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(8, 13));
            make.centerY.equalTo(self.hospitalView.mas_centerY);
        }];
    }
    
    return _hospitalView;
}

- (UIView *)hospitalAdreessView
{
    if (!_hospitalAdreessView) {
        _hospitalAdreessView = [[UIView alloc]init];
        _hospitalAdreessView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_hospitalAdreessView];
        
        UIImageView *leftImage = [[UIImageView alloc]init];
        leftImage.image = [UIImage imageNamed:@"hospital_Distance"];
        [_hospitalAdreessView addSubview:leftImage];
        
        [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(19, 19));
            make.left.top.mas_equalTo(15);
        }];
        
        
        UILabel *hospitalAdreessLabel = [[UILabel alloc]init];
        hospitalAdreessLabel.font = [UIFont systemFontOfSize:14];
        hospitalAdreessLabel.textColor = [UIColor colorWithHexString:@"333333"];
        hospitalAdreessLabel.tag = 10086;
        [_hospitalAdreessView addSubview:hospitalAdreessLabel];
        [hospitalAdreessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftImage.mas_right).offset(10);
            make.top.mas_equalTo(18);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(15);
        }];
        
        
        
        UILabel *hospitalDistance = [[UILabel alloc]init];
        hospitalDistance.font = [UIFont systemFontOfSize:12];
        hospitalDistance.textColor = [UIColor colorWithHexString:@"999999"];
        hospitalDistance.tag = 10087;
        [_hospitalAdreessView addSubview:hospitalDistance];
        
        [hospitalDistance mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hospitalAdreessLabel.mas_left);
            make.right.mas_equalTo(hospitalAdreessLabel.mas_right);
            make.top.mas_equalTo(hospitalAdreessLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(12);
        }];
        
        UIView *lineview = [[UIView alloc]init];
        lineview.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
        [_hospitalAdreessView addSubview:lineview];
        [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(0);
        }];
        
        UIImageView *rightImage = [[UIImageView alloc]init];
        rightImage.image = [UIImage imageNamed:@"click_right"];
        [_hospitalAdreessView addSubview:rightImage];
        [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.hospitalView.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(8, 13));
            make.centerY.equalTo(self.hospitalAdreessView.mas_centerY);
        }];
        
    }
    return _hospitalAdreessView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch.view isEqual:self.hospitalAdreessView] ) {
        [self clickMapAction];
    }
    else if ([touch.view isEqual:self.hospitalView])
    {
        GHNewHospitalViewController *hospital = [[GHNewHospitalViewController alloc]init];
        hospital.hospitalID = self.model.hospitalId;
        [self.viewController.navigationController pushViewController:hospital animated:YES];
    }
}

- (void)clickMapAction {
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"hospitalId"] = self.model.hospitalId;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiHospital withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[response[@"data"][@"hospital"][@"lat"] doubleValue] longitude:[response[@"data"][@"hospital"][@"lng"] doubleValue]];
            
            
            //终点坐标
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择地图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"用iPhone自带地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //当前位置
                MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
                MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
                //传入目的地，会显示在苹果自带地图上面目的地一栏
                toLocation.name = ISNIL(self.model.hospitalName);
                
                
                NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
                NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
                
                //导航方式选择
                [MKMapItem openMapsWithItems:items launchOptions:options];
            }];
            
            [alert addAction:action];
            
            
            if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
            {
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"用高德地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    NSURL *myLocationScheme = [NSURL URLWithString:[[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&t=0",@"掌上优医",coordinate.latitude,coordinate.longitude,ISNIL(self.model.hospitalName)] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    
                    if (@available(iOS 10.0, *)) {
                        //iOS10以后,使用新API
                            [[UIApplication sharedApplication] openURL:myLocationScheme options:@{} completionHandler:^(BOOL success) { NSLog(@"scheme调用结束"); }];
                    
                        
                    } else {
                        //iOS10以前,使用旧API
                        [[UIApplication sharedApplication] openURL:myLocationScheme];
                    }
                    
                    
                }];
                
                [alert addAction:action];
            }
            
            if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
                
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"用百度地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    NSURL *myLocationScheme = [NSURL URLWithString: [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name:%@&mode=driving&coord_type=gcj02",coordinate.latitude, coordinate.longitude, ISNIL(self.model.hospitalName)] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    
                    if (@available(iOS 10.0, *)) {
                        //iOS10以后,使用新API
                        [[UIApplication sharedApplication] openURL:myLocationScheme options:@{} completionHandler:^(BOOL success) { NSLog(@"scheme调用结束"); }];
                        
                    } else {
                        //iOS10以前,使用旧API
                        [[UIApplication sharedApplication] openURL:myLocationScheme];
                    }
                    
                    
                }];
                
                [alert addAction:action];
                
            }
            
            if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
                
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"用腾讯地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    NSURL *myLocationScheme = [NSURL URLWithString: [[NSString stringWithFormat:@"qqmap://map/routeplan?fromcoord=CurrentLocation&type=drive&to=%@&tocoord=%f,%f&policy=1",ISNIL(self.model.hospitalName), coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    
                    if (@available(iOS 10.0, *)) {
                        //iOS10以后,使用新API
                        [[UIApplication sharedApplication] openURL:myLocationScheme options:@{} completionHandler:^(BOOL success) { NSLog(@"scheme调用结束"); }];
                        
                    } else {
                        //iOS10以前,使用旧API
                        [[UIApplication sharedApplication] openURL:myLocationScheme];
                    }
                    
                    
                }];
                
                [alert addAction:action];
                
            }
            
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
                
            }];
            
        }
        
    }];
    
}
@end

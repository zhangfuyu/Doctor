//
//  GHHotHospitalView.m
//  掌上优医
//
//  Created by apple on 2019/10/30.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHotHospitalView.h"
#import "GHNewHospitalViewController.h"

@interface GHHotHospitalView ()

@property (nonatomic , strong) UIImageView *headerimage;

@property (nonatomic , strong) UILabel *namelabel;

@property (nonatomic , strong) UILabel *gradelabel;

@property (nonatomic , strong) UILabel *distancelabel;


@end
@implementation GHHotHospitalView

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
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.17].CGColor;
        // 阴影偏移，默认(0, -3)
        self.layer.shadowOffset = CGSizeMake(0,0);
        // 阴影透明度，默认0
        self.layer.shadowOpacity = 1;
        // 阴影半径，默认3
        self.layer.shadowRadius = 5;
        
       
        [self.headerimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(HScaleHeight(15));
            make.size.mas_equalTo(CGSizeMake(HScaleHeight(60), HScaleHeight(60)));
        }];
        
        [self.namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headerimage.mas_right).offset(HScaleHeight(8.5));
            make.right.mas_equalTo(-HScaleHeight(17));
            make.top.mas_equalTo(self.headerimage.mas_top);
        }];
        
        [self.gradelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.headerimage.mas_bottom);
            make.left.mas_equalTo(self.namelabel.mas_left);
            make.height.mas_equalTo(HScaleHeight(12));
        }];
        
        [self.distancelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.namelabel.mas_right);
            make.bottom.mas_equalTo(self.headerimage.mas_bottom);
            make.height.mas_equalTo(HScaleHeight(12));

        }];
    }
    return self;
}
- (void)setModel:(GHHospitalRecommendedModel *)model
{
    _model = model;

    [self.headerimage sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.headImgUrl)) placeholderImage:[UIImage imageNamed:@"hospital_placeholder"]];
    
    self.namelabel.text = model.hospitalName;
    
    self.gradelabel.text = model.hospitalGrade;
    
    self.distancelabel.text = [NSString stringWithFormat:@"%.1fkm",[model.distance floatValue] / 1000];
    
}
- (UIImageView *)headerimage
{
    if (!_headerimage) {
        _headerimage = [[UIImageView alloc]init];
        [self addSubview:_headerimage];
    }
    return _headerimage;
}
- (UILabel *)namelabel
{
    if (!_namelabel) {
        _namelabel = [[UILabel alloc]init];
        _namelabel.font = HScaleFont(13);
        _namelabel.textColor = [UIColor colorWithHexString:@"333333"];
        _namelabel.numberOfLines = 2;
        [self addSubview:_namelabel];
    }
    return _namelabel;
}
- (UILabel *)gradelabel
{
    if (!_gradelabel) {
        _gradelabel = [[UILabel alloc]init];
        _gradelabel.font = HScaleFont(12);
        _gradelabel.textColor = [UIColor colorWithHexString:@"666666"];
        [self addSubview:_gradelabel];
    }
    return _gradelabel;
}

- (UILabel *)distancelabel
{
    if (!_distancelabel) {
        _distancelabel = [[UILabel alloc]init];
        _distancelabel.font = HScaleFont(12);
        _distancelabel.textColor = [UIColor colorWithHexString:@"999999"];
        _distancelabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_distancelabel];
    }
    return _distancelabel;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    GHNewHospitalViewController *hospital = [[GHNewHospitalViewController alloc]init];
    hospital.hospitalID = self.model.hospitalId;
    [self.viewController.navigationController pushViewController:hospital animated:true];
}
@end

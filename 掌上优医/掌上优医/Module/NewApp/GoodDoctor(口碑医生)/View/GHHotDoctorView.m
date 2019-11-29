//
//  GHHotDoctorView.m
//  掌上优医
//
//  Created by apple on 2019/10/30.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHotDoctorView.h"
#import "GHNewDoctorDetailViewController.h"

@interface GHHotDoctorView ()

@property (nonatomic , strong) UIImageView *headerimage;

@property (nonatomic , strong) UILabel *namelabel;

@property (nonatomic , strong) UILabel *departmentlabel;

@property (nonatomic , strong) UILabel *indexlabel;

@property (nonatomic , strong) UILabel *hospitalLabel;

@property (nonatomic , strong) UIImageView *edgesImage;

@end

@implementation GHHotDoctorView

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
        
        self.backgroundColor = [UIColor colorWithRed:253/255.0 green:253/255.0 blue:253/255.0 alpha:1.0];
        
       self.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.13].CGColor;
      // 阴影偏移，默认(0, -3)
      self.layer.shadowOffset = CGSizeMake(0,0);
      // 阴影透明度，默认0
      self.layer.shadowOpacity = 1;
      // 阴影半径，默认3
      self.layer.shadowRadius = 5;
        
        [self.headerimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleHeight(10));
            make.size.mas_equalTo(CGSizeMake(HScaleHeight(46), HScaleHeight(46)));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [self.namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headerimage.mas_right).offset(HScaleHeight(8));
            make.top.mas_equalTo(self.headerimage.mas_top);
            make.height.mas_equalTo(HScaleHeight(13));
        }];
        
        [self.departmentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.namelabel.mas_right).offset(HScaleHeight(7.5));
            make.bottom.mas_equalTo(self.namelabel.mas_bottom);
            make.height.mas_equalTo(HScaleHeight(10));
            make.right.mas_equalTo(self.mas_right).offset(-HScaleHeight(20));
        }];
        
        [self.hospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.namelabel.mas_left);
            make.bottom.mas_equalTo(self.headerimage.mas_bottom);
            make.right.mas_equalTo(self.mas_right).offset(-HScaleHeight(20));
        }];
        
        [self.edgesImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(HScaleHeight(31.5), HScaleHeight(31.5)));
        }];
        
        [self.indexlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setModel:(GHDoctorRecommendedModel *)model
{
    _model = model;
    [self.headerimage sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.headImgUrl)) placeholderImage:[UIImage imageNamed:@"hospital_placeholder"]];
    
    self.namelabel.text = model.doctorName;
    self.hospitalLabel.text = model.hospitalName;
    self.departmentlabel.text = model.departmentName;
    self.indexlabel.text = [NSString stringWithFormat:@"%@",model.index];
    if (([model.index intValue] == 1)) {
        self.indexlabel.textColor = [UIColor colorWithHexString:@"ED514C"];
    }
    else if ([model.index intValue] == 2)
    {
        self.indexlabel.textColor = [UIColor colorWithHexString:@"FFA845"];
    }
    else if ([model.index intValue] == 3)
    {
        self.indexlabel.textColor = [UIColor colorWithHexString:@"FAD731"];
    }
    else
    {
        
        self.indexlabel.textColor = [UIColor colorWithHexString:@"C2CECE"];
    }
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
        _namelabel.textColor = [UIColor colorWithHexString:@"333333"];
        _namelabel.font = HScaleFont(13);
        [self addSubview:_namelabel];
    }
    return _namelabel;
}

- (UILabel *)departmentlabel
{
    if (!_departmentlabel) {
        _departmentlabel = [[UILabel alloc]init];
        _departmentlabel.textColor = [UIColor colorWithHexString:@"666666"];
        _departmentlabel.font = HScaleFont(10);
        [self addSubview:_departmentlabel];
    }
    return _departmentlabel;
}
- (UILabel *)hospitalLabel
{
    if (!_hospitalLabel) {
        _hospitalLabel = [[UILabel alloc]init];
        _hospitalLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _hospitalLabel.font = HScaleFont(9);
        _hospitalLabel.numberOfLines = 2;
        [self addSubview:_hospitalLabel];
    }
    return _hospitalLabel;
}

- (UILabel *)indexlabel
{
    if (!_indexlabel) {
        _indexlabel = [[UILabel alloc]init];
        _indexlabel.font = HScaleBoldFont(20);
        _indexlabel.textAlignment = NSTextAlignmentCenter;
        [self.edgesImage addSubview:_indexlabel];
    }
    return _indexlabel;
}
- (UIImageView *)edgesImage
{
    if (!_edgesImage) {
        _edgesImage = [[UIImageView alloc]init];
        _edgesImage.image = [UIImage imageNamed:@"doctor_edges"];
        [self addSubview:_edgesImage];
    }
    return _edgesImage;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    GHNewDoctorDetailViewController *vc = [[GHNewDoctorDetailViewController alloc] init];
    vc.doctorId = self.model.doctorId;
    [self.viewController.navigationController pushViewController:vc animated:true];
}
@end

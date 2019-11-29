//
//  GHMapHospitalAnnotationView.m
//  掌上优医
//
//  Created by GH on 2019/5/23.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHMapHospitalAnnotationView.h"
#import "GHHospitalPointAnnotation.h"

@interface GHMapHospitalAnnotationView ()

@property (nonatomic, strong, readwrite) GHMapHospitalCalloutView *calloutView;

@end

@implementation GHMapHospitalAnnotationView

//- (instancetype)initWithFrame:(CGRect)frame {
//
//    if (self = [super initWithFrame:frame]) {
//
//        [self setupUI];
//
//    }
//    return self;
//
//}

//- (void)setSelected:(BOOL)selected {
//
//    [super setSelected:selected];
//
//    if (selected == true) {
//        self.titleLabel.hidden = true;
//    } else {
//        self.titleLabel.hidden = false;
//    }
//
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected == true) {
        self.titleLabel.hidden = true;
        self.iconImageView.image = [UIImage imageNamed:@"ic_fujinyiyuan_dizhi_selscted"];
    } else {
        self.titleLabel.hidden = false;
        self.iconImageView.image = [UIImage imageNamed:@"ic_fujinyiyuan_dizhi_unsected"];
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            self.calloutView = [[GHMapHospitalCalloutView alloc] initWithFrame:CGRectMake(0, 0, 160, 70)];

        }

        self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                              -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        
        CGPoint point = [self convertRect:self.superview.frame toView:self.window].origin;
        
        if (point.x > SCREENWIDTH * .5) {
            
            [self.calloutView setupDirection:1];
            
            self.calloutView.mj_x -= 95;
            self.calloutView.mj_y += 5;
            
        } else {
            
            [self.calloutView setupDirection:0];
            
            self.calloutView.mj_x += 95;
            self.calloutView.mj_y += 5;
            
        }

        
        self.calloutView.model = ((GHHospitalPointAnnotation *)self.annotation).model;
        
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }

    
    [super setSelected:selected animated:animated];
    
//    if (self.selected == selected)
//    {
//        return;
//    }
//


    

    
    
}



- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    iconImageView.image = [UIImage imageNamed:@"ic_fujinyiyuan_dizhi_unsected"];
    [self addSubview:iconImageView];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(17);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(0);
    }];
    self.iconImageView = iconImageView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = kDefaultBlueColor;
    titleLabel.layer.cornerRadius = 5;
    titleLabel.layer.masksToBounds = true;
    titleLabel.font = [UIFont systemFontOfSize:7];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    self.titleLabel = titleLabel;
    
}

@end

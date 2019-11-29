//
//  GHMapHospitalCalloutView.m
//  掌上优医
//
//  Created by GH on 2019/5/23.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHMapHospitalCalloutView.h"
#import <MapKit/MapKit.h>
#import "GHHospitalDetailViewController.h"
//#define kPortraitMargin     5
//#define kPortraitWidth      70
//#define kPortraitHeight     50
//
//#define kTitleWidth         120
//#define kTitleHeight        20
//
//#define kArrorHeight        10

@interface GHMapHospitalCalloutView ()

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIImageView *hospitalHeadPortraitImageView;

@property (nonatomic, strong) UILabel *hospitalNameLabel;

@property (nonatomic, strong) UILabel *hospitalAddressLabel;


@end

@implementation GHMapHospitalCalloutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:bgImageView];
    
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    self.bgImageView = bgImageView;
    
    UIView *hospitalcontentView = [[UIView alloc] init];
    hospitalcontentView.backgroundColor = [UIColor clearColor];
    hospitalcontentView.layer.cornerRadius = 4;
    hospitalcontentView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    hospitalcontentView.layer.shadowOffset = CGSizeMake(0,2);
    hospitalcontentView.layer.shadowOpacity = 1;
    hospitalcontentView.layer.shadowRadius = 4;
    [self addSubview:hospitalcontentView];
    
    [hospitalcontentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-5);
        make.top.mas_equalTo(0);
    }];
    self.contentView = hospitalcontentView;
    
    UIImageView *hospitalHeadPortraitImageView = [[UIImageView alloc] init];
    hospitalHeadPortraitImageView.contentMode = UIViewContentModeScaleAspectFill;
    hospitalHeadPortraitImageView.layer.cornerRadius = 2;
    hospitalHeadPortraitImageView.layer.masksToBounds = true;
    hospitalHeadPortraitImageView.backgroundColor = kDefaultGaryViewColor;
    [hospitalcontentView addSubview:hospitalHeadPortraitImageView];
    
    [hospitalHeadPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(7);
        make.width.height.mas_equalTo(25);
        make.left.mas_equalTo(7);
    }];
    self.hospitalHeadPortraitImageView = hospitalHeadPortraitImageView;
    
    
    UILabel *hospitalNameLabel = [[UILabel alloc] init];
    hospitalNameLabel.textColor = kDefaultBlackTextColor;
    hospitalNameLabel.font = H10;
    hospitalNameLabel.numberOfLines = 0;
    [hospitalcontentView addSubview:hospitalNameLabel];
    
    [hospitalNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hospitalHeadPortraitImageView.mas_right).offset(10);
        make.right.mas_equalTo(-7);
        make.top.bottom.mas_equalTo(hospitalHeadPortraitImageView);
    }];
    self.hospitalNameLabel = hospitalNameLabel;
    
    
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    iconImageView.image = [UIImage imageNamed:@"ic_fujinyiyuan_dizhi_unsected"];
    [hospitalcontentView addSubview:iconImageView];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(8);
        make.left.mas_equalTo(hospitalHeadPortraitImageView);
        make.top.mas_equalTo(hospitalHeadPortraitImageView.mas_bottom).offset(5);
    }];
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.font = [UIFont systemFontOfSize:9];
    addressLabel.textColor = kDefaultBlackTextColor;
    [hospitalcontentView addSubview:addressLabel];
    
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImageView.mas_right).offset(5);
        make.top.mas_equalTo(iconImageView);
        make.bottom.mas_equalTo(iconImageView);
        make.right.mas_equalTo(hospitalNameLabel);
    }];
    self.hospitalAddressLabel = addressLabel;
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [hospitalcontentView addSubview:actionButton];
    
    [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    [actionButton addTarget:self action:@selector(clickDetailAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *navigationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    navigationButton.titleLabel.font = [UIFont systemFontOfSize:9];
    [navigationButton setTitleColor:kDefaultGrayTextColor forState:UIControlStateNormal];
    [navigationButton setTitle:@"导航  " forState:UIControlStateNormal];
    navigationButton.transform = CGAffineTransformMakeScale(-1, 1);
    navigationButton.titleLabel.transform = CGAffineTransformMakeScale(-1, 1);
    navigationButton.imageView.transform = CGAffineTransformMakeScale(-1, 1);
    [navigationButton setImage:[UIImage imageNamed:@"ic_ fujinyiyuan_daohang"] forState:UIControlStateNormal];
    [hospitalcontentView addSubview:navigationButton];
    
    [navigationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(0);
        
    }];
    
    [navigationButton addTarget:self action:@selector(clickLocationAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickDetailAction {
    
    GHHospitalDetailViewController *vc = [[GHHospitalDetailViewController alloc] init];
    vc.model = self.model;
    [self.viewController.navigationController pushViewController:vc animated:true];
    
}

- (void)clickLocationAction {
    
    if (self.model.hospitalAddress.length == 0) {
        return;
    }
    
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[self.model.lat doubleValue] longitude:[self.model.lng doubleValue]];
    
    //终点坐标
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择地图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"用iPhone自带地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //当前位置
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
        //传入目的地，会显示在苹果自带地图上面目的地一栏
        toLocation.name = ISNIL(self.model.hospitalName);
        //导航方式选择
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
    }];
    
    [alert addAction:action];
    
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"用高德地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSURL *myLocationScheme = [NSURL URLWithString:[[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&t=0",@"掌上优医",coordinate.latitude,coordinate.longitude,ISNIL(self.model.hospitalName)] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            if ([[UIDevice currentDevice].systemVersion integerValue] >= 10) {
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
            
            if ([[UIDevice currentDevice].systemVersion integerValue] >= 10) {
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
            
            if ([[UIDevice currentDevice].systemVersion integerValue] >= 10) {
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

- (void)setModel:(GHSearchHospitalModel *)model {
    
    _model = model;
    
    [self.hospitalHeadPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.profilePhoto)) placeholderImage:[UIImage imageNamed:@"hospital_placeholder"]];
    self.hospitalNameLabel.text = self.model.hospitalName;
    self.hospitalAddressLabel.text = self.model.hospitalAddress;

}

- (void)setupDirection:(NSUInteger)direction {
    
    if (direction == 0) {
        
        self.bgImageView.image = [UIImage imageNamed:@"bgn_fujinyiyuan_tanhuakuang_left"];
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(10);
        }];
        
    } else {
        
        self.bgImageView.image = [UIImage imageNamed:@"bgn_fujinyiyuan_tanhuakuang_right"];
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(0);
        }];
        
    }
    
}


@end

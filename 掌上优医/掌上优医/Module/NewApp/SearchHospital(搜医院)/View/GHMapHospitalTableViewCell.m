//
//  GHMapHospitalTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/5/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHMapHospitalTableViewCell.h"
#import <MapKit/MapKit.h>

@interface GHMapHospitalTableViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *distanceLabel;

@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UILabel *selectDotLabel;

@end

@implementation GHMapHospitalTableViewCell

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
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kDefaultBlackTextColor;
    nameLabel.font = H17;
    [self.contentView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(-70);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(18);
    }];
    self.nameLabel = nameLabel;
    
    UILabel *distanceLabel = [[UILabel alloc] init];
    distanceLabel.textColor = kDefaultBlackTextColor;
    distanceLabel.font = H14;
    distanceLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:distanceLabel];
    
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-13);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(18);
    }];
    self.distanceLabel = distanceLabel;
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.font = H13;
    addressLabel.textColor = kDefaultGrayTextColor;
    [self.contentView addSubview:addressLabel];
    
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(-70);
        make.height.mas_equalTo(14);
        make.bottom.mas_equalTo(-15);
    }];
    self.addressLabel = addressLabel;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [self.contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(15);
    }];
    
    UIButton *navigationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    navigationButton.titleLabel.font = H14;
    [navigationButton setTitleColor:kDefaultGrayTextColor forState:UIControlStateNormal];
    [navigationButton setTitle:@"导航 " forState:UIControlStateNormal];
    navigationButton.transform = CGAffineTransformMakeScale(-1, 1);
    navigationButton.titleLabel.transform = CGAffineTransformMakeScale(-1, 1);
    navigationButton.imageView.transform = CGAffineTransformMakeScale(-1, 1);
    [navigationButton setImage:[UIImage imageNamed:@"ic_fujinyiyuan_yiyuandaohang"] forState:UIControlStateNormal];
    [self.contentView addSubview:navigationButton];
    
    [navigationButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(35);
        make.centerY.mas_equalTo(addressLabel);
        
    }];
    [navigationButton addTarget:self action:@selector(clickLocationAction) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    
    self.nameLabel.text = ISNIL(model.hospitalName);
    self.distanceLabel.text = [NSString stringWithFormat:@"%.1fkm",[ISNIL(model.distance) floatValue] / 1000];//[ISNIL(model.distance) getKillMeter];
    self.addressLabel.text = ISNIL(model.hospitalAddress);
    
}

@end

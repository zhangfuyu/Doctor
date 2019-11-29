//
//  GHDoctorInfoErrorViewController.m
//  掌上优医
//
//  Created by GH on 2018/11/5.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHDoctorInfoErrorViewController.h"

#import "GHTextView.h"
#import "JFMorePhotoView.h"

#import "UIButton+touch.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

#import "GHHospitalChooseAddressViewController.h"

#import "GHDoctorAddTimeView.h"

#import "GHChooseDepartmentViewController.h"

#import "GHInfoErrorProgressViewController.h"

#import "GHChooseDoctorHospitalViewController.h"

@interface GHDoctorInfoErrorViewController ()<UITextViewDelegate, GHHospitalChooseAddressViewControllerDelegate, MAMapViewDelegate, GHChooseDepartmentViewControllerDelegate, GHChooseDoctorHospitalViewControllerDelegate>

@property (nonatomic, strong) JFMorePhotoView *doctorPhotoView;

@property (nonatomic, strong) GHTextView *doctorNameTextView;

@property (nonatomic, strong) NSMutableArray *positionButtonArray;

@property (nonatomic, strong) NSMutableArray *typeButtonArray;

@property (nonatomic, strong) GHTextView *hospitalNameTextView;

@property (nonatomic, strong) GHTextView *hospitalAddressTextView;

@property (nonatomic, strong) GHTextView *doctorIntroduceTextView;

@property (nonatomic, strong) GHTextView *doctorInfoTextView;

/**
 <#Description#>
 */
@property (nonatomic, strong) MAMapView *mapView;

/**
 <#Description#>
 */
@property (nonatomic, strong) MAPointAnnotation *point;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHDoctorAddTimeView *addTimeView;

@property (nonatomic, strong) UILabel *departmentLabel;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSString *departmentSecondId;

@property (nonatomic, strong) NSString *departmentFirstId;

@property (nonatomic, strong) NSString *departmentSecondName;

@property (nonatomic, strong) NSString *departmentFirstName;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIView *submitSuccessView;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHSearchHospitalModel *hospitalModel;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHDataCollectionDoctorModel *dataCollectionModel;

@end

@implementation GHDoctorInfoErrorViewController

- (UIView *)submitSuccessView {
    
    if (!_submitSuccessView) {
        
        _submitSuccessView = [[UIView alloc] init];
        _submitSuccessView.backgroundColor = kDefaultGaryViewColor;
        [self.view addSubview:_submitSuccessView];
        
        [_submitSuccessView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.contentMode = UIViewContentModeCenter;
        iconImageView.image = [UIImage imageNamed:@"btn_tijiaochenggong"];
        [_submitSuccessView addSubview:iconImageView];
        
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(74);
            make.left.mas_equalTo(SCREENWIDTH * .5 - 37);
            make.top.mas_equalTo(60);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = H18;
        titleLabel.textColor = kDefaultBlackTextColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"提交成功";
        [_submitSuccessView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(iconImageView.mas_bottom).offset(25);
        }];
        
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.font = H17;
        descLabel.textColor = kDefaultGrayTextColor;
        descLabel.textAlignment = NSTextAlignmentCenter;
        descLabel.text = @"感谢您的反馈，我们将尽快核实!";
        [_submitSuccessView addSubview:descLabel];
        
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(titleLabel.mas_bottom).offset(15);
        }];
        
    }
    
    return _submitSuccessView;
    
}


- (NSMutableArray *)typeButtonArray {
    
    if (!_typeButtonArray) {
        _typeButtonArray = [[NSMutableArray alloc] init];
    }
    return _typeButtonArray;
    
}

- (NSMutableArray *)positionButtonArray {
    
    if (!_positionButtonArray) {
        _positionButtonArray = [[NSMutableArray alloc] init];
    }
    return _positionButtonArray;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"医生报错";
    
    [self setupUI];
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiJudgeDoctorInfoError withParameter:@{@"type":@(1)} withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
           
            
            if (![response[@"data"][@"flag"] boolValue]) {
                
                self.navigationItem.title = @"提交成功";
                self.submitSuccessView.hidden = false;
                
                [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiDoctorInfoErrorDetil withParameter:@{@"type":@(1)} withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                    
                    if (isSuccess) {
                        
                        
                        NSArray *dataarry = response[@"data"];
                        NSDictionary *lastdic = [dataarry lastObject];
                        if (lastdic) {
                            GHDataCollectionDoctorModel *model = [[GHDataCollectionDoctorModel alloc] initWithDictionary:lastdic[@"reportingInfo"] error:nil];
                            
                            
                            if ([model.doctorId isEqualToString:self.realModel.modelId]) {
                                
                                self.dataCollectionModel = model;
                                
                                [self addRightButton:@selector(clickProgressAction) title:@"核实进度 "];
                                
                                
                            }
                        }
                        
                    }
                    
                }];
            }
            else
            {
                NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
                params[@"hospitalId"] = self.realModel.hospitalId;
                
                [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiHospital withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                    
                    if (isSuccess) {
                        
                        CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[response[@"data"][@"hospital"][@"lat"] doubleValue] longitude:[response[@"data"][@"hospital"][@"lng"] doubleValue]];
                        
                        //终点坐标
                        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
                        
                        self.mapView.centerCoordinate = coordinate;
                        
                        MAPointAnnotation *point = [[MAPointAnnotation alloc] init];
                        point.coordinate = coordinate;
                        
                        self.point = point;
                        
                        [self.mapView addAnnotation:point];
                        
                        [self updateUI];
                        
                    }
                    
                }];
                
            }
        }
    }];
    
    
   
    
    
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.bounces = false;
    scrollView.showsVerticalScrollIndicator = false;
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(Height_StatusBar);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [self.view addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
        make.height.greaterThanOrEqualTo(@0.f);//此处保证容器View高度的动态变化 大于等于0.f的高度
    }];
    
    UIView *imageContentView = [[UIView alloc] init];
    imageContentView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:imageContentView];
    
    [imageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(190);
    }];
    
    UILabel *doctorImageTitleLabel = [[UILabel alloc] init];
    doctorImageTitleLabel.font = H16;
    doctorImageTitleLabel.textColor = kDefaultBlackTextColor;
    doctorImageTitleLabel.text = @"医生图片";
    [imageContentView addSubview:doctorImageTitleLabel];
    
    [doctorImageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(0);
    }];
    
    UILabel *doctorImageDescLabel = [[UILabel alloc] init];
    doctorImageDescLabel.font = H13;
    doctorImageDescLabel.textColor = kDefaultGrayTextColor;
    doctorImageDescLabel.text = @"仅限制png、JPG格式";
    [imageContentView addSubview:doctorImageDescLabel];
    
    [doctorImageDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(85);
        make.height.mas_equalTo(35);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UILabel *doctorHeaderImageTitleLabel = [[UILabel alloc] init];
    doctorHeaderImageTitleLabel.font = H15;
    doctorHeaderImageTitleLabel.textColor = kDefaultGrayTextColor;
    doctorHeaderImageTitleLabel.text = @"上传医生图片";
    [imageContentView addSubview:doctorHeaderImageTitleLabel];
    
    [doctorHeaderImageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(45);
    }];
    
    JFMorePhotoView *doctorHeaderPhotoView = [[JFMorePhotoView alloc] initWithCount:6];
    doctorHeaderPhotoView.canAddCount = 1;
    doctorHeaderPhotoView.fileType = @"doctorPic";
    [imageContentView addSubview:doctorHeaderPhotoView];
    self.doctorPhotoView = doctorHeaderPhotoView;
    
    [doctorHeaderPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(doctorHeaderImageTitleLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(90);
    }];
    
    UILabel *lineLabel1 = [[UILabel alloc] init];
    lineLabel1.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel1];
    
    [lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(imageContentView.mas_bottom);
    }];
    
    
    UIView *nameContentView = [[UIView alloc] init];
    nameContentView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:nameContentView];
    
    [nameContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel1.mas_bottom);
        make.height.mas_equalTo(76);
    }];
    
    UILabel *doctorNameTitleLabel = [[UILabel alloc] init];
    doctorNameTitleLabel.font = H16;
    doctorNameTitleLabel.textColor = kDefaultBlackTextColor;
    doctorNameTitleLabel.text = @"医生姓名";
    [nameContentView addSubview:doctorNameTitleLabel];
    
    [doctorNameTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(20);
    }];
    
    GHTextView *textView = [[GHTextView alloc] initWithFrame:CGRectMake(106, 12, SCREENWIDTH - 106 - 41, 50)];
    textView.font = H16;
    textView.textColor = kDefaultBlackTextColor;
    textView.backgroundColor = [UIColor whiteColor];
    textView.bounces = false;
    [nameContentView addSubview:textView];
    
    self.doctorNameTextView = textView;
    
    UIButton *doctorNameCleanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doctorNameCleanButton setImage:[UIImage imageNamed:@"ic_yiyuanbaocuo_quxiao"] forState:UIControlStateNormal];
    [nameContentView addSubview:doctorNameCleanButton];
    
    [doctorNameCleanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(42);
        make.right.mas_equalTo(-5);
        make.centerY.mas_equalTo(doctorNameTitleLabel);
    }];
    [doctorNameCleanButton addTarget:self action:@selector(clickDoctorNameAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *lineLabel2 = [[UILabel alloc] init];
    lineLabel2.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel2];
    
    [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(nameContentView.mas_bottom);
    }];
    
    UIView *chooseContentView = [[UIView alloc] init];
    chooseContentView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:chooseContentView];
    
    [chooseContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel2.mas_bottom);
        make.height.mas_equalTo(280);
    }];
    
    NSArray *typeArray = @[@"中医", @"西医", @"中西医结合"];
//    NSArray *positionArray = @[@"主任医师", @"副主任医师", @"主治医师", @"住院医师", @"普通医师"];
    NSArray *positionArray = @[@"主任医师", @"副主任医师", @"主治医师", @"医师"];
    
    NSArray *titleArray = @[@"医生职称", @"医生类型"];
    NSArray *dataArray = @[positionArray, typeArray];
    
    for (NSInteger index = 0; index < dataArray.count; index++) {
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = H15;
        titleLabel.textColor = kDefaultBlackTextColor;
        titleLabel.text = [titleArray objectOrNilAtIndex:index];
        [chooseContentView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(17);
        }];
        
        NSArray *array = [dataArray objectOrNilAtIndex:index];
        
        for (NSInteger indexY = 0; indexY < array.count; indexY++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
            [button setTitleColor:kDefaultBlueColor forState:UIControlStateSelected];
            [button setTitle:ISNIL([array objectOrNilAtIndex:indexY]) forState:UIControlStateNormal];
            
            
            button.titleLabel.font = H14;
            button.layer.cornerRadius = 5;
            button.layer.masksToBounds = true;
            button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
            button.backgroundColor = [UIColor whiteColor];
            button.layer.borderWidth = 0.5;
            button.isIgnore = true;
            
            [button setBackgroundColor:[UIColor clearColor]];
            
            [chooseContentView addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(32);
                make.width.mas_equalTo((SCREENWIDTH - 30 - 30) / 3);
                make.left.mas_equalTo(17 + (indexY % 3) * ((SCREENWIDTH - 30 - 30) / 3 + 13));
                make.top.mas_equalTo(titleLabel.mas_bottom).offset((indexY / 3) * (30 + 17) + 30);
                
            }];
            
            if (index == 0) {
                
                button.tag = indexY;
                [self.positionButtonArray addObject:button];
                
            } else if (index == 1) {
                
                button.tag = 10 + indexY;
                [self.typeButtonArray addObject:button];
                
            }
            
            [button addTarget:self action:@selector(clickTagAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        if (index == 0) {
            
            [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(30);
            }];
            
        } else if (index == 1) {
            
            [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(170);
            }];
            
        }
        
    }
    
    UILabel *lineLabel3 = [[UILabel alloc] init];
    lineLabel3.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel3];
    
    [lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(chooseContentView.mas_bottom);
    }];
    
    
    UIView *addressContentView = [[UIView alloc] init];
    addressContentView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:addressContentView];
    
    [addressContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel3.mas_bottom);
    }];
    
    UILabel *addressTitleLabel = [[UILabel alloc] init];
    addressTitleLabel.textColor = kDefaultBlackTextColor;
    addressTitleLabel.font = HB18;
    addressTitleLabel.text = @"出诊地点";
    [addressContentView addSubview:addressTitleLabel];
    
    [addressTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(60);
        make.top.mas_equalTo(0);
    }];
    
    UILabel *hospitalNameTitleLabel = [[UILabel alloc] init];
    hospitalNameTitleLabel.font = H16;
    hospitalNameTitleLabel.textColor = kDefaultBlackTextColor;
    hospitalNameTitleLabel.text = @"医院名称";
    [addressContentView addSubview:hospitalNameTitleLabel];
    
    [hospitalNameTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(60);
    }];
    
    GHTextView *hospitalNameTextView = [[GHTextView alloc] initWithFrame:CGRectMake(106, 52, SCREENWIDTH - 106 - 41, 50)];
    hospitalNameTextView.font = H16;
    hospitalNameTextView.textColor = kDefaultBlackTextColor;
    hospitalNameTextView.backgroundColor = [UIColor whiteColor];
    hospitalNameTextView.bounces = false;
    hospitalNameTextView.userInteractionEnabled = false;
    [addressContentView addSubview:hospitalNameTextView];
    
    self.hospitalNameTextView = hospitalNameTextView;
    
    
    UILabel *linelineLabel1 = [[UILabel alloc] init];
    linelineLabel1.backgroundColor = kDefaultLineViewColor;
    [addressContentView addSubview:linelineLabel1];
    
    [linelineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(104);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(hospitalNameTextView.mas_bottom).offset(5);
    }];
    
    
    UILabel *hospitalAddressDescLabel = [[UILabel alloc] init];
    hospitalAddressDescLabel.font = H16;
    hospitalAddressDescLabel.textColor = kDefaultBlackTextColor;
    hospitalAddressDescLabel.text = @"出诊地址";
    [addressContentView addSubview:hospitalAddressDescLabel];
    
    [hospitalAddressDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(140);
    }];
    
    GHTextView *hospitalAddressTextView = [[GHTextView alloc] initWithFrame:CGRectMake(106, 132, SCREENWIDTH - 106 - 54, 50)];
    hospitalAddressTextView.font = H16;
    hospitalAddressTextView.textColor = kDefaultGrayTextColor;
    hospitalAddressTextView.backgroundColor = [UIColor whiteColor];
    //    hospitalAddressTextView.scrollEnabled = false;
    hospitalAddressTextView.bounces = false;
    hospitalAddressTextView.userInteractionEnabled = false;
    [addressContentView addSubview:hospitalAddressTextView];
    
    self.hospitalAddressTextView = hospitalAddressTextView;
    
    
    UIView *mapBGView = [[UIView alloc] initWithFrame:CGRectMake(20, 197, SCREENWIDTH - 40, 120)];
    mapBGView.layer.masksToBounds = true;
    [addressContentView addSubview:mapBGView];
    
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:mapBGView.bounds];
    self.mapView.delegate = self;
    [mapBGView addSubview:self.mapView];
    
    self.mapView.showsScale = false;
    self.mapView.scrollEnabled = false;
    self.mapView.zoomEnabled = false;
    self.mapView.showsCompass = false;
    self.mapView.zoomLevel = 15;
    
    
    UIButton *hospitalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addressContentView addSubview:hospitalButton];
    
    [hospitalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(hospitalNameTextView);
        make.bottom.mas_equalTo(mapBGView);
    }];
    [hospitalButton addTarget:self action:@selector(clickHospitalNameAction) forControlEvents:UIControlEventTouchUpInside];

    
    UILabel *doctorTimeTitleLabel = [[UILabel alloc] init];
    doctorTimeTitleLabel.font = H16;
    doctorTimeTitleLabel.textColor = kDefaultBlackTextColor;
    doctorTimeTitleLabel.text = @"出诊时间";
    [addressContentView addSubview:doctorTimeTitleLabel];
    
    [doctorTimeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(mapBGView.mas_bottom).offset(20);
    }];
    
    GHDoctorAddTimeView *addTimeView = [[GHDoctorAddTimeView alloc] init];
    
    [addressContentView addSubview:addTimeView];
    
    [addTimeView setupTimeArray:[self.realModel.diagnosisTime componentsSeparatedByString:@","]];

    self.addTimeView = addTimeView;
    
    
    [addressContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(addTimeView.mas_bottom).offset(20);
    }];
    
    UILabel *lineLabel4 = [[UILabel alloc] init];
    lineLabel4.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel4];
    
    [lineLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(addressContentView.mas_bottom);
    }];
    
    UIView *departmentContentView = [[UIView alloc] init];
    departmentContentView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:departmentContentView];
    
    [departmentContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel4.mas_bottom);
        make.height.mas_equalTo(80);
    }];
    
    UILabel *departmentTitleLabel = [[UILabel alloc] init];
    departmentTitleLabel.font = H16;
    departmentTitleLabel.textColor = kDefaultBlackTextColor;
    departmentTitleLabel.text = @"出诊科室";
    [departmentContentView addSubview:departmentTitleLabel];
    
    [departmentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(80);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(0);
    }];
    
    UILabel *departmentLabel = [[UILabel alloc] init];
    departmentLabel.font = H14;
    departmentLabel.textColor = kDefaultBlackTextColor;
    departmentLabel.textAlignment = NSTextAlignmentRight;
    [departmentContentView addSubview:departmentLabel];
    
    [departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(90);
        make.height.mas_equalTo(80);
        make.right.mas_equalTo(-45);
        make.top.mas_equalTo(0);
    }];
    self.departmentLabel = departmentLabel;
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.contentMode = UIViewContentModeCenter;
    arrowImageView.image = [UIImage imageNamed:@"personcenter_right_arrow"];
    arrowImageView.backgroundColor = [UIColor whiteColor];
    [departmentContentView addSubview:arrowImageView];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.width.height.mas_equalTo(16);
        make.centerY.mas_equalTo(departmentLabel.mas_centerY);
    }];
    
    UIButton *departmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [departmentContentView addSubview:departmentButton];
    
    [departmentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    [departmentButton addTarget:self action:@selector(clickDepartmentAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lineLabel5 = [[UILabel alloc] init];
    lineLabel5.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel5];
    
    [lineLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(departmentContentView.mas_bottom);
    }];
    
    UIView *infoContentView = [[UIView alloc] init];
    infoContentView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:infoContentView];
    
    [infoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel5.mas_bottom);
        make.height.mas_equalTo(465);
    }];
    
    UILabel *doctorGoodAtTitleLabel = [[UILabel alloc] init];
    doctorGoodAtTitleLabel.font = H16;
    doctorGoodAtTitleLabel.textColor = kDefaultBlackTextColor;
    doctorGoodAtTitleLabel.text = @"医生擅长";
    [infoContentView addSubview:doctorGoodAtTitleLabel];
    
    [doctorGoodAtTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(15);
    }];
    
    GHTextView *intrudeTextView = [[GHTextView alloc] initWithFrame:CGRectMake(16, 55, SCREENWIDTH - 32, 150)];
    intrudeTextView.font = H16;
    intrudeTextView.layer.borderColor = kDefaultGaryViewColor.CGColor;
    intrudeTextView.layer.borderWidth = 1;
    intrudeTextView.textColor = kDefaultBlackTextColor;
    intrudeTextView.backgroundColor = [UIColor whiteColor];
    [infoContentView addSubview:intrudeTextView];
    
    self.doctorIntroduceTextView = intrudeTextView;
    
    
    UILabel *doctorInfoTitleLabel = [[UILabel alloc] init];
    doctorInfoTitleLabel.font = H16;
    doctorInfoTitleLabel.textColor = kDefaultBlackTextColor;
    doctorInfoTitleLabel.text = @"职业经历";
    [infoContentView addSubview:doctorInfoTitleLabel];
    
    [doctorInfoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(230);
    }];
    
    GHTextView *doctorInfoTextView = [[GHTextView alloc] initWithFrame:CGRectMake(16, 275, SCREENWIDTH - 32, 150)];
    doctorInfoTextView.font = H16;
    doctorInfoTextView.layer.borderColor = kDefaultGaryViewColor.CGColor;
    doctorInfoTextView.layer.borderWidth = 1;
    doctorInfoTextView.textColor = kDefaultBlackTextColor;
    doctorInfoTextView.backgroundColor = [UIColor whiteColor];
    [infoContentView addSubview:doctorInfoTextView];
    
    self.doctorInfoTextView = doctorInfoTextView;
    
    
    
    
    UILabel *lineLabel6 = [[UILabel alloc] init];
    lineLabel6.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel6];
    
    [lineLabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(infoContentView.mas_bottom);
    }];
    
    UIView *submitContentView = [[UIView alloc] init];
    submitContentView.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:submitContentView];
    
    [submitContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel6.mas_bottom);
        make.height.mas_equalTo(90);
    }];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.backgroundColor = kDefaultBlueColor;
    submitButton.titleLabel.font = H18;
    submitButton.layer.cornerRadius = 4;
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitContentView addSubview:submitButton];
    
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(20);
    }];
    [submitButton addTarget:self action:@selector(clickSubmitAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(submitContentView.mas_bottom);
    }];
    
}

- (void)clickDepartmentAction {
    
    NSLog(@"选择科室");
    
    GHChooseDepartmentViewController *vc = [[GHChooseDepartmentViewController alloc] init];
    vc.delegate = self;
    if (self.departmentSecondId.length) {
        vc.departmentId = self.departmentSecondId;
    } else {
        vc.departmentId = self.realModel.secondDepartmentId;
    }
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)chooseDepartmentWithSecondName:(NSString *)secondName withSecondId:(NSString *)secondId withFirstName:(NSString *)firstName withFirstId:(NSString *)firstId {
    
    self.departmentLabel.text = ISNIL(secondName);
    
    self.departmentSecondName = secondName;
    self.departmentSecondId = secondId;
    self.departmentFirstName = firstName;
    self.departmentFirstId = firstId;
    
}



- (void)clickDoctorNameAction {
    
    self.doctorNameTextView.text = @"";
    
}

- (void)clickHospitalNameCleanAction {
    self.hospitalNameTextView.text = @"";
}

- (void)clickHospitalAddressAction {
    self.hospitalAddressTextView.text = @"";
}

- (void)clickMapAction {
    
    [self clickNoneAction];
    
    GHHospitalChooseAddressViewController *vc = [[GHHospitalChooseAddressViewController alloc] init];
    vc.point = self.point;
    vc.location = self.hospitalAddressTextView.text;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)chooseAddressWithAddress:(NSString *)address withCoordinate:(CLLocationCoordinate2D)coordinate {
    
    [self.mapView removeAnnotation:self.point];
    
    self.point.coordinate = coordinate;
    
    self.mapView.centerCoordinate = coordinate;
    
    [self.mapView addAnnotation:self.point];
    
    self.hospitalAddressTextView.text = ISNIL(address);
    
}

- (void)clickNoneAction {
    
    [self.doctorNameTextView resignFirstResponder];
    
    [self.hospitalNameTextView resignFirstResponder];
    
    [self.hospitalAddressTextView resignFirstResponder];
    
    [self.doctorInfoTextView resignFirstResponder];
    
    [self.doctorIntroduceTextView resignFirstResponder];
    
}

- (void)clickTagAction:(UIButton *)sender {
    
    [self clickNoneAction];
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        sender.layer.borderColor = kDefaultBlueColor.CGColor;
        sender.backgroundColor = UIColorHex(0xEFF0FD);
        
    } else {
        sender.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
        sender.backgroundColor = [UIColor whiteColor];
    }
    
    NSArray *buttonArray;
    
    if (sender.tag < 10) {
        
        buttonArray = self.positionButtonArray;
        
    } else if (sender.tag < 100) {
        
        buttonArray = self.typeButtonArray;
        
    }
    
    
    for (UIButton *button in buttonArray) {
        
        if (button == sender) {
            continue;
        }
        
        button.selected = false;
        button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
        button.backgroundColor = [UIColor whiteColor];
        
    }
    
}


- (void)updateUI {
 
    self.doctorNameTextView.text = ISNIL(self.realModel.doctorName);
    
    self.hospitalNameTextView.text = ISNIL(self.realModel.hospitalName);
    
    self.hospitalAddressTextView.text = ISNIL(self.realModel.hospitalAddress);
    
    self.doctorIntroduceTextView.text = ISNIL(self.realModel.specialize);
    
    self.doctorInfoTextView.text = ISNIL(self.realModel.doctorInfo);
    
    self.departmentLabel.text = ISNIL(self.realModel.secondDepartmentName);
    
    for (UIButton *button in self.positionButtonArray) {
        
        if ([button.currentTitle isEqualToString:ISNIL(self.realModel.doctorGrade)]) {
            
            button.selected = true;
            button.layer.borderColor = kDefaultBlueColor.CGColor;
            button.backgroundColor = UIColorHex(0xEFF0FD);
            
        }
        
    }
    
    for (UIButton *button in self.typeButtonArray) {
        
        if ([button.currentTitle isEqualToString:ISNIL(self.realModel.medicineType)]) {
            
            button.selected = true;
            button.layer.borderColor = kDefaultBlueColor.CGColor;
            button.backgroundColor = UIColorHex(0xEFF0FD);
            
        }
        
    }
    
}

- (void)clickHospitalNameAction {
    
    NSLog(@"选择医院");
    
    GHChooseDoctorHospitalViewController *vc = [[GHChooseDoctorHospitalViewController alloc] init];
    vc.searchKey = self.hospitalNameTextView.text;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:false];
    
}

- (void)choooseHospitalWithModel:(GHSearchHospitalModel *)model {
    
    self.hospitalModel = model;
    
    self.hospitalNameTextView.text = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.hospitalName)];
    
    self.hospitalAddressTextView.text = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.hospitalAddress)];
    
    [self.mapView removeAnnotation:self.point];
    
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[model.lat doubleValue] longitude:[model.lng doubleValue]];
    
    //终点坐标
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    
    self.mapView.centerCoordinate = coordinate;
    
    MAPointAnnotation *point = [[MAPointAnnotation alloc] init];
    point.coordinate = coordinate;
    
    self.point = point;
    
    [self.mapView addAnnotation:point];
    
}

- (void)clickSubmitAction {
    
    if ([NSString stringContainsEmoji:self.doctorNameTextView.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的医生姓名,请勿输入特殊字符"];
        return;
    }
    
    if (self.doctorNameTextView.text.length < 2 || self.doctorNameTextView.text.length > 20) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的医生姓名,不少于2个字符,不大于20个字"];
        return;
    }
    
    if ([NSString stringContainsEmoji:self.hospitalNameTextView.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的医院名称,请勿输入特殊字符"];
        return;
    }
    
    if (self.hospitalNameTextView.text.length < 5) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的医院名称,不少于5个字符"];
        return;
    }
    
    if (self.hospitalNameTextView.text.length > 200) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的医院名称,不大于200个字符"];
        return;
    }
    
    if ([NSString stringContainsEmoji:self.hospitalAddressTextView.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的医院地址,请勿输入特殊字符"];
        return;
    }
    
    if (self.hospitalAddressTextView.text.length < 5) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的医院地址,不少于5个字符"];
        return;
    }
    
    if (self.hospitalAddressTextView.text.length > 400) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的医院地址,不大于400个字符"];
        return;
    }
    
    if (![self.doctorIntroduceTextView.text isEqualToString:@"无专长"]) {
        
        if ([NSString stringContainsEmoji:self.doctorIntroduceTextView.text]) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的医生擅长,请勿输入特殊字符"];
            return;
        }
        
        if (self.doctorIntroduceTextView.text.length < 2) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的医生擅长,不少于2个字符"];
            return;
        }
        
        if (self.doctorIntroduceTextView.text.length > 2048) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的医生擅长,不大于2048个字符"];
            return;
        }
        
    }
    
    if (![self.doctorInfoTextView.text isEqualToString:@"无介绍"]) {
        
        if ([NSString stringContainsEmoji:self.doctorInfoTextView.text]) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的医生职业经历,请勿输入特殊字符"];
            return;
        }
        
        if (self.doctorInfoTextView.text.length < 2) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的医生职业经历,不少于2个字符"];
            return;
        }
        
        if (self.doctorInfoTextView.text.length > 2048) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的医生职业经历,不大于2048个字符"];
            return;
        }
        
    }
    

    
    NSString *medicineType;
    
    for (UIButton *button in self.typeButtonArray) {
        
        if (button.selected == true) {
            medicineType = button.currentTitle;
        }
        
    }
    
    if (medicineType.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择医生类型"];
        return;
    }
    
    NSString *doctorGrade;
    
    for (UIButton *button in self.positionButtonArray) {
        
        if (button.selected == true) {
            doctorGrade = button.currentTitle;
        }
 
    }
    if ([doctorGrade isEqualToString:@"主任医师"]) {
        doctorGrade = @"4";
    }
    else if ([doctorGrade isEqualToString:@"副主任医师"])
    {
        doctorGrade = @"3";
    }
    else if ([doctorGrade isEqualToString:@"主治医师"])
    {
        doctorGrade = @"2";
    }
    else if ([doctorGrade isEqualToString:@"医师"])
    {
        doctorGrade = @"1";
    }
    
    if (doctorGrade.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择医生职称"];
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    if (self.doctorPhotoView.uploadImageUrlArray.count > 0) {
        NSDictionary *headerDic = [self.doctorPhotoView.uploadImageUrlArray firstObject];
        params[@"imageUrl"] = headerDic[@"url"];
    }
    
    params[@"name"] = self.doctorNameTextView.text;
    params[@"doctorGradeNum"] = doctorGrade;
    
    params[@"medicineType"] = medicineType;
    params[@"hospital"] = self.hospitalNameTextView.text;
    params[@"address"] = self.hospitalAddressTextView.text;
    params[@"visitTime"] = [self.addTimeView getTimeString].length ? [self.addTimeView getTimeString] : nil;
    params[@"visitingDepartment"] = self.departmentSecondName;
    params[@"goodAt"] = self.doctorIntroduceTextView.text;
    params[@"careerExperience"] = self.doctorInfoTextView.text;
    params[@"doctorId"] = self.realModel.modelId;
    params[@"latitude"] = [NSString stringWithFormat:@"%lf",self.mapView.centerCoordinate.latitude];
    params[@"longitude"] = [NSString stringWithFormat:@"%lf",self.mapView.centerCoordinate.longitude];
    params[@"type"] = @(1);
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiCreateDoctorInfoError withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            self.navigationItem.title = @"提交成功";
            self.submitSuccessView.hidden = false;
        }
    }];
    
    
    
    
    return;
    /**********************************/
    params[@"dataCollectionType"] = @"1";

    params[@"originDoctorId"] = self.realModel.modelId;
    
    params[@"userId"] = [GHUserModelTool shareInstance].userInfoModel.modelId;
    params[@"userNickName"] = ISNIL([GHUserModelTool shareInstance].userInfoModel.nickName).length ? [GHUserModelTool shareInstance].userInfoModel.nickName : ISNIL([GHUserModelTool shareInstance].userInfoModel.showPhoneNum);
    
    params[@"profilePhoto"] = [self.doctorPhotoView getOnlyImageUrlArray].count ? [[self.doctorPhotoView getOnlyImageUrlArray] firstObject] : nil;
    

    params[@"qualityCertifyMaterials"] = self.realModel.qualityCertifyMaterials;
    params[@"qualityCertifyFlag"] = self.realModel.qualityCertifyFlag;
    
    
    if (self.departmentSecondName.length && self.departmentSecondId.length && self.departmentFirstName.length && self.departmentFirstId.length) {

        params[@"firstDepartmentId"] = self.departmentFirstId;
        params[@"firstDepartmentName"] = self.departmentFirstName;
        params[@"secondDepartmentId"] = self.departmentSecondId;
        params[@"secondDepartmentName"] = self.departmentSecondName;

    } else {

        params[@"firstDepartmentId"] = self.realModel.firstDepartmentId;
        params[@"firstDepartmentName"] = self.realModel.firstDepartmentName;
        params[@"secondDepartmentId"] = self.realModel.secondDepartmentId;
        params[@"secondDepartmentName"] = self.realModel.secondDepartmentName;

    }
    
    params[@"hospitalAddress"] = self.hospitalAddressTextView.text;
    
    params[@"hospitalName"] = self.hospitalNameTextView.text;
    params[@"hospitalId"] = self.hospitalModel.modelId.length ? self.hospitalModel.modelId : self.realModel.hospitalId;
    params[@"hospitalLevel"] = self.hospitalModel.level.length ? self.hospitalModel.level : self.realModel.hospitalLevel;
    
//    if (![ISNIL(self.doctorIntroduceTextView.text) isEqualToString:@"无专长"]) {
        params[@"specialize"] = self.doctorIntroduceTextView.text;
//    }
    
//    if (![ISNIL(self.doctorInfoTextView.text) isEqualToString:@"无介绍"]) {
        params[@"doctorInfo"] = self.doctorInfoTextView.text;
//    }

    params[@"doctorName"] = self.doctorNameTextView.text;
    params[@"doctorGrade"] = doctorGrade;
    params[@"medicineType"] = medicineType;
    params[@"diagnosisTime"] = [self.addTimeView getTimeString].length ? [self.addTimeView getTimeString] : nil;
    
//    if (![ISNIL(self.hospitalAddressTextView.text) isEqualToString:ISNIL(self.realModel.hospitalAddress)]) {
//        params[@"hospitalAddress"] = self.hospitalAddressTextView.text;
//    }
//
//    if (![ISNIL(self.hospitalNameTextView.text) isEqualToString:ISNIL(self.realModel.hospitalName)]) {
//        params[@"hospitalName"] = self.hospitalNameTextView.text;
//        params[@"hospitalId"] = self.hospitalModel.modelId;
//    }
//
//    if (![ISNIL(self.doctorIntroduceTextView.text) isEqualToString:ISNIL(self.realModel.specialize)]) {
//        params[@"specialize"] = self.doctorIntroduceTextView.text;
//    }
//
//    if (![ISNIL(self.doctorInfoTextView.text) isEqualToString:ISNIL(self.realModel.doctorInfo)]) {
//        params[@"doctorInfo"] = self.doctorInfoTextView.text;
//    }
//
//    if (![ISNIL(self.doctorNameTextView.text) isEqualToString:ISNIL(self.realModel.doctorName)]) {
//        params[@"doctorName"] = self.doctorNameTextView.text;
//    }
//
//    if (![ISNIL(doctorGrade) isEqualToString:ISNIL(self.realModel.doctorGrade)]) {
//        params[@"doctorGrade"] = doctorGrade;
//    }
//
//    if (![ISNIL(medicineType) isEqualToString:ISNIL(self.realModel.medicineType)]) {
//        params[@"medicineType"] = medicineType;
//    }
//
//    if (![ISNIL([self.addTimeView getTimeString]) isEqualToString:ISNIL(self.realModel.diagnosisTime)]) {
//        params[@"diagnosisTime"] = [self.addTimeView getTimeString].length ? [self.addTimeView getTimeString] : nil;
//    }
//
//
//    if ([self.departmentSecondId integerValue] != [self.realModel.secondDepartmentId integerValue]) {
//
//        if (self.departmentSecondName.length && self.departmentSecondId.length && self.departmentFirstName.length && self.departmentFirstId.length) {
//
//            params[@"firstDepartmentId"] = self.departmentFirstId;
//            params[@"firstDepartmentName"] = self.departmentFirstName;
//            params[@"secondDepartmentId"] = self.departmentSecondId;
//            params[@"secondDepartmentName"] = self.departmentSecondName;
//
//        }
//
//    }
//
    
    

    
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiDataCollectionDoctor withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            self.navigationItem.title = @"提交成功";
            self.submitSuccessView.hidden = false;
            
            NSMutableDictionary *sonParams = [[NSMutableDictionary alloc] init];
            sonParams[@"pageSize"] = @(3);
            sonParams[@"from"] = @(0);
            
            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDataCollectionMyDoctors withParameter:sonParams withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
               
                if (isSuccess) {
                    
                    for (NSDictionary *dic in response) {
                        
                        GHDataCollectionDoctorModel *model = [[GHDataCollectionDoctorModel alloc] initWithDictionary:dic error:nil];
                        
                        if (model == nil) {
                            continue;
                        }
                        
//                        if ([model.originDoctorId longValue] == [self.realModel.modelId longValue]) {
//                        
//                            self.dataCollectionModel = model;
//                            
//                             [self addRightButton:@selector(clickProgressAction) title:@"核实进度 "];
//                            
//                            break;
//                            
//                        }
                    
                    }
                    
                }
                
            }];
            
            
            
        }
        
    }];
    
    
    
}

- (void)clickProgressAction {
    
    GHInfoErrorProgressViewController *vc = [[GHInfoErrorProgressViewController alloc] init];
    vc.type = 1;
    vc.doctorModel = self.dataCollectionModel;
    [self.navigationController pushViewController:vc animated:true];
    
}


//- (void)clickSubmitAction {
//
//    //    if (self.textView.text.length < 10) {
//    //        [SVProgressHUD showErrorWithStatus:@"请填写报错内容,字数不得大于300字,字数不得小于10字"];
//    //        return;
//    //    }
//
//
////    if (self.textView.text.length == 0) {
////        [SVProgressHUD showErrorWithStatus:@"请填写报错内容"];
////        return;
////    }
////
////    if (self.textView.text.length > 300) {
////        [SVProgressHUD showErrorWithStatus:@"请填写300字以内的报错内容"];
////        return;
////    }
////
////    if (self.textView.text.length < 10) {
////        [SVProgressHUD showErrorWithStatus:@"请填写10字以上的报错内容"];
////        return;
////    }
////
////    if ([NSString isEmpty:ISNIL(self.textView.text)]) {
////        [SVProgressHUD showErrorWithStatus:@"请填写正确的报错内容,请勿包含表情等特殊字符"];
////        return;
////    }
////
////    if ([NSString stringContainsEmoji:ISNIL(self.textView.text)]) {
////        [SVProgressHUD showErrorWithStatus:@"请填写正确的报错内容,请勿包含表情等特殊字符"];
////        return;
////    }
//
//    [self submitAction];
//
//
//}

//- (void)uploadPhotoAction {
//
//    [[GHUploadPhotoTool shareInstance] uploadImageWithImage:self.recordImage withMaxCapture:300 completion:^(NSString * _Nonnull urlStr, UIImage * _Nonnull thumbImage) {
//
//        self.recordUrlStr = urlStr;
//
//        if (self.recordUrlStr.length) {
//
//            [self submitAction];
//
//        }
//
//    }];
//
//}

- (void)submitAction {
    
}




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

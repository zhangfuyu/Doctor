//
//  GHAddHospitalView.m
//  掌上优医
//
//  Created by GH on 2019/5/30.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHAddHospitalView.h"

#import "JFMorePhotoView.h"

#import "GHTextView.h"
#import "UIButton+touch.h"

#import "GHHospitalDetailInfoErrorAddPhoneView.h"

#import "GHHospitalTimeChooseView.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

#import "GHHospitalChooseAddressViewController.h"

#import "GHInfoErrorProgressViewController.h"

#import "GHAreaModel.h"
#import "PinYin4Objc.h"

#import "GHAddHospitalTagView.h"

#import "GHAddHospitalAuthenticationViewController.h"

#import "GHAddHospitalInformationViewController.h"

#import "GHHospitalInformationModel.h"

@interface GHAddHospitalView () <UIScrollViewDelegate, GHHospitalTimeChooseViewDelegate, MAMapViewDelegate, GHHospitalChooseAddressViewControllerDelegate, UITextViewDelegate, GHAddHospitalAuthenticationViewControllerDelegate, GHAddHospitalInformationViewControllerDelegate>

@property (nonatomic, strong) JFMorePhotoView *hospitalHeaderPhotoView;

@property (nonatomic, strong) JFMorePhotoView *hospitalEnvironmentPhotoView;

@property (nonatomic, strong) GHTextView *hospitalNameTextView;

@property (nonatomic, strong) GHTextView *hospitalAddressTextView;

@property (nonatomic, strong) GHTextView *hospitalIntrudeTextView;

/**
 医院等级
 */
@property (nonatomic, strong) NSMutableArray *levelButtonArray;

/**
 医院类型
 */
@property (nonatomic, strong) NSMutableArray *typeButtonArray;

/**
 医保
 */
@property (nonatomic, strong) NSMutableArray *yibaoButtonArray;

/**
 公立/私立
 */
@property (nonatomic, strong) NSMutableArray *propertyButtonArray;

@property (nonatomic, strong) NSMutableArray *tagButtonArray;

@property (nonatomic, strong) NSMutableArray *customTagButtonArray;

/**
 医院设置
 */
@property (nonatomic, strong) NSMutableArray *hospitalFacilityButtonArray;

/**
 营业时间
 */
@property (nonatomic, strong) UILabel *yingyeTimeLabel;

/**
 门诊时间
 */
@property (nonatomic, strong) UILabel *menzhenTimeLabel;

/**
 急诊时间
 */
@property (nonatomic, strong) UILabel *jizhenTimeLabel;

@property (nonatomic, strong) GHHospitalTimeChooseView *yingyeTimeView;

@property (nonatomic, strong) GHHospitalTimeChooseView *menzhenTimeView;

@property (nonatomic, strong) GHHospitalTimeChooseView *jizhenTimeView;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHHospitalDetailInfoErrorAddPhoneView *addPhoneView;

/**
 <#Description#>
 */
@property (nonatomic, strong) MAMapView *mapView;

/**
 <#Description#>
 */
@property (nonatomic, strong) MAPointAnnotation *point;

@property (nonatomic, strong) UIView *submitSuccessView;


@property (nonatomic, strong) NSString *countryName;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *countyName;

@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *county;

@property (nonatomic, strong) GHDataCollectionHospitalModel *dataCollectionModel;

/**
 医院自定义标签 View
 */
@property (nonatomic, strong) GHAddHospitalTagView *hospitalCustomTagView;

/**
 医院资质 ImageView
 */
@property (nonatomic, strong) UIImageView *hospitalAuthenticationImageView;

/**
 医院资质 JSON String
 */
@property (nonatomic, copy) NSString<Optional> *qualityCertifyMaterials;

@property (nonatomic, strong) UIView *hospitalInformationView;

@property (nonatomic, copy) NSArray *hospitalInformationArray;

@property (nonatomic, strong) NSMutableArray *hospitalInformationTitleLabelArray;

@end

@implementation GHAddHospitalView

- (NSMutableArray *)hospitalInformationTitleLabelArray {
    
    if (!_hospitalInformationTitleLabelArray) {
        _hospitalInformationTitleLabelArray = [[NSMutableArray alloc] init];
    }
    return _hospitalInformationTitleLabelArray;
    
}

- (NSMutableArray *)tagButtonArray {
    
    if (!_tagButtonArray) {
        _tagButtonArray = [[NSMutableArray alloc] init];
    }
    return _tagButtonArray;
    
}

- (NSMutableArray *)customTagButtonArray {
    
    if (!_customTagButtonArray) {
        _customTagButtonArray = [[NSMutableArray alloc] init];
    }
    return _customTagButtonArray;
    
}

- (NSMutableArray *)hospitalFacilityButtonArray {
    
    if (!_hospitalFacilityButtonArray) {
        _hospitalFacilityButtonArray = [[NSMutableArray alloc] init];
    }
    return _hospitalFacilityButtonArray;
    
}

- (UIView *)submitSuccessView {
    
    if (!_submitSuccessView) {
        
        _submitSuccessView = [[UIView alloc] init];
        _submitSuccessView.backgroundColor = kDefaultGaryViewColor;
        [self addSubview:_submitSuccessView];
        
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

- (GHHospitalTimeChooseView *)yingyeTimeView {
    
    if (!_yingyeTimeView) {
        _yingyeTimeView = [[GHHospitalTimeChooseView alloc] init];
        _yingyeTimeView.delegate = self;
        _yingyeTimeView.titleLabel.text = @"营业时间";
        [self addSubview:_yingyeTimeView];
        
        [_yingyeTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _yingyeTimeView;
    
}

- (GHHospitalTimeChooseView *)menzhenTimeView {
    
    if (!_menzhenTimeView) {
        _menzhenTimeView = [[GHHospitalTimeChooseView alloc] init];
        _menzhenTimeView.delegate = self;
        _menzhenTimeView.titleLabel.text = @"门诊时间";
        [self addSubview:_menzhenTimeView];
        
        [_menzhenTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _menzhenTimeView;
    
}

- (GHHospitalTimeChooseView *)jizhenTimeView {
    
    if (!_jizhenTimeView) {
        _jizhenTimeView = [[GHHospitalTimeChooseView alloc] init];
        _jizhenTimeView.delegate = self;
        _jizhenTimeView.titleLabel.text = @"门诊时间";
        [self addSubview:_jizhenTimeView];
        
        [_jizhenTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _jizhenTimeView;
    
}

- (void)chooseTimeFinishWithTime:(NSString *)time withTimeView:(GHHospitalTimeChooseView *)timeView {
    
    if (timeView == self.yingyeTimeView) {
        self.yingyeTimeLabel.text = ISNIL(time);
    } else if (timeView == self.menzhenTimeView) {
        self.menzhenTimeLabel.text = ISNIL(time);
    } else if (timeView == self.jizhenTimeView) {
        self.jizhenTimeLabel.text = ISNIL(time);
    }
    
}

- (NSMutableArray *)levelButtonArray {
    
    if (!_levelButtonArray) {
        _levelButtonArray = [[NSMutableArray alloc] init];
    }
    return _levelButtonArray;
    
}

- (NSMutableArray *)typeButtonArray {
    
    if (!_typeButtonArray) {
        _typeButtonArray = [[NSMutableArray alloc] init];
    }
    return _typeButtonArray;
    
}

- (NSMutableArray *)yibaoButtonArray {
    
    if (!_yibaoButtonArray) {
        _yibaoButtonArray = [[NSMutableArray alloc] init];
    }
    return _yibaoButtonArray;
    
}

- (NSMutableArray *)propertyButtonArray {
    
    if (!_propertyButtonArray) {
        _propertyButtonArray = [[NSMutableArray alloc] init];
    }
    return _propertyButtonArray;
    
}

- (void)setType:(NSUInteger)type {
    
    _type = type;
    
    [self setupUI];
    
}

- (void)setupUI {
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.bounces = false;
    scrollView.showsVerticalScrollIndicator = false;
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.delegate = self;
    [self addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(Height_StatusBar);
        make.bottom.mas_equalTo(kBottomSafeSpace);
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
        make.height.mas_equalTo(350 + 90);
    }];
    
    UILabel *hospitalImageTitleLabel = [[UILabel alloc] init];
    hospitalImageTitleLabel.font = H16;
    hospitalImageTitleLabel.textColor = kDefaultBlackTextColor;
    hospitalImageTitleLabel.text = @"医院图片";
    [imageContentView addSubview:hospitalImageTitleLabel];
    
    [hospitalImageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(0);
    }];
    
    UILabel *hospitalImageDescLabel = [[UILabel alloc] init];
    hospitalImageDescLabel.font = H13;
    hospitalImageDescLabel.textColor = kDefaultGrayTextColor;
    hospitalImageDescLabel.text = @"仅限制png、JPG格式";
    [imageContentView addSubview:hospitalImageDescLabel];
    
    [hospitalImageDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(85);
        make.height.mas_equalTo(50);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UILabel *hospitalHeaderImageTitleLabel = [[UILabel alloc] init];
    hospitalHeaderImageTitleLabel.font = H15;
    hospitalHeaderImageTitleLabel.textColor = kDefaultGrayTextColor;
    hospitalHeaderImageTitleLabel.text = @"上传医院封面照";
    [imageContentView addSubview:hospitalHeaderImageTitleLabel];
    
    [hospitalHeaderImageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(65);
    }];
    
    JFMorePhotoView *hospitalHeaderPhotoView = [[JFMorePhotoView alloc] initWithCount:6];
    hospitalHeaderPhotoView.canAddCount = 1;
    [imageContentView addSubview:hospitalHeaderPhotoView];
    self.hospitalHeaderPhotoView = hospitalHeaderPhotoView;
    
    [hospitalHeaderPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(hospitalHeaderImageTitleLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(90);
    }];
    
    
    UILabel *hospitalEnvImageTitleLabel = [[UILabel alloc] init];
    hospitalEnvImageTitleLabel.font = H15;
    hospitalEnvImageTitleLabel.textColor = kDefaultGrayTextColor;
    hospitalEnvImageTitleLabel.text = @"上传医院环境图片";
    [imageContentView addSubview:hospitalEnvImageTitleLabel];
    
    [hospitalEnvImageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(208);
    }];
    
    JFMorePhotoView *hospitalEnvironmentPhotoView = [[JFMorePhotoView alloc] initWithCount:6];
    hospitalEnvironmentPhotoView.canAddCount = 6;
    [imageContentView addSubview:hospitalEnvironmentPhotoView];
    self.hospitalEnvironmentPhotoView = hospitalEnvironmentPhotoView;
    
    [hospitalEnvironmentPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(hospitalEnvImageTitleLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(160);
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
        make.height.mas_equalTo(100);
    }];
    
    UILabel *hospitalNameTitleLabel = [[UILabel alloc] init];
    hospitalNameTitleLabel.font = H16;
    hospitalNameTitleLabel.textColor = kDefaultBlackTextColor;
    hospitalNameTitleLabel.text = @"医院名称";
    [nameContentView addSubview:hospitalNameTitleLabel];
    
    [hospitalNameTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(30);
    }];
    
    GHTextView *textView = [[GHTextView alloc] initWithFrame:CGRectMake(106, 22, SCREENWIDTH - 106 - 41, 50)];
    textView.font = H16;
    textView.textColor = kDefaultBlackTextColor;
    textView.backgroundColor = [UIColor whiteColor];
    textView.bounces = false;
    textView.placeholder = @"请输入医院名称";
    textView.placeholderColor = UIColorHex(0xcccccc);
    [nameContentView addSubview:textView];
    
    self.hospitalNameTextView = textView;
    
    UIButton *hospitalNameCleanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [hospitalNameCleanButton setImage:[UIImage imageNamed:@"ic_yiyuanbaocuo_quxiao"] forState:UIControlStateNormal];
    [nameContentView addSubview:hospitalNameCleanButton];
    
    [hospitalNameCleanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(42);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(19);
    }];
    [hospitalNameCleanButton addTarget:self action:@selector(clickHospitalNameAction) forControlEvents:UIControlEventTouchUpInside];
    
    
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
        make.height.mas_equalTo(737);
        //        make.height.mas_equalTo(545);
    }];
    
    //    NSArray *levelArray = @[@"三级医院", @"二级医院", @"一级医院"];
    NSArray *levelArray = @[@"三级甲等", @"三级乙等", @"三级其他", @"二级甲等", @"二级乙等", @"二级其他", @"一级"];
    NSArray *typeDataArray = @[@"综合医院", @"中医医院", @"中西医结合医院", @"专科医院", @"康复医院", @"民族医院", @"诊所", @"中医诊所", @"西医诊所"];
    NSArray *yibaoArray = @[@"有医保", @"无医保"];
    NSArray *propertyArray = @[@"私立医院", @"公立医院"];
    
    NSArray *tagArray = @[@"中医", @"西医", @"中西医结合"];
    
    NSArray *titleArray = @[@"医院等级", @"医院类型", @"医保情况", @"医院属性", @"医院标签"];
    NSArray *dataArray = @[levelArray, typeDataArray, yibaoArray, propertyArray, tagArray];
    
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
                [self.levelButtonArray addObject:button];
                
            } else if (index == 1) {
                
                button.tag = 10 + indexY;
                [self.typeButtonArray addObject:button];
                
            } else if (index == 2) {
                
                button.tag = 100 + indexY;
                [self.yibaoButtonArray addObject:button];
                
            } else if (index == 3) {
                
                button.tag = 1000 + indexY;
                [self.propertyButtonArray addObject:button];
                
            } else if (index == 4) {
                
                button.tag = 10000 + indexY;
                [self.tagButtonArray addObject:button];
                
            }
            
            [button addTarget:self action:@selector(clickTagAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        
        
        if (index == 0) {
            
            [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(30);
            }];
            
        } else if (index == 1) {
            
            [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(230);
            }];
            
            
        } else if (index == 2) {
            
            [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(430);
            }];
            
        } else if (index == 3) {
            
            [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(535);
            }];
            
        } else if (index == 4) {
            
            [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(635);
            }];
            
        }
        
    }
    
    UILabel *lineLabel3 = [[UILabel alloc] init];
    lineLabel3.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel3];
    
    if (self.type == 2) {
        
        [lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(10);
            make.top.mas_equalTo(chooseContentView.mas_bottom);
        }];
        
    } else {
        
        UIView *customTagContentView = [[UIView alloc] init];
        customTagContentView.backgroundColor = [UIColor whiteColor];
        [contentView addSubview:customTagContentView];
        
        [customTagContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(chooseContentView.mas_bottom);
        }];
        
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = H15;
        titleLabel.textColor = kDefaultBlackTextColor;
        titleLabel.text = @"其他标签";
        [customTagContentView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(17);
            make.top.mas_equalTo(0);
        }];
        
        GHAddHospitalTagView *customTagView = [[GHAddHospitalTagView alloc] init];
        [customTagContentView addSubview:customTagView];
        
        [customTagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(30);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(60);
        }];
        
        self.hospitalCustomTagView = customTagView;
        
        [customTagContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(customTagView.mas_bottom).offset(10);
        }];
        
        [lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(10);
            make.top.mas_equalTo(customTagContentView.mas_bottom);
        }];
        
    }
    

    
    UIView *phoneAndTimeContentView = [[UIView alloc] init];
    phoneAndTimeContentView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:phoneAndTimeContentView];
    
    [phoneAndTimeContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel3.mas_bottom);
    }];
    
    UIView *phoneContentView = [[UIView alloc] init];
    phoneContentView.backgroundColor = [UIColor whiteColor];
    [phoneAndTimeContentView addSubview:phoneContentView];
    
    [phoneContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UILabel *hospitalPhoneTitleLabel = [[UILabel alloc] init];
    hospitalPhoneTitleLabel.font = H16;
    hospitalPhoneTitleLabel.textColor = kDefaultBlackTextColor;
    hospitalPhoneTitleLabel.text = @"医院电话";
    [phoneAndTimeContentView addSubview:hospitalPhoneTitleLabel];
    
    [hospitalPhoneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(25);
    }];
    
    
    GHHospitalDetailInfoErrorAddPhoneView *addPhoneView = [[GHHospitalDetailInfoErrorAddPhoneView alloc] init];
    addPhoneView.isAdd = true;
    [phoneAndTimeContentView addSubview:addPhoneView];
    
    [addPhoneView setupPhoneArray:@[]];
    
    [phoneContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(addPhoneView);
    }];
    self.addPhoneView = addPhoneView;
    
    UIView *timeContentView = [[UIView alloc] init];
    timeContentView.backgroundColor = [UIColor whiteColor];
    [phoneAndTimeContentView addSubview:timeContentView];
    
    [timeContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(phoneContentView.mas_bottom);
    }];
    
    UILabel *timeLineLabel = [[UILabel alloc] init];
    timeLineLabel.backgroundColor = kDefaultLineViewColor;
    [timeContentView addSubview:timeLineLabel];
    
    [timeLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    if (self.type == 2) {
        
        
        UILabel *menzhenTimeTitleLabel = [[UILabel alloc] init];
        menzhenTimeTitleLabel.font = H16;
        menzhenTimeTitleLabel.textColor = kDefaultBlackTextColor;
        menzhenTimeTitleLabel.text = @"门诊时间";
        [timeContentView addSubview:menzhenTimeTitleLabel];
        
        [menzhenTimeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(70);
            make.top.mas_equalTo(27);
        }];
        
        UILabel *menzhenTimeLabel = [[UILabel alloc] init];
        menzhenTimeLabel.font = H16;
        menzhenTimeLabel.textColor = kDefaultBlackTextColor;
        [timeContentView addSubview:menzhenTimeLabel];
        
        [menzhenTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(107);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(27);
        }];
        self.menzhenTimeLabel = menzhenTimeLabel;
        
        UILabel *lineLineLabel1 = [[UILabel alloc] init];
        lineLineLabel1.backgroundColor = kDefaultGaryViewColor;
        [timeContentView addSubview:lineLineLabel1];
        
        [lineLineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(105);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(60);
        }];
        
        UILabel *jizhenTimeTitleLabel = [[UILabel alloc] init];
        jizhenTimeTitleLabel.font = H16;
        jizhenTimeTitleLabel.textColor = kDefaultBlackTextColor;
        jizhenTimeTitleLabel.text = @"急诊时间";
        [timeContentView addSubview:jizhenTimeTitleLabel];
        
        [jizhenTimeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(70);
            make.top.mas_equalTo(80);
        }];
        
        UILabel *jizhenTimeLabel = [[UILabel alloc] init];
        jizhenTimeLabel.font = H16;
        jizhenTimeLabel.textColor = kDefaultBlackTextColor;
        [timeContentView addSubview:jizhenTimeLabel];
        
        [jizhenTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(107);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(80);
        }];
        self.jizhenTimeLabel = jizhenTimeLabel;
        
        UILabel *lineLineLabel2 = [[UILabel alloc] init];
        lineLineLabel2.backgroundColor = kDefaultGaryViewColor;
        [timeContentView addSubview:lineLineLabel2];
        
        [lineLineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(105);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(120);
        }];
        
        [timeContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(160);
        }];
        
        UIButton *menzhenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        menzhenButton.tag = 2;
        [timeContentView addSubview:menzhenButton];
        
        [menzhenButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(60);
        }];
        [menzhenButton addTarget:self action:@selector(clickTimeViewAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *jizhenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        jizhenButton.tag = 3;
        [timeContentView addSubview:jizhenButton];
        
        [jizhenButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(lineLineLabel1);
            make.height.mas_equalTo(60);
        }];
        [jizhenButton addTarget:self action:@selector(clickTimeViewAction:) forControlEvents:UIControlEventTouchUpInside];
        
    } else {
        
        UILabel *yingyeTimeTitleLabel = [[UILabel alloc] init];
        yingyeTimeTitleLabel.font = H16;
        yingyeTimeTitleLabel.textColor = kDefaultBlackTextColor;
        yingyeTimeTitleLabel.text = @"营业时间";
        [timeContentView addSubview:yingyeTimeTitleLabel];
        
        [yingyeTimeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(70);
            make.top.mas_equalTo(27);
        }];
        
        UILabel *yingyeTimeLabel = [[UILabel alloc] init];
        yingyeTimeLabel.font = H16;
        yingyeTimeLabel.textColor = kDefaultBlackTextColor;
        [timeContentView addSubview:yingyeTimeLabel];
        
        [yingyeTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(107);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(27);
        }];
        self.yingyeTimeLabel = yingyeTimeLabel;
        
        UIButton *yingyeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        yingyeButton.tag = 1;
        [timeContentView addSubview:yingyeButton];
        
        [yingyeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(60);
        }];
        [yingyeButton addTarget:self action:@selector(clickTimeViewAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lineLineLabel1 = [[UILabel alloc] init];
        lineLineLabel1.backgroundColor = kDefaultGaryViewColor;
        [timeContentView addSubview:lineLineLabel1];
        
        [lineLineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(105);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(60);
        }];
        
        [timeContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(100);
        }];
        
    }
    
    [phoneAndTimeContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(timeContentView.mas_bottom);
    }];
    
    UILabel *lineLabel4 = [[UILabel alloc] init];
    lineLabel4.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel4];
    
    [lineLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(phoneAndTimeContentView.mas_bottom);
    }];
    
    UIView *addressAndInfoContentView = [[UIView alloc] init];
    addressAndInfoContentView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:addressAndInfoContentView];
    
    [addressAndInfoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel4.mas_bottom);
        make.height.mas_equalTo(490);
    }];
    
    UILabel *hospitalAddressTitleLabel = [[UILabel alloc] init];
    hospitalAddressTitleLabel.font = H16;
    hospitalAddressTitleLabel.textColor = kDefaultBlackTextColor;
    hospitalAddressTitleLabel.text = @"医院地址";
    [addressAndInfoContentView addSubview:hospitalAddressTitleLabel];
    
    [hospitalAddressTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(25);
    }];
    
    UILabel *hospitalAddressDescLabel = [[UILabel alloc] init];
    hospitalAddressDescLabel.font = H16;
    hospitalAddressDescLabel.textColor = kDefaultGrayTextColor;
    hospitalAddressDescLabel.text = @"地址";
    [addressAndInfoContentView addSubview:hospitalAddressDescLabel];
    
    [hospitalAddressDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(65);
    }];
    
    GHTextView *hospitalAddressTextView = [[GHTextView alloc] initWithFrame:CGRectMake(75, 58, SCREENWIDTH - 75 - 54, 50)];
    hospitalAddressTextView.font = H16;
    hospitalAddressTextView.textColor = kDefaultGrayTextColor;
    hospitalAddressTextView.backgroundColor = [UIColor whiteColor];
    hospitalAddressTextView.delegate = self;
    hospitalAddressTextView.bounces = false;
    hospitalAddressTextView.placeholder = @"请输入医院地址";
    hospitalAddressTextView.placeholderColor = UIColorHex(0xcccccc);
    [addressAndInfoContentView addSubview:hospitalAddressTextView];
    
    self.hospitalAddressTextView = hospitalAddressTextView;
    
    UIButton *hospitalAddressCleanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [hospitalAddressCleanButton setImage:[UIImage imageNamed:@"ic_yiyuanbaocuo_quxiao"] forState:UIControlStateNormal];
    [addressAndInfoContentView addSubview:hospitalAddressCleanButton];
    
    [hospitalAddressCleanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(42);
        make.right.mas_equalTo(-5);
        make.centerY.mas_equalTo(hospitalAddressDescLabel);
    }];
    [hospitalAddressCleanButton addTarget:self action:@selector(clickHospitalAddressAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *mapBGView = [[UIView alloc] initWithFrame:CGRectMake(20, 125, SCREENWIDTH - 40, 120)];
    mapBGView.layer.masksToBounds = true;
    [addressAndInfoContentView addSubview:mapBGView];
    
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
    
//    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[self.realModel.lat doubleValue] longitude:[self.realModel.lng doubleValue]];
//
//    //终点坐标
//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
//
//    self.mapView.centerCoordinate = coordinate;
    
    MAPointAnnotation *point = [[MAPointAnnotation alloc] init];
    
    self.point = point;
    
    
    UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mapBGView addSubview:mapButton];
    
    [mapButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    [mapButton addTarget:self action:@selector(clickMapAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILabel *hospitalIntrudeTitleLabel = [[UILabel alloc] init];
    hospitalIntrudeTitleLabel.font = H16;
    hospitalIntrudeTitleLabel.textColor = kDefaultBlackTextColor;
    hospitalIntrudeTitleLabel.text = @"医院简介";
    [addressAndInfoContentView addSubview:hospitalIntrudeTitleLabel];
    
    [hospitalIntrudeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(270);
    }];
    
    GHTextView *intrudeTextView = [[GHTextView alloc] initWithFrame:CGRectMake(16, 307, SCREENWIDTH - 32, 150)];
    intrudeTextView.font = H16;
    intrudeTextView.layer.borderColor = kDefaultGaryViewColor.CGColor;
    intrudeTextView.layer.borderWidth = 1;
    intrudeTextView.textColor = kDefaultBlackTextColor;
    intrudeTextView.backgroundColor = [UIColor whiteColor];
    intrudeTextView.placeholder = @"请输入医院介绍";
    intrudeTextView.placeholderColor = UIColorHex(0xcccccc);
    [addressAndInfoContentView addSubview:intrudeTextView];
    
    self.hospitalIntrudeTextView = intrudeTextView;
    
    UILabel *lineLabel5 = [[UILabel alloc] init];
    lineLabel5.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel5];
    
    [lineLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(addressAndInfoContentView.mas_bottom);
    }];
    
    UIView *sheshiContentView = [[UIView alloc] init];
    sheshiContentView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:sheshiContentView];
    
    [sheshiContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel5.mas_bottom);
    }];
    
    UILabel *sheshiTitleLabel = [[UILabel alloc] init];
    sheshiTitleLabel.font = H16;
    sheshiTitleLabel.textColor = kDefaultBlackTextColor;
    sheshiTitleLabel.text = @"医院设施";
    [sheshiContentView addSubview:sheshiTitleLabel];
    
    [sheshiTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(30);
    }];
    
    NSArray *sheshiTitleArray = @[@"支付宝", @"微信支付", @"支持刷卡", @"ATM机", @"付费停车", @"WiFi", @"充电宝", @"便利店", @"自动贩卖机", @"食堂", @"儿童娱乐区"];
    
    UIView *hotContentView = [[UIView alloc] init];
    [sheshiContentView addSubview:hotContentView];
    
    [hotContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(70);
    }];
    
    CGFloat width = 21;
    NSInteger line = 0;
    for (NSInteger index = 0; index < sheshiTitleArray.count; index++) {
        
        NSString *str = [sheshiTitleArray objectOrNilAtIndex:index];
        
        UIButton *sicknessButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        sicknessButton.layer.cornerRadius = 4;
        sicknessButton.titleLabel.font = H14;
        sicknessButton.tag = index;
        
        [sicknessButton setTitle:str forState:UIControlStateNormal];
        [sicknessButton setTitleColor:kDefaultGrayTextColor forState:UIControlStateNormal];
        [sicknessButton setTitleColor:kDefaultBlueColor forState:UIControlStateSelected];
        sicknessButton.layer.borderColor = kDefaultGrayTextColor.CGColor;
        sicknessButton.layer.borderWidth = .5;
        sicknessButton.layer.masksToBounds = true;
        
        [hotContentView addSubview:sicknessButton];
        
        [sicknessButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(width);
            make.width.mas_equalTo([str widthForFont:sicknessButton.titleLabel.font] + 6);
            make.top.mas_equalTo(line * 35);
            make.height.mas_equalTo(25);
        }];
        
        width += [str widthForFont:sicknessButton.titleLabel.font] + 6 + 4;
        
        if (width > SCREENWIDTH - 21) {
            line += 1;
            width = 21;
            [sicknessButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(width);
                make.top.mas_equalTo(line * 35);
            }];
            width += [str widthForFont:sicknessButton.titleLabel.font] + 6 + 4;
        }
        
        [sicknessButton addTarget:self action:@selector(clickSheShiTagAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.hospitalFacilityButtonArray addObject:sicknessButton];
        
    }
    
    [hotContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(line * 35 + 25);
    }];
    
    [sheshiContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(hotContentView.mas_bottom);
    }];
    
    UIView *hospitalAuthenticationContentView = [[UIView alloc] init];
    hospitalAuthenticationContentView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:hospitalAuthenticationContentView];
    
    [hospitalAuthenticationContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(sheshiContentView.mas_bottom).offset(0);
        make.height.mas_equalTo(80 + 60 + 10);
    }];
    
    UILabel *hospitalAuthenticationTitleLabel = [[UILabel alloc] init];
    hospitalAuthenticationTitleLabel.font = H16;
    hospitalAuthenticationTitleLabel.textColor = kDefaultBlackTextColor;
    hospitalAuthenticationTitleLabel.text = @"医院资质";
    [hospitalAuthenticationContentView addSubview:hospitalAuthenticationTitleLabel];
    
    [hospitalAuthenticationTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(80);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(0);
    }];
    
    
    UIImageView *hospitalAuthenticationLabelArrowImageView = [[UIImageView alloc] init];
    hospitalAuthenticationLabelArrowImageView.contentMode = UIViewContentModeCenter;
    hospitalAuthenticationLabelArrowImageView.image = [UIImage imageNamed:@"personcenter_right_arrow"];
    hospitalAuthenticationLabelArrowImageView.backgroundColor = [UIColor whiteColor];
    [hospitalAuthenticationContentView addSubview:hospitalAuthenticationLabelArrowImageView];
    
    [hospitalAuthenticationLabelArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.width.height.mas_equalTo(16);
        make.centerY.mas_equalTo(hospitalAuthenticationTitleLabel);
    }];
    
    UIButton *hospitalAuthenticationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [hospitalAuthenticationContentView addSubview:hospitalAuthenticationButton];
    
    [hospitalAuthenticationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    [hospitalAuthenticationButton addTarget:self action:@selector(clickHospitalAuthenticationAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *hospitalAuthenticationImageView = [[UIImageView alloc] init];
    hospitalAuthenticationImageView.layer.masksToBounds = true;
    hospitalAuthenticationImageView.contentMode = UIViewContentModeScaleAspectFill;
    [hospitalAuthenticationContentView addSubview:hospitalAuthenticationImageView];
    
    [hospitalAuthenticationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(60);
        make.top.mas_equalTo(70);
        make.left.mas_equalTo(20);
    }];
    self.hospitalAuthenticationImageView = hospitalAuthenticationImageView;
    
//    UIView *hospitalInformationContentView = [[UIView alloc] init];
//    hospitalInformationContentView.backgroundColor = [UIColor whiteColor];
//    [contentView addSubview:hospitalInformationContentView];
//
//    [hospitalInformationContentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(0);
//        make.top.mas_equalTo(hospitalAuthenticationContentView.mas_bottom).offset(0);
//        make.height.mas_equalTo(140);
//    }];
//    self.hospitalInformationView = hospitalInformationContentView;
//
//    UILabel *hospitalInformationTitleLabel = [[UILabel alloc] init];
//    hospitalInformationTitleLabel.font = H16;
//    hospitalInformationTitleLabel.textColor = kDefaultBlackTextColor;
//    hospitalInformationTitleLabel.text = @"医院咨讯";
//    [hospitalInformationContentView addSubview:hospitalInformationTitleLabel];
//
//    [hospitalInformationTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(16);
//        make.height.mas_equalTo(16);
//        make.width.mas_equalTo(170);
//        make.top.mas_equalTo(5);
//    }];
//
//    UIButton *addHospitalInformationButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    addHospitalInformationButton.titleLabel.font = H15;
//    [addHospitalInformationButton setTitle:@" 编辑医院资讯" forState:UIControlStateNormal];
//    [addHospitalInformationButton setTitleColor:kDefaultBlueColor forState:UIControlStateNormal];
//    [addHospitalInformationButton setImage:[UIImage imageNamed:@"ic_xinzhengyiyuan_bianjiyiyuanzixun"] forState:UIControlStateNormal];
//    addHospitalInformationButton.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
//    addHospitalInformationButton.layer.borderWidth = .5;
//    addHospitalInformationButton.layer.cornerRadius = 5;
//    addHospitalInformationButton.layer.masksToBounds = true;
//    [hospitalInformationContentView addSubview:addHospitalInformationButton];
//
//    [addHospitalInformationButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(188);
//        make.height.mas_equalTo(40);
//        make.centerX.mas_equalTo(contentView);
//        make.bottom.mas_equalTo(-40);
//    }];
//    [addHospitalInformationButton addTarget:self action:@selector(clickAddHospitalInformationAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lineLabel6 = [[UILabel alloc] init];
    lineLabel6.backgroundColor = kDefaultGaryViewColor;
    [contentView addSubview:lineLabel6];
    
    [lineLabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(hospitalAuthenticationContentView.mas_bottom);
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

- (void)clickAddHospitalInformationAction {
    
    GHAddHospitalInformationViewController *vc = [[GHAddHospitalInformationViewController alloc] init];
    [vc.dataArray addObjectsFromArray:self.hospitalInformationArray];
    vc.delegate = self;
    [self.viewController.navigationController pushViewController:vc animated:true];
    
}

- (void)finishSaveHospitalInformationWithArray:(NSArray *)array {
    
    self.hospitalInformationArray = array;
    
    [self.hospitalInformationView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(140 + 30 * array.count);
    }];
    
    for (UILabel *titleLabel in self.hospitalInformationTitleLabelArray) {
        [titleLabel removeFromSuperview];
    }
    
    [self.hospitalInformationTitleLabelArray removeAllObjects];
    
    for (NSInteger index = 0; index < array.count; index++) {
        
        GHHospitalInformationModel *informationModel = [array objectOrNilAtIndex:index];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = H16;
        titleLabel.textColor = kDefaultBlackTextColor;
        titleLabel.text = ISNIL(informationModel.title);
        
        [self.hospitalInformationView addSubview:titleLabel];
  
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.right.mas_equalTo(-16);
            make.height.mas_equalTo(30);
            make.top.mas_equalTo(index * 30 + 40);
        }];
        
        [self.hospitalInformationTitleLabelArray addObject:titleLabel];
        
    }
    
}

- (void)clickHospitalAuthenticationAction {
    
    GHAddHospitalAuthenticationViewController *vc = [[GHAddHospitalAuthenticationViewController alloc] init];
    vc.delegate = self;
    vc.qualityCertifyMaterials = self.qualityCertifyMaterials;
    [self.viewController.navigationController pushViewController:vc animated:true];
    
}

- (void)uploadHospitalAuthenticationWithMaterials:(NSString *)materials {
    
    self.qualityCertifyMaterials = materials;
    
    [self.hospitalAuthenticationImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL([[materials jsonValueDecoded][@"pics"] firstObject][@"url"]))];
//    [self.hospitalAuthenticationImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL([[[materials jsonValueDecoded][@"pics"] jsonValueDecoded] firstObject][@"url"]))];
    
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    
    static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
    
    MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
    
    if (annotationView == nil)
    {
        annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        
    }
    
    annotationView.image = [UIImage imageNamed:@"ic_yoyuanbaocuo_dizhitubiao"];
    
    annotationView.centerOffset = CGPointMake(0, -30);
    
    return annotationView;
    
}



- (void)clickHospitalNameAction {
    self.hospitalNameTextView.text = @"";
}

- (void)clickHospitalAddressAction {
    self.hospitalAddressTextView.text = @"";
}

- (void)clickSheShiTagAction:(UIButton *)sender {
    
    [self clickNoneAction];
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        sender.layer.borderColor = kDefaultBlueColor.CGColor;
        sender.backgroundColor = UIColorHex(0xEFF0FD);
        
    } else {
        sender.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
        sender.backgroundColor = [UIColor whiteColor];
    }
    
}



- (void)clickSubmitAction {
    
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
    
    if ([NSString stringContainsEmoji:self.hospitalIntrudeTextView.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的医院介绍,请勿输入特殊字符"];
        return;
    }
    
    if (self.hospitalIntrudeTextView.text.length > 0) {
        
        if (self.hospitalIntrudeTextView.text.length < 2) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的医院介绍,不少于2个字符"];
            return;
        }
        
        if (self.hospitalIntrudeTextView.text.length > 5120) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的医院介绍,不大于5120个字符"];
            return;
        }
        
    }
    

    
    NSString *grade;
    
    for (UIButton *button in self.levelButtonArray) {
        
        if (button.selected == true) {
            grade = button.currentTitle;
        }
        
    }
    
    if (grade.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择医院等级"];
        return;
    }
    
    NSString *category;
    
    for (UIButton *button in self.typeButtonArray) {
        
        if (button.selected == true) {
            category = button.currentTitle;
        }
        
    }
    
    if (category.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择医院类型"];
        return;
    }
    
    NSString *medicalInsuranceFlag;
    
    for (UIButton *button in self.yibaoButtonArray) {
        
        if (button.selected == true) {
            medicalInsuranceFlag = button.currentTitle;
        }
        
    }
    
    if (medicalInsuranceFlag.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择医保情况"];
        return;
    }
    
    if ([medicalInsuranceFlag isEqualToString:@"有医保"]) {
        medicalInsuranceFlag = @"1";
    } else {
        medicalInsuranceFlag = @"0";
    }
    
    
    NSString *governmentalHospitalFlag;
    
    for (UIButton *button in self.propertyButtonArray) {
        
        if (button.selected == true) {
            governmentalHospitalFlag = button.currentTitle;
        }
        
    }
    
    if (governmentalHospitalFlag.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择医院属性"];
        return;
    }
    
    if ([governmentalHospitalFlag isEqualToString:@"公立医院"]) {
        governmentalHospitalFlag = @"1";
    } else {
        governmentalHospitalFlag = @"0";
    }
    
    NSMutableArray *hospitalFacilityArray = [[NSMutableArray alloc] init];
    
    for (UIButton *button in self.hospitalFacilityButtonArray) {
        
        if (button.selected == true) {
            [hospitalFacilityArray addObject:button.currentTitle];
        }
        
    }
    
    NSString *hospitalTag;
    
    for (UIButton *button in self.tagButtonArray) {
        
        if (button.selected == true) {
            hospitalTag = button.currentTitle;
        }
        
    }
    
    if (hospitalTag.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择医院标签"];
        return;
    }
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    params[@"category"] = category;

    if (self.type == 0) {
        
        params[@"categoryByScale"] = @"诊所";
    
        params[@"outpatientDepartmentTime"] = self.yingyeTimeLabel.text.length ? self.yingyeTimeLabel.text : nil;
        
        params[@"hospitalTags"] = self.hospitalCustomTagView.tagArray.count ? [self.hospitalCustomTagView.tagArray componentsJoinedByString:@","] : nil;
        
    } else if (self.type == 1) {
        
        params[@"categoryByScale"] = @"专科医院";
        
        params[@"outpatientDepartmentTime"] = self.yingyeTimeLabel.text.length ? self.yingyeTimeLabel.text : nil;
        
        params[@"hospitalTags"] = self.hospitalCustomTagView.tagArray.count ? [self.hospitalCustomTagView.tagArray componentsJoinedByString:@","] : nil;
        
    } else if (self.type == 2) {
        
        params[@"categoryByScale"] = @"综合医院";
        
        params[@"emergencyTreatmentTime"] = self.jizhenTimeLabel.text.length ? self.jizhenTimeLabel.text : nil;
        
        params[@"outpatientDepartmentTime"] = self.menzhenTimeLabel.text.length ? self.menzhenTimeLabel.text : nil;
    }
    
    params[@"dataCollectionType"] = @(3);
    
    if (self.country.length) {
        params[@"country"] = self.country;
    }
    
    if (self.province.length) {
        params[@"province"] = self.province;
    }
    
    if (self.city.length) {
        params[@"city"] = self.city;
    }
    
    if (self.county.length) {
        params[@"county"] = self.county;
    }
    
    if (self.point.coordinate.latitude > 0) {
        params[@"lat"] = @(self.point.coordinate.latitude);
    }
    
    if (self.point.coordinate.longitude > 0) {
        params[@"lng"] = @(self.point.coordinate.longitude);
    }
    
//    if (self.hospitalInformationArray.count) {
//
//        NSMutableArray *newsArray = [[NSMutableArray alloc] init];
//
//        for (GHHospitalInformationModel *infoModel in self.hospitalInformationArray) {
//
//            NSMutableDictionary *newsDic = [[NSMutableDictionary alloc] init];
//            newsDic[@"title"] = ISNIL(infoModel.title);
//            newsDic[@"h5url"] = ISNIL(infoModel.h5url);
//
//            [newsArray addObject:newsDic];
//
//        }
//
//        params[@"hospitalNews"] = [newsArray jsonStringEncoded];
//
//    }

    params[@"contactNumber"] = [self.addPhoneView getContactNumberString].length ? [self.addPhoneView getContactNumberString] : nil;
    
    

    params[@"governmentalHospitalFlag"] = governmentalHospitalFlag;

    params[@"grade"] = grade;

    params[@"hospitalAddress"] = self.hospitalAddressTextView.text;

    params[@"qualityCertifyMaterials"] = self.qualityCertifyMaterials.length ? self.qualityCertifyMaterials : nil;

    params[@"hospitalName"] = self.hospitalNameTextView.text;

    params[@"introduction"] = self.hospitalIntrudeTextView.text.length ? self.hospitalIntrudeTextView.text : nil;

    params[@"medicalInsuranceFlag"] = medicalInsuranceFlag;
    
    params[@"medicineType"] = hospitalTag;

    params[@"profilePhoto"] = [self.hospitalHeaderPhotoView getOnlyImageUrlArray].count ? [[self.hospitalHeaderPhotoView getOnlyImageUrlArray] firstObject] : nil;

    params[@"pictures"] = [self.hospitalEnvironmentPhotoView uploadImageUrlArray].count ? [[self.hospitalEnvironmentPhotoView uploadImageUrlArray] jsonStringEncoded] : nil;

    params[@"hospitalFacility"] = hospitalFacilityArray.count ? [hospitalFacilityArray componentsJoinedByString:@","] : nil;


    params[@"userId"] = [GHUserModelTool shareInstance].userInfoModel.modelId;
    params[@"userNickName"] = ISNIL([GHUserModelTool shareInstance].userInfoModel.nickName).length ? [GHUserModelTool shareInstance].userInfoModel.nickName : ISNIL([GHUserModelTool shareInstance].userInfoModel.showPhoneNum);
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];

    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiDataCollectionHospital withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {

        if (isSuccess) {

            self.viewController.navigationItem.title = @"提交成功";
            self.submitSuccessView.hidden = false;

        }

    }];
    
}

- (void)clickProgressAction {
    
    GHInfoErrorProgressViewController *vc = [[GHInfoErrorProgressViewController alloc] init];
    vc.type = 2;
    vc.hospitalModel = self.dataCollectionModel;
    [self.viewController.navigationController pushViewController:vc animated:true];
    
}

- (void)clickMapAction {
    
    [self clickNoneAction];
    
    GHHospitalChooseAddressViewController *vc = [[GHHospitalChooseAddressViewController alloc] init];
    
    MAPointAnnotation *point = [[MAPointAnnotation alloc] init];
    
    point.coordinate = self.point.coordinate;
    
    vc.point = point;
    vc.location = self.hospitalAddressTextView.text;
    vc.delegate = self;
    [self.viewController.navigationController pushViewController:vc animated:true];
    
}

- (void)chooseAddressWithAddress:(NSString *)address withCoordinate:(CLLocationCoordinate2D)coordinate {
    
    [self.mapView removeAnnotation:self.point];
    
    self.point.coordinate = coordinate;
    
    self.mapView.centerCoordinate = coordinate;
    
    [self.mapView addAnnotation:self.point];
    
    self.hospitalAddressTextView.text = ISNIL(address);
    
    [self getLocationWithLocation:ISNIL(address)];
    
}


- (void)clickTimeViewAction:(UIButton *)sender{
    
    [self clickNoneAction];
    
    if (sender.tag == 1) {
        self.yingyeTimeView.hidden = false;
    } else if (sender.tag == 2) {
        self.menzhenTimeView.hidden = false;
    } else if (sender.tag == 3) {
        self.jizhenTimeView.hidden = false;
    }
    
}

- (void)clickNoneAction {
    
    self.yingyeTimeView.hidden = true;
    self.menzhenTimeView.hidden = true;
    self.jizhenTimeView.hidden = true;
    
    [self.addPhoneView endAllEditing];
    
    [self.hospitalNameTextView resignFirstResponder];
    
    [self.hospitalAddressTextView resignFirstResponder];
    
    [self.hospitalIntrudeTextView resignFirstResponder];
    
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
        
        buttonArray = self.levelButtonArray;
        
        for (UIButton *button in buttonArray) {
            
            if (button == sender) {
                continue;
            }
            
            button.selected = false;
            button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
            button.backgroundColor = [UIColor whiteColor];
            
        }
        
    } else if (sender.tag < 100) {
        
        buttonArray = self.typeButtonArray;
        
        for (UIButton *button in buttonArray) {
            
            if (button == sender) {
                continue;
            }
            
            button.selected = false;
            button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
            button.backgroundColor = [UIColor whiteColor];
            
        }
        
    } else if (sender.tag < 1000) {
        
        buttonArray = self.yibaoButtonArray;
        
        for (UIButton *button in buttonArray) {
            
            if (button == sender) {
                continue;
            }
            
            button.selected = false;
            button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
            button.backgroundColor = [UIColor whiteColor];
            
        }
        
    } else if (sender.tag < 10000) {
        
        buttonArray = self.propertyButtonArray;
        
        for (UIButton *button in buttonArray) {
            
            if (button == sender) {
                continue;
            }
            
            button.selected = false;
            button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
            button.backgroundColor = [UIColor whiteColor];
            
        }
        
    } else if (sender.tag < 100000) {
        
        buttonArray = self.tagButtonArray;
        
        for (UIButton *button in buttonArray) {
            
            if (button == sender) {
                continue;
            }
            
            button.selected = false;
            button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
            button.backgroundColor = [UIColor whiteColor];
            
        }
        
    }
    
    

    
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (textView == self.hospitalAddressTextView) {
        
        if (textView.text == 0) {
            self.hospitalAddressTextView.placeholder = @"请输入医院地址";
        } else {
            self.hospitalAddressTextView.placeholder = @"";
        }
        
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (textView.text && self.hospitalAddressTextView == textView) {
        self.hospitalAddressTextView.placeholder = @"";
        [self getLocationWithLocation:textView.text];
    }
    
}

- (void)getLocationWithLocation:(NSString *)str {
    
    self.countryName = @"";
    
    self.provinceName = @"";
    
    self.cityName = @"";
    
    self.countyName = @"";
    
    self.country = @"";
    
    self.province = @"";
    
    self.city = @"";
    
    self.county = @"";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"address"] = str;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiLocationGeocode withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[response[@"latitude"] doubleValue] longitude:[response[@"longitude"] doubleValue]];
            
            //终点坐标
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
            
            self.point.coordinate = coordinate;
            
            self.mapView.centerCoordinate = coordinate;
            
            self.countryName = response[@"countryName"];
            
            self.provinceName = response[@"provinceName"];
            
            self.cityName = response[@"cityName"];
            
            self.countyName = response[@"countyName"];
            
            if (self.countyName.length == 0 || self.countryName.length == 0 || self.provinceName.length == 0 || self.cityName.length == 0 ) {
                self.hospitalAddressTextView.text = @"";
                self.hospitalAddressTextView.placeholder = @"请输入医院地址";
                [SVProgressHUD showErrorWithStatus:@"请输入正确的医院地址"];
                return ;
            }
            
            [self getCountyId];
            
        }
        
    }];
    
}

/**
 获取 国家 省市区 id
 */
- (void)getCountyId {
    
    NSArray *array = [[GHSaveDataTool shareInstance] loadProvinceCityAreaData];
    
    if (array.count == 0) {
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSystemparamAreas withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            if (isSuccess) {
                
                
                NSMutableArray *provinceArray = [[NSMutableArray alloc] init];
                
                NSMutableArray *cityArray = [[NSMutableArray alloc] init];
                
                NSMutableArray *areaArray = [[NSMutableArray alloc] init];
                
                NSInteger provinceTag = 0;
                
                NSInteger cityTag = 0;
                
                for (NSDictionary *info in response) {
                    
                    GHAreaModel *model = [[GHAreaModel alloc] initWithDictionary:info error:nil];
                    
                    if (model == nil) {
                        continue;
                    }
                    
                    if ([model.areaLevel integerValue] == 1) {
                        [[GHSaveDataTool shareInstance] saveCountryDataWithArray:@[model]];
                    } else if ([model.areaLevel integerValue] == 2) {
                        
                        [provinceArray addObject:model];
                        
                    } else if ([model.areaLevel integerValue] == 3) {
                        
                        GHAreaModel *provinceModel = [provinceArray objectOrNilAtIndex:provinceTag];
                        
                        if ([provinceModel.areaCode integerValue] == [model.parentCode integerValue]) {
                            
                            if ([model.areaName isEqualToString:@"市辖区"]) {
                                model.areaName = provinceModel.areaName;
                            }
                            
                            [provinceModel.children addObject:model];
                            
                        } else {
                            
                            GHAreaModel *provinceModel = [provinceArray objectOrNilAtIndex:provinceTag + 1];
                            
                            if ([provinceModel.areaCode integerValue] == [model.parentCode integerValue]) {
                                
                                if ([model.areaName isEqualToString:@"市辖区"]) {
                                    model.areaName = provinceModel.areaName;
                                }
                                
                                [provinceModel.children addObject:model];
                                
                                provinceTag = [provinceArray indexOfObject:provinceModel];
                                
                            } else {
                                
                                for (GHAreaModel *provinceModel in provinceArray) {
                                    
                                    if ([provinceModel.areaCode integerValue] == [model.parentCode integerValue]) {
                                        
                                        if ([model.areaName isEqualToString:@"市辖区"]) {
                                            model.areaName = provinceModel.areaName;
                                        }
                                        
                                        [provinceModel.children addObject:model];
                                        
                                        provinceTag = [provinceArray indexOfObject:provinceModel];
                                        
                                        break;
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                        [cityArray addObject:model];
                        
                    } else if ([model.areaLevel integerValue] == 4) {
                        
                        GHAreaModel *cityModel = [cityArray objectOrNilAtIndex:cityTag];
                        
                        if ([cityModel.areaCode integerValue] == [model.parentCode integerValue]) {
                            
                            [cityModel.children addObject:model];
                            
                        } else {
                            
                            
                            GHAreaModel *cityModel = [cityArray objectOrNilAtIndex:provinceTag + 1];
                            
                            if ([cityModel.areaCode integerValue] == [model.parentCode integerValue]) {
                                
                                [cityModel.children addObject:model];
                                
                                cityTag = [cityArray indexOfObject:cityModel];
                                
                            } else {
                                
                                for (GHAreaModel *cityModel in cityArray) {
                                    
                                    if ([cityModel.areaCode integerValue] == [model.parentCode integerValue]) {
                                        
                                        [cityModel.children addObject:model];
                                        
                                        cityTag = [cityArray indexOfObject:cityModel];
                                        
                                        break;
                                        
                                    }
                                    
                                }
                                
                            }
                            
                            
                        }
                        
                        [areaArray addObject:model];
                        
                    }
                    
                }
                
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                    [[GHSaveDataTool shareInstance] saveProvinceCityAreaDataWithArray:[provinceArray copy]];
                    
                    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
                    [outputFormat setToneType:ToneTypeWithoutTone];
                    [outputFormat setVCharType:VCharTypeWithV];
                    [outputFormat setCaseType:CaseTypeUppercase];
                    
                    NSMutableArray *cityArray = [[NSMutableArray alloc] init];
                    
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    
                    NSMutableArray *provinceArray = [[NSMutableArray alloc] init];
                    
                    for (NSDictionary *info in response) {
                        
                        GHAreaModel *model = [[GHAreaModel alloc] initWithDictionary:info error:nil];
                        
                        if (model == nil) {
                            continue;
                        }
                        
                        if ([model.areaLevel integerValue] == 2) {
                            [provinceArray addObject:model];
                        } else if ([model.areaLevel integerValue] == 3) {
                            
                            if ([model.areaName isEqualToString:@"县"]) {
                                continue;
                            }
                            
                            if (model.areaName.length) {
                                
                                if ([model.areaName isEqualToString:@"市辖区"]) {
                                    
                                    for (GHAreaModel *provinceModel in provinceArray) {
                                        
                                        if ([provinceModel.areaCode integerValue] == [model.parentCode integerValue]) {
                                            model.areaName = provinceModel.areaName;
                                            break;
                                        }
                                        
                                    }
                                }
                                
                                if ([model.areaName isEqualToString:@"自治区直辖县级行政区划"] || [model.areaName isEqualToString:@"省直辖县级行政区划"]) {
                                    
                                    for (GHAreaModel *provinceModel in provinceArray) {
                                        
                                        if ([provinceModel.areaCode integerValue] == [model.parentCode integerValue]) {
                                            model.areaName = [NSString stringWithFormat:@"%@%@", ISNIL(provinceModel.areaName), ISNIL(model.areaName)];
                                            break;
                                        }
                                        
                                    }
                                    
                                }
                                
                                //                                if ([model.areaName hasSuffix:@"市"]) {
                                //                                    model.areaName = [model.areaName substringToIndex:model.areaName.length - 1];
                                //                                }
                                
                                NSString *pinYin = [PinyinHelper toHanyuPinyinStringWithNSString:model.areaName withHanyuPinyinOutputFormat:outputFormat withNSString:@" "];
                                
                                if (pinYin.length > 0) {
                                    
                                    model.fist = [pinYin substringToIndex:1];
                                    
                                    NSArray *pinyinArray = [pinYin componentsSeparatedByString:@" "];
                                    
                                    for (NSString *str in pinyinArray) {
                                        
                                        model.pinYin = [NSString stringWithFormat:@"%@%@",ISNIL(model.pinYin), ISNIL(str)];
                                        
                                        if (str.length) {
                                            model.fistPinYin = [NSString stringWithFormat:@"%@%@",ISNIL(model.fistPinYin), [str substringToIndex:1]];
                                        }
                                        
                                    }
                                    
                                    if ([dic.allKeys containsObject:model.fist]) {
                                        
                                        NSMutableArray *array = dic[model.fist];
                                        [array addObject:model];
                                        
                                    } else {
                                        
                                        NSMutableArray *array = [[NSMutableArray alloc] init];
                                        [array addObject:model];
                                        
                                        dic[model.fist] = array;
                                        
                                    }
                                    
                                }
                                
                            }
                            
                            
                            
                        } else if ([model.areaLevel integerValue] == 4) {
                            break;
                        }
                        
                    }
                    
                    
                    NSArray *arr = [dic allKeys];
                    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
                        NSComparisonResult result = [obj1 compare:obj2];
                        return result==NSOrderedDescending;
                    }];
                    
                    for (NSString *key in arr) {
                        
                        NSArray *valueArr = dic[key];
                        valueArr = [valueArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
                            NSComparisonResult result = [ISNIL(((GHAreaModel *)obj1).pinYin) compare:ISNIL(((GHAreaModel *)obj2).pinYin)];
                            return result==NSOrderedDescending;
                        }];
                        
                        NSDictionary *d = @{@"key":key,@"value":valueArr};
                        [cityArray addObject:d];
                        
                    }
                    
                    [[GHSaveDataTool shareInstance] saveSortCityDataWithArray:[cityArray copy]];
                    
                });
                
                
                [self getCountryIdWithArray:provinceArray];
                
            }
            
        }];
        
    } else {
        
        [self getCountryIdWithArray:array];
        
    }
    
    
    
    
}

- (void)getCountryIdWithArray:(NSArray *)array {
    
    self.country = @"1";
    
    for (NSInteger index = 0; index < array.count; index++) {
        
        GHAreaModel *provinceModel = [array objectOrNilAtIndex:index];
        
        if ([provinceModel.areaName hasPrefix:self.provinceName]) {
            
            self.province = provinceModel.modelId;
            
            for (NSInteger indexY = 0; indexY < provinceModel.children.count; indexY++) {
                
                GHAreaModel *cityModel = [provinceModel.children objectOrNilAtIndex:indexY];
                
                if ([cityModel.areaName hasPrefix:self.cityName]) {
                    
                    self.city = cityModel.modelId;
                    
                    for (NSInteger indexZ = 0; indexZ < cityModel.children.count; indexZ++) {
                        
                        GHAreaModel *countyModel = [cityModel.children objectOrNilAtIndex:indexZ];
                        
                        if ([countyModel.areaName hasPrefix:self.countyName]) {
                            
                            self.county = countyModel.modelId;
                            
                            break;
                        }
                        
                    }
                    
                    
                    break;
                    
                }
                
            }
            
            break;
            
        }
        
    }
    
}





@end

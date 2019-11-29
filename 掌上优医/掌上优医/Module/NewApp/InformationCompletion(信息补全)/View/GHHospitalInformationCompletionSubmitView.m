//
//  GHHospitalInformationCompletionSubmitView.m
//  掌上优医
//
//  Created by GH on 2019/6/4.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHospitalInformationCompletionSubmitView.h"
#import "JFMorePhotoView.h"
#import "UIButton+touch.h"
#import "GHTextView.h"
#import "GHAddHospitalTagView.h"
#import "GHHospitalDetailInfoErrorAddPhoneView.h"
#import "GHHospitalTimeChooseView.h"
#import "GHAddHospitalAuthenticationViewController.h"
#import "GHAddHospitalInformationViewController.h"
#import "GHHospitalInformationModel.h"

@interface GHHospitalInformationCompletionSubmitView () <GHAddHospitalTagViewDelegate, GHHospitalTimeChooseViewDelegate, GHHospitalDetailInfoErrorAddPhoneViewDelegate, GHAddHospitalAuthenticationViewControllerDelegate, GHAddHospitalInformationViewControllerDelegate>

@property (nonatomic, strong) JFMorePhotoView *hospitalHeaderPhotoView;

@property (nonatomic, strong) JFMorePhotoView *hospitalEnvironmentPhotoView;

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
 医院自定义标签 View
 */
@property (nonatomic, strong) GHAddHospitalTagView *hospitalCustomTagView;

/**
 <#Description#>
 */
@property (nonatomic, assign) CGFloat customTagViewHeight;

@property (nonatomic, assign) CGFloat addPhoneViewHeight;

@property (nonatomic, assign) CGFloat hospitalNewsViewHeight;

@property (nonatomic, strong) GHHospitalDetailInfoErrorAddPhoneView *addPhoneView;

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
 医院资质 ImageView
 */
@property (nonatomic, strong) UIImageView *hospitalAuthenticationImageView;

/**
 医院资质 JSON String
 */
@property (nonatomic, copy) NSString<Optional> *qualityCertifyMaterials;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIView *hospitalInformationView;

@property (nonatomic, copy) NSArray *hospitalInformationArray;

@property (nonatomic, strong) NSMutableArray *hospitalInformationTitleLabelArray;

@end

@implementation GHHospitalInformationCompletionSubmitView

- (NSMutableArray *)hospitalInformationTitleLabelArray {
    
    if (!_hospitalInformationTitleLabelArray) {
        _hospitalInformationTitleLabelArray = [[NSMutableArray alloc] init];
    }
    return _hospitalInformationTitleLabelArray;
    
}

- (GHHospitalTimeChooseView *)yingyeTimeView {
    
    if (!_yingyeTimeView) {
        _yingyeTimeView = [[GHHospitalTimeChooseView alloc] init];
        _yingyeTimeView.delegate = self;
        _yingyeTimeView.titleLabel.text = @"营业时间";
        [self.viewController.view addSubview:_yingyeTimeView];
        
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
        [self.viewController.view addSubview:_menzhenTimeView];
        
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
        [self.viewController.view addSubview:_jizhenTimeView];
        
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

- (void)setModel:(GHSearchHospitalModel *)model {
    
    _model = model;
    
    [self setupUI];
    
}

- (void)setupUI {
    
    CGFloat contentHeight = 0;
    
    UIView *nameContentView = [[UIView alloc] init];
    nameContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:nameContentView];
    
    [nameContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    contentHeight += 100;
    
    UILabel *hospitalNameLabel = [[UILabel alloc] init];
    hospitalNameLabel.font = HM17;
    hospitalNameLabel.textColor = kDefaultBlackTextColor;
    hospitalNameLabel.text = ISNIL(self.model.hospitalName);
    [nameContentView addSubview:hospitalNameLabel];
    
    [hospitalNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(10);
    }];
    
    UILabel *hospitalAddressLabel = [[UILabel alloc] init];
    hospitalAddressLabel.font = H14;
    hospitalAddressLabel.textColor = kDefaultGrayTextColor;
    hospitalAddressLabel.text = ISNIL(self.model.hospitalAddress);
    [nameContentView addSubview:hospitalAddressLabel];
    
    [hospitalAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(42);
    }];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    iconImageView.image = [UIImage imageNamed:@"ic_fujinyiyuan_dizhi_unsected"];
    [nameContentView addSubview:iconImageView];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(15);
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(70);
    }];
    
    UILabel *hospitalDistanceLabel = [[UILabel alloc] init];
    hospitalDistanceLabel.font = H14;
    hospitalDistanceLabel.textColor = kDefaultBlackTextColor;
    hospitalDistanceLabel.text = [NSString stringWithFormat:@"距离您%@", [ISNIL(self.model.distance) getKillMeter]];
    [nameContentView addSubview:hospitalDistanceLabel];
    
    [hospitalDistanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(38);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(15);
        make.centerY.mas_equalTo(iconImageView);
    }];
    
    UILabel *lineLabel1 = [[UILabel alloc] init];
    lineLabel1.backgroundColor = kDefaultGaryViewColor;
    [self addSubview:lineLabel1];
    
    [lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(nameContentView.mas_bottom);
    }];
    
    contentHeight += 10;
    
    UIView *imageContentView = [[UIView alloc] init];
    imageContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:imageContentView];
    
    [imageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel1.mas_bottom);
        make.height.mas_equalTo(350 + 90);
    }];
    contentHeight += 440;
    
    
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
    hospitalHeaderImageTitleLabel.text = @"医院封面照";
    [imageContentView addSubview:hospitalHeaderImageTitleLabel];
    
    [hospitalHeaderImageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(65);
    }];

    
    JFMorePhotoView *hospitalHeaderPhotoView = [[JFMorePhotoView alloc] initWithCount:1];
    hospitalHeaderPhotoView.canAddCount = 1;
    if (self.model.profilePhoto.length) {
        hospitalHeaderPhotoView.isOnlyCanCancel = true;
        hospitalHeaderPhotoView.imageUrlArray = @[self.model.profilePhoto];
        
    }
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
    hospitalEnvImageTitleLabel.text = @"医院环境图片";
    [imageContentView addSubview:hospitalEnvImageTitleLabel];
    
    [hospitalEnvImageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(208);
    }];
    
    
    
    if (self.model.pictures.length) {
        
        NSMutableArray *urlArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in [self.model.pictures jsonValueDecoded]) {
            [urlArray addObject:ISNIL(dic[@"url"])];
        }
        
        JFMorePhotoView *hospitalEnvironmentPhotoView = [[JFMorePhotoView alloc] initWithCount:urlArray.count];
        hospitalEnvironmentPhotoView.canAddCount = urlArray.count;
        
        hospitalEnvironmentPhotoView.isOnlyCanCancel = true;
        
        hospitalEnvironmentPhotoView.imageUrlArray = urlArray;
        
        [imageContentView addSubview:hospitalEnvironmentPhotoView];
        self.hospitalEnvironmentPhotoView = hospitalEnvironmentPhotoView;
        
        [hospitalEnvironmentPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.right.mas_equalTo(-16);
            make.top.mas_equalTo(hospitalEnvImageTitleLabel.mas_bottom).offset(15);
            if (urlArray.count < 4) {
                make.height.mas_equalTo(90);
            } else {
                make.height.mas_equalTo(160);
            }
            
        }];
        
        if (urlArray.count < 4) {
            [imageContentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(350);
            }];
            contentHeight -= 90;
        }
        
    } else {
        
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
        
    }
    
    
    
    UILabel *lineLabel2 = [[UILabel alloc] init];
    lineLabel2.backgroundColor = kDefaultGaryViewColor;
    [self addSubview:lineLabel2];
    
    [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(imageContentView.mas_bottom);
    }];
    
    contentHeight += 10;
    
    UIView *chooseContentView = [[UIView alloc] init];
    chooseContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:chooseContentView];
    
    [chooseContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel2.mas_bottom);
        make.height.mas_equalTo(737);
    }];
    
    contentHeight += 737;
    
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
    [self addSubview:lineLabel3];
    
    if ([self.model.categoryByScale isEqualToString:@"综合医院"]) {
        
        [lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(10);
            make.top.mas_equalTo(chooseContentView.mas_bottom);
        }];
        
        contentHeight += 10;
        
        contentHeight += 50;
        
    } else {
        
        UIView *customTagContentView = [[UIView alloc] init];
        customTagContentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:customTagContentView];
        
        [customTagContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(chooseContentView.mas_bottom);
        }];
        contentHeight += 40;
        
        
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
        customTagView.delegate = self;
        [customTagContentView addSubview:customTagView];
        
        [customTagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(30);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(60);
        }];
        self.hospitalCustomTagView = customTagView;
        
        if (self.model.hospitalTags.length) {
            
            [customTagView.tagArray addObjectsFromArray:[self.model.hospitalTags componentsSeparatedByString:@","]];
            
            [customTagView updateUI];
            
//            for (UIButton *button in customTagView.tagCloseArray) {
//                button.hidden = true;
//            }
//
//            customTagView.addTagButton.hidden = true;
//
            if (customTagView.tagArray.count < 3) {
                self.customTagViewHeight = 60;
                contentHeight += 60;
            } else {
                self.customTagViewHeight = (((customTagView.tagArray.count) / 3) * (30 + 17) + 50);
                contentHeight += (((customTagView.tagArray.count) / 3) * (30 + 17) + 50);
            }
//
//            for (UIButton *button in customTagView.tagButtonArray) {
//
//                button.enabled = false;
//                button.backgroundColor = kDefaultGaryViewColor;
//                [button setTitleColor:kDefaultGrayTextColor forState:UIControlStateNormal];
//
//            }
            
        } else {
            self.customTagViewHeight = 60;
            contentHeight += 60;
//            contentHeight += (((5) / 3) * (30 + 17) + 50);
        }
        
        [customTagContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(customTagView.mas_bottom).offset(10);
        }];
        
        [lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(10);
            make.top.mas_equalTo(customTagContentView.mas_bottom);
        }];
        
        contentHeight += 10;
        
    }
    
    UIView *phoneAndTimeContentView = [[UIView alloc] init];
    phoneAndTimeContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:phoneAndTimeContentView];
    
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
    addPhoneView.delegate = self;
    [phoneAndTimeContentView addSubview:addPhoneView];
    
    [addPhoneView setupPhoneArray:[self.model.contactNumber componentsSeparatedByString:@","]];
    
    [phoneContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(addPhoneView);
    }];
    self.addPhoneView = addPhoneView;
    
    if ([self.model.contactNumber componentsSeparatedByString:@","].count == 0) {

        self.addPhoneViewHeight = 60;
        contentHeight += 60;
        
    } else {
        
        self.addPhoneViewHeight = (48 + [self.model.contactNumber componentsSeparatedByString:@","].count * 60);
        contentHeight += (48 + [self.model.contactNumber componentsSeparatedByString:@","].count * 60);
    }
    
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
    
    if ([self.model.categoryByScale hasPrefix:@"综合医院"]) {
        
        
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
        menzhenTimeLabel.text = ISNIL(self.model.outpatientDepartmentTime);
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
        jizhenTimeLabel.text = ISNIL(self.model.emergencyTreatmentTime);
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
        
        contentHeight += 160;
        
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
        yingyeTimeLabel.text = ISNIL(self.model.outpatientDepartmentTime);
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
        
        contentHeight += 100;
        
    }
    
    [phoneAndTimeContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(timeContentView.mas_bottom);
    }];
    
    UILabel *lineLabel4 = [[UILabel alloc] init];
    lineLabel4.backgroundColor = kDefaultGaryViewColor;
    [self addSubview:lineLabel4];
    
    [lineLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(phoneAndTimeContentView.mas_bottom);
    }];
    
    contentHeight += 10;
    
    
    UIView *hospitalInfoContentView = [[UIView alloc] init];
    hospitalInfoContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:hospitalInfoContentView];
    
    [hospitalInfoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel4.mas_bottom);
        make.height.mas_equalTo(235);
    }];
    contentHeight += 235;
    
    UILabel *hospitalIntrudeTitleLabel = [[UILabel alloc] init];
    hospitalIntrudeTitleLabel.font = H16;
    hospitalIntrudeTitleLabel.textColor = kDefaultBlackTextColor;
    hospitalIntrudeTitleLabel.text = @"医院简介";
    [hospitalInfoContentView addSubview:hospitalIntrudeTitleLabel];
    
    [hospitalIntrudeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(60);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    GHTextView *intrudeTextView = [[GHTextView alloc] initWithFrame:CGRectMake(16, 60, SCREENWIDTH - 32, 150)];
    intrudeTextView.font = H16;
    intrudeTextView.layer.borderColor = kDefaultGaryViewColor.CGColor;
    intrudeTextView.layer.borderWidth = 1;
    intrudeTextView.textColor = kDefaultBlackTextColor;
    intrudeTextView.backgroundColor = [UIColor whiteColor];
    intrudeTextView.text = ISNIL(self.model.introduction);
    [hospitalInfoContentView addSubview:intrudeTextView];
    
    self.hospitalIntrudeTextView = intrudeTextView;
    
    UILabel *lineLabel5 = [[UILabel alloc] init];
    lineLabel5.backgroundColor = kDefaultGaryViewColor;
    [self addSubview:lineLabel5];
    
    [lineLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(hospitalInfoContentView.mas_bottom);
    }];
    contentHeight += 10;
    
    
    UIView *sheshiContentView = [[UIView alloc] init];
    sheshiContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:sheshiContentView];
    
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
    
    NSArray *sheshiSelectedArray = [self.model.hospitalFacility componentsSeparatedByString:@","];
    
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
        
        if ([sheshiSelectedArray containsObject:ISNIL(str)]) {
            
            sicknessButton.selected = true;
            sicknessButton.layer.borderColor = kDefaultBlueColor.CGColor;
            sicknessButton.backgroundColor = UIColorHex(0xEFF0FD);
            
        }
        
    }
    
    [hotContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(line * 35 + 25 + 16);
    }];
    
    [sheshiContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(hotContentView.mas_bottom);
    }];
    
    contentHeight += 70;
    contentHeight += (line * 35 + 25 + 16);
    
    UILabel *lineLabel6 = [[UILabel alloc] init];
    lineLabel6.backgroundColor = kDefaultGaryViewColor;
    [self addSubview:lineLabel6];
    
    [lineLabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(sheshiContentView.mas_bottom);
    }];
    
    contentHeight += 10;
    
    
    UIView *hospitalAuthenticationContentView = [[UIView alloc] init];
    hospitalAuthenticationContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:hospitalAuthenticationContentView];
    
    [hospitalAuthenticationContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(sheshiContentView.mas_bottom).offset(0);
        make.height.mas_equalTo(80 + 60 + 10);
    }];
    contentHeight += 150;
    
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
    
    if (self.model.qualityCertifyMaterials.length) {
        [self uploadHospitalAuthenticationWithMaterials:self.model.qualityCertifyMaterials];
    }
    
    
//    UIView *hospitalInformationContentView = [[UIView alloc] init];
//    hospitalInformationContentView.backgroundColor = [UIColor whiteColor];
//    [self addSubview:hospitalInformationContentView];
//
//    [hospitalInformationContentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(0);
//        make.top.mas_equalTo(hospitalAuthenticationContentView.mas_bottom).offset(0);
//        make.height.mas_equalTo(140);
//    }];
//    self.hospitalInformationView = hospitalInformationContentView;
//
//    self.hospitalNewsViewHeight = 140;
//    contentHeight += 140;
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
//        make.centerX.mas_equalTo(hospitalInformationContentView);
//        make.bottom.mas_equalTo(-40);
//    }];
//    [addHospitalInformationButton addTarget:self action:@selector(clickAddHospitalInformationAction) forControlEvents:UIControlEventTouchUpInside];
//
//    NSMutableArray *newsArray = [[NSMutableArray alloc] init];
//
//    for (NSDictionary *dic in [self.model.hospitalNews jsonValueDecoded]) {
//
//        GHHospitalInformationModel *newsModel = [[GHHospitalInformationModel alloc] initWithDictionary:dic error:nil];
//
//
//        if (newsModel == nil) {
//            continue;
//        }
//
//        [newsArray addObject:newsModel];
//
//    }
//
//    if (newsArray.count) {
//        [self finishSaveHospitalInformationWithArray:[newsArray copy]];
//    }
    
    UILabel *lineLabel7 = [[UILabel alloc] init];
    lineLabel7.backgroundColor = kDefaultGaryViewColor;
    [self addSubview:lineLabel7];
    
    [lineLabel7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(hospitalAuthenticationContentView.mas_bottom);
    }];
    contentHeight += 10;
    
    UIView *submitContentView = [[UIView alloc] init];
    submitContentView.backgroundColor = kDefaultGaryViewColor;
    [self addSubview:submitContentView];
    
    [submitContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel7.mas_bottom);
        make.height.mas_equalTo(90);
    }];
    
    contentHeight += 90;
    
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
    
    
    self.contentHeight = contentHeight;
    
    [self updateUI];
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


- (void)clickSubmitAction {
    
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
    
    params[@"originHospitalId"] = self.model.modelId;
    
    if ([self.model.categoryByScale isEqualToString:@"诊所"]) {
        
        params[@"outpatientDepartmentTime"] = self.yingyeTimeLabel.text.length ? self.yingyeTimeLabel.text : nil;
        
        params[@"hospitalTags"] = self.hospitalCustomTagView.tagArray.count ? [self.hospitalCustomTagView.tagArray componentsJoinedByString:@","] : nil;
        
    } else if ([self.model.categoryByScale isEqualToString:@"专科医院"]) {
        
        params[@"outpatientDepartmentTime"] = self.yingyeTimeLabel.text.length ? self.yingyeTimeLabel.text : nil;
        
        params[@"hospitalTags"] = self.hospitalCustomTagView.tagArray.count ? [self.hospitalCustomTagView.tagArray componentsJoinedByString:@","] : nil;
        
    } else {
        
        params[@"emergencyTreatmentTime"] = self.jizhenTimeLabel.text.length ? self.jizhenTimeLabel.text : nil;
        
        params[@"outpatientDepartmentTime"] = self.menzhenTimeLabel.text.length ? self.menzhenTimeLabel.text : nil;
        
    }
    
    params[@"dataCollectionType"] = @(2);
    
    params[@"country"] = self.model.country;
    params[@"province"] = self.model.province;
    params[@"city"] = self.model.city;
    params[@"county"] = self.model.county;
    params[@"lat"] = self.model.lat;
    params[@"lng"] = self.model.lng;

    params[@"contactNumber"] = [self.addPhoneView getContactNumberString].length ? [self.addPhoneView getContactNumberString] : nil;

    params[@"governmentalHospitalFlag"] = governmentalHospitalFlag;
    
    params[@"grade"] = grade;
    
    params[@"hospitalAddress"] = self.model.hospitalAddress;
    
    params[@"qualityCertifyMaterials"] = self.qualityCertifyMaterials.length ? self.qualityCertifyMaterials : nil;
    
    params[@"hospitalName"] = self.model.hospitalName;
    
    params[@"introduction"] = self.hospitalIntrudeTextView.text.length ? self.hospitalIntrudeTextView.text : nil;
    
    params[@"medicalInsuranceFlag"] = medicalInsuranceFlag;
    
    params[@"medicineType"] = hospitalTag;
    
    params[@"profilePhoto"] = [self.hospitalHeaderPhotoView getOnlyImageUrlArray].count ? [[self.hospitalHeaderPhotoView getOnlyImageUrlArray] firstObject] : nil;
    
    if ([self.hospitalEnvironmentPhotoView uploadImageUrlArray].count) {
        
        NSMutableArray *picturesArray = [[NSMutableArray alloc] init];
        
        for (id dic in [self.hospitalEnvironmentPhotoView uploadImageUrlArray]) {
            
            if ([dic isKindOfClass:[NSDictionary class]]) {
                [picturesArray addObject:dic];
            } else {
                [picturesArray addObject:@{@"url": dic}];
            }
            
        }
        
        params[@"pictures"] =  [picturesArray jsonStringEncoded];
        
    }
    
    
    
    params[@"hospitalFacility"] = hospitalFacilityArray.count ? [hospitalFacilityArray componentsJoinedByString:@","] : nil;
    
    
    params[@"userId"] = [GHUserModelTool shareInstance].userInfoModel.modelId;
    params[@"userNickName"] = ISNIL([GHUserModelTool shareInstance].userInfoModel.nickName).length ? [GHUserModelTool shareInstance].userInfoModel.nickName : ISNIL([GHUserModelTool shareInstance].userInfoModel.showPhoneNum);
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiDataCollectionHospital withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            self.viewController.navigationItem.title = @"提交成功";
            
            [SVProgressHUD showSuccessWithStatus:@"恭喜您,提交成功"];
            
            [self.viewController.navigationController popViewControllerAnimated:true];
            
        }
        
    }];
    
}
// GXN,TJCG
- (void)clickHospitalAuthenticationAction {
    
    GHAddHospitalAuthenticationViewController *vc = [[GHAddHospitalAuthenticationViewController alloc] init];
    vc.delegate = self;
    vc.qualityCertifyMaterials = self.qualityCertifyMaterials;
    [self.viewController.navigationController pushViewController:vc animated:true];
    
}

- (void)uploadHospitalAuthenticationWithMaterials:(NSString *)materials {
    
    self.qualityCertifyMaterials = materials;

    [self.hospitalAuthenticationImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL([[materials jsonValueDecoded][@"pics"] firstObject][@"url"]))];
//    [self.hospitalAuthenticationImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL([materials jsonValueDecoded][@"pics"]))];
    
}

- (void)updateCustomTagViewWithHeight:(CGFloat)height {
    
    self.contentHeight -= self.customTagViewHeight;
    
    self.customTagViewHeight = height;
    
    self.contentHeight += self.customTagViewHeight;
    
    [self updateHeight];
    
}

- (void)updateAddPhoneViewWithHeight:(CGFloat)height {
    
    self.contentHeight -= self.addPhoneViewHeight;
    
    self.addPhoneViewHeight = height;
    
    self.contentHeight += self.addPhoneViewHeight;
    
    [self updateHeight];
    
}

- (void)updateHeight {
    
    if ([self.delegate respondsToSelector:@selector(updateSubmitViewWithHeight:)]) {
        [self.delegate updateSubmitViewWithHeight:self.contentHeight];
    }
    
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

- (void)updateUI {
    
    if (self.model.hospitalGrade.length) {
        
        for (UIButton *button in self.levelButtonArray) {
            
            button.enabled = false;
            button.backgroundColor = kDefaultGaryViewColor;
            [button setTitleColor:kDefaultGrayTextColor forState:UIControlStateNormal];
            
            if ([button.currentTitle isEqualToString:ISNIL(self.model.hospitalGrade)]) {
                
                button.selected = true;
                button.layer.borderColor = kDefaultBlueColor.CGColor;
                button.backgroundColor = UIColorHex(0xEFF0FD);
                
                [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
                
            }
         
            
            
        }
        
    }
    
    if (self.model.category.length) {
        
        for (UIButton *button in self.typeButtonArray) {
            
            button.enabled = false;
            button.backgroundColor = kDefaultGaryViewColor;
            [button setTitleColor:kDefaultGrayTextColor forState:UIControlStateNormal];
            
            if ([button.currentTitle isEqualToString:ISNIL(self.model.category)]) {
                
                button.selected = true;
                button.layer.borderColor = kDefaultBlueColor.CGColor;
                button.backgroundColor = UIColorHex(0xEFF0FD);
                
                [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
                
            }
            

            
        }
        
    }
    
    if (self.model.medicalInsuranceFlag.length) {
        
        for (UIButton *button in self.yibaoButtonArray) {
            
            button.enabled = false;
            button.backgroundColor = kDefaultGaryViewColor;
            [button setTitleColor:kDefaultGrayTextColor forState:UIControlStateNormal];
            
        }
        
        if ([self.model.medicalInsuranceFlag integerValue] == 1) {
            
            UIButton *button = [self.yibaoButtonArray firstObject];
            
            button.selected = true;
            button.layer.borderColor = kDefaultBlueColor.CGColor;
            button.backgroundColor = UIColorHex(0xEFF0FD);
            
            [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
            
        } else {
            
            UIButton *button = [self.yibaoButtonArray lastObject];
            
            button.selected = true;
            button.layer.borderColor = kDefaultBlueColor.CGColor;
            button.backgroundColor = UIColorHex(0xEFF0FD);
            
            [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
            
        }
        

        
    }
    
    if (self.model.governmentalHospitalFlag.length) {
        
        for (UIButton *button in self.propertyButtonArray) {
            
            button.enabled = false;
            button.backgroundColor = kDefaultGaryViewColor;
            [button setTitleColor:kDefaultGrayTextColor forState:UIControlStateNormal];
            
        }
        
        if ([self.model.governmentalHospitalFlag integerValue] == 1) {
            
            UIButton *button = [self.propertyButtonArray lastObject];
            
            button.selected = true;
            button.layer.borderColor = kDefaultBlueColor.CGColor;
            button.backgroundColor = UIColorHex(0xEFF0FD);
            
            [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
            
        } else {
            
            UIButton *button = [self.propertyButtonArray firstObject];
            
            button.selected = true;
            button.layer.borderColor = kDefaultBlueColor.CGColor;
            button.backgroundColor = UIColorHex(0xEFF0FD);
            
            [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
            
        }
        

        
    }
    
 
    
    if (self.model.medicineType.length) {
        
        for (UIButton *button in self.tagButtonArray) {
            
            button.enabled = false;
            button.backgroundColor = kDefaultGaryViewColor;
            [button setTitleColor:kDefaultGrayTextColor forState:UIControlStateNormal];
            
            
            if ([button.currentTitle isEqualToString:ISNIL(self.model.medicineType)]) {
                
                button.selected = true;
                button.layer.borderColor = kDefaultBlueColor.CGColor;
                button.backgroundColor = UIColorHex(0xEFF0FD);
                
                [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
                
            }
            
        }
        
//        if ([self.model.medicineType isEqualToString:@"中医"]) {
//
//            UIButton *button = [self.tagButtonArray firstObject];
//
//            button.selected = true;
//            button.layer.borderColor = kDefaultBlueColor.CGColor;
//            button.backgroundColor = UIColorHex(0xEFF0FD);
//
//            [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
//
//        } else if ([self.model.medicineType isEqualToString:@"西医"]) {
//
//            UIButton *button = [self.tagButtonArray lastObject];
//
//            button.selected = true;
//            button.layer.borderColor = kDefaultBlueColor.CGColor;
//            button.backgroundColor = UIColorHex(0xEFF0FD);
//
//            [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
//
//        } else {
//
//            UIButton *button = [self.tagButtonArray firstObject];
//
//            button.selected = true;
//            button.layer.borderColor = kDefaultBlueColor.CGColor;
//            button.backgroundColor = UIColorHex(0xEFF0FD);
//
//            UIButton *lastButton = [self.tagButtonArray lastObject];
//
//            lastButton.selected = true;
//            lastButton.layer.borderColor = kDefaultBlueColor.CGColor;
//            lastButton.backgroundColor = UIColorHex(0xEFF0FD);
//
//            [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
//
//            [lastButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
//
//        }
        

        
    }
    

    
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
//
//    [self.hospitalNameTextView resignFirstResponder];
//
//    [self.hospitalAddressTextView resignFirstResponder];
    
    [self.hospitalIntrudeTextView resignFirstResponder];
    
}



@end

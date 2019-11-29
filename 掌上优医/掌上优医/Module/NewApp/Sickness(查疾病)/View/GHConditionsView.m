//
//  GHConditionsView.m
//  掌上优医
//
//  Created by apple on 2019/8/8.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHConditionsView.h"
#import "GHProvinceCityAreaViewController.h"
#import "GHDoctorSortViewController.h"
#import "GHDoctorFilterViewController.h"

#import "GHHospitalSortViewController.h"
#import "GHHospitalFilterViewController.h"

@interface GHConditionsView ()<GHProvinceCityAreaViewControllerDelegate,GHDoctorSortViewControllerDelegate,GHDoctorFilterViewControllerDelegate,GHHospitalSortViewControllerDelegate,GHHospitalFilterViewControllerDelegate>

@property (nonatomic , strong)GHProvinceCityAreaViewController *locationview;

@property (nonatomic , strong)GHDoctorSortViewController *sortview; // y医生 排序

@property (nonatomic , strong)GHDoctorFilterViewController *fillerView;//医生 筛选

@property (nonatomic , strong)GHHospitalSortViewController *hospitalSortview;//医院 排序

@property (nonatomic , strong)GHHospitalFilterViewController *hospitalFillerView;//医院 排序



@end


@implementation GHConditionsView

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
        self.backgroundColor = RGBACOLOR(51,51,51,0.2);
        [self creatUI];
    }
    return self;
}
- (void)creatUI
{
    [self hiddenSubView];
}
- (void)setConditions:(GHconditions)conditions
{
    _conditions = conditions;
    
    
    if (conditions == GHconditions_Location) {
        
        if (self.locationview.view.hidden) {
            
            self.locationview.view.hidden = NO;
            self.sortview.view.hidden = YES;
            self.fillerView.view.hidden = YES;
            self.hospitalFillerView.view.hidden = YES;
            self.hospitalSortview.view.hidden = YES;
        }
        else
        {
            [self clickNoneView];

        }
        
    }
    else if (conditions == GHconditions_Sorting)
    {
        
        if (self.rolesType == GHrolesType_Doctor) {
            
            if (self.sortview.view.hidden) {
                self.sortview.view.hidden = NO;
                self.locationview.view.hidden = YES;
                self.fillerView.view.hidden = YES;
                self.hospitalFillerView.view.hidden = YES;
                self.hospitalSortview.view.hidden = YES;
            }
            else
            {
                [self clickNoneView];
                
            }
            
        }
        else
        {
            if (self.hospitalSortview.view.hidden) {
                self.hospitalSortview.view.hidden = NO;
                self.locationview.view.hidden = YES;
                self.sortview.view.hidden = YES;
                self.fillerView.view.hidden = YES;
                self.hospitalFillerView.view.hidden = YES;
                
            }
            else
            {
                [self clickNoneView];

            }
        }
       
    }
    else
    {
        if (self.rolesType == GHrolesType_Doctor) {
            if (self.fillerView.view.hidden) {
                self.fillerView.view.hidden = NO;
                self.locationview.view.hidden = YES;
                self.sortview.view.hidden = YES;
                self.hospitalFillerView.view.hidden = YES;
                self.hospitalSortview.view.hidden = YES;
            }
            else
            {
                [self clickNoneView];
                
            }
        }
        else
        {
            if (self.hospitalFillerView.view.hidden) {
                self.hospitalFillerView.view.hidden = NO;
                self.hospitalSortview.view.hidden = YES;
                self.locationview.view.hidden = YES;
                self.sortview.view.hidden = YES;
                self.fillerView.view.hidden = YES;
            }
            else
            {
                [self clickNoneView];

            }
            
        }
        
       
    }
}

- (void)clickNoneView
{
    [self hiddenSubView];
    self.hidden = YES;
}

- (void)hiddenSubView
{
    self.locationview.view.hidden = YES;
    self.sortview.view.hidden = YES;
    self.fillerView.view.hidden = YES;
    self.hospitalSortview.view.hidden = YES;
    self.hospitalFillerView.view.hidden = YES;

}

#pragma mark - GHProvinceCityAreaViewControllerDelegate  选择地域
- (void)chooseFinishWithCountryModel:(GHAreaModel *)countryModel provinceModel:(GHAreaModel *)provinceModel cityModel:(GHAreaModel *)cityModel areaModel:(GHAreaModel *)areaModel areaLevel:(NSInteger)areaLevel {
    
//    NSString *location = @"";
//    NSString *AreaId = @"";
    
//    if (areaLevel == 4) {
//        location = ISNIL(areaModel.areaName);
//        AreaId = areaModel.modelId;
//    } else if (areaLevel == 3) {
//        location = ISNIL(cityModel.areaName);
//        AreaId = cityModel.modelId;
//
//    } else if (areaLevel == 2) {
//        location = ISNIL(provinceModel.areaName);
//        AreaId = provinceModel.modelId;
//
//    } else if (areaLevel == 1) {
//        location = @"全国";
//        AreaId = countryModel.modelId;
//    }
    if (areaLevel == 1) {
        if (self.chooseLocationBlock) {
            self.chooseLocationBlock(countryModel.areaName, @"", @"",areaLevel);
        }
    }
    else if (areaLevel == 2)
    {
        if (self.chooseLocationBlock) {
                  self.chooseLocationBlock(provinceModel.areaName, @"", @"",areaLevel);
              }
    }
    else if (areaLevel == 3)
    {
        if (self.chooseLocationBlock) {
            self.chooseLocationBlock(provinceModel.areaName, cityModel.areaName, @"",areaLevel);
        }
    }
    else
    {
        if (self.chooseLocationBlock) {
            self.chooseLocationBlock(provinceModel.areaName, cityModel.areaName, areaModel.areaName,areaLevel);
        }
    }
    
    
    
    
    [self clickNoneView];
    
    
}

#pragma  mark - GHDoctorSortViewControllerDelegate 选择排序方式
- (void)chooseFinishDoctorSortWithSort:(NSString *)sort
{
    if (self.chooseSortBlock) {
        self.chooseSortBlock(ISNIL(sort));
    }
    [self clickNoneView];
}

#pragma mark - GHDoctorFilterViewControllerDelegate 筛选

/**
 chooseFillerBlock

 @param position 医生职称
 @param doctorType 医院类型
 @param hospitalLevel 医院等级
 */
- (void)chooseFinishDoctorPosition:(NSString *)position doctorType:(NSString *)doctorType hospitalLevel:(NSString *)hospitalLevel {
    
    if (self.chooseFillerBlock) {
        self.chooseFillerBlock(position, doctorType, hospitalLevel);
    }
    
    [self clickNoneView];

    
}
#pragma mark - GHHospitalSortViewControllerDelegate 医院 排序
- (void)chooseFinishHospitalSortWithSort:(NSString *)sort
{
    if (self.chooseSortBlock) {
        self.chooseSortBlock(ISNIL(sort));
    }
    [self clickNoneView];
}

- (void)chooseFinishHospitalType:(NSString *)type level:(NSString *)level
{
    if (self.chooseFillerBlock) {
        self.chooseFillerBlock(@"", type, level);
    }
    
    [self clickNoneView];
}

/**
 选择地域控制器
 
 @return _locationview
 */
- (GHProvinceCityAreaViewController *)locationview
{
    if (!_locationview) {
        _locationview = [[GHProvinceCityAreaViewController alloc] init];
        _locationview.view.frame = CGRectMake(0, 0, SCREENWIDTH, 338);
        _locationview.delegate = self;
        [self addSubview:_locationview.view];
    }
    return _locationview;
}

/**
 选择排序控制器
 
 @return _sortview
 */
- (GHDoctorSortViewController *)sortview
{
    if (!_sortview) {
        _sortview = [[GHDoctorSortViewController alloc] init];
        _sortview.view.frame = CGRectMake(0, 0, SCREENWIDTH, 90);
        _sortview.delegate = self;
        [self addSubview:_sortview.view];
    }
    return _sortview;
}

/**
 筛选d控制器
 
 @return _fillerView
 */
- (GHDoctorFilterViewController *)fillerView
{
    if (!_fillerView) {
        _fillerView = [[GHDoctorFilterViewController alloc] init];
        _fillerView.view.frame = CGRectMake(0, 0, SCREENWIDTH, 368);
        _fillerView.delegate = self;
        [self addSubview:_fillerView.view];
    }
    return _fillerView;
}

-(GHHospitalSortViewController *)hospitalSortview
{
    if (!_hospitalSortview) {
        _hospitalSortview = [[GHHospitalSortViewController alloc] init];
        _hospitalSortview.isNotHaveSearch = true;
        _hospitalSortview.view.frame = CGRectMake(0, 0, SCREENWIDTH, 180);
        
        _hospitalSortview.delegate = self;
        [self addSubview:_hospitalSortview.view];
    }
    return _hospitalSortview;
}
- (GHHospitalFilterViewController *)hospitalFillerView
{
    if (!_hospitalFillerView) {
        _hospitalFillerView = [[GHHospitalFilterViewController alloc] init];
        _hospitalFillerView.view.frame = CGRectMake(0, 0, SCREENWIDTH, 328);
        _hospitalFillerView.delegate = self;
        [self addSubview:_hospitalFillerView.view];
    }
    return _hospitalFillerView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if (touch.view != self.locationview.view && touch.view != self.sortview.view && touch.view != self.fillerView.view && touch.view != self.hospitalSortview.view && touch.view != self.hospitalFillerView.view) {
        
        [self clickNoneView];
        
        if (self.chooseLocationBlock) {
            self.chooseLocationBlock(0, @"", @"" , 5);
        }
        
        if (self.chooseSortBlock) {
            self.chooseSortBlock(@"");
        }
        if (self.chooseFillerBlock) {
            self.chooseFillerBlock(@"", @"", @"");

        }
        

    }
}



@end

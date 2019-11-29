//
//  GHNewChooseRoleView.h
//  掌上优医
//
//  Created by apple on 2019/8/7.
//  Copyright © 2019年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum : NSUInteger {
   
    GHconditions_Location  = 0, //地址
    GHconditions_Sorting = 1,//排序
    GHconditions_Screening =2,//筛选
    
} GHconditions;

typedef enum : NSUInteger {
    
    GHrolesType_Hospital  = 0, //医生
    GHrolesType_Doctor = 1,//医院
    GHrolesType_information =2,//资讯
    
} GHrolesType;


@interface GHNewChooseRoleView : UIView

- (void)resetbtnSelect;//吧按钮的select。设置成no

@property (nonatomic , assign)GHconditions conditions;

@property (nonatomic , assign)GHrolesType rolesType;//展示医生 医院 资讯 选中状态

@property (nonatomic , copy) void (^chooseConditionsBlock)(GHconditions conditon);

@property (nonatomic , copy) void (^chooseRolesTypeBlock)(GHrolesType rolesType , NSString *roseText);//点击医生 医院 资讯

@property (nonatomic, strong) UIButton *LocationButton;//选择地域 按钮
@property (nonatomic, strong) UIButton *SortButton;//排序按钮
@property (nonatomic, strong) UIButton *FilterButton;//筛选


@property (nonatomic , strong) NSString *locationtext;

@property (nonatomic , strong) NSString *sortText;

@property (nonatomic , strong) NSString *Filter;


@end

NS_ASSUME_NONNULL_END

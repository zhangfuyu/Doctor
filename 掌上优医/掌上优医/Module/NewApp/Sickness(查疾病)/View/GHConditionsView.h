//
//  GHConditionsView.h
//  掌上优医
//
//  Created by apple on 2019/8/8.
//  Copyright © 2019年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHNewChooseRoleView.h"


NS_ASSUME_NONNULL_BEGIN

@interface GHConditionsView : UIView

- (void)clickNoneView;


@property (nonatomic , assign)GHrolesType rolesType;//根据 医生。医院。显示不同选择框

@property (nonatomic , assign)GHconditions conditions;//位置。排序方式。筛选。

@property (nonatomic, copy) void (^chooseLocationBlock)(NSString *country , NSString *city , NSString *area , NSInteger areaLevel);

@property (nonatomic, copy) void (^chooseSortBlock)(NSString *sortText);

@property (nonatomic, copy) void (^chooseFillerBlock)(NSString *position , NSString *doctorType , NSString *hospitalLevel);


@end

NS_ASSUME_NONNULL_END

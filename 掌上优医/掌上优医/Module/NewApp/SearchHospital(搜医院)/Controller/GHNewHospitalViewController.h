//
//  GHNewHospitalViewController.h
//  掌上优医
//
//  Created by apple on 2019/8/15.
//  Copyright © 2019年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHSearchHospitalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHNewHospitalViewController : GHBaseViewController

@property (nonatomic, strong) GHSearchHospitalModel *model;


@property (nonatomic, strong) NSString *hospitalID;

@property (nonatomic, strong) NSString *distance;//距离

@property (nonatomic, strong) NSString *departmentId;//科室ID。呦则传无则不传

@property (nonatomic, copy) void (^clickCollectionBlock)(BOOL collection);


@end

NS_ASSUME_NONNULL_END

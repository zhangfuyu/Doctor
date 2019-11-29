//
//  GHChooseDepartmentViewController.h
//  掌上优医
//
//  Created by GH on 2019/5/24.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHChooseDepartmentViewControllerDelegate <NSObject>

@optional
- (void)chooseDepartmentWithSecondName:(NSString *)secondName withSecondId:(NSString *)secondId withFirstName:(NSString *)firstName withFirstId:(NSString *)firstId;

@end

@interface GHChooseDepartmentViewController : GHBaseViewController

@property (nonatomic, strong) NSString *departmentId;

@property (nonatomic, weak) id<GHChooseDepartmentViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

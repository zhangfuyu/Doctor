//
//  GHAddHospitalInformationViewController.h
//  掌上优医
//
//  Created by GH on 2019/6/1.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHAddHospitalInformationViewControllerDelegate <NSObject>

@optional
- (void)finishSaveHospitalInformationWithArray:(NSArray *)array;

@end

@interface GHAddHospitalInformationViewController : GHBaseViewController

@property (nonatomic, weak) id<GHAddHospitalInformationViewControllerDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

NS_ASSUME_NONNULL_END

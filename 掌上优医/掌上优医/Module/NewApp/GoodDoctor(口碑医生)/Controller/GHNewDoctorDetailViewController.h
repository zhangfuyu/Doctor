//
//  GHNewDoctorDetailViewController.h
//  掌上优医
//
//  Created by apple on 2019/8/9.
//  Copyright © 2019年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHNewDoctorDetailViewController : GHBaseViewController

@property (nonatomic, copy) NSString *doctorId;

@property (nonatomic, copy) void (^clickCollectionBlock)(BOOL collection);



@end

NS_ASSUME_NONNULL_END

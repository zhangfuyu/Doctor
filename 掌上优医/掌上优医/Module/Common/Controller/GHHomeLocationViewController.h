//
//  GHHomeLocationViewController.h
//  掌上优医
//
//  Created by GH on 2018/10/27.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHHomeLocationViewControllerDelegate <NSObject>

- (void)chooseFinishWithCity:(NSString *)city withCode:(NSString *)code;

@end

@interface GHHomeLocationViewController : GHBaseViewController

@property (nonatomic, weak) id<GHHomeLocationViewControllerDelegate> delegate;

//@property (nonatomic, copy) NSString *currentLocation;

@end

NS_ASSUME_NONNULL_END

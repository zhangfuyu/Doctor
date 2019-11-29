//
//  GHGuideViewController.h
//  掌上优医
//
//  Created by GH on 2018/10/24.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHGuideViewControllerDelegate <NSObject>

- (void)changeRootViewController;

@end


@interface GHGuideViewController : GHBaseViewController

@property (nonatomic, weak) id<GHGuideViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

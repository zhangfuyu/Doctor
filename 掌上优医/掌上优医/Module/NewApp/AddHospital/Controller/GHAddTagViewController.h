//
//  GHAddTagViewController.h
//  掌上优医
//
//  Created by GH on 2019/5/31.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHAddTagViewControllerDelegate <NSObject>

@optional
- (void)finishAddTag:(NSString *)tag;

@end

@interface GHAddTagViewController : GHBaseViewController

@property (nonatomic, weak) id<GHAddTagViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

//
//  GHNFullRecommendCodeViewController.h
//  掌上优医
//
//  Created by GH on 2019/2/19.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"

typedef enum : NSUInteger {
    GHNFullRecommendCodeViewController_PersonCenter,
    GHNFullRecommendCodeViewController_BindPhone,
    GHNFullRecommendCodeViewController_Register,
} GHNFullRecommendCodeType;

NS_ASSUME_NONNULL_BEGIN

@interface GHNFullRecommendCodeViewController : GHBaseViewController

/**
 <#Description#>
 */
@property (nonatomic, assign) GHNFullRecommendCodeType type;

@end

NS_ASSUME_NONNULL_END

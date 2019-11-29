//
//  GHNSearchHotViewController.h
//  掌上优医
//
//  Created by GH on 2019/4/4.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    GHNSearchHotType_Disease,
    GHNSearchHotType_Doctor,
    GHNSearchHotType_Hospital,
    GHNSearchHotType_Information
} GHNSearchHotType;

@interface GHNSearchHotViewController : GHBaseViewController

/**
 <#Description#>
 */
@property (nonatomic, assign) GHNSearchHotType type;

/**
 <#Description#>
 */
@property (nonatomic, assign) BOOL isComment;

@end

NS_ASSUME_NONNULL_END

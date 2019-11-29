//
//  GHSicknessLibraryViewController.h
//  掌上优医
//
//  Created by GH on 2018/10/30.
//  Copyright © 2018 GH. All rights reserved.
//
//  疾病库

#import "GHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHSicknessLibraryViewController : GHBaseViewController

/**
 <#Description#>
 */
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

NS_ASSUME_NONNULL_END

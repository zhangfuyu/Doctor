//
//  GHNewDiseaseDetailViewController.h
//  掌上优医
//
//  Created by apple on 2019/8/6.
//  Copyright © 2019年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHBaseSearchViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface GHNewDiseaseDetailViewController : GHBaseSearchViewController
@property (nonatomic , strong) NSString *sicknessId;

@property (nonatomic , assign) NSInteger selectType;

@end

NS_ASSUME_NONNULL_END

//
//  GHNewContentHeaderView.h
//  掌上优医
//
//  Created by apple on 2019/8/6.
//  Copyright © 2019年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHNDiseaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHNewContentHeaderView : UIView
@property (nonatomic, copy) void (^clickTypeBlock)(float height);
@property (nonatomic, strong) GHNDiseaseModel *model;

@end

NS_ASSUME_NONNULL_END

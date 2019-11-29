//
//  GHNewDoctorDetailView.h
//  掌上优医
//
//  Created by apple on 2019/8/9.
//  Copyright © 2019年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHSearchDoctorModel.h"
#import "GHBaseView.h"


NS_ASSUME_NONNULL_BEGIN

@interface GHNewDoctorDetailView : GHBaseView

@property (nonatomic, copy) void (^backSelfHeight)(CGFloat headHeight);

@property (nonatomic, strong) GHSearchDoctorModel *model;


@end

NS_ASSUME_NONNULL_END

//
//  GHNewCommentsHeaderView.h
//  掌上优医
//
//  Created by apple on 2019/8/12.
//  Copyright © 2019年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHBaseView.h"
#import "GHSearchDoctorModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHNewCommentsHeaderView : GHBaseView

@property (nonatomic, strong) GHSearchDoctorModel *model;

@property (nonatomic, strong) NSString *doctorid;


@end

NS_ASSUME_NONNULL_END

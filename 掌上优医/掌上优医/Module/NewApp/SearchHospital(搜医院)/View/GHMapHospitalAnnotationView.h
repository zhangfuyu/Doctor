//
//  GHMapHospitalAnnotationView.h
//  掌上优医
//
//  Created by GH on 2019/5/23.
//  Copyright © 2019 GH. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "GHSearchHospitalModel.h"
#import "GHMapHospitalCalloutView.h"

NS_ASSUME_NONNULL_BEGIN


@interface GHMapHospitalAnnotationView : MAAnnotationView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, readonly) GHMapHospitalCalloutView *calloutView;

@end

NS_ASSUME_NONNULL_END

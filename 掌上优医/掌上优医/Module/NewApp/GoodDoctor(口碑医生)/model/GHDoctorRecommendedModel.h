//
//  GHDoctorRecommendedModel.h
//  掌上优医
//
//  Created by apple on 2019/10/30.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GHDoctorRecommendedModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *departmentName;

@property (nonatomic, copy) NSString<Optional> *doctorId;

@property (nonatomic, copy) NSString<Optional> *doctorName;

@property (nonatomic, copy) NSString<Optional> *headImgUrl;

@property (nonatomic, copy) NSString<Optional> *hospitalName;

@property (nonatomic, copy) NSString<Optional> *index;

@end

NS_ASSUME_NONNULL_END

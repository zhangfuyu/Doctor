//
//  GHHospitalRecommendedModel.h
//  掌上优医
//
//  Created by apple on 2019/10/29.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHHospitalRecommendedModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *distance;

@property (nonatomic, copy) NSString<Optional> *headImgUrl;

@property (nonatomic, copy) NSString<Optional> *hospitalGrade;

@property (nonatomic, copy) NSString<Optional> *hospitalId;

@property (nonatomic, copy) NSString<Optional> *hospitalName;

@end

NS_ASSUME_NONNULL_END

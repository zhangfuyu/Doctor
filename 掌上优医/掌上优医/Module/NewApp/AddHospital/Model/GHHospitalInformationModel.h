//
//  GHHospitalInformationModel.h
//  掌上优医
//
//  Created by GH on 2019/6/1.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHHospitalInformationModel : JSONModel

/**
 标题
 */
@property (nonatomic, copy) NSString<Optional> *title;

/**
 图片 URL
 */
@property (nonatomic, copy) NSString<Optional> *informationImageUrl;

/**
 URL
 */
@property (nonatomic, copy) NSString<Optional> *h5url;

/**
 是否是外部链接
 */
@property (nonatomic, copy) NSNumber<Optional> *isExternalWeb;

@end

NS_ASSUME_NONNULL_END

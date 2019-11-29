//
//  GHHomeBannerModel.h
//  掌上优医
//
//  Created by GH on 2018/11/19.
//  Copyright © 2018 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHHomeBannerModel : JSONModel <NSCoding>

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *desc;

/**
 Description
 */
@property (nonatomic, copy) NSString<Optional> *gmtCreate;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *modelId;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *showOrder;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *url;

/**
 活动URL 5-200字符
 */
@property (nonatomic, copy) NSString<Optional> *activityUrl;

@property (nonatomic, copy) NSString<Optional> *playPosition;

@end

NS_ASSUME_NONNULL_END

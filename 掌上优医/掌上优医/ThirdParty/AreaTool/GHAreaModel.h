//
//  GHAreaModel.h
//  掌上优医
//
//  Created by GH on 2018/10/26.
//  Copyright © 2018 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHAreaModel : JSONModel <NSCoding>


/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *modelId;

/**
 Description
 */
@property (nonatomic, copy) NSString<Optional> *areaCode;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *parentCode;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *areaName;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *areaLevel;

/**
 拼音
 */
@property (nonatomic, copy) NSString<Optional> *pinYin;

/**
 拼音首字符
 */
@property (nonatomic, copy) NSString<Optional> *fistPinYin;

/**
 首字母
 */
@property (nonatomic, copy) NSString<Optional> *fist;

@property (nonatomic, strong) NSMutableArray<Optional> *children;

@end

NS_ASSUME_NONNULL_END

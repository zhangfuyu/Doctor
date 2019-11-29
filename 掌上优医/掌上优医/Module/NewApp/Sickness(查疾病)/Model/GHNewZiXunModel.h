//
//  GHNewZiXunModel.h
//  掌上优医
//
//  Created by apple on 2019/9/19.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHNewZiXunModel : JSONModel


/**
作者
 */
@property (nonatomic, copy) NSString<Optional> *doctorId;

/**
是否精选 1否 2精选
 */
@property (nonatomic, copy) NSString<Optional> *choiceFlag;

/**
内容 为空
 */
@property (nonatomic, copy) NSString<Optional> *content;

/**
 时间
 */
@property (nonatomic, copy) NSString<Optional> *createTime;

/**
收藏数量
 */
@property (nonatomic, copy) NSString<Optional> *favoriteCount;

/**
 作者
 */
@property (nonatomic, copy) NSString<Optional> *firstTypeId;

/**
 封面照片
 */
@property (nonatomic, copy) NSString<Optional> *frontCoverUrl;

/**
 作者
 */
@property (nonatomic, copy) NSString<Optional> *modelID;

/**

 */
@property (nonatomic, copy) NSString<Optional> *secondTypeId;

/**

 */
@property (nonatomic, copy) NSString<Optional> *sortTime;

/**

 */
@property (nonatomic, copy) NSString<Optional> *title;

/**

 */
@property (nonatomic, copy) NSString<Optional> *typeName;

/**

 */
@property (nonatomic, copy) NSString<Optional> *updateTime;

/**
 访问数量
 */
@property (nonatomic, copy) NSString<Optional> *visitCount;


@end

NS_ASSUME_NONNULL_END

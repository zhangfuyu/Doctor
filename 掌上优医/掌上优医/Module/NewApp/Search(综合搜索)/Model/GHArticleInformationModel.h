//
//  GHArticleInformationModel.h
//  掌上优医
//
//  Created by GH on 2018/10/25.
//  Copyright © 2018 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHArticleInformationModel : JSONModel

/**
 作者
 */
@property (nonatomic, copy) NSString<Optional> *author;

/**
 资讯封面
 */
@property (nonatomic, copy) NSString<Optional> *frontCoverUrl;

/**
 创建时间 格式 yyyy-MM-dd HH:mm:ss
 */
@property (nonatomic, copy) NSString<Optional> *gmtCreate;

@property (nonatomic, copy) NSString<Optional> *shouldShowTime;


/**
 资讯ID
 */
@property (nonatomic, copy) NSString<Optional> *modelId;

/**
 一级分类ID
 */
@property (nonatomic, copy) NSString<Optional> *newsFirstTypeId;

/**
 二级分类ID
 */
@property (nonatomic, copy) NSString<Optional> *newsSecondTypeId;

/**
 资讯标题
 */
@property (nonatomic, copy) NSString<Optional> *title;

/**
 访问次数
 */
@property (nonatomic, copy) NSString<Optional> *visitCount;

@property (nonatomic, copy) NSNumber<Optional> *isVisit;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *collectionId;



@end

NS_ASSUME_NONNULL_END

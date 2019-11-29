//
//  GHMyCollectionInformationModel.h
//  掌上优医
//
//  Created by GH on 2019/2/21.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHMyCollectionInformationModel : JSONModel

/**
 收藏资源ID, 填写 医生ID|圈子ID|医院ID|资讯ID
 */
@property (nonatomic, copy) NSString<Optional> *contentId;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *contentInfo;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *contentType;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *modelId;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *gmtCreate;

@property (nonatomic, copy) NSString<Optional> *title;






@end

NS_ASSUME_NONNULL_END

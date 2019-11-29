//
//  GHZuJiInformationModel.h
//  掌上优医
//
//  Created by GH on 2019/2/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHZuJiInformationModel : JSONModel <NSCoding>

/**
 资讯ID
 */
@property (nonatomic, copy) NSString<Optional> *modelId;

/**
 资讯ID
 */
@property (nonatomic, copy) NSString<Optional> *title;

/**
 创建时间 格式 yyyy-MM-dd HH:mm:ss
 */
@property (nonatomic, copy) NSString<Optional> *gmtCreate;

@end

NS_ASSUME_NONNULL_END

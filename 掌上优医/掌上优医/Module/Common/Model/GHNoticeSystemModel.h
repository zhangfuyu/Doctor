//
//  GHNoticeSystemModel.h
//  掌上优医
//
//  Created by GH on 2018/11/13.
//  Copyright © 2018 GH. All rights reserved.
//
//  系统消息 通知

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHNoticeSystemModel : JSONModel <NSCoding>

@property (nonatomic, copy) NSString<Optional> *content;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *createDate;
/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *updateDate;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *modelId;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *title;




@end

NS_ASSUME_NONNULL_END

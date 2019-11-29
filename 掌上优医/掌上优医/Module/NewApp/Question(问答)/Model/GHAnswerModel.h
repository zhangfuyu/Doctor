//
//  GHAnswerModel.h
//  掌上优医
//
//  Created by GH on 2019/5/27.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHAnswerModel : JSONModel

/**
 作者ID 正整数
 */
@property (nonatomic, copy) NSString<Optional> *authorId;

/**
 作者姓名 长度为[1,48]
 */
@property (nonatomic, copy) NSString<Optional> *authorName;

/**
 作者头像 长度为[5,200]
 */
@property (nonatomic, copy) NSString<Optional> *authorProfileUrl;

/**
 帖子状态 1：未审核 2：待人工审核 3：审核通过 4：未通过审核
 */
@property (nonatomic, copy) NSString<Optional> *checkStatus;

/**
 帖子内容
 */
@property (nonatomic, copy) NSString<Optional> *content;

/**
 创建时间，格式 yyyy-MM-dd HH:mm:ss
 */
@property (nonatomic, copy) NSString<Optional> *gmtCreate;

/**
 修改时间，格式 yyyy-MM-dd HH:mm:ss
 */
@property (nonatomic, copy) NSString<Optional> *gmtModified;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *modelId;

/**
 最后回复者姓名 长度为[1,48]
 */
@property (nonatomic, copy) NSString<Optional> *lastReplyAuthorName;

/**
 点赞数
 */
@property (nonatomic, copy) NSString<Optional> *likeCount;

/**
 所属帖子ID 正整数
 */
@property (nonatomic, copy) NSString<Optional> *postId;

/**
 回复数
 */
@property (nonatomic, copy) NSString<Optional> *replyCount;


@property (nonatomic, copy) NSNumber<Optional> *contentHeight;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray<Optional> *replyArray;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSString<Optional> *authorHeaderUrl;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSString<Optional> *createDate;

/**
 问题id
 */
@property (nonatomic, strong) NSString<Optional> *problemId;


@end

NS_ASSUME_NONNULL_END

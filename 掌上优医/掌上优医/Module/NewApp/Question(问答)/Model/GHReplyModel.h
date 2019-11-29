//
//  GHReplyModel.h
//  掌上优医
//
//  Created by GH on 2019/5/27.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHReplyModel : JSONModel


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
 所属评论ID 正整数
 */
@property (nonatomic, copy) NSString<Optional> *discussId;

/**
 点赞数
 */
@property (nonatomic, copy) NSString<Optional> *likeCount;

/**
 所属帖子ID 正整数
 */
@property (nonatomic, copy) NSString<Optional> *postId;

/**
 被回复的reply ID 正整数
 */
@property (nonatomic, copy) NSString<Optional> *replyToReplyId;

/**
 被回复者ID 正整数
 */
@property (nonatomic, copy) NSString<Optional> *replyToUserId;

/**
 被回复者姓名 长度[1,48]
 */
@property (nonatomic, copy) NSString<Optional> *replyToUserName;

@property (nonatomic, copy) NSNumber<Optional> *contentHeight;

@property (nonatomic, copy) NSNumber<Optional> *isMeReply;

@property (nonatomic, copy) NSString<Optional> *showContent;
//回答的id
@property (nonatomic, copy) NSString<Optional> *answerId;

@property (nonatomic, copy) NSString<Optional> *authorHeaderUrl;

//审核状态 1未审核 2待人工审核 3审核通过 4未通过审核
@property (nonatomic, copy) NSString<Optional> *checkState;

@property (nonatomic, copy) NSString<Optional> *createDate;
//问题id
@property (nonatomic, copy) NSString<Optional> *parentReplyId;
//锁定者
@property (nonatomic, copy) NSString<Optional> *locker;
@end

NS_ASSUME_NONNULL_END

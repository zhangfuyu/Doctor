//
//  GHNoticeLikeModel.h
//  掌上优医
//
//  Created by GH on 2018/11/13.
//  Copyright © 2018 GH. All rights reserved.
//
//  点赞消息 通知

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHNoticeLikeModel : JSONModel <NSCoding>

//@property (nonatomic, copy) NSString<Optional> *modelId;
//
//@property (nonatomic, copy) NSString<Optional> *userHeadPortrait;
//
//@property (nonatomic, copy) NSString<Optional> *userNickName;
//
//@property (nonatomic, copy) NSString<Optional> *replyContent;
//
//@property (nonatomic, copy) NSString<Optional> *replyContentId;
//
//@property (nonatomic, copy) NSString<Optional> *time;
//
//@property (nonatomic, copy) NSString<Optional> *topicImageUrl;
//
//@property (nonatomic, copy) NSString<Optional> *topicTitle;
//
//@property (nonatomic, copy) NSString<Optional> *topicDesc;
//
//@property (nonatomic, copy) NSString<Optional> *shouldShowReplyContent;

/**
 响应者ID
 */
@property (nonatomic, copy) NSString<Optional> *responderId;

/**
 响应者姓名
 */
@property (nonatomic, copy) NSString<Optional> *responderName;

/**
 响应者头像
 */
@property (nonatomic, copy) NSString<Optional> *responderProfile;

/**
 资源类型:   1.帖子 2.评论 3.回复
 */
@property (nonatomic, copy) NSString<Optional> *contentType;

/**
 资源ID
 */
@property (nonatomic, copy) NSString<Optional> *contentId;

/**
 帖子标题、 评论内容前50字符、回复内容前50字符
 */
@property (nonatomic, copy) NSString<Optional> *content;

/**
 响应类型： 1.点赞  2:.评论 3.回复
 */
@property (nonatomic, copy) NSString<Optional> *actionType;

/**
 响应内容ID ---点赞时 ，空值
 */
@property (nonatomic, copy) NSString<Optional> *responseContentId;

/**
 响应内容   前50个字符 --- 点赞时，空值
 */
@property (nonatomic, copy) NSString<Optional> *responseContent;

@property (nonatomic, copy) NSString<Optional> *responseDateTime;

@property (nonatomic, copy) NSString<Optional> *postId;

@property (nonatomic, copy) NSString<Optional> *postCover;

@property (nonatomic, copy) NSString<Optional> *shouldShowReplyContent;


@end

NS_ASSUME_NONNULL_END

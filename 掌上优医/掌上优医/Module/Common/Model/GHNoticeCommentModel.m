//
//  GHNoticeCommentModel.m
//  掌上优医
//
//  Created by GH on 2018/11/13.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHNoticeCommentModel.h"

//static NSString *kModelId = @"kModelId";
//static NSString *kUserHeadPortrait = @"kUserHeadPortrait";
//static NSString *kUserNickName = @"kUserNickName";
//static NSString *kReplyContent = @"kReplyContent";
//static NSString *kReplyContentId = @"kReplyContentId";
//static NSString *kReplyTime = @"kReplyTime";
//static NSString *kMyReplyContentId = @"kMyReplyContentId";
//static NSString *kMyReplyContent = @"kMyReplyContent";

static NSString *kGHNoticeCommentModelResponderId = @"kGHNoticeCommentModelResponderId";
static NSString *kGHNoticeCommentModelResponderName = @"kGHNoticeCommentModelResponderName";
static NSString *kGHNoticeCommentModelResponderProfile = @"kGHNoticeCommentModelResponderProfile";
static NSString *kGHNoticeCommentModelContentType = @"kGHNoticeCommentModelContentType";
static NSString *kGHNoticeCommentModelContentId = @"kGHNoticeCommentModelContentId";
static NSString *kGHNoticeCommentModelContent = @"kGHNoticeCommentModelContent";
static NSString *kGHNoticeCommentModelActionType = @"kGHNoticeCommentModelActionType";
static NSString *kGHNoticeCommentModelResponseContentId = @"kGHNoticeCommentModelResponseContentId";
static NSString *kGHNoticeCommentModelResponseContent = @"kGHNoticeCommentModelResponseContent";
static NSString *kGHNoticeCommentModelResponseDateTime = @"kGHNoticeCommentModelResponseDateTime";

//推送帖子消息 结构如下：
//postEvent  帖子通知
//{
//    responderId       响应者ID
//    responderName     响应者姓名
//    responderProfile  响应者头像
//
//    contentType       资源类型:   1.帖子 2.评论 3.回复
//    contentId         资源ID
//    content           帖子标题、 评论内容前50字符、回复内容前50字符
//
//    actionType        响应类型： 1.点赞  2:.评论 3.回复
//    responseContentId 响应内容ID ---点赞时 ，空值
//    responseContent   响应内容   前50个字符 --- 点赞时，空值
//}

@interface GHNoticeCommentModel ()

@end

@implementation GHNoticeCommentModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:ISNIL(self.responderId) forKey:kGHNoticeCommentModelResponderId];
    [aCoder encodeObject:ISNIL(self.responderName) forKey:kGHNoticeCommentModelResponderName];
    [aCoder encodeObject:ISNIL(self.responderProfile) forKey:kGHNoticeCommentModelResponderProfile];
    [aCoder encodeObject:ISNIL(self.contentType) forKey:kGHNoticeCommentModelContentType];
    [aCoder encodeObject:ISNIL(self.contentId) forKey:kGHNoticeCommentModelContentId];
    [aCoder encodeObject:ISNIL(self.content) forKey:kGHNoticeCommentModelContent];
    [aCoder encodeObject:ISNIL(self.actionType) forKey:kGHNoticeCommentModelActionType];
    [aCoder encodeObject:ISNIL(self.responseContentId) forKey:kGHNoticeCommentModelResponseContentId];
    [aCoder encodeObject:ISNIL(self.responseContent) forKey:kGHNoticeCommentModelResponseContent];
    [aCoder encodeObject:ISNIL(self.responseDateTime) forKey:kGHNoticeCommentModelResponseDateTime];
//    [aCoder encodeObject:ISNIL(self.modelId) forKey:kModelId];
//    [aCoder encodeObject:ISNIL(self.userHeadPortrait) forKey:kUserHeadPortrait];
//    [aCoder encodeObject:ISNIL(self.userNickName) forKey:kUserNickName];
//    [aCoder encodeObject:ISNIL(self.replyContent) forKey:kReplyContent];
//    [aCoder encodeObject:ISNIL(self.replyContentId) forKey:kReplyContentId];
//    [aCoder encodeObject:ISNIL(self.replyTime) forKey:kReplyTime];
//    [aCoder encodeObject:ISNIL(self.myReplyContent) forKey:kMyReplyContent];
//    [aCoder encodeObject:ISNIL(self.myReplyContentId) forKey:kMyReplyContentId];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        
        self.responderId = [aDecoder decodeObjectForKey:kGHNoticeCommentModelResponderId];
        self.responderName = [aDecoder decodeObjectForKey:kGHNoticeCommentModelResponderName];
        self.responderProfile = [aDecoder decodeObjectForKey:kGHNoticeCommentModelResponderProfile];
        self.contentType = [aDecoder decodeObjectForKey:kGHNoticeCommentModelContentType];
        self.contentId = [aDecoder decodeObjectForKey:kGHNoticeCommentModelContentId];
        self.content = [aDecoder decodeObjectForKey:kGHNoticeCommentModelContent];
        self.actionType = [aDecoder decodeObjectForKey:kGHNoticeCommentModelActionType];
        self.responseContentId = [aDecoder decodeObjectForKey:kGHNoticeCommentModelResponseContentId];
        self.responseContent = [aDecoder decodeObjectForKey:kGHNoticeCommentModelResponseContent];
        self.responseDateTime = [aDecoder decodeObjectForKey:kGHNoticeCommentModelResponseDateTime];
        
//        self.modelId = [aDecoder decodeObjectForKey:kModelId];
//        self.userHeadPortrait = [aDecoder decodeObjectForKey:kUserHeadPortrait];
//        self.userNickName = [aDecoder decodeObjectForKey:kUserNickName];
//        self.replyContentId = [aDecoder decodeObjectForKey:kReplyContentId];
//        self.replyContent = [aDecoder decodeObjectForKey:kReplyContent];
//        self.replyTime = [aDecoder decodeObjectForKey:kReplyTime];
//        self.myReplyContent = [aDecoder decodeObjectForKey:kMyReplyContent];
//        self.myReplyContentId = [aDecoder decodeObjectForKey:kMyReplyContentId];
        
    }
    return self;
    
}

- (NSString<Optional> *)shouldShowReplyContent {
    if ([_contentType integerValue] == 1) {
        return [NSString stringWithFormat:@"%@评论了你: %@", ISNIL(_responderName), ISNIL(_responseContent)];
    }
    return [NSString stringWithFormat:@"%@回复了你: %@", ISNIL(_responderName), ISNIL(_responseContent)];
}

- (NSString<Optional> *)shouldShowMyReplyContent {
    
    if ([_contentType integerValue] == 1) {
        return @"";
    }
    
    if (_content.length == 0) {
        return _content;
    }
    
    if ([_contentType integerValue] == 2) {
        return [NSString stringWithFormat:@"我的评论: %@", _content];
    }
    
    return [NSString stringWithFormat:@"我的回复: %@", _content];
}


@end


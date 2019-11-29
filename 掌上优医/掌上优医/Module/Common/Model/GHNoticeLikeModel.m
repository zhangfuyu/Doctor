//
//  GHNoticeLikeModel.m
//  掌上优医
//
//  Created by GH on 2018/11/13.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHNoticeLikeModel.h"

static NSString *kGHNoticeLikeModelResponderId = @"kGHNoticeLikeModelResponderId";
static NSString *kGHNoticeLikeModelResponderName = @"kGHNoticeLikeModelResponderName";
static NSString *kGHNoticeLikeModelResponderProfile = @"kGHNoticeLikeModelResponderProfile";
static NSString *kGHNoticeLikeModelContentType = @"kGHNoticeLikeModelContentType";
static NSString *kGHNoticeLikeModelContentId = @"kGHNoticeLikeModelContentId";
static NSString *kGHNoticeLikeModelContent = @"kGHNoticeLikeModelContent";
static NSString *kGHNoticeLikeModelActionType = @"kGHNoticeLikeModelActionType";
static NSString *kGHNoticeLikeModelResponseContentId = @"kGHNoticeLikeModelResponseContentId";
static NSString *kGHNoticeLikeModelResponseContent = @"kGHNoticeLikeModelResponseContent";
static NSString *kGHNoticeLikeModelPostId = @"kGHNoticeLikeModelPostId";
static NSString *kGHNoticeLikeModelPostCover = @"kGHNoticeLikeModelPostCover";
static NSString *kGHNoticeLikeModelResponseDateTime = @"kGHNoticeLikeModelResponseDateTime";

@implementation GHNoticeLikeModel

- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:ISNIL(self.responderId) forKey:kGHNoticeLikeModelResponderId];
    [aCoder encodeObject:ISNIL(self.responderName) forKey:kGHNoticeLikeModelResponderName];
    [aCoder encodeObject:ISNIL(self.responderProfile) forKey:kGHNoticeLikeModelResponderProfile];
    [aCoder encodeObject:ISNIL(self.contentType) forKey:kGHNoticeLikeModelContentType];
    [aCoder encodeObject:ISNIL(self.contentId) forKey:kGHNoticeLikeModelContentId];
    [aCoder encodeObject:ISNIL(self.content) forKey:kGHNoticeLikeModelContent];
    [aCoder encodeObject:ISNIL(self.actionType) forKey:kGHNoticeLikeModelActionType];
    [aCoder encodeObject:ISNIL(self.responseContentId) forKey:kGHNoticeLikeModelResponseContentId];
    [aCoder encodeObject:ISNIL(self.responseContent) forKey:kGHNoticeLikeModelResponseContent];
    [aCoder encodeObject:ISNIL(self.responseDateTime) forKey:kGHNoticeLikeModelResponseDateTime];
    
    [aCoder encodeObject:ISNIL(self.postId) forKey:kGHNoticeLikeModelPostId];
    [aCoder encodeObject:ISNIL(self.postCover) forKey:kGHNoticeLikeModelPostCover];
    
    //
//    [aCoder encodeObject:ISNIL(self.modelId) forKey:kModelId];
//    [aCoder encodeObject:ISNIL(self.userHeadPortrait) forKey:kUserHeadPortrait];
//    [aCoder encodeObject:ISNIL(self.userNickName) forKey:kUserNickName];
//    [aCoder encodeObject:ISNIL(self.replyContent) forKey:kReplyContent];
//    [aCoder encodeObject:ISNIL(self.replyContentId) forKey:kReplyContentId];
//    [aCoder encodeObject:ISNIL(self.time) forKey:kTime];
//    [aCoder encodeObject:ISNIL(self.topicImageUrl) forKey:kTopicImageUrl];
//    [aCoder encodeObject:ISNIL(self.topicTitle) forKey:kTopicTitle];
//    [aCoder encodeObject:ISNIL(self.topicDesc) forKey:kTopicDesc];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {

        self.responderId = [aDecoder decodeObjectForKey:kGHNoticeLikeModelResponderId];
        self.responderName = [aDecoder decodeObjectForKey:kGHNoticeLikeModelResponderName];
        self.responderProfile = [aDecoder decodeObjectForKey:kGHNoticeLikeModelResponderProfile];
        self.contentType = [aDecoder decodeObjectForKey:kGHNoticeLikeModelContentType];
        self.contentId = [aDecoder decodeObjectForKey:kGHNoticeLikeModelContentId];
        self.content = [aDecoder decodeObjectForKey:kGHNoticeLikeModelContent];
        self.actionType = [aDecoder decodeObjectForKey:kGHNoticeLikeModelActionType];
        self.responseContentId = [aDecoder decodeObjectForKey:kGHNoticeLikeModelResponseContentId];
        self.responseContent = [aDecoder decodeObjectForKey:kGHNoticeLikeModelResponseContent];
        self.responseDateTime = [aDecoder decodeObjectForKey:kGHNoticeLikeModelResponseDateTime];
        
        self.postId = [aDecoder decodeObjectForKey:kGHNoticeLikeModelPostId];
        self.postCover = [aDecoder decodeObjectForKey:kGHNoticeLikeModelPostCover];
        
//        self.modelId = [aDecoder decodeObjectForKey:kModelId];
//        self.userHeadPortrait = [aDecoder decodeObjectForKey:kUserHeadPortrait];
//        self.userNickName = [aDecoder decodeObjectForKey:kUserNickName];
//        self.replyContentId = [aDecoder decodeObjectForKey:kReplyContentId];
//        self.replyContent = [aDecoder decodeObjectForKey:kReplyContent];
//        self.time = [aDecoder decodeObjectForKey:kTime];
//        self.topicImageUrl = [aDecoder decodeObjectForKey:kTopicImageUrl];
//        self.topicTitle = [aDecoder decodeObjectForKey:kTopicTitle];
//        self.topicDesc = [aDecoder decodeObjectForKey:kTopicDesc];
        
    }
    return self;
    
}

- (NSString<Optional> *)shouldShowReplyContent {

    if ([_contentType integerValue] == 1) {
        return _content;
    }
    
    if (_content.length) {
        
        if ([_contentType integerValue] == 2) {
            return [NSString stringWithFormat:@"我的评论: %@", _content];
        }
        
        return [NSString stringWithFormat:@"我的回复: %@", _content];
    }
    
    return _content;

    

}

@end

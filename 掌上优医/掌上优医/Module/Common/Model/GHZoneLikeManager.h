//
//  GHZoneLikeManager.h
//  掌上优医
//
//  Created by GH on 2018/12/7.
//  Copyright © 2018 GH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHZoneLikeManager : NSObject

/**
 系统帖子点赞 ID 数组
 */
@property (nonatomic, strong) NSMutableArray *systemPostLikeIdArray;

/**
 系统评论点赞 ID 数组
 */
@property (nonatomic, strong) NSMutableArray *systemDiscussLikeIdArray;

/**
 系统回复点赞 ID 数组
 */
@property (nonatomic, strong) NSMutableArray *systemReplyLikeIdArray;

/**
 评论点赞 ID 数组
 */
@property (nonatomic, strong) NSMutableArray *systemCommentLikeIdArray;

/**
 本地帖子点赞 ID 数组
 */
@property (nonatomic, strong) NSMutableArray *localPostLikeIdArray;

/**
 本地评论点赞 ID 数组
 */
@property (nonatomic, strong) NSMutableArray *localDiscussLikeIdArray;

/**
 本地回复点赞 ID 数组
 */
@property (nonatomic, strong) NSMutableArray *localReplyLikeIdArray;


+ (instancetype)shareInstance;

/**
 同步回复数据
 */
- (void)synchronousReplyLikeData;

/**
 同步评论数据
 */
- (void)synchronousDiscussLikeData;

/**
 同步帖子数据
 */
- (void)synchronousPostLikeData;


@end

NS_ASSUME_NONNULL_END

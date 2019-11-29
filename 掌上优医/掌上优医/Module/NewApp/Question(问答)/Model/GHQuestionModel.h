//
//  GHQuestionModel.h
//  掌上优医
//
//  Created by GH on 2019/5/27.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHQuestionModel : JSONModel

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
 评论数
 */
@property (nonatomic, copy) NSString<Optional> *discussCount;

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
 置顶标志 1：未置顶 2：置顶
 */
@property (nonatomic, copy) NSString<Optional> *isStickyPost;

/**
 点赞数
 */
@property (nonatomic, copy) NSString<Optional> *likeCount;

/**
 属主ID 正整数
 */
@property (nonatomic, copy) NSString<Optional> *ownerId;

/**
 属主名称 长度为[1,50]
 */
@property (nonatomic, copy) NSString<Optional> *ownerName;

/**
 属主类型 1：圈子、2：医生
 */
@property (nonatomic, copy) NSString<Optional> *ownerType;

/**
 帖子封面
 */
@property (nonatomic, copy) NSString<Optional> *postCoverPicUrl;

/**
 回复数
 */
@property (nonatomic, copy) NSString<Optional> *replyCount;

/**
 帖子标题 长度为[1,20]
 */
@property (nonatomic, copy) NSString<Optional> *title;

/**
 搜索时，记录总数
 */
@property (nonatomic, copy) NSString<Optional> *totalCount;

/**
 访问次数
 */
@property (nonatomic, copy) NSString<Optional> *visitCount;

/**
 回答次数
 */
@property (nonatomic, copy) NSString<Optional> *answerNums;

/**
 坐着头像
 */
@property (nonatomic, copy) NSString<Optional> *authorHeaderUrl;

/**
浏览次数
*/
@property (nonatomic, copy) NSString<Optional> *browseNums;

/**
 审核状态 1未审核 2待人工审核 3审核通过 4未通过审核
 */
@property (nonatomic, copy) NSString<Optional> *checkState;

/**
 是否删除 0未删除 1已删除
 */
@property (nonatomic, copy) NSString<Optional> *isDelete;

/**
时间
 */
@property (nonatomic, copy) NSString<Optional> *createDate;
@end

NS_ASSUME_NONNULL_END

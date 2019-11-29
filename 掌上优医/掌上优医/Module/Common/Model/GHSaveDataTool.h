//
//  GHSaveDataTool.h
//  掌上优医
//
//  Created by GH on 2018/11/13.
//  Copyright © 2018 GH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    GHSaveDataType_Sickness,
    GHSaveDataType_Doctor,
    GHSaveDataType_Hospital,
    GHSaveDataType_Information
} GHSaveDataType;

@interface GHSaveDataTool : NSObject

/**
 用于存储精选内容的 id, 浏览状态仅保存本次打开 APP
 */
@property (nonatomic, strong) NSMutableArray *readCommentIdArray;

/**
 用于存储浏览过的文章的 id, 浏览状态仅保存本次打开 APP
 */
@property (nonatomic, strong) NSMutableArray *readInformationIdArray;

+ (instancetype)shareInstance;

- (void)addObject:(id)object withType:(GHSaveDataType)type;

- (void)addObjectToCommentDoctorRecord:(id)object;

- (void)addObjectToCommentHospitalRecord:(id)object;

- (NSArray *)getSandboxNoticeDataWithCommentDoctorRecord;

- (NSArray *)getSandboxNoticeDataWithCommentHospitalRecord;

- (void)replaceArray:(NSArray *)array withType:(GHSaveDataType)type;

- (NSArray *)getSandboxNoticeDataWithType:(GHSaveDataType)type;

/**
 保存帖子草稿
 */
- (void)savePostDetailDraftWithHTMLArray:(NSArray *)array;

/**
 加载帖子草稿
 */
- (NSArray *)loadPostDetailDraft;

/**
 清除帖子草稿
 */
- (void)cleanPostDetailDraft;

/**
 保存帖子标题
 */
- (void)savePostDetailTitleWithTitle:(NSString *)title;

/**
 加载帖子标题
 */
- (NSString *)loadPostDetailTitle;

/**
 清除帖子标题
 */
- (void)cleanPostDetailTitle;

/**
 获取省市区缓存数据
 */
- (NSArray *)loadProvinceCityAreaData;

/**
 保存省市区缓存数据
 */
- (void)saveProvinceCityAreaDataWithArray:(NSArray *)array;

/**
 保存国家缓存数据
 */
- (void)saveCountryDataWithArray:(NSArray *)array;

/**
 获取国家缓存数据
 */
- (NSArray *)loadCountryData;

/**
 获取市缓存数据
 */
- (NSArray *)loadSortCityData;

/**
 保存市缓存数据
 */
- (void)saveSortCityDataWithArray:(NSArray *)array;

/**
 清理所有的地理位置的缓存数据
 */
- (void)cleanAllCityData;

/**
 用户退出登录, 清除所有本地缓存的通知消息
 */
- (void)userLogoutRemoveAllNotice;

- (void)userLogoutRemoveWithType:(GHSaveDataType)type;

@end

NS_ASSUME_NONNULL_END

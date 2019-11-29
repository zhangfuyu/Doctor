//
//  GHDoctorCommentTagView.h
//  掌上优医
//
//  Created by GH on 2019/1/16.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    GHDoctorCommentTagType_SingleSelection, // 单选
    GHDoctorCommentTagType_MultipleChoice   // 多选
} GHDoctorCommentTagType;

@protocol GHDoctorCommentTagViewDelegate <NSObject>

@optional
- (void)chooseTagAction;

@end

@interface GHDoctorCommentTagView : GHBaseView

/**
 <#Description#>
 */
@property (nonatomic, assign) GHDoctorCommentTagType type;

/**
 <#Description#>
 */
@property (nonatomic, weak) id<GHDoctorCommentTagViewDelegate> delegate;

- (instancetype)initWithTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray;

/**
 获取选择结果

 @return <#return value description#>
 */
- (NSArray *)getChooseResultArray;

/**
 清空选择状态
 */
- (void)resetAllStatus;

- (void)setChooseStatusWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END

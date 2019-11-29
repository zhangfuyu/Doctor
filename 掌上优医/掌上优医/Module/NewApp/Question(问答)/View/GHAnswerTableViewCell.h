//
//  GHAnswerTableViewCell.h
//  掌上优医
//
//  Created by GH on 2019/5/27.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseTableViewCell.h"
#import "GHAnswerModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHAnswerTableViewCellDelegate <NSObject>

@optional

- (void)clickReplyAnswerActionWithAnswerModel:(GHAnswerModel *)model;

@end

@interface GHAnswerTableViewCell : GHBaseTableViewCell

@property (nonatomic, weak) id<GHAnswerTableViewCellDelegate> delegate;

@property (nonatomic, strong) GHAnswerModel *model;

@end

NS_ASSUME_NONNULL_END

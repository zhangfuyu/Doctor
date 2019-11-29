//
//  GHEditInfoTableViewCell.h
//  掌上优医
//
//  Created by GH on 2018/11/2.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    GHEditInfoTableViewCellStyle_HeadPortrait,
    GHEditInfoTableViewCellStyle_Arrow,
    GHEditInfoTableViewCellStyle_Default,
} GHEditInfoTableViewCellStyle;

@interface GHEditInfoTableViewCell : GHBaseTableViewCell

@property (nonatomic, assign) GHEditInfoTableViewCellStyle style;

@property (nonatomic, strong) UIImageView *headPortraitImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *descLabel;

@end

NS_ASSUME_NONNULL_END

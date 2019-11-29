//
//  GHInfoErrorProgressTableViewCell.h
//  掌上优医
//
//  Created by GH on 2019/5/29.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHInfoErrorProgressTableViewCell : GHBaseTableViewCell

@property (nonatomic, strong) UILabel *firstValueLabel;

@property (nonatomic, strong) UILabel *secondValueLabel;

@property (nonatomic, strong) UILabel *thirdValueLabel;

@property (nonatomic, strong) UILabel *firstTitleLabel;

@property (nonatomic, strong) UILabel *secondTitleLabel;

@property (nonatomic, strong) UILabel *thirdTitleLabel;

@property (nonatomic, strong) NSMutableArray *imageViewArray;

@end

NS_ASSUME_NONNULL_END

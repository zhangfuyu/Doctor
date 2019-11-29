//
//  GHQuestionTableViewCell.h
//  掌上优医
//
//  Created by GH on 2019/5/27.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseTableViewCell.h"
#import "GHQuestionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHQuestionTableViewCell : GHBaseTableViewCell

@property (nonatomic, strong) GHQuestionModel *model;

@end

NS_ASSUME_NONNULL_END

//
//  GHLocationAreaTableViewCell.h
//  掌上优医
//
//  Created by GH on 2018/10/29.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHBaseTableViewCell.h"
#import "GHAreaModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHLocationAreaTableViewCell : GHBaseTableViewCell

@property (nonatomic, strong) GHAreaModel *model;

@property (nonatomic, assign) BOOL isSearch;

@property (nonatomic, copy) NSString *searchText;

@end

NS_ASSUME_NONNULL_END

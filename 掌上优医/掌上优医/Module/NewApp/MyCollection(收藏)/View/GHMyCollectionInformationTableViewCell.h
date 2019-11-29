//
//  GHMyCollectionInformationTableViewCell.h
//  掌上优医
//
//  Created by GH on 2019/2/21.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseTableViewCell.h"
#import "GHMyCollectionInformationModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHMyCollectionInformationTableViewCellDelegate <NSObject>

@optional
- (void)cancelCollectionSuccessShouldReloadData;

@end

@interface GHMyCollectionInformationTableViewCell : GHBaseTableViewCell

@property (nonatomic, weak) id<GHMyCollectionInformationTableViewCellDelegate> delegate;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHMyCollectionInformationModel *model;

@end

NS_ASSUME_NONNULL_END

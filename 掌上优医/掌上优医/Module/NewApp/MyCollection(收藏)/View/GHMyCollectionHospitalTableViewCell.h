//
//  GHMyCollectionHospitalTableViewCell.h
//  掌上优医
//
//  Created by GH on 2019/2/21.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseTableViewCell.h"
#import "GHMyCollectionHospitalModel.h"
#import "GHSearchHospitalModel.h"


NS_ASSUME_NONNULL_BEGIN

@protocol GHMyCollectionHospitalTableViewCellDelegate <NSObject>

@optional
- (void)cancelCollectionSuccessShouldReloadData;

@end

@interface GHMyCollectionHospitalTableViewCell : GHBaseTableViewCell

@property (nonatomic, weak) id<GHMyCollectionHospitalTableViewCellDelegate> delegate;

@property (nonatomic, strong) GHSearchHospitalModel *model;

@end

NS_ASSUME_NONNULL_END

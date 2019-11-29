//
//  GHNMyCollectionDoctorTableViewCell.h
//  掌上优医
//
//  Created by GH on 2019/2/21.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseTableViewCell.h"
#import "GHMyCollectionDoctorModel.h"

#import "GHSearchDoctorModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol GHNMyCollectionDoctorTableViewCellDelegate <NSObject>

@optional
- (void)cancelCollectionSuccessShouldReloadData;

@end

@interface GHNMyCollectionDoctorTableViewCell : GHBaseTableViewCell

@property (nonatomic, weak) id<GHNMyCollectionDoctorTableViewCellDelegate> delegate;

@property (nonatomic, strong) GHSearchDoctorModel *model;

@end

NS_ASSUME_NONNULL_END

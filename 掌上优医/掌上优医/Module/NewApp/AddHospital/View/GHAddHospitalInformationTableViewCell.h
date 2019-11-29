//
//  GHAddHospitalInformationTableViewCell.h
//  掌上优医
//
//  Created by GH on 2019/6/1.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseTableViewCell.h"
#import "GHHospitalInformationModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHAddHospitalInformationTableViewCellDelegate <NSObject>

@optional
- (void)clickDeleteWithTag:(NSInteger)tag;

- (void)clickAddHospitalInformationAction;

@end

@interface GHAddHospitalInformationTableViewCell : GHBaseTableViewCell

@property (nonatomic, weak) id<GHAddHospitalInformationTableViewCellDelegate> delegate;

@property (nonatomic, assign) NSUInteger index;

@property (nonatomic, strong) GHHospitalInformationModel *model;

- (void)syncModel;

@end

NS_ASSUME_NONNULL_END

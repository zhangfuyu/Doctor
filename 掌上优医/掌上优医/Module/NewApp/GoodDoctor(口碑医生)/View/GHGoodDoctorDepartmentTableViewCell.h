//
//  GHGoodDoctorDepartmentTableViewCell.h
//  掌上优医
//
//  Created by GH on 2018/10/30.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHBaseTableViewCell.h"
#import "GHNewDepartMentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHGoodDoctorDepartmentTableViewCell : GHBaseTableViewCell

@property (nonatomic, strong) GHNewDepartMentModel *model;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) NSString *hospitalID;
@end

NS_ASSUME_NONNULL_END

//
//  GHHospitalDepartmentChildrenTableViewCell.h
//  掌上优医
//
//  Created by GH on 2019/5/27.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseTableViewCell.h"
#import "GHDepartmentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHHospitalDepartmentChildrenTableViewCell : GHBaseTableViewCell

@property (nonatomic, strong) NSArray *childrenArray;

@property (nonatomic, strong) NSString *hospitalID;

@end

NS_ASSUME_NONNULL_END

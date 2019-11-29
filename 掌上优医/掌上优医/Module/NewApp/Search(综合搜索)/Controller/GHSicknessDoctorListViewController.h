//
//  GHSicknessDoctorListViewController.h
//  掌上优医
//
//  Created by GH on 2018/10/30.
//  Copyright © 2018 GH. All rights reserved.
//
//  疾病医生列表

#import "GHBaseViewController.h"
#import "GHNewDepartMentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHSicknessDoctorListViewController : GHBaseViewController



/**
 <#Description#>
 */
@property (nonatomic, strong) GHNewDepartMentModel *departmentModel;

/**
 按科室找医生
 */
@property (nonatomic, copy) NSString *departmentName;

@property (nonatomic, copy) NSString *sicknessId;

/**
 按疾病找医生
 */
@property (nonatomic, copy) NSString *sicknessName;

@property (nonatomic, copy) NSString *sicknessTitleName;


@property (nonatomic,strong)NSString *wordsType;

@end

NS_ASSUME_NONNULL_END

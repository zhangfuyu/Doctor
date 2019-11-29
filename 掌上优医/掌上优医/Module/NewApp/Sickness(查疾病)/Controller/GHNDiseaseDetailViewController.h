//
//  GHNDiseaseDetailViewController.h
//  掌上优医
//
//  Created by GH on 2019/4/1.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHNDiseaseDetailViewController : GHBaseViewController

@property (nonatomic, copy) NSString<Optional> *sicknessId;

@property (nonatomic, copy) NSString<Optional> *sicknessName;

@property (nonatomic, copy) NSString<Optional> *symptom;

@property (nonatomic, copy) NSString<Optional> *departmentName;

@end

NS_ASSUME_NONNULL_END

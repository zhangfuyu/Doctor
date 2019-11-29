//
//  GHDoctorDetailAnswerView.h
//  掌上优医
//
//  Created by GH on 2019/5/23.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"
#import "GHQuestionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHDoctorDetailAnswerView : GHBaseView

@property (nonatomic, strong) NSString *doctorId;

@property (nonatomic, strong) NSString *doctorName;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHQuestionModel *model;

@end

NS_ASSUME_NONNULL_END

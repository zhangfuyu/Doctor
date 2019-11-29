//
//  GHInformationDetailViewController.h
//  掌上优医
//
//  Created by GH on 2018/11/9.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHBaseViewController.h"
#import "GHArticleInformationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHInformationDetailViewController : GHBaseViewController

/**
 资讯 id
 */
@property (nonatomic, strong) NSString *informationId;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHArticleInformationModel *model;

@end

NS_ASSUME_NONNULL_END

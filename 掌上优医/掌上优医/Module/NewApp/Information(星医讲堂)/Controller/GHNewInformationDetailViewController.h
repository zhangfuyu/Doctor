//
//  GHNewInformationDetailViewController.h
//  掌上优医
//
//  Created by apple on 2019/9/19.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"
#import "GHNewZiXunModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHNewInformationDetailViewController : GHBaseViewController

@property (nonatomic, strong) NSString *informationId;
@property (nonatomic, strong) GHNewZiXunModel *model;
@property (nonatomic, copy) void (^clickCollectionBlock)(BOOL collection);


@end

NS_ASSUME_NONNULL_END

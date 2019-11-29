//
//  GHNPersonCenterCellView.h
//  掌上优医
//
//  Created by GH on 2019/2/20.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHNPersonCenterCellView : GHBaseView

@property (nonatomic, strong) UIButton *actionButton;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *lineLabel;

- (instancetype)initWithImageName:(NSString *)imageName withTitle:(NSString *)title withDesc:(NSString *)desc;

@end

NS_ASSUME_NONNULL_END

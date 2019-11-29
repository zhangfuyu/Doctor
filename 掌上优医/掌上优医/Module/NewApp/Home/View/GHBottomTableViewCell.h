//
//  GHBottomTableViewCell.h
//  掌上优医
//
//  Created by apple on 2019/7/31.
//  Copyright © 2019年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GHPageContentView.h"
NS_ASSUME_NONNULL_BEGIN

@interface GHBottomTableViewCell : UITableViewCell
@property (nonatomic, strong) GHPageContentView *pageContentView;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, assign) BOOL cellCanScroll;
@property (nonatomic, assign) BOOL isRefresh;

@property (nonatomic, strong) NSString *currentTagStr;
@end

NS_ASSUME_NONNULL_END

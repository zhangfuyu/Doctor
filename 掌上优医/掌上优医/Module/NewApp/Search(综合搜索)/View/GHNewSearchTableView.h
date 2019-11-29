//
//  GHNewSearchTableView.h
//  掌上优医
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHNewSearchTableView : UITableView

@property (nonatomic, strong)NSString *searchText;
// 数据源
@property (nonatomic, strong)NSMutableArray *thinkData;

// 点击cell
@property (nonatomic, copy) void (^clickResultBlock)(NSString *key);


@end

NS_ASSUME_NONNULL_END

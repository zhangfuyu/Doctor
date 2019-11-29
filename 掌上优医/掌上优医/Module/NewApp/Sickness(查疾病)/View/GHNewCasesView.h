//
//  GHNewCasesView.h
//  掌上优医
//
//  Created by apple on 2019/8/7.
//  Copyright © 2019年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHNewCasesView : UIView

@property (nonatomic, copy) void (^clickTypeBlock)(NSString *clickTitle);


@property (nonatomic, strong)  NSMutableArray *titleArry;

@end

NS_ASSUME_NONNULL_END

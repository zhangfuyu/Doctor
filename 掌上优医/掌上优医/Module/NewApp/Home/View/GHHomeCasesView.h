//
//  GHHomeCasesView.h
//  掌上优医
//
//  Created by apple on 2019/9/19.
//  Copyright © 2019 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHHomeCasesView : UIView

@property (nonatomic, copy) void (^clickTypeBlock)(NSString *clickTitle);


@property (nonatomic, strong)  NSMutableArray *titleArry;

@property (nonatomic, assign) NSInteger selectBtnTag;

@end

NS_ASSUME_NONNULL_END

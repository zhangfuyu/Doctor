//
//  GHSearchHearView.h
//  掌上优医
//
//  Created by apple on 2019/10/28.
//  Copyright © 2019 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHSearchHearView : UIView

- (instancetype)initWithTitleArray:(NSArray *)titleArray;

@property (nonatomic, copy) void (^clickTypeBlock)(NSInteger clickTag);


@property (nonatomic, strong)  NSMutableArray *titleArry;

@property (nonatomic, assign) NSInteger selectBtnTag;

@end

NS_ASSUME_NONNULL_END

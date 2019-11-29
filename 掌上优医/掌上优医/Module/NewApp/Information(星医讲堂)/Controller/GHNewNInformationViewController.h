//
//  GHNewNInformationViewController.h
//  掌上优医
//
//  Created by apple on 2019/8/1.
//  Copyright © 2019年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHNewNInformationViewController : GHBaseViewController
@property (nonatomic, assign) BOOL vcCanScroll;
@property (nonatomic, strong) UITableView *scrollView;
@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, strong) NSString *str;

@property (nonatomic, assign) BOOL isShowHomepush;

- (void)requsetData;
@end

NS_ASSUME_NONNULL_END

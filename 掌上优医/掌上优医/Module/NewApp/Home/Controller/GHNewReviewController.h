//
//  GHNewReviewController.h
//  掌上优医
//
//  Created by apple on 2019/7/31.
//  Copyright © 2019年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHNewReviewController : GHBaseViewController
@property (nonatomic, assign) BOOL vcCanScroll;
@property (nonatomic, strong) UICollectionView *scrollView;
@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, strong) NSString *str;
- (void)reloadRequest;
@end

NS_ASSUME_NONNULL_END

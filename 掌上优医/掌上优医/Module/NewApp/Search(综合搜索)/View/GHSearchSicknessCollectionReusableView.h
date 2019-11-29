//
//  GHSearchSicknessCollectionReusableView.h
//  掌上优医
//
//  Created by GH on 2018/10/29.
//  Copyright © 2018 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GHSearchSicknessCollectionReusableViewDelegate <NSObject>

- (void)finishSearchKeyWithText:(NSString *)text;

@end

@interface GHSearchSicknessCollectionReusableView : UICollectionReusableView

@property (nonatomic, weak) id<GHSearchSicknessCollectionReusableViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

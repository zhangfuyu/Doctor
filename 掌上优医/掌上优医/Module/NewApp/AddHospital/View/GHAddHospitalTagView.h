//
//  GHAddHospitalTagView.h
//  掌上优医
//
//  Created by GH on 2019/5/30.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHAddHospitalTagViewDelegate <NSObject>

@optional
- (void)updateCustomTagViewWithHeight:(CGFloat)height;

@end

@interface GHAddHospitalTagView : GHBaseView

/**
 <#Description#>
 */
@property (nonatomic, weak) id<GHAddHospitalTagViewDelegate> delegate;


@property (nonatomic, strong) NSMutableArray *tagArray;

@property (nonatomic, strong) NSMutableArray *tagButtonArray;

@property (nonatomic, strong) NSMutableArray *tagCloseArray;

@property (nonatomic, strong) UIButton *addTagButton;

- (void)updateUI;

@end

NS_ASSUME_NONNULL_END

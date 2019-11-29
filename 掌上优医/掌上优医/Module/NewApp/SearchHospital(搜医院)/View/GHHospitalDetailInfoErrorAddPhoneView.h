//
//  GHHospitalDetailInfoErrorAddPhoneView.h
//  掌上优医
//
//  Created by GH on 2019/5/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHHospitalDetailInfoErrorAddPhoneViewDelegate <NSObject>

@optional
- (void)updateAddPhoneViewWithHeight:(CGFloat)height;

@end

@interface GHHospitalDetailInfoErrorAddPhoneView : GHBaseView

@property (nonatomic, weak) id<GHHospitalDetailInfoErrorAddPhoneViewDelegate> delegate;

- (void)setupPhoneArray:(NSArray *)array;

- (void)endAllEditing;

/**
 <#Description#>
 */
@property (nonatomic, assign) BOOL isAdd;

/**
 获取联系电话
 
 @return <#return value description#>
 */
- (NSString *)getContactNumberString;

@end

NS_ASSUME_NONNULL_END

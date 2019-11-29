//
//  JFMorePhotoView.h
//  LeaseCloud
//
//  Created by JFYT on 2017/8/18.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFMorePhotoView : UIView

@property (nonatomic, strong) NSArray *imageUrlArray;

- (instancetype)initWithCount:(NSUInteger)count;

- (instancetype)initWithCount:(NSUInteger)count withCustomPhoto:(BOOL)customPhoto;

@property (nonatomic, assign) NSUInteger canAddCount;

@property (nonatomic, strong) NSMutableArray *uploadImageUrlArray;

@property (nonatomic, strong) NSString *fileType;

@property (nonatomic, assign) BOOL isOnlyCanCancel;

- (NSArray *)getOnlyImageUrlArray;

- (void)clickDeleteAction:(UIButton *)sender;

@property (nonatomic, strong) NSMutableArray *deleteButtonArray;

@end

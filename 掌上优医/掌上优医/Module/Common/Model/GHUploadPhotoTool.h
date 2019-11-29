//
//  GHUploadPhotoTool.h
//  掌上优医
//
//  Created by GH on 2018/11/10.
//  Copyright © 2018 GH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^uploadFinishBlock)(NSString *urlStr, UIImage *thumbImage);

@interface GHUploadPhotoTool : NSObject

+ (instancetype)shareInstance;

- (void)uploadImageWithImage:(UIImage *)image withMaxCapture:(NSUInteger)maxCapture type:(NSString *)type completion:(uploadFinishBlock)completion;

- (void)uploadVideoWithData:(NSData *)data completion:(uploadFinishBlock)completion;

@end

NS_ASSUME_NONNULL_END

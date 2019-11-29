//
//  GHPhotoTool.h
//  掌上优医
//
//  Created by GH on 2018/11/7.
//  Copyright © 2018 GH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PhotoSizeType) {
    PhotoSizeTypeSquare,        // 正方形 300 * 300 ?(待定)
    PhotoSizeTypeRectangle      // 矩形   300 * 400 ?(待定)
};


typedef void(^DeleteImgBlock)();

typedef void(^TakePhotoCallBack)(UIImage *originalImage, UIImage *image,NSData *data);

@interface GHPhotoTool : NSObject


/**
 *  单例
 */
+ (GHPhotoTool *)shareInstance;

/**
 *  点击删除的回调
 *
 */
- (void)deleteImgBlock:(DeleteImgBlock)deleteImgBlock;

/**
 *  进行拍照/选照片操作
 *
 *  @param isPresent 是否之前已经使用过模态(重复模态,会导致打开相册crash)
 *  @param block     拍完照后回调方法
 */
- (void)takePhotoWithVC:(UIViewController *)vc
              isPresent:(BOOL)isPresent
             allowsEdit:(BOOL)allowsEdit
                  block:(TakePhotoCallBack)block;

/**
 *  进行拍照/选照片操作
 *
 *  @param isPresent 是否之前已经使用过模态(重复模态,会导致打开相册crash)
 *  @param hasExampleImg 是否展示示例图片
 *  @param isVerticalScreen 横竖屏 yes竖屏;no横屏
 *  @param block     拍完照后回调方法
 */
- (void)takePhotoWithVC:(UIViewController *)vc
              isPresent:(BOOL)isPresent
             allowsEdit:(BOOL)allowsEdit
         exampleImgName:(NSString *)exampleImgName
          hasExampleImg:(BOOL)hasExampleImg
       isVerticalScreen:(BOOL)isVerticalScreen
                  block:(TakePhotoCallBack)block;


/**
 *  从相册选照片操作
 *
 *  @param isPresent 是否之前已经使用过模态(重复模态,会导致打开相册crash)
 *  @param block 拍完照后回调方法
 */
- (void)takePhotoLibraryWithVC:(UIViewController *)vc
                     isPresent:(BOOL)isPresent
                    allowsEdit:(BOOL)allowsEdit
                         block:(TakePhotoCallBack)block ;

/**
 *  从相机拍照操作
 *
 *  @param isPresent 是否之前已经使用过模态(重复模态,会导致打开相册crash)
 *  @param block 拍完照后回调方法
 */
- (void)takePhotoCameraWithVC:(UIViewController *)vc
                     isPresent:(BOOL)isPresent
                    allowsEdit:(BOOL)allowsEdit
                         block:(TakePhotoCallBack)block ;

/**
 *  点击查看大图(只查看,无其它处理)
 *
 *  @param imageUrlArr    图片/URL数组(image对象/image的URL,其余错误)
 *  @param index          当前图片的index
 *  @param viewController  viewController
 */
- (void)showBigImage:(NSArray *)imageUrlArr
        currentIndex:(NSInteger)index
      viewController:(UIViewController *)viewController
       cancelBtnText:(NSString *)btnText;

- (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;

- (void)uploadImageOrFileWithVC:(UIViewController *)vc
              andTipController:(UIViewController *)tipVC block:(TakePhotoCallBack)block;


@end

NS_ASSUME_NONNULL_END

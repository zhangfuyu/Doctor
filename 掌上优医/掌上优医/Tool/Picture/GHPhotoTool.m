//
//  GHPhotoTool.m
//  掌上优医
//
//  Created by GH on 2018/11/7.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHPhotoTool.h"
#import <MWPhotoBrowser.h>

#import "UIImage+Extension.h"

#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

#define kKeyWindow [UIApplication sharedApplication].keyWindow

@interface GHPhotoTool ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,MWPhotoBrowserDelegate>

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, copy) TakePhotoCallBack   block;
@property (nonatomic, copy) DeleteImgBlock   deleteImgBlock;
@property (nonatomic, assign) BOOL              isPresent;
@property (nonatomic, assign) BOOL              allowsEdit;// 是否允许编辑
@property (nonatomic, strong) NSMutableArray *photoArray;

@property (nonatomic, strong) UIView *navAddView;


@property (nonatomic, strong) UIViewController *tipVC;
@property (nonatomic, strong) NSObject *delegate;

@property (nonatomic, strong) UIActionSheet *fileAction;

@end

@implementation GHPhotoTool

// 单例
+ (GHPhotoTool *)shareInstance {
    
    static GHPhotoTool *tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[GHPhotoTool alloc] init];
    });
    return tools;
}


- (void)deleteImgBlock:(DeleteImgBlock)deleteImgBlock {
    self.deleteImgBlock = deleteImgBlock;
}

// 进行拍照/选照片操作
- (void)takePhotoWithVC:(UIViewController *)vc
              isPresent:(BOOL)isPresent
             allowsEdit:(BOOL)allowsEdit
                  block:(TakePhotoCallBack)block {
    
    self.viewController = vc;
    self.block = block;
    self.isPresent = isPresent;
    self.allowsEdit = allowsEdit;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [actionSheet showInView:vc.view];
}


/**
 选择上传文件或者图片
 */
-(void)uploadImageOrFileWithVC:(UIViewController *)vc andTipController:(UIViewController *)tipVC   block:(TakePhotoCallBack)block{
    self.viewController = vc;
    self.tipVC = tipVC;
    
    self.block= block;
    UIActionSheet *actionSheet  = [[UIActionSheet alloc] initWithTitle:nil
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"拍照", @"从相册中选取",@"上传文件", nil];
    self.fileAction = actionSheet;
    [actionSheet showInView:vc.view];
    
}

- (void)takePhotoWithVC:(UIViewController *)vc
              isPresent:(BOOL)isPresent
             allowsEdit:(BOOL)allowsEdit
         exampleImgName:(NSString *)exampleImgName
          hasExampleImg:(BOOL)hasExampleImg
       isVerticalScreen:(BOOL)isVerticalScreen
                  block:(TakePhotoCallBack)block {
    self.viewController = vc;
    self.block = block;
    self.isPresent = isPresent;
    self.allowsEdit = allowsEdit;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    //actionSheet.actionSheetStyle = UIBarStyleDefault;
    [actionSheet showInView:vc.view];
    
//    self.exmaplePhotoView = [[ExamplePhotoView alloc] initWithViewFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) imageName:exampleImgName hasExampleImg:hasExampleImg isVerticalScreen:isVerticalScreen];
//    [self.viewController.view addSubview:self.exmaplePhotoView];
}


// 从相册选照片操作
- (void)takePhotoLibraryWithVC:(UIViewController *)vc
                     isPresent:(BOOL)isPresent
                    allowsEdit:(BOOL)allowsEdit
                         block:(TakePhotoCallBack)block {
    self.viewController = vc;
    self.block = block;
    self.isPresent = isPresent;
    self.allowsEdit = allowsEdit;
    [self photo:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)takePhotoCameraWithVC:(UIViewController *)vc isPresent:(BOOL)isPresent allowsEdit:(BOOL)allowsEdit block:(TakePhotoCallBack)block {
    
    self.viewController = vc;
    self.block = block;
    self.isPresent = isPresent;
    self.allowsEdit = allowsEdit;
 
    [self photo:UIImagePickerControllerSourceTypeCamera];
}

/**
 *  点击查看大图(只查看,无其它处理)
 *
 *  @param imageUrlArr    图片/URL数组
 *  @param index          当前图片的index
 *  @param viewController  viewController
 */

- (void)showBigImage:(NSArray *)imageUrlArr
        currentIndex:(NSInteger)index
      viewController:(UIViewController *)viewController
       cancelBtnText:(NSString *)btnText{
    
    if (!imageUrlArr || imageUrlArr.count == 0) {
        return;
    }
    [self p_showBigImage:imageUrlArr
            currentIndex:index
        displayNavArrows:NO
              enableGrid:NO
                  isPush:YES
          viewController:viewController
           cancelBtnText:btnText];
}



#pragma mark - 内部私有方法
// ActionSheet 事件
- (void)photo:(UIImagePickerControllerSourceType)type {
    
    if (type == UIImagePickerControllerSourceTypePhotoLibrary) {
        
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) { // 无权限 // do something...
            [SVProgressHUD showErrorWithStatus:@"请前往设置打开您的相册权限"];
        }else{
            
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.view.backgroundColor = [UIColor whiteColor];
            //      picker.navigationController.navigationBar.barTintColor =  [UIColor blackColor];
            // picker.edgesForExtendedLayout = 0;
            
            picker.sourceType = type;
            //      picker.allowsEditing = NO; // yes为打开图像编辑功能
            picker.delegate = self;
            //    picker.edgesForExtendedLayout = UIRectEdgeNone;
            //    picker.navigationBar.backgroundColor = UIColorFrom16RGB(0x30333d);
            //    picker.navigationBar.barTintColor = UIColorFrom16RGB(0x30333d);
            [self.viewController presentViewController:picker animated:YES completion:nil];
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            
            picker.navigationBar.translucent = NO;
            picker.navigationBar.tintColor = kDefaultBlueColor;
            
        }
        
        
    }else if (type == UIImagePickerControllerSourceTypeCamera) {
        
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo]; if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) { // 无权限 // do something...
            [SVProgressHUD showErrorWithStatus:@"请前往设置打开您的相机权限"];
        }else{
            
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.view.backgroundColor = [UIColor whiteColor];
            //      picker.navigationController.navigationBar.barTintColor =  [UIColor blackColor];
            // picker.edgesForExtendedLayout = 0;
            
            picker.sourceType = type;
            //      picker.allowsEditing = NO; // yes为打开图像编辑功能
            picker.delegate = self;
            //    picker.edgesForExtendedLayout = UIRectEdgeNone;
            //    picker.navigationBar.backgroundColor = UIColorFrom16RGB(0x30333d);
            //    picker.navigationBar.barTintColor = UIColorFrom16RGB(0x30333d);
            [self.viewController presentViewController:picker animated:YES completion:nil];
            
            //      if (!self.isPresent) {
            //        [self.viewController.view addSubview:picker.view];
            //      }
            
            
        }
        
        
    }
    
}

// 处理图片
- (void)manageImage:(NSDictionary *)info {
    // 默认不允许编辑
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    //    if (self.allowsEdit) {
    //        originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
    //    }
    
    UIImage *editImage = [self scaleImage:originalImage];
    NSData *data = UIImageJPEGRepresentation(editImage, 0.7);
    
    if(self.block) {
        self.block(originalImage, editImage,data);
    }
}

// 裁剪图片
- (UIImage *)scaleImage:(UIImage *)image {
    
    CGSize originalSize = image.size;
    if (MAX(originalSize.width, originalSize.height) < 1024.0) {
        return image;
    }
    // 获取新的size 进行裁剪
    originalSize = [self p_getEditImageSize:originalSize];
    CGRect rect = CGRectMake(0, 0, originalSize.width, originalSize.height);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

// 获取裁剪的尺寸
- (CGSize)p_getEditImageSize:(CGSize)size {
    
    CGSize originalSize = size;
    
    if (originalSize.width > 1024.0 && originalSize.height > 1024.0) {
        if (originalSize.width > originalSize.height) {
            CGFloat tempScale = 1024.0 / originalSize.width;
            originalSize.width = 1024.0;
            originalSize.height = originalSize.height *tempScale;
            return originalSize;
        }
        
        CGFloat tempScale = 1024.0 / originalSize.height;
        originalSize.height = 1024.0;
        originalSize.width = originalSize.width *tempScale;
        return originalSize;
        
    } else if (MAX(originalSize.width, originalSize.height) > 1024.0) {
        
        if (originalSize.width > 1024.0  ) {
            CGFloat tempScale = 1024.0 / originalSize.width;
            originalSize.width = 1024.0;
            originalSize.height = originalSize.height *tempScale;
            return originalSize;
        }
        
        if (originalSize.height > 1024.0 ) {
            CGFloat tempScale = 1024.0 / originalSize.height;
            originalSize.height = 1024.0;
            originalSize.width = originalSize.width *tempScale;
            return originalSize;
        }
    }
    
    return originalSize;
}

// 压缩图片
- (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 0.7f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}
/**
 1、是 “压” 文件体积变小，但是像素数不变，长宽尺寸不变，那么质量可能下降，
 2、是 “缩” 文件的尺寸变小，也就是像素数减少。长宽尺寸变小，文件体积同样会减小。
 
 这个 UIImageJPEGRepresentation(image, 0.0)，是1的功能。
 这个 [sourceImage drawInRect:CGRectMake(0,0,targetWidth, targetHeight)] 是2的功能。
 */

/**
 *  点击查看大图的方法(内部)
 *
 *  @param imageUrlArray    图片的URL数组
 *  @param index            当前图片的index
 *  @param displayNavArrows 展现底部前进后退的按钮
 *  @param enableGrid       是否允许查看所有图片缩略图的网格
 *  @param isPush           显现方式(push/模态)
 *  @param VC               viewController
 */
- (void)p_showBigImage:(NSArray *)imageUrlArray
          currentIndex:(NSInteger)index
      displayNavArrows:(BOOL)displayNavArrows
            enableGrid:(BOOL)enableGrid
                isPush:(BOOL)isPush
        viewController:(UIViewController *)VC
         cancelBtnText:(NSString *)btnText {
    
    [self.photoArray removeAllObjects];
    
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i =0; i < imageUrlArray.count; i++) {
        id tempObject = imageUrlArray[i];
        MWPhoto *photo;
        if ([tempObject isKindOfClass:[UIImage class]]) {
            photo = [MWPhoto photoWithImage:(UIImage *)tempObject];
        } else {
            photo = [MWPhoto photoWithURL:kGetBigImageURLWithString((NSString *)tempObject)];
        }
        [imageArray addObject:photo];
    }
    [self.photoArray addObjectsFromArray:imageArray];
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    // 为了让取消按钮不会超出屏幕, 所以加上了空格
    browser.cancelBtnText = [NSString stringWithFormat:@"%@    ", ISNIL(btnText)];
    browser.delegate = self;
    browser.displayActionButton = NO; // 是否显示分享按钮
    browser.displayNavArrows = displayNavArrows; // 底部前进后退的按钮
    browser.displaySelectionButtons = NO;// 选中的按钮(右上角)
    browser.alwaysShowControls = YES; // 导航条底部的tabbar是否一直显示
    browser.zoomPhotosToFill = YES; // 放大以填充
    browser.enableGrid = enableGrid; // 是否允许查看所有图片缩略图的网格
    browser.startOnGrid = NO; // 是否开始的网格缩略图,而不是第一张照片
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = NO; // 自动播放视频
    browser.delayToHideElements = 30;
    
    [browser setCurrentPhotoIndex:index];
    
    //
    //    if (isPush) {
    //        // push方式出现
    //        [VC.navigationController pushViewController:browser animated:YES];
    //        return;
    //    }
    
    // 模态出现
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [VC presentViewController:nc animated:NO completion:nil];
}

/**
 是否有相机功能

 @return <#return value description#>
 */
-(BOOL)hasCamera {
    
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
    [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}
#pragma mark --UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0 && [self hasCamera]) {
        [self photo:UIImagePickerControllerSourceTypeCamera];
    } else if (buttonIndex == 1) {
        [self photo:UIImagePickerControllerSourceTypePhotoLibrary];
    }else if (buttonIndex == 2){
        if ([self.fileAction isEqual:actionSheet]) {
            [self uploadFile];
        }
        
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"示例照片消失");
//    if (self.exmaplePhotoView) {
//        [self.exmaplePhotoView removeFromSuperview];
//    }
    
}

#pragma mark ---选取文件上传
-(void)uploadFile{
    [self.viewController.navigationController pushViewController:self.tipVC animated:YES];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self manageImage:info];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo {
//    [self manageImage:editingInfo];
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker { 
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 第3方照片分享 MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photoArray.count;
}
- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photoArray.count) {
        return [self.photoArray objectAtIndex:index];
    }
    return nil;
}

// 显示缩略图
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < self.photoArray.count) {
        return [self.photoArray objectAtIndex:index];
    }
    return nil;
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    if (self.deleteImgBlock) {
        //    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationUploadHandinCarVoa" object:nil];
        self.deleteImgBlock();
    }
}

#pragma mark - lazy load
- (NSMutableArray *)photoArray {
    if (!_photoArray) {
        _photoArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _photoArray;
}



@end

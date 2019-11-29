//
//  JFMorePhotoView.m
//  LeaseCloud
//
//  Created by JFYT on 2017/8/18.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "JFMorePhotoView.h"
#import "GHPhotoTool.h"
//#import "UIView+Extension.h"

#import <UIButton+WebCache.h>

#import "GHUploadPhotoTool.h"

@interface JFMorePhotoView ()

@property (nonatomic, strong) NSMutableArray *photoButtonArray;

@property (nonatomic, assign) NSUInteger count;

@property (nonatomic, assign) BOOL isPresent;

@property (nonatomic, strong) NSMutableArray *photoArray;

/**
 <#Description#>
 */


@property (nonatomic, strong) UIButton *sender;

@property (nonatomic, strong) UIImage *selectImage;

@end

@implementation JFMorePhotoView

- (NSMutableArray *)deleteButtonArray {
    
    if (!_deleteButtonArray) {
        _deleteButtonArray = [[NSMutableArray alloc] init];
    }
    return _deleteButtonArray;
    
}

- (NSMutableArray *)uploadImageUrlArray{
  
    if (!_uploadImageUrlArray) {
        _uploadImageUrlArray = [[NSMutableArray alloc] init];
    }
    return _uploadImageUrlArray;
  
}

- (NSMutableArray *)photoArray{
  
    if (!_photoArray) {
        _photoArray = [[NSMutableArray alloc] init];
    }
    return _photoArray;
  
}

- (NSMutableArray *)photoButtonArray{
  
    if (!_photoButtonArray) {
        _photoButtonArray = [[NSMutableArray alloc] init];
    }
    return _photoButtonArray;
  
}

- (instancetype)initWithCount:(NSUInteger)count{
  
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.count = count;
        self.isPresent = YES;
        [self setupMainView];
    }

    return self;
  
}

- (instancetype)initWithCount:(NSUInteger)count withCustomPhoto:(BOOL)customPhoto {
    
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.count = count;
        self.isPresent = YES;
//        self.isCustomPhoto = customPhoto;
        [self setupMainView];
    }
    
    return self;
    
}

- (void)setupMainView{
  
    for (NSUInteger index = 0; index < self.count; index++) {

        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
        addButton.layer.borderWidth = 0.5;
        addButton.layer.cornerRadius = 1;
        addButton.clipsToBounds = true;

        [addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        
        
        addButton.tag = index;
        [self addSubview:addButton];

        [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(90);
            make.width.mas_equalTo(90);
            make.left.mas_equalTo((95 * (index % 3)));
            make.top.mas_equalTo(0 + (95) * (index / 3));
        }];

        addButton.hidden = YES;

        [addButton addTarget:self action:@selector(addPhotoAction:) forControlEvents:UIControlEventTouchUpInside];

        [self.photoButtonArray addObject:addButton];
        
        
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [deleteButton setImage:[UIImage imageNamed:@"ic_delete"] forState:UIControlStateNormal];
        
        deleteButton.tag = index;
        
        deleteButton.hidden = true;
        
        [self addSubview:deleteButton];
        
        [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(16);
            make.top.right.mas_equalTo(addButton);
        }];
        
        [deleteButton addTarget:self action:@selector(clickDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.deleteButtonArray addObject:deleteButton];

    }
  
}

- (void)addPhotoAction:(UIButton *)sender{
  self.sender = sender;
  kWeakSelf
//  if (self.imageUrlArray.count) {
//    [[CCCPhotoTools shareInstance] showBigImage:weakSelf.imageUrlArray currentIndex:sender.tag viewController:weakSelf.viewController cancelBtnText:@"取消"];
//  }else{
    if (sender.currentImage) {
        
      //有加号图片,添加照片
      [[GHPhotoTool shareInstance] takePhotoWithVC:weakSelf.viewController isPresent:self.isPresent allowsEdit:YES block:^(UIImage *originalImage, UIImage *image, NSData *data) {

          self.selectImage = image;

          [self uploadImageWithTag:self.sender.tag withData:data withImage:image];

      }];
      self.isPresent = NO;
        
        
      
    }else{
        
        if (self.isOnlyCanCancel == true) {
            [[GHPhotoTool shareInstance] showBigImage:weakSelf.photoArray currentIndex:sender.tag viewController:weakSelf.viewController cancelBtnText:@"取消"];
        } else {
            
            [[GHPhotoTool shareInstance] showBigImage:weakSelf.photoArray currentIndex:sender.tag viewController:weakSelf.viewController cancelBtnText:@"删除"];
            
            [[GHPhotoTool shareInstance] deleteImgBlock:^{
                [self.viewController.navigationController dismissViewControllerAnimated:YES completion:nil];
                if (sender.tag < self.canAddCount) {
                    if (sender.tag <self.uploadImageUrlArray.count) {
                        [self.photoArray removeObjectAtIndex:sender.tag];
                        [self.uploadImageUrlArray removeObjectAtIndex:sender.tag];
                        [self updateUI];
                    }
                }
            }];
            
        }
      

      
    }
//  }
  
}

- (void)clickDeleteAction:(UIButton *)sender {
    
    if (sender.tag < self.canAddCount) {
        if (sender.tag <self.uploadImageUrlArray.count) {
            [self.photoArray removeObjectAtIndex:sender.tag];
            [self.uploadImageUrlArray removeObjectAtIndex:sender.tag];
            [self updateUI];
        }
    }
    
}

- (void)uploadImageWithTag:(NSUInteger)tag withData:(NSData *)tdata withImage:(UIImage *)image{
  
    [self.sender setBackgroundImage:self.selectImage forState:UIControlStateNormal];
    [self.sender setImage:nil forState:UIControlStateNormal];
    [self.sender setTitle:@"" forState:UIControlStateNormal];
    
    UIButton *deleteButton = [self.deleteButtonArray objectOrNilAtIndex:self.sender.tag];
    deleteButton.hidden = false;
    
    if (self.isOnlyCanCancel == true) {
        deleteButton.hidden = true;
    }
    
    if (self.sender.tag < self.canAddCount - 1) {
        UIButton *button = [self.photoButtonArray objectOrNilAtIndex:self.sender.tag + 1];
        button.hidden = NO;
    }
    
    [self.photoArray addObject:self.selectImage];
    
    if (self.photoArray.count >= 3) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(185);
        }];
    } else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(90);
        }];
    }
    
    [SVProgressHUD showWithStatus:@"正在上传照片,请稍候..."];
    
    [[GHUploadPhotoTool shareInstance] uploadImageWithImage:image withMaxCapture:500 type:self.fileType completion:^(NSString * _Nonnull urlStr, UIImage * _Nonnull thumbImage) {
        
        [SVProgressHUD showSuccessWithStatus:@"图片上传成功"];
        [SVProgressHUD dismiss];
        
        NSMutableDictionary *imageInfoDic = [[NSMutableDictionary alloc] init];
        imageInfoDic[@"url"] = urlStr;
        imageInfoDic[@"width"] = @(thumbImage.size.width);
        imageInfoDic[@"height"] = @(thumbImage.size.height);
        
        [self.uploadImageUrlArray insertObject:imageInfoDic atIndex:tag];
        
    }];

}

- (void)updateUI{
  
  for (NSUInteger index = 0; index < self.photoButtonArray.count; index++) {
    
    UIButton *sender = [self.photoButtonArray objectAtIndex:index];
    sender.hidden = YES;
      
      UIButton *deleteButton = [self.deleteButtonArray objectOrNilAtIndex:index];
      deleteButton.hidden = YES;
    
    if (index < self.photoArray.count) {

        deleteButton.hidden = NO;
        
        if (self.isOnlyCanCancel == true) {
            deleteButton.hidden = true;
        }
        
        sender.hidden = NO;
        [sender setBackgroundImage:[self.photoArray objectAtIndex:index] forState:UIControlStateNormal];
        [sender setImage:nil forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    

    }
    
    if (index == self.photoArray.count) {
        sender.hidden = NO;
        [sender setBackgroundImage:nil forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
//        if (self.isCustomPhoto) {
//            [sender setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
//            [sender setTitle:@"最多四张" forState:UIControlStateNormal];
//        } else {
//
//        }
//      [sender setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    }
    
  }
    
    
    if (self.photoArray.count >= 3) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(185);
        }];
    } else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(90);
        }];
    }

  
}


- (void)setImageUrlArray:(NSArray *)imageUrlArray{
  
  _imageUrlArray = imageUrlArray;
//  [SDWebImageDownloader.sharedDownloader setValue:@"application/application/octet-stream"
//                               forHTTPHeaderField:@"Accept"];
  for (NSUInteger index = 0; index < imageUrlArray.count; index++) {
    if (imageUrlArray.count <= self.photoButtonArray.count) {
        
      UIButton *button = [self.photoButtonArray objectAtIndex:index];
      [button setImage:nil forState:UIControlStateNormal];
        [button setTitle:@"" forState:UIControlStateNormal];
      button.hidden = NO;
    
        NSString *imageUrl = [imageUrlArray objectAtIndex:index];
        [self.photoArray addObject:[[UIImage alloc] init]];
        [self.uploadImageUrlArray addObject:imageUrl];
        

        
        [button sd_setBackgroundImageWithURL:kGetBigImageURLWithString(imageUrl) forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (!error) {
                [self.photoArray replaceObjectAtIndex:index withObject:image];
            }
            
        }];
        
      
      [button setImage:nil forState:UIControlStateNormal];
      [button setTitle:@"" forState:UIControlStateNormal];
        
    }
  }

    [self updateUI];
  
}

- (void)setCanAddCount:(NSUInteger)canAddCount{
  
  _canAddCount = canAddCount;
  
  UIButton *button = [self.photoButtonArray firstObject];
  button.hidden = NO;

}

- (NSArray *)getOnlyImageUrlArray {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (id dic in self.uploadImageUrlArray) {
        
        if ([dic isKindOfClass:[NSDictionary class]]) {
            [array addObject:ISNIL(dic[@"url"])];
        } else if ([dic isKindOfClass:[NSString class]]) {
            [array addObject:ISNIL(dic)];
        }
        
    }
    
    return [array copy];
    
}

@end

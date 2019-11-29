//
//  CBTKeyboardCollectionViewCell.h
//  chebutou
//
//  Created by chebutou on 2017/12/19.
//  Copyright © 2017年 chebutou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBTKeyboardModel.h"

@protocol CBTKeyboardCollectionViewCellDelegate <NSObject>

@optional
- (void)KeyBoardCellBtnClick:(NSInteger)Tag;

@end

@interface CBTKeyboardCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<CBTKeyboardCollectionViewCellDelegate> delegate;

@property (nonatomic, strong) UIButton * keyboardBtn;

@property (nonatomic, strong) CBTKeyboardModel * model;

@end

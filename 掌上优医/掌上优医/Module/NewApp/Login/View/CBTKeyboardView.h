//
//  CBTKeyboardView.h
//  chebutou
//
//  Created by chebutou on 2017/12/19.
//  Copyright © 2017年 chebutou. All rights reserved.
//

#import "GHBaseView.h"

#import "CBTKeyboardCustomFlowLayout.h"
#import "CBTKeyboardCollectionViewCell.h"


@interface CBTKeyboardView : GHBaseView <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CBTKeyboardCollectionViewCellDelegate>

{
    BOOL isUp;
}

@property (nonatomic, strong) UICollectionView * topView;

@property (nonatomic, strong) UICollectionView * middleView;

@property (nonatomic, strong) UICollectionView * bottomView;

@property (nonatomic, strong) UIView * inputSource;

@property (nonatomic, strong) UIButton * clearBtn;

@property (nonatomic, strong) UIButton * upBtn;

@property (nonatomic, strong) NSMutableArray * modelArray;

@property (nonatomic, copy) NSArray * letterArray;

@end

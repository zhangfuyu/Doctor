//
//  CBTKeyboardView.m
//  chebutou
//
//  Created by chebutou on 2017/12/19.
//  Copyright © 2017年 chebutou. All rights reserved.
//

#import "CBTKeyboardView.h"
#import "UIButton+touch.h"

#define SCREEN_WIDTH         [UIScreen mainScreen].bounds.size.width

#define BOARDRATIO           (224.0 / 275)           //键盘的高宽比
#define KEYRATIO             (86.0  / 63)            //按键的高宽比

#define KEYBOARD_HEIGHT      (SCREEN_WIDTH * BOARDRATIO)    //键盘的高

#define BTN_WIDTH            (SCREEN_WIDTH / 10.0 - 6) //按键的宽
#define BTN_HEIGHT           (BTN_WIDTH * KEYRATIO)         //按键的高
#define ITEM_HEIGHT          (BTN_HEIGHT + 10)              //item的高

#define TOTAL_HEIGHT         (ITEM_HEIGHT * 4 + 10)

@implementation CBTKeyboardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, TOTAL_HEIGHT);
        
        [self setData];
        [self setup];
        
        if (kBottomSafeSpace != 0) {
            self.height += 34;
            [self.upBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-44);
            }];
            [self.clearBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-44);
            }];
        }
    }
    return self;
}

- (void)setData
{
    isUp = YES;
    
    for (NSInteger i = 1 ; i < 10 ; i ++)
    {
        CBTKeyboardModel * model = [[CBTKeyboardModel alloc] init];
        model.isUpper = YES;
        model.key = [NSString stringWithFormat:@"%ld",i];
        [self.modelArray addObject:model];
    }
    
    CBTKeyboardModel * model = [[CBTKeyboardModel alloc] init];
    model.isUpper = YES;
    model.key = @"0";
    [self.modelArray addObject:model];
    
    for (NSInteger i = 0 ; i < 26 ; i ++ )
    {
        CBTKeyboardModel * model = [[CBTKeyboardModel alloc] init];
        model.isUpper = YES;
        model.key = self.letterArray[i];
        
        [self.modelArray addObject:model];
    }
}

- (NSMutableArray *)modelArray
{
    if (!_modelArray)
    {
        _modelArray = [[NSMutableArray alloc] init];
    }
    return _modelArray;
}

- (NSArray *)letterArray
{
    if (!_letterArray)
    {
        _letterArray = @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"B",@"N",@"M"];
//        _letterArray = [NSArray arrayWithObjects:@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"B",@"N",@"M", nil];
    }
    return _letterArray;
}

- (UIButton *)clearBtn
{
    if (!_clearBtn)
    {
        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clearBtn.isIgnore = true;
        [_clearBtn setImage:[UIImage imageNamed:@"clear_a"] forState:UIControlStateNormal];
        [_clearBtn setImage:[UIImage imageNamed:@"clear_b"] forState:UIControlStateHighlighted];
        [_clearBtn addTarget:self action:@selector(ClearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_clearBtn];
        [_clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-3);
            make.bottom.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(BTN_HEIGHT, BTN_HEIGHT));
        }];
    }
    return _clearBtn;
}

- (UIButton *)upBtn
{
    if (!_upBtn)
    {
        _upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _upBtn.isIgnore = true;
        [_upBtn setImage:[UIImage imageNamed:@"up_a"] forState:UIControlStateNormal];
        [_upBtn setImage:[UIImage imageNamed:@"up_b"] forState:UIControlStateHighlighted];
        [_upBtn addTarget:self action:@selector(UpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_upBtn];
        [_upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(3);
            make.bottom.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(BTN_HEIGHT, BTN_HEIGHT));
        }];
    }
    return _upBtn;
}

- (void)setup
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self upBtn];
    [self clearBtn];
    
    //topView
    CBTKeyboardCustomFlowLayout * topflowLayout = [[CBTKeyboardCustomFlowLayout alloc]init];
    topflowLayout.sectionInset = UIEdgeInsetsMake(10, 3, 0, 3);
    [topflowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.topView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , ITEM_HEIGHT * 2) collectionViewLayout:topflowLayout];
    [self addSubview:self.topView];
    self.topView.delegate = self;
    self.topView.dataSource = self;
    self.topView.backgroundColor = [UIColor clearColor];
    [self.topView registerClass:[CBTKeyboardCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CBTKeyboardCollectionViewCell class])];
    
    
    //middleView
    CBTKeyboardCustomFlowLayout * middleflowLayout = [[CBTKeyboardCustomFlowLayout alloc]init];
    middleflowLayout.sectionInset = UIEdgeInsetsMake(10, 3, 0, 3);
    [middleflowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.middleView = [[UICollectionView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 20.0, ITEM_HEIGHT * 2, SCREEN_WIDTH / 10.0 * 9, ITEM_HEIGHT) collectionViewLayout:middleflowLayout];
    [self addSubview:self.middleView];
    self.middleView.delegate = self;
    self.middleView.dataSource = self;
    self.middleView.backgroundColor = [UIColor clearColor];
    [self.middleView registerClass:[CBTKeyboardCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CBTKeyboardCollectionViewCell class])];
    
    //bottomView
    CBTKeyboardCustomFlowLayout * bottomflowLayout = [[CBTKeyboardCustomFlowLayout alloc]init];
    bottomflowLayout.sectionInset = UIEdgeInsetsMake(10, 3, 0, 3);
    [bottomflowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.bottomView = [[UICollectionView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 3.0 / 20.0, ITEM_HEIGHT * 3, SCREEN_WIDTH / 10.0 * 7.0, ITEM_HEIGHT) collectionViewLayout:bottomflowLayout];
    [self addSubview:self.bottomView];
    self.bottomView.delegate = self;
    self.bottomView.dataSource = self;
    self.bottomView.backgroundColor = [UIColor clearColor];
    [self.bottomView registerClass:[CBTKeyboardCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CBTKeyboardCollectionViewCell class])];
    

    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView == self.topView)
    {
        return 2;
    }
    
    if (collectionView == self.middleView)
    {
        return 1;
    }
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.topView)
    {
        return 10;
    }
    
    if (collectionView == self.middleView)
    {
        return 9;
    }
    
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    CBTKeyboardCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CBTKeyboardCollectionViewCell class]) forIndexPath:indexPath];
    
    NSInteger index = indexPath.section * 10 + indexPath.item ;
    if (collectionView == self.middleView)
    {
        index = 20 + indexPath.section * 10 + indexPath.item ;
    }
    else if (collectionView == self.bottomView)
    {
        index = 29 + indexPath.section * 10 + indexPath.item ;
    }
    cell.tag = index + 100;
    cell.delegate = self;
    CBTKeyboardModel * model = (CBTKeyboardModel *)[self.modelArray objectOrNilAtIndex:index];
    CBTKeyboardModel * newmodel = [[CBTKeyboardModel alloc] init];
    newmodel.key = model.key;
    newmodel.isUpper = isUp;
    
    cell.model = newmodel;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(BTN_WIDTH , BTN_HEIGHT);
}

#pragma mark - 设置每个UICollectionView最小垂直间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - 设置每个UICollectionView最小水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


#pragma mark - KeyBoardCellDelgate
- (void)KeyBoardCellBtnClick:(NSInteger)Tag
{
    CBTKeyboardModel * model = (CBTKeyboardModel *)[self.modelArray objectOrNilAtIndex:Tag];
    if (!isUp && Tag > 9)
    {
        NSString * string = [model.key lowercaseString];
        [self inputString:string];
    }
    else
    {
        [self inputString:model.key];
    }
}

#pragma mark - Response Events
- (void)UpBtnClick:(UIButton *)sender
{
    sender.userInteractionEnabled = NO;
    isUp = !isUp;
    UIImage * image = isUp ? [UIImage imageNamed:@"up_a"] : [UIImage imageNamed:@"up_b"];
    [sender setImage:image forState:UIControlStateNormal];
    
    [self.topView reloadData];
    [self.middleView reloadData];
    [self.bottomView reloadData];
    sender.userInteractionEnabled = YES;
}

- (void)ClearBtnClick:(UIButton *)sender
{
    if (self.inputSource)
    {
        if ([self.inputSource isKindOfClass:[UITextField class]])
        {
            UITextField *tmp = (UITextField *)self.inputSource;
            [tmp deleteBackward];
        }
        else if ([self.inputSource isKindOfClass:[UITextView class]])
        {
            UITextView *tmp = (UITextView *)self.inputSource;
            [tmp deleteBackward];
        }
        else if ([self.inputSource isKindOfClass:[UISearchBar class]])
        {
            UISearchBar *tmp = (UISearchBar *)self.inputSource;
            NSMutableString *info = [NSMutableString stringWithString:tmp.text];
            if (info.length > 0) {
                NSString *s = [info substringToIndex:info.length-1];
                [tmp setText:s];
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationRecommendCodeClear" object:nil];
    }
}

#pragma mark - Private Events
- (void)inputString:(NSString *)string
{
    if (self.inputSource)
    {
        //UITextField
        if ([self.inputSource isKindOfClass:[UITextField class]])
        {
            UITextField * tmp = (UITextField *)self.inputSource;
            if (tmp.delegate && [tmp.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
            {
                NSRange range = NSMakeRange(tmp.text.length, 1);
                BOOL ret = [tmp.delegate textField:tmp shouldChangeCharactersInRange:range replacementString:string];
                if (ret)
                {
                    [tmp insertText:string];
                }
            }
            else
            {
                [tmp insertText:string];
            }
            
        }
        
        //UITextView
        else if ([self.inputSource isKindOfClass:[UITextView class]])
        {
            UITextView * tmp = (UITextView *)self.inputSource;
            if (tmp.delegate && [tmp.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)])
            {
                NSRange range = NSMakeRange(tmp.text.length, 1);
                BOOL ret = [tmp.delegate textView:tmp shouldChangeTextInRange:range replacementText:string];
                if (ret)
                {
                    [tmp insertText:string];
                }
            }
            else
            {
                [tmp insertText:string];
            }
            
        }
//            CBTUserModel
        //UISearchBar
        else if ([self.inputSource isKindOfClass:[UISearchBar class]])
        {
            UISearchBar *tmp = (UISearchBar *)self.inputSource;
            NSMutableString * info = [NSMutableString stringWithString:tmp.text];
            [info appendString:string];
            if (tmp.delegate && [tmp.delegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)])
            {
                NSRange range = NSMakeRange(tmp.text.length, 1);
                BOOL ret = [tmp.delegate searchBar:tmp shouldChangeTextInRange:range replacementText:string];
                if (ret)
                {
                    [tmp setText:[info copy]];
                }
            }
            else
            {
                [tmp setText:[info copy]];
            }
        }
    }
}

@end

//
//  GHEmojiRateView.m
//  掌上优医
//
//  Created by GH on 2019/5/14.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHEmojiRateView.h"

#define ForegroundStarImage @"ic_dianping_selected"
#define BackgroundStarImage @"ic_dianping_unselected"

typedef void(^completeBlock)(CGFloat currentScore);

@interface GHEmojiRateView()

@property (nonatomic, strong) UIView *foregroundStarView;
@property (nonatomic, strong) UIView *backgroundStarView;

@property (nonatomic, assign) NSInteger numberOfStars;


@property (nonatomic, strong) completeBlock complete;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *foregroundArray;

@end

@implementation GHEmojiRateView

- (NSMutableArray *)foregroundArray {
    
    if (!_foregroundArray) {
        _foregroundArray = [[NSMutableArray alloc] init];
    }
    return _foregroundArray;
    
}

#pragma mark - 代理方式
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = 5;
        _rateStyle = EmojiWholeStar;
        [self createStarView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(EmojiRateStyle)rateStyle isAnination:(BOOL)isAnimation delegate:(id)delegate{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        _rateStyle = rateStyle;
        _isAnimation = isAnimation;
        _delegate = delegate;
        [self createStarView];
    }
    return self;
}

#pragma mark - block方式
-(instancetype)initWithFrame:(CGRect)frame finish:(finishBlock)finish{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = 5;
        _rateStyle = EmojiWholeStar;
        _complete = ^(CGFloat currentScore){
            finish(currentScore);
        };
        [self createStarView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(EmojiRateStyle)rateStyle isAnination:(BOOL)isAnimation finish:(finishBlock)finish{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        _rateStyle = rateStyle;
        _isAnimation = isAnimation;
        _complete = ^(CGFloat currentScore){
            finish(currentScore);
        };
        [self createStarView];
    }
    return self;
}

#pragma mark - private Method
-(void)createStarView{
    
    self.foregroundStarView = [self createStarViewWithImage:ForegroundStarImage];
    self.backgroundStarView = [self createStarViewWithImage:BackgroundStarImage];
    self.foregroundStarView.frame = CGRectMake(0, 0, self.bounds.size.width*_currentScore/self.numberOfStars, self.bounds.size.height);
    
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    
    self.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(userPanRateView:)];
    [self addGestureRecognizer:panGesture];
    
}

- (UIView *)createStarViewWithImage:(NSString *)imageName {
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < self.numberOfStars; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_%ld", imageName, i + 1]]];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.width = 20;
        imageView.height = 20;
        imageView.mj_y = 2.5;
        imageView.mj_x = (20 + (20)) * i;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
        
        if ([imageName isEqualToString:ForegroundStarImage]) {
            [self.foregroundArray addObject:imageView];
        }
        
    }
    return view;
}

- (void)userTapRateView:(UITapGestureRecognizer *)gesture {
    CGPoint tapPoint = [gesture locationInView:self];
    CGFloat offset = tapPoint.x;
    CGFloat realStarScore = offset / 40;
    switch (_rateStyle) {
        case EmojiWholeStar:
        {
            self.currentScore = ceilf(realStarScore);
            break;
        }
        case EmojiHalfStar:
            self.currentScore = roundf(realStarScore)>realStarScore ? ceilf(realStarScore):(ceilf(realStarScore)-0.5);
            break;
        case EmojiIncompleteStar:
            self.currentScore = realStarScore;
            break;
        default:
            break;
    }
    
    if (self.currentScore == 0) {
        self.currentScore = 1;
    }
    
    if (self.currentScore > 5) {
        self.currentScore = 5;
    }
    
}

- (void)userPanRateView:(UIPanGestureRecognizer *)gesture {
    
    CGPoint moviePoint = [gesture locationInView:gesture.view];
    CGFloat offset = moviePoint.x;
    CGFloat realStarScore = offset / 40;
    switch (_rateStyle) {
        case EmojiWholeStar:
        {
            self.currentScore = ceilf(realStarScore);
            break;
        }
        case EmojiHalfStar:
            self.currentScore = roundf(realStarScore)>realStarScore ? ceilf(realStarScore):(ceilf(realStarScore)-0.5);
            break;
        case EmojiIncompleteStar:
            self.currentScore = realStarScore;
            break;
        default:
            break;
    }
    
    if (self.currentScore == 0) {
        self.currentScore = 1;
    }
    
    if (self.currentScore > 5) {
        self.currentScore = 5;
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak GHEmojiRateView *weakSelf = self;
    CGFloat animationTimeInterval = self.isAnimation ? 0.2 : 0;
    [UIView animateWithDuration:animationTimeInterval animations:^{
        weakSelf.foregroundStarView.frame = CGRectMake(0, 0, 40 * weakSelf.currentScore, weakSelf.bounds.size.height);
    }];
}


-(void)setCurrentScore:(CGFloat)currentScore {
    if (_currentScore == currentScore) {
        return;
    }
    if (currentScore < 0) {
        _currentScore = 0;
    } else if (currentScore > _numberOfStars) {
        _currentScore = _numberOfStars;
    } else {
        _currentScore = currentScore;
    }
    
    if ([self.delegate respondsToSelector:@selector(emojiRateView:currentScore:)]) {
        
        for (UIImageView *imageView in self.foregroundArray) {
            
            if (currentScore > 5) {
                imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_5", ForegroundStarImage]];
            } else if (currentScore < 1) {
                imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_1", ForegroundStarImage]];
            } else {
                imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%.0f", ForegroundStarImage, currentScore]];
            }
            
            
        }
        
        
        [self.delegate emojiRateView:self currentScore:_currentScore];
    }
    
    if (self.complete) {
        _complete(_currentScore);
    }
    
    [self setNeedsLayout];
}

@end

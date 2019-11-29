//
//  GHEmojiRateView.h
//  掌上优医
//
//  Created by GH on 2019/5/14.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"

@class GHEmojiRateView;

typedef void(^finishBlock)(CGFloat currentScore);

typedef NS_ENUM(NSInteger, EmojiRateStyle)
{
    EmojiWholeStar = 0, //只能整星评论
    EmojiHalfStar = 1,  //允许半星评论
    EmojiIncompleteStar = 2  //允许不完整星评论
};

@protocol GHEmojiRateViewDelegate <NSObject>

- (void)emojiRateView:(GHEmojiRateView *)starRateView currentScore:(CGFloat)currentScore;

@end


@interface GHEmojiRateView : GHBaseView

@property (nonatomic,assign)BOOL isAnimation;       //是否动画显示，默认NO
@property (nonatomic,assign)EmojiRateStyle rateStyle;    //评分样式    默认是WholeStar
@property (nonatomic, weak) id<GHEmojiRateViewDelegate>delegate;

@property (nonatomic, assign) CGFloat currentScore;

-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(EmojiRateStyle)rateStyle isAnination:(BOOL)isAnimation delegate:(id)delegate;


-(instancetype)initWithFrame:(CGRect)frame finish:(finishBlock)finish;
-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(EmojiRateStyle)rateStyle isAnination:(BOOL)isAnimation finish:(finishBlock)finish;

@end


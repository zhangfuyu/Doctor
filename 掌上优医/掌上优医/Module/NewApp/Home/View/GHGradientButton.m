//
//  GHGradientButton.m
//  掌上优医
//
//  Created by apple on 2019/10/11.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHGradientButton.h"
@interface GHGradientButton ()
{
    NSArray *_gradientColors; //存储渐变色数组
}

@property (nonatomic , strong)UIColor *gradientColor;
@end

@implementation GHGradientButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setNomelColor:(NSArray<UIColor *> *)colors
{
     [self setTitleColor:colors[0] forState:UIControlStateNormal];
}
- (void)setSelectedColor:(NSArray<UIColor *> *)colors
{
    if (colors.count == 1) {
        [self setNomelColor:colors];
    }
    else
    {
       //创建渐变层对象
       CAGradientLayer *gradientLayer = [CAGradientLayer layer];
       //设置渐变层的frame等同于titleLabel属性的frame（这里高度有个小误差，补上就可以了）
       gradientLayer.startPoint = CGPointMake(0, 0);
       gradientLayer.endPoint = CGPointMake(1, 0);
       gradientLayer.frame = CGRectMake(0, 0, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height + 3);
       //将存储的渐变色数组（UIColor类）转变为CAGradientLayer对象的colors数组，并设置该数组为CAGradientLayer对象的colors属性
       NSMutableArray *gradientColors = [NSMutableArray array];
       for (UIColor *colorItem in _gradientColors) {
           [gradientColors addObject:(id)colorItem.CGColor];
       }
       gradientLayer.colors = [NSArray arrayWithArray:gradientColors];
       //下一步需要将CAGradientLayer对象绘制到一个UIImage对象上，以便使用这个UIImage对象来填充按钮的字体
       UIImage *gradientImage = [self imageFromLayer:gradientLayer];
       
       UIColor *selectColor = [UIColor colorWithPatternImage:gradientImage];
        [self setTitleColor:selectColor forState:UIControlStateSelected];
    }
}

- (void)setGradientColors:(NSArray<UIColor *> *)colors {
    _gradientColors = [NSArray arrayWithArray:colors];
}



//绘制UIButton对象titleLabel的渐变色特效
- (void)setTitleGradientColors:(NSArray<UIColor *> *)colors {
    if (colors.count == 1) { //只有一种颜色，直接上色
        [self setTitleColor:colors[0] forState:UIControlStateNormal];
    } else { //有多种颜色，需要渐变层对象来上色
        
        //使用UIColor的如下方法，将字体颜色设为gradientImage模式，这样就可以将渐变色填充到字体上了，同理可以设置按钮各状态的不同显示效果
        [self setTitleColor:self.gradientColor forState:UIControlStateNormal];
    }
}

//将一个CALayer对象绘制到一个UIImage对象上，并返回这个UIImage对象
- (UIImage *)imageFromLayer:(CALayer *)layer {
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.opaque, 0);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

- (UIColor *)gradientColor
{
    if (!_gradientColor) {
        //创建渐变层对象
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        //设置渐变层的frame等同于titleLabel属性的frame（这里高度有个小误差，补上就可以了）
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.frame = CGRectMake(0, 0, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height + 3);
        //将存储的渐变色数组（UIColor类）转变为CAGradientLayer对象的colors数组，并设置该数组为CAGradientLayer对象的colors属性
        NSMutableArray *gradientColors = [NSMutableArray array];
        for (UIColor *colorItem in _gradientColors) {
            [gradientColors addObject:(id)colorItem.CGColor];
        }
        gradientLayer.colors = [NSArray arrayWithArray:gradientColors];
        //下一步需要将CAGradientLayer对象绘制到一个UIImage对象上，以便使用这个UIImage对象来填充按钮的字体
        UIImage *gradientImage = [self imageFromLayer:gradientLayer];
        
        _gradientColor = [UIColor colorWithPatternImage:gradientImage];
    }
    return _gradientColor;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_gradientColors) {
        [self setTitleGradientColors:_gradientColors];
    }
}
@end

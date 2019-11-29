//
//  GHNewContentHeaderView.m
//  掌上优医
//
//  Created by apple on 2019/8/6.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewContentHeaderView.h"
@interface GHNewContentHeaderView ()
@property (nonatomic , strong)NSMutableArray *buttonArray;

@property (nonatomic , strong)UILabel *contentlabel;

@property (nonatomic , strong)UIButton *arrowButton;

@end

@implementation GHNewContentHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *buttonView = [[UIView alloc] init];
        buttonView.backgroundColor = [UIColor whiteColor];
        [self addSubview:buttonView];
        
        [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top);
            make.height.mas_equalTo(34);
        }];
        
        NSArray *titleArray = @[@"概述", @"症状", @"病因", @"诊断", @"治疗"];
        
        for (NSInteger index = 0; index < titleArray.count; index++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:ISNIL([titleArray objectOrNilAtIndex:index]) forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
            [button setTitleColor:kDefaultBlueColor forState:UIControlStateSelected];
            button.titleLabel.font = HM15;
            button.tag = index;
            [buttonView addSubview:button];
            
            button.frame = CGRectMake(index * (SCREENWIDTH / titleArray.count), 0, SCREENWIDTH / titleArray.count, 34);
            
            [self.buttonArray addObject:button];
            
            [button addTarget:self action:@selector(clickTypeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            if (index == 0) {
                button.selected = YES;
            }
        }
        
        
        self.contentlabel = [[UILabel alloc] init];
        self.contentlabel.font = H14;
        self.contentlabel.textColor = kDefaultBlackTextColor;
        self.contentlabel.numberOfLines = 0;
        self.contentlabel.text = @"暂无简介";
        [self addSubview:self.contentlabel];
        
        [self.contentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(15);
            make.right.equalTo(self.mas_right).with.offset(-15);
            make.top.mas_equalTo(44);
            make.height.mas_equalTo(44);
        }];
        
        
        self.arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.arrowButton setImage:[UIImage imageNamed:@"ic_yiyuanzhuye_gengduo"] forState:UIControlStateNormal];
        [self.arrowButton setImage:[UIImage imageNamed:@"ic_yiyuanzhuye_shouqi"] forState:UIControlStateSelected];
        self.arrowButton.backgroundColor = [UIColor whiteColor];
      
        [self addSubview:self.arrowButton];
        
        [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.equalTo(self.mas_bottom).with.offset(-5);
            make.height.mas_equalTo(35);
        }];
        
        
        [self.arrowButton addTarget:self action:@selector(clickOpenAction:) forControlEvents:UIControlEventTouchUpInside];
//        self.arrowButton.hidden = true;
        
        
        
        UIView *lineview = [[UIView alloc]init];
        lineview.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
        [self addSubview:lineview];
        [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(5);
        }];
        
    }
    return self;
}
- (void)setModel:(GHNDiseaseModel *)model
{
    _model = model;
    
    
    [self setForlableText:_model.summary];
    
   
}

- (void)setForlableText:(NSString *)text
{
    if (!text) {
        self.arrowButton.hidden = YES;
        
        [self.contentlabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        
        if (self.clickTypeBlock) {
            self.clickTypeBlock(34 + 10 + 10 + 5);
        }
        return;
    }
    
    
    NSString *shouldGoodAtStr = text;//ISNIL(@"鼻炎即鼻腔炎性疾病，是病毒、细菌、变应原、各种理化因子以及某些全身性疾病引起的鼻腔黏膜的炎症。鼻炎的主要病理改变是鼻腔黏膜充血、肿胀、渗出、增生、萎缩或坏死等。鼻......");
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.maximumLineHeight = 21;
    paragraphStyle.minimumLineHeight = 21;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    
//    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:shouldGoodAtStr];
     NSAttributedString *attr = [[NSAttributedString alloc] initWithData:[shouldGoodAtStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
//    [attr addAttributes:@{NSFontAttributeName: H14} range:NSMakeRange(0, attr.string.length)];
//    [attr addAttributes:@{NSForegroundColorAttributeName: kDefaultBlackTextColor} range:NSMakeRange(0, attr.string.length)];
//    
//    [attr addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, attr.string.length)];
    
//    CGFloat shouldHeight = [shouldGoodAtStr getShouldHeightWithContent:attr.string withFont:H14 withWidth:SCREENWIDTH - 30 withLineHeight:21];
    CGFloat shouldHeight =  [attr boundingRectWithSize:CGSizeMake(SCREENWIDTH - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    self.contentlabel.attributedText = attr;
    
    if (shouldHeight > 44) {
        self.arrowButton.hidden = NO;
        [self.contentlabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
        }];
        if (self.clickTypeBlock) {
            self.clickTypeBlock(34 + 10 + 44 + 10 + 35 + 5);
        }
    }
    else
    {
        self.arrowButton.hidden = YES;
        
        [self.contentlabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(shouldHeight);
        }];
        
        if (self.clickTypeBlock) {
            self.clickTypeBlock(34 + 10 + shouldHeight + 10 + 5);
        }
    }
    

    
    
    
    
    
}


- (void)clickOpenAction:(UIButton *)sender
{
   self.arrowButton.selected = !self.arrowButton.selected;
    
    if (self.arrowButton.selected) {
        
        
//        CGFloat shouldHeight = [self.contentlabel.attributedText.string getShouldHeightWithContent:self.contentlabel.attributedText.string withFont:H14 withWidth:SCREENWIDTH - 30 withLineHeight:21];
         CGFloat shouldHeight =  [self.contentlabel.attributedText boundingRectWithSize:CGSizeMake(SCREENWIDTH - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        
        [self.contentlabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(shouldHeight);
        }];
        
        if (self.clickTypeBlock) {
            self.clickTypeBlock(34 + 10 + shouldHeight + 10 + 40);
        }
    }
    else
    {
        [self.contentlabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
        }];
        if (self.clickTypeBlock) {
            self.clickTypeBlock(34 + 10 + 44 + 10 + 40);
        }
    }
    
    
    
    
}
- (void)clickTypeButtonAction:(UIButton *)sender {
    
    
    
    self.arrowButton.selected = NO;
    [self.contentlabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
    }];
    
    for (UIButton *clickbtn in self.buttonArray) {
        if (clickbtn.tag != sender.tag) {
            clickbtn.selected = NO;
        }
        else
        {
            clickbtn.selected = YES;
        }
    }
    
   
    
    switch (sender.tag) {
        case 0:
            {
                [self setForlableText:_model.summary];

            }
            break;
        case 1:
        {
            [self setForlableText:_model.symptom];
            
        }
            break;
        case 2:
        {
            [self setForlableText:_model.pathogeny];

        }
            break;
        case 3:
        {
            [self setForlableText:_model.diagnosis];

        }
            break;
            
        default:
        {
            [self setForlableText:_model.treatment];

        }
            break;
    }
    
}

- (NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _buttonArray;
}
@end

//
//  GHDoctorCommentTagView.m
//  掌上优医
//
//  Created by GH on 2019/1/16.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHDoctorCommentTagView.h"
#import "UIButton+touch.h"

@interface GHDoctorCommentTagView ()

/**
 <#Description#>
 */
@property (nonatomic, strong) NSArray *titleArray;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSArray *imageArray;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *buttonArray;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *bgImageViewArray;

@end

@implementation GHDoctorCommentTagView

- (NSMutableArray *)buttonArray {
    
    if (!_buttonArray) {
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
    
}

- (NSMutableArray *)bgImageViewArray {
    
    if (!_bgImageViewArray) {
        _bgImageViewArray = [[NSMutableArray alloc] init];
    }
    return _bgImageViewArray;
    
}

- (instancetype)initWithTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray {
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleArray = titleArray;
        self.imageArray = imageArray;
        
        [self setupUI];
        
    }
    return self;
    
}

- (void)setupUI {
    
    for (NSInteger index = 0; index < self.titleArray.count; index++) {
        

        
//        UIView *bgView = [[UIView alloc] init];
//        bgView.backgroundColor = UIColorHex(0xEEF0F0);
//        bgView.layer.cornerRadius = 5;
//        bgView.layer.masksToBounds = true;
//        [self addSubview:bgView];
//
//
//        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(32);
//            make.width.mas_equalTo((SCREENWIDTH - 30 * self.titleArray.count) / self.titleArray.count);
//            make.left.mas_equalTo(15 + index * ((SCREENWIDTH - 30 * self.titleArray.count) / self.titleArray.count + 30));
//            make.centerY.mas_equalTo(self);
//        }];
//
//
//        UIView *view = [[UIView alloc] init];
//        view.backgroundColor = UIColorHex(0xDBFBFF);
//        view.tag = index;
//        view.userInteractionEnabled = false;
//        [self addSubview:view];
//
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.top.bottom.mas_equalTo(bgView);
//        }];
//
//        UIImageView *bgImageView = [[UIImageView alloc] init];
//        bgImageView.image = [UIImage imageNamed:@"ic_yonghupingjia_yiquanyu"];
//        [view addSubview:bgImageView];
//
//        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.top.mas_equalTo(0);
//            make.height.mas_equalTo(17.5);
//            make.width.mas_equalTo(18.5);
//        }];
//
//        UIImageView *iconImageView = [[UIImageView alloc] init];
//        iconImageView.image = [UIImage imageNamed:ISNIL([self.imageArray objectOrNilAtIndex:index])];
//        iconImageView.contentMode = UIViewContentModeScaleAspectFit;
//        [bgImageView addSubview:iconImageView];
//
//        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.height.mas_equalTo(8);
//            make.right.mas_equalTo(-1.5);
//            make.top.mas_equalTo(1.5);
//        }];
//
//
//        UILabel *titleLabel = [[UILabel alloc] init];
//        titleLabel.textAlignment = NSTextAlignmentCenter;
//        titleLabel.font = H14;
//        titleLabel.backgroundColor = [UIColor clearColor];
//        titleLabel.textColor = kDefaultBlackTextColor;
//        titleLabel.text = ISNIL([self.titleArray objectOrNilAtIndex:index]);
//        titleLabel.layer.cornerRadius = 5;
//        titleLabel.layer.masksToBounds = true;
//        titleLabel.userInteractionEnabled = false;
//        [self addSubview:titleLabel];
//
//        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.top.bottom.mas_equalTo(bgView);
//        }];

        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
        [button setTitleColor:kDefaultBlueColor forState:UIControlStateSelected];
        [button setTitle:ISNIL([self.titleArray objectOrNilAtIndex:index]) forState:UIControlStateNormal];
        
        
        button.titleLabel.font = H14;
        button.tag = index;
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = true;
        button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderWidth = 1;
        button.isIgnore = true;
        
        [button setBackgroundColor:[UIColor clearColor]];
        
        
        
        [self addSubview:button];

        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(32);
            make.width.mas_equalTo((SCREENWIDTH - 16 * self.titleArray.count - 16) / self.titleArray.count);
            make.left.mas_equalTo(16 + index * ((SCREENWIDTH - 16 * self.titleArray.count - 16) / self.titleArray.count + 16));
            make.centerY.mas_equalTo(self);

        }];
        
//        [self.bgImageViewArray addObject:view];
//        view.hidden = true;
        
        [self.buttonArray addObject:button];
        
        [button addTarget:self action:@selector(clickTagAction:) forControlEvents:UIControlEventTouchUpInside];

        
    }
    
    
}

- (void)clickTagAction:(UIButton *)sender {
    
    if (self.type == GHDoctorCommentTagType_SingleSelection) {
        
        if (sender.selected == true) {
            sender.selected = false;
            
            sender.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
            sender.backgroundColor = [UIColor whiteColor];
        } else {
            
            for (UIButton *button in self.buttonArray) {
                button.selected = false;
                
                button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
                button.backgroundColor = [UIColor whiteColor];
            }
            
            sender.selected = true;
            
            sender.layer.borderColor = kDefaultBlueColor.CGColor;
            sender.backgroundColor = UIColorHex(0xEFF0FD);
            
        }
        

        
    } else if (self.type == GHDoctorCommentTagType_MultipleChoice){
        
        sender.selected = !sender.selected;
        
        if (sender.selected) {
            
            sender.layer.borderColor = kDefaultBlueColor.CGColor;
            sender.backgroundColor = UIColorHex(0xEFF0FD);
            
        } else {
            sender.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
            sender.backgroundColor = [UIColor whiteColor];
        }
        
    }
    
    if ([self.delegate respondsToSelector:@selector(chooseTagAction)]) {
        [self.delegate chooseTagAction];
    }
  
}

- (NSArray *)getChooseResultArray {
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    for (UIButton *button in self.buttonArray) {
        
        if (button.selected == true) {
            [resultArray addObject:ISNIL(button.currentTitle)];
        }
        
    }
    
    return [resultArray copy];
    
}

- (void)resetAllStatus {
    
    for (UIButton *button in self.buttonArray) {
        button.selected = false;
    }
    
    for (UIView *bgView in self.bgImageViewArray) {
        bgView.hidden = true;
    }
    
}

- (void)setChooseStatusWithArray:(NSArray *)array {
 
    for (NSInteger index = 0; index < self.buttonArray.count; index++) {
        
        UIButton *button = [self.buttonArray objectOrNilAtIndex:index];
        UIView *bgView = [self.bgImageViewArray objectOrNilAtIndex:index];
        
        button.selected = false;
        bgView.hidden = true;
        
        if ([array containsObject:ISNIL(button.currentTitle)]) {
            button.selected = true;
            bgView.hidden = false;
        }
    }

}

@end

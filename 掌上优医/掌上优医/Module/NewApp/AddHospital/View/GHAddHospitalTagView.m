//
//  GHAddHospitalTagView.m
//  掌上优医
//
//  Created by GH on 2019/5/30.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHAddHospitalTagView.h"
#import "UIButton+touch.h"

#import "GHAddTagViewController.h"

@interface GHAddHospitalTagView () <GHAddTagViewControllerDelegate>






@end

@implementation GHAddHospitalTagView

- (NSMutableArray *)tagCloseArray {
    
    if (!_tagCloseArray) {
        _tagCloseArray = [[NSMutableArray alloc] init];
    }
    return _tagCloseArray;
    
}

- (NSMutableArray *)tagArray {
    
    if (!_tagArray) {
        _tagArray = [[NSMutableArray alloc] init];
    }
    return _tagArray;
    
}

- (NSMutableArray *)tagButtonArray {
    
    if (!_tagButtonArray) {
        _tagButtonArray = [[NSMutableArray alloc] init];
    }
    return _tagButtonArray;
    
}

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:UIColorHex(0xC5C5C5) forState:UIControlStateNormal];\
    [button setTitle:@"+ 添加标签" forState:UIControlStateNormal];
    
    
    button.titleLabel.font = H14;
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = true;
    button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
    
    button.layer.borderWidth = 0.5;
    button.isIgnore = true;
    
    [button setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(32);
        make.width.mas_equalTo((SCREENWIDTH - 30 - 30) / 3);
        make.left.mas_equalTo(17 + (self.tagArray.count % 3) * ((SCREENWIDTH - 30 - 30) / 3 + 13));
        make.top.mas_equalTo((self.tagArray.count / 3) * (30 + 17) + 10);
    }];
    
    self.addTagButton = button;
    
    [button addTarget:self action:@selector(clickAddTagAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickAddTagAction {
 
    GHAddTagViewController *vc = [[GHAddTagViewController alloc] init];
    vc.delegate = self;
    [self.viewController.navigationController pushViewController:vc animated:false];
    
}

- (void)finishAddTag:(NSString *)tag {
    
    [self.tagArray addObject:ISNIL(tag)];
    
    [self updateUI];
    
}

- (void)clickCloseAction:(UIButton *)sender {
    
    [self.tagArray removeObjectAtIndex:sender.tag];
    
    [self updateUI];
    
}

- (void)updateUI {
    
    for (UIButton *closeButton in self.tagCloseArray) {
        [closeButton removeFromSuperview];
    }
    
    for (UIButton *tagButton in self.tagButtonArray) {
        [tagButton removeFromSuperview];
    }
    
    for (NSInteger index = 0; index < self.tagArray.count; index++) {
        
        NSString *tag = [self.tagArray objectOrNilAtIndex:index];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];\
        [button setTitle:ISNIL(tag) forState:UIControlStateNormal];
        
        
        button.titleLabel.font = H14;
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = true;
        button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
        
        button.layer.borderWidth = 0.5;
        
        [button setBackgroundColor:[UIColor whiteColor]];
        
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(32);
            make.width.mas_equalTo((SCREENWIDTH - 30 - 30) / 3);
            make.left.mas_equalTo(17 + (index % 3) * ((SCREENWIDTH - 30 - 30) / 3 + 13));
            make.top.mas_equalTo((index / 3) * (30 + 17) + 10);
        }];
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setImage:[UIImage imageNamed:@"ic_dianpingyisheng_quxiao"] forState:UIControlStateNormal];
        closeButton.tag = index;
        
        [self addSubview:closeButton];
        
        [closeButton addTarget:self action:@selector(clickCloseAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(20);
            make.centerX.mas_equalTo(button.mas_right);
            make.centerY.mas_equalTo(button.mas_top);
        }];
        
        [self.tagButtonArray addObject:button];
        [self.tagCloseArray addObject:closeButton];
        
    }
    
    
    [self.addTagButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17 + (self.tagArray.count % 3) * ((SCREENWIDTH - 30 - 30) / 3 + 13));
        make.top.mas_equalTo((self.tagArray.count / 3) * (30 + 17) + 10);
    }];
    
    if ([self.delegate respondsToSelector:@selector(updateCustomTagViewWithHeight:)]) {
        
        if (self.tagArray.count < 3) {
            [self.delegate updateCustomTagViewWithHeight:60];
        } else {
            [self.delegate updateCustomTagViewWithHeight:(((self.tagArray.count) / 3) * (30 + 17) + 50)];
        }
       
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        
        if (self.tagArray.count < 3) {
            make.height.mas_equalTo(60);
        } else {
            make.height.mas_equalTo(((self.tagArray.count) / 3) * (30 + 17) + 50);
        }
       
    }];
    
}

@end

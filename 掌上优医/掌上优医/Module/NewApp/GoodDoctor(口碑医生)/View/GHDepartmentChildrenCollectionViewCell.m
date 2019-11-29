//
//  GHDepartmentChildrenCollectionViewCell.m
//  掌上优医
//
//  Created by GH on 2018/11/15.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHDepartmentChildrenCollectionViewCell.h"

@implementation GHDepartmentChildrenCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = true;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = HScaleFont(16);
    titleLabel.textColor = kDefaultBlackTextColor;
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(0);
    }];
    self.titleLabel = titleLabel;
    
}

@end


////
////  GHDepartmentChildrenCollectionViewCell.m
////  掌上优医
////
////  Created by GH on 2018/11/15.
////  Copyright © 2018 GH. All rights reserved.
////
//
//#import "GHDepartmentChildrenCollectionViewCell.h"
//
//@implementation GHDepartmentChildrenCollectionViewCell
//
//- (instancetype)initWithFrame:(CGRect)frame {
//
//    if (self = [super initWithFrame:frame]) {
//        [self setupUI];
//    }
//    return self;
//
//}
//
//- (void)setupUI {
//
//    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.font = [UIFont systemFontOfSize:floor(16 * (SCREENWIDTH / 375.f))];
//    titleLabel.textColor = kDefaultBlackTextColor;
//    [self addSubview:titleLabel];
//
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.bottom.right.mas_equalTo(0);
//    }];
//    self.titleLabel = titleLabel;
//
//    UILabel *lineLabel = [[UILabel alloc] init];
//    lineLabel.backgroundColor = kDefaultLineViewColor;
//    [self addSubview:lineLabel];
//
//    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.mas_equalTo(0);
//        make.height.mas_equalTo(1);
//    }];
//
//}
//
//@end

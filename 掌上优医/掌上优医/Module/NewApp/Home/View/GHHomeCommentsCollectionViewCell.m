//
//  GHHomeCommentsCollectionViewCell.m
//  掌上优医
//
//  Created by GH on 2019/2/18.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHomeCommentsCollectionViewCell.h"
#import "GHMyCommentsDetailViewController.h"

@interface GHHomeCommentsCollectionViewCell ()

/**
 <#Description#>
 */
@property (nonatomic, strong) UIImageView *imageView;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIView *imageContentView;

@property (nonatomic, strong) UIImageView *headPortraitImageView;

@property (nonatomic, strong) UILabel *nameLabel;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIButton *browserButton;

@end

@implementation GHHomeCommentsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 4;
    contentView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    contentView.layer.shadowOffset = CGSizeMake(0,2);
    contentView.layer.shadowOpacity = 1;
    contentView.layer.shadowRadius = 4;
    [self.contentView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(1);
        make.right.mas_equalTo(-1);
        make.top.mas_equalTo(1);
        make.bottom.mas_equalTo(-3);
    }];
    
    UIView *imageContentView = [[UIView alloc] init];
    imageContentView.backgroundColor = [UIColor whiteColor];
    imageContentView.layer.masksToBounds = true;
    imageContentView.layer.cornerRadius = 4;
    [contentView addSubview:imageContentView];
    
    [imageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0);
    }];
    self.imageContentView = imageContentView;
    
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = kDefaultGaryViewColor;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageContentView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    self.imageView = imageView;
    
    UIView *textContentView = [[UIView alloc] init];
    textContentView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:textContentView];
    
    [textContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(imageContentView.mas_bottom).offset(-3);
        make.bottom.mas_equalTo(0);
    }];
    
    UIImageView *headPortraitImageView = [[UIImageView alloc] init];
    headPortraitImageView.contentMode = UIViewContentModeScaleAspectFill;
    headPortraitImageView.layer.cornerRadius = 8.5;
    headPortraitImageView.layer.masksToBounds = true;
    headPortraitImageView.layer.borderColor = kDefaultLineViewColor.CGColor;
    headPortraitImageView.layer.borderWidth = 1;
    headPortraitImageView.backgroundColor = kDefaultGaryViewColor;
    [textContentView addSubview:headPortraitImageView];
    
    [headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-12);
        make.width.height.mas_equalTo(17);
        make.left.mas_equalTo(7);
    }];
    self.headPortraitImageView = headPortraitImageView;
    
    
    UIButton *browserButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [browserButton setTitleColor:UIColorHex(0x505151) forState:UIControlStateNormal];
    [browserButton setImage:[UIImage imageNamed:@"ic_homepage_watch_unselected"] forState:UIControlStateNormal];
    [browserButton setImage:[UIImage imageNamed:@"ic_homepage_watch_selected"] forState:UIControlStateSelected];
    browserButton.titleLabel.font = H12;
    browserButton.userInteractionEnabled = false;
    [contentView addSubview:browserButton];
    
    [browserButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-8);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(0);
    }];
    
    self.browserButton = browserButton;
    
    
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kDefaultBlackTextColor;
    nameLabel.font = H11;
    [textContentView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(7);
        make.top.bottom.mas_equalTo(headPortraitImageView);
        make.right.mas_equalTo(browserButton.mas_left).offset(-5);
    }];
    self.nameLabel = nameLabel;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = HM13;
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.numberOfLines = 2;
    titleLabel.backgroundColor = [UIColor whiteColor];
    [textContentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(6);
        make.right.mas_equalTo(-6);
        make.bottom.mas_equalTo(-37);
        make.top.mas_equalTo(3);
    }];
    
    self.titleLabel = titleLabel;
    
    

    
}



- (void)setModel:(GHChoiceModel *)model {
    
    _model = model;
    
    self.titleLabel.text = ISNIL(model.comment);
    
    self.nameLabel.text = ISNIL(model.userNickName);
    [self.headPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.userProfileUrl)) placeholderImage:[UIImage imageNamed:@"personcenter_user_default"]];
    
    NSArray *array = [model.pictures jsonValueDecoded];
    
    if (array.count) {
        
        [self.imageView sd_setImageWithURL:kGetBigImageURLWithString(model.firstPicture)];
        
        [self.imageContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo([model.imageHeight floatValue] + 4);
        }];
        
    } else {
        
        self.imageView.image = [UIImage new];
        
        [self.imageContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        
    }
    self.browserButton.hidden = YES;
    
    if ([self.model.visitCount integerValue] > 999) {
        [self.browserButton setTitle:@"999+" forState:UIControlStateNormal];
    } else {
        [self.browserButton setTitle:[NSString stringWithFormat:@"%ld", [self.model.visitCount integerValue]] forState:UIControlStateNormal];
    }
    
    if ([[GHSaveDataTool shareInstance].readCommentIdArray containsObject:self.model.modelId]) {
        self.browserButton.selected = true;
        if ([self.model.visitCount integerValue] == 0) {
            [self.browserButton setTitle:@"1" forState:UIControlStateNormal];
        }
    } else {
        self.browserButton.selected = false;
    }
    
    
}

@end


////
////  GHHomeCommentsCollectionViewCell.m
////  掌上优医
////
////  Created by GH on 2019/2/18.
////  Copyright © 2019 GH. All rights reserved.
////
//
//#import "GHHomeCommentsCollectionViewCell.h"
//#import "GHMyCommentsDetailViewController.h"
//
//@interface GHHomeCommentsCollectionViewCell ()
//
///**
// <#Description#>
// */
//@property (nonatomic, strong) UIImageView *imageView;
//
///**
// <#Description#>
// */
//@property (nonatomic, strong) UILabel *titleLabel;
//
///**
// <#Description#>
// */
//@property (nonatomic, strong) UIView *imageContentView;
//
//@end
//
//@implementation GHHomeCommentsCollectionViewCell
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
//    UIView *contentView = [[UIView alloc] init];
//    contentView.backgroundColor = [UIColor whiteColor];
//    contentView.layer.cornerRadius = 4;
//    contentView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
//    contentView.layer.shadowOffset = CGSizeMake(0,2);
//    contentView.layer.shadowOpacity = 1;
//    contentView.layer.shadowRadius = 4;
//    [self.contentView addSubview:contentView];
//
//    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(1);
//        make.right.mas_equalTo(-1);
//        make.top.mas_equalTo(1);
//        make.bottom.mas_equalTo(-3);
//    }];
//
//    UIView *imageContentView = [[UIView alloc] init];
//    imageContentView.backgroundColor = [UIColor whiteColor];
//    imageContentView.layer.masksToBounds = true;
//    imageContentView.layer.cornerRadius = 4;
//    [self.contentView addSubview:imageContentView];
//
//    [imageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.left.mas_equalTo(1);
//        make.right.mas_equalTo(-1);
//        make.height.mas_equalTo(0);
//    }];
//    self.imageContentView = imageContentView;
//
//
//
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.backgroundColor = kDefaultGaryViewColor;
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    [imageContentView addSubview:imageView];
//
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//        make.bottom.mas_equalTo(0);
//    }];
//    self.imageView = imageView;
//
//    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.font = HM14;
//    titleLabel.textColor = kDefaultBlackTextColor;
//    titleLabel.numberOfLines = 0;
//    titleLabel.backgroundColor = [UIColor whiteColor];
//    [contentView addSubview:titleLabel];
//
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(6);
//        make.right.mas_equalTo(-6);
//        make.bottom.mas_equalTo(0);
//        make.top.mas_equalTo(imageContentView.mas_bottom).offset(0);
//    }];
//
//    self.titleLabel = titleLabel;
//
//
//}
//
//
//
//- (void)setModel:(GHChoiceModel *)model {
//
//    _model = model;
//
//    self.titleLabel.text = ISNIL(model.comment);
//
//    NSArray *array = [model.pictures jsonValueDecoded];
//
//    if (array.count) {
//
//        [self.imageView sd_setImageWithURL:kGetImageURLWithString(model.firstPicture)];
//
//        [self.imageContentView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo([model.imageHeight floatValue]);
//        }];
//
//    } else {
//
//        self.imageView.image = [UIImage new];
//
//        [self.imageContentView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(0);
//        }];
//
//    }
//
//
//
//}
//
//@end

//
//  GHInfoErrorProgressTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/5/29.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHInfoErrorProgressTableViewCell.h"

@implementation GHInfoErrorProgressTableViewCell

- (NSMutableArray *)imageViewArray {
    
    if (!_imageViewArray) {
        _imageViewArray = [[NSMutableArray alloc] init];
    }
    return _imageViewArray;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    UILabel *titleLabel1 = [[UILabel alloc] init];
    titleLabel1.font = H16;
    titleLabel1.textColor = kDefaultGrayTextColor;
    titleLabel1.text = @"核实内容";
    [self.contentView addSubview:titleLabel1];
    
    [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(16);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(70);
    }];
    self.firstTitleLabel = titleLabel1;
    
    UILabel *valueLabel1 = [[UILabel alloc] init];
    valueLabel1.font = H16;
    valueLabel1.textColor = kDefaultBlackTextColor;
    [self.contentView addSubview:valueLabel1];
    
    [valueLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.mas_equalTo(titleLabel1.mas_top).offset(-1);
        make.right.mas_equalTo(-16);
    }];
    self.firstValueLabel = valueLabel1;
    
    
    UILabel *titleLabel2 = [[UILabel alloc] init];
    titleLabel2.font = H16;
    titleLabel2.textColor = kDefaultGrayTextColor;
    titleLabel2.text = @"原始信息";
    [self.contentView addSubview:titleLabel2];
    
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(valueLabel1.mas_bottom).offset(16);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(70);
    }];
    self.secondTitleLabel = titleLabel2;
    
    UILabel *valueLabel2 = [[UILabel alloc] init];
    valueLabel2.font = H16;
    valueLabel2.textColor = kDefaultBlackTextColor;
    valueLabel2.numberOfLines = 0;
    [self.contentView addSubview:valueLabel2];
    
    [valueLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.mas_equalTo(titleLabel2.mas_top).offset(-1);
        make.right.mas_equalTo(-16);
    }];
    self.secondValueLabel = valueLabel2;
    
    
    UILabel *titleLabel3 = [[UILabel alloc] init];
    titleLabel3.font = H16;
    titleLabel3.textColor = kDefaultGrayTextColor;
    titleLabel3.text = @"上报信息";
    [self.contentView addSubview:titleLabel3];
    
    [titleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(valueLabel2.mas_bottom).offset(16);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(70);
    }];
    self.thirdTitleLabel = titleLabel3;
    
    UILabel *valueLabel3 = [[UILabel alloc] init];
    valueLabel3.font = H16;
    valueLabel3.textColor = kDefaultBlackTextColor;
    valueLabel3.numberOfLines = 0;
    [self.contentView addSubview:valueLabel3];
    
    [valueLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.mas_equalTo(titleLabel3.mas_top).offset(-1);
        make.right.mas_equalTo(-16);
    }];
    self.thirdValueLabel = valueLabel3;

    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [self.contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    for (NSInteger index = 0; index < 6; index++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = kDefaultGaryViewColor;
        imageView.clipsToBounds = true;
        imageView.tag = index;
        imageView.userInteractionEnabled = true;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(40);
            make.left.mas_equalTo(15 + 50 * index);
            make.top.mas_equalTo(45);
        }];
        
        imageView.hidden = YES;
        
        [self.imageViewArray addObject:imageView];
        
    }
    
}

@end

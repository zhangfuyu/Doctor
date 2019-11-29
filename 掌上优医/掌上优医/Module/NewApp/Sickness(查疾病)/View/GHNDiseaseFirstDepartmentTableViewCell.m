//
//  GHNDiseaseFirstDepartmentTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/4/4.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNDiseaseFirstDepartmentTableViewCell.h"

@interface GHNDiseaseFirstDepartmentTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *lineLabel;

@property (nonatomic, strong) UILabel *lineLabel2;

@end

@implementation GHNDiseaseFirstDepartmentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = HM17;
    titleLabel.textColor = kDefaultBlackTextColor;
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-40);
        make.top.bottom.mas_equalTo(0);
    }];
    self.titleLabel = titleLabel;
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:arrowImageView];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
        make.width.mas_equalTo(40);
    }];
    self.arrowImageView = arrowImageView;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultBlueColor;
    [self.contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(3.5);
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(titleLabel);
    }];
    self.lineLabel = lineLabel;
    
    UILabel *lineLabel2 = [[UILabel alloc] init];
    lineLabel2.backgroundColor = kDefaultBlueColor;
    [self.contentView addSubview:lineLabel2];
    
    [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    self.lineLabel2 = lineLabel2;
    
}

- (void)setModel:(GHNewDepartMentModel *)model {
    
    _model = model;
    
    self.titleLabel.text = ISNIL(model.departmentName);
    
    if ([model.isOpen boolValue]) {
        self.arrowImageView.image = [UIImage imageNamed:@"search_sort_up_icon"];
    } else {
        self.arrowImageView.image = [UIImage imageNamed:@"search_sort_down_icon"];
    }
    
    if ([model.isSelected boolValue]) {
        self.lineLabel.hidden = false;
        self.contentView.backgroundColor = [UIColor whiteColor];
    } else {
        self.lineLabel.hidden = true;
        self.contentView.backgroundColor = kDefaultGaryViewColor;
    }
    
    if ([model.modelid longValue] == 0) {
        self.arrowImageView.hidden = true;
    } else {
        self.arrowImageView.hidden = false;
    }
    
    if ([model.modelid longValue] == 0 || [model.isSelected boolValue] == false) {
        self.lineLabel2.hidden = true;
    } else {
        self.lineLabel2.hidden = false;
    }
    
}

@end

//
//  GHNDiseaseSecondDepartmentTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/4/4.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNDiseaseSecondDepartmentTableViewCell.h"

@interface GHNDiseaseSecondDepartmentTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation GHNDiseaseSecondDepartmentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = H17;
    titleLabel.textColor = kDefaultBlackTextColor;
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.top.bottom.mas_equalTo(0);
    }];
    self.titleLabel = titleLabel;
    
}

- (void)setModel:(GHNewDepartMentModel *)model {
    
    _model = model;
    
    self.titleLabel.text = ISNIL(model.departmentName);
    
    if ([model.isSelected boolValue]) {
        self.titleLabel.textColor = kDefaultBlueColor;
    } else {
        self.titleLabel.textColor = kDefaultBlackTextColor;
    }
    
}

@end

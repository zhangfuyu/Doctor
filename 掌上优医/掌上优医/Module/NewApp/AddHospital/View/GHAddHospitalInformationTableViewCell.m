//
//  GHAddHospitalInformationTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/6/1.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHAddHospitalInformationTableViewCell.h"
#import "GHTextField.h"
#import "JFMorePhotoView.h"
#import "UIButton+touch.h"


@interface GHAddHospitalInformationTableViewCell ()

/**
 <#Description#>
 */
@property (nonatomic, strong) GHTextField *titleTextField;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHTextField *urlTextField;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIButton *isExternalButton;

/**
 <#Description#>
 */
@property (nonatomic, strong) JFMorePhotoView *photoView;

@end

@implementation GHAddHospitalInformationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultGaryViewColor;
    [self.contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *informationTitleLabel = [[UILabel alloc] init];
    informationTitleLabel.textColor = kDefaultBlackTextColor;
    informationTitleLabel.font = H16;
    informationTitleLabel.text = @"资讯标题";
    [self.contentView addSubview:informationTitleLabel];
    
    [informationTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(35);
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(16);
        make.width.mas_equalTo(80);
    }];
    

    
    GHTextField *titleTextField = [[GHTextField alloc] init];
    titleTextField.backgroundColor = [UIColor whiteColor];
    titleTextField.returnKeyType = UIReturnKeyDone;
    titleTextField.font = H15;
    titleTextField.textColor = kDefaultBlackTextColor;
    titleTextField.leftSpace = 6;
    
    titleTextField.placeholder = @"请输入标题";
    [self.contentView addSubview:titleTextField];
    
    [titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(110);
        make.right.mas_equalTo(-16);
        make.centerY.mas_equalTo(informationTitleLabel);
    }];
    
    self.titleTextField = titleTextField;
    
    UILabel *informationTitleLineLabel = [[UILabel alloc] init];
    informationTitleLineLabel.backgroundColor = kDefaultLineViewColor;
    [self.contentView addSubview:informationTitleLineLabel];
    
    [informationTitleLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(110);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(informationTitleLabel.mas_bottom).offset(3);
        make.height.mas_equalTo(1);
    }];
    
    
    JFMorePhotoView *photoView = [[JFMorePhotoView alloc] initWithCount:1];
    photoView.canAddCount = 1;
    [self.contentView addSubview:photoView];
    self.photoView = photoView;
    
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(informationTitleLabel.mas_bottom).offset(12);
        make.height.mas_equalTo(90);
    }];
    
    UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkButton setImage:[UIImage imageNamed:@"ic_yiyuanzixun_waibulianjie_unselected"] forState:UIControlStateNormal];
    [checkButton setImage:[UIImage imageNamed:@"ic_yiyuanzixun_waibulianjie_selected"] forState:UIControlStateSelected];
    [checkButton setTitle:@" 外部链接" forState:UIControlStateNormal];
    [checkButton setTitleColor:UIColorHex(0xCCCCCC) forState:UIControlStateNormal];
    checkButton.titleLabel.font = H13;
    checkButton.selected = true;
    checkButton.isIgnore = true;
    [self.contentView addSubview:checkButton];
    
    [checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(165);
        make.height.mas_equalTo(30);
    }];
    
    [checkButton addTarget:self action:@selector(clickCheckAction:) forControlEvents:UIControlEventTouchUpInside];
    self.isExternalButton = checkButton;
    
    
    GHTextField *urlTextField = [[GHTextField alloc] init];
    urlTextField.backgroundColor = [UIColor whiteColor];
    urlTextField.returnKeyType = UIReturnKeyDone;
    urlTextField.font = H15;
    urlTextField.textColor = kDefaultBlueColor;
    urlTextField.keyboardType = UIKeyboardTypeURL;
    urlTextField.placeholder = @"请输入链接";
    [self.contentView addSubview:urlTextField];
    
    [urlTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(200);
    }];
    
    self.urlTextField = urlTextField;
    
    UILabel *urlLineLabel = [[UILabel alloc] init];
    urlLineLabel.backgroundColor = kDefaultLineViewColor;
    [self.contentView addSubview:urlLineLabel];
    
    [urlLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(urlTextField.mas_bottom).offset(3);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *deleteLineLabel = [[UILabel alloc] init];
    deleteLineLabel.backgroundColor = kDefaultLineViewColor;
    [self.contentView addSubview:deleteLineLabel];
    
    [deleteLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-53);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [deleteButton setTitleColor:kDefaultGrayTextColor forState:UIControlStateNormal];
    deleteButton.titleLabel.font = H15;
    deleteButton.layer.borderColor = kDefaultGrayTextColor.CGColor;
    deleteButton.layer.borderWidth = .5;
    deleteButton.layer.cornerRadius = 12;
    deleteButton.layer.masksToBounds = true;
    [self.contentView addSubview:deleteButton];
    
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(deleteLineLabel.mas_top).offset(-12);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(66);
    }];
    [deleteButton addTarget:self action:@selector(clickDeleteAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *addHospitalInformationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addHospitalInformationButton.titleLabel.font = H15;
    [addHospitalInformationButton setTitle:@" 添加医院资讯" forState:UIControlStateNormal];
    [addHospitalInformationButton setTitleColor:kDefaultBlueColor forState:UIControlStateNormal];
    [addHospitalInformationButton setImage:[UIImage imageNamed:@"ic_xinzhengyiyuan_bianjiyiyuanzixun"] forState:UIControlStateNormal];
    [self.contentView addSubview:addHospitalInformationButton];
    
    [addHospitalInformationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(-16);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(deleteLineLabel.mas_bottom);
    }];
    
    [addHospitalInformationButton addTarget:self action:@selector(clickAddAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickCheckAction:(UIButton *)sender {
    
    sender.selected = !sender.isSelected;
    
}

- (void)setModel:(GHHospitalInformationModel *)model {
    
    _model = model;
    
    self.isExternalButton.selected = [model.isExternalWeb boolValue];
    
    self.urlTextField.text = ISNIL(model.h5url);
    
    self.titleTextField.text = ISNIL(model.title);
    
    if (model.informationImageUrl.length) {
        
        self.photoView.imageUrlArray = @[model.informationImageUrl];
        
    } else {
     
        if (self.photoView.deleteButtonArray.count > 0) {
            [self.photoView clickDeleteAction:[self.photoView.deleteButtonArray firstObject]];
        }
        
    }
    
}

- (void)clickDeleteAction {
    
    [self syncModel];
    
    if ([self.delegate respondsToSelector:@selector(clickDeleteWithTag:)]) {
        [self.delegate clickDeleteWithTag:self.index];
    }
    
}

- (void)clickAddAction {
    
    [self syncModel];
 
    if ([self.delegate respondsToSelector:@selector(clickAddHospitalInformationAction)]) {
        [self.delegate clickAddHospitalInformationAction];
    }
    
}

- (void)syncModel {
    
    self.model.isExternalWeb = [NSNumber numberWithBool:self.isExternalButton.isSelected];
    
    self.model.title = self.titleTextField.text;
    
    self.model.h5url = self.urlTextField.text;
    
    self.model.informationImageUrl = [[self.photoView getOnlyImageUrlArray] objectOrNilAtIndex:0];
    
}

@end

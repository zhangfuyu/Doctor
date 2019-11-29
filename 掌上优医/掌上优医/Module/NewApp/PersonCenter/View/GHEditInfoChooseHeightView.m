//
//  GHEditInfoChooseHeightView.m
//  掌上优医
//
//  Created by GH on 2019/2/20.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHEditInfoChooseHeightView.h"

@interface GHEditInfoChooseHeightView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation GHEditInfoChooseHeightView

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        
        for (NSInteger index = 50; index <= 230; index++) {
            [_dataArray addObject:[NSString stringWithFormat:@"%ld", index]];
        }
        
    }
    
    return _dataArray;
    
}

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.backgroundColor = RGBACOLOR(51, 51, 51, 0.1);
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(206 - kBottomSafeSpace);
    }];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = H16;
    [contentView addSubview:cancelButton];
    
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(60);
    }];
    [cancelButton addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    confirmButton.titleLabel.font = H16;
    [contentView addSubview:confirmButton];
    
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(0);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(60);
    }];
    [confirmButton addTarget:self action:@selector(clickConfirmAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.dataSource = self;
    picker.delegate =self;
    picker.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:picker];
    
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(45);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    
    self.pickerView = picker;
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor clearColor];
    [self addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(contentView.mas_top);
    }];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCancelAction)];
    [topView addGestureRecognizer:tapGR];
    
}

- (void)clickCancelAction {
    
    self.hidden = true;
    
}

- (void)clickConfirmAction {
    
    self.hidden = true;
    
    if ([self.delegate respondsToSelector:@selector(finishEditHeightWithText:)]) {
        
        NSInteger row = [self.pickerView selectedRowInComponent:0];
        
        [self.delegate finishEditHeightWithText:ISNIL([self.dataArray objectOrNilAtIndex:row])];
        
        
        
    }
    
}

#pragma mark---UIPicker数据源方法
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel){
        
        pickerLabel = [[UILabel alloc] init];
        
        // Setup label properties - frame, font, colors etc
        
        //adjustsFontSizeToFitWidth property to YES
        
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        
        pickerLabel.font = H17;
        
        pickerLabel.textColor = UIColorHex(0x4B4B4B);
        
    }
    
    // Fill the label text here
    
    pickerLabel.text = [NSString stringWithFormat:@"%@cm", [self.dataArray objectOrNilAtIndex:row]];
    
    return pickerLabel;
    
}


@end

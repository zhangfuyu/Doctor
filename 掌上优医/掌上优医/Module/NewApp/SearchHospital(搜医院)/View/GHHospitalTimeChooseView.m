//
//  GHHospitalTimeChooseView.m
//  掌上优医
//
//  Created by GH on 2019/5/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHospitalTimeChooseView.h"

@interface GHHospitalTimeChooseView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *startPickerView;

@property (nonatomic, strong) UIPickerView *endPickerView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation GHHospitalTimeChooseView

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        
        for (NSInteger index = 0; index < 24; index++) {
            [_dataArray addObject:[NSString stringWithFormat:@"%2ld:00", index]];
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
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.cornerRadius = 4;
    bottomView.layer.masksToBounds = true;
    [self addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(10);
        make.height.mas_equalTo((220 - kBottomSafeSpace));
    }];
    
    UIButton *contentView = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addTarget:self action:@selector(clickNoneAction) forControlEvents:UIControlEventTouchUpInside];
    contentView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.titleLabel.font = H16;
    [cancelButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [bottomView addSubview:cancelButton];
    
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.height.mas_equalTo(56);
        make.width.mas_equalTo(83);
    }];
    [cancelButton addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.titleLabel.font = H16;
    [confirmButton setTitleColor: kDefaultBlueColor forState:UIControlStateNormal];
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [bottomView addSubview:confirmButton];
    
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.height.mas_equalTo(56);
        make.width.mas_equalTo(83);
    }];
    
    [confirmButton addTarget:self action:@selector(clickConfirmAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [bottomView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(6);
        make.right.mas_equalTo(-6);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(56);
    }];
    
    UILabel *startTimeLabel = [[UILabel alloc] init];
    startTimeLabel.font = H14;
    startTimeLabel.textColor = kDefaultBlackTextColor;
    startTimeLabel.textAlignment = NSTextAlignmentCenter;
    startTimeLabel.text = @"开始时间";
    [bottomView addSubview:startTimeLabel];
    
    [startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(95);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(110);
    }];
    
    UILabel *endTimeLabel = [[UILabel alloc] init];
    endTimeLabel.font = H14;
    endTimeLabel.textColor = kDefaultBlackTextColor;
    endTimeLabel.textAlignment = NSTextAlignmentCenter;
    endTimeLabel.text = @"结束时间";
    [bottomView addSubview:endTimeLabel];
    
    [endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(95);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(110);
    }];
    
    UIPickerView *startPickerView = [[UIPickerView alloc] init];
    startPickerView.dataSource = self;
    startPickerView.delegate =self;
    startPickerView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:startPickerView];
    
    [startPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.width.mas_equalTo(60);
        make.top.mas_equalTo(60);
        make.height.mas_equalTo(120);
    }];
    
    self.startPickerView = startPickerView;
    
    UIPickerView *endPickerView = [[UIPickerView alloc] init];
    endPickerView.dataSource = self;
    endPickerView.delegate =self;
    endPickerView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:endPickerView];
    
    [endPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-100);
        make.width.mas_equalTo(60);
        make.top.mas_equalTo(60);
        make.height.mas_equalTo(120);
    }];
    
    self.endPickerView = endPickerView;
    
    [startPickerView selectRow:8 inComponent:0 animated:false];
    
    [endPickerView selectRow:18 inComponent:0 animated:false];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = HB18;
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cancelButton.mas_right);
        make.right.mas_equalTo(confirmButton.mas_left);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(56);
    }];
    self.titleLabel = titleLabel;
    
    

    
    UIButton *tapView = [UIButton buttonWithType:UIButtonTypeCustom];
    tapView.backgroundColor = [UIColor clearColor];
    [tapView addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tapView];
    
    [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(bottomView.mas_top);
    }];
    
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
    
    pickerLabel.text = [NSString stringWithFormat:@"%@", [self.dataArray objectOrNilAtIndex:row]];
    
    return pickerLabel;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 40;
    
}

- (void)clickConfirmAction {
    
    self.hidden = true;
    
    if ([self.delegate respondsToSelector:@selector(chooseTimeFinishWithTime:withTimeView:)]) {
        
        NSInteger startRow = [self.startPickerView selectedRowInComponent:0];
        NSInteger endRow = [self.endPickerView selectedRowInComponent:0];
        
        [self.delegate chooseTimeFinishWithTime:[NSString stringWithFormat:@"%@~%@", [self.dataArray objectOrNilAtIndex:startRow], [self.dataArray objectOrNilAtIndex:endRow]] withTimeView:self];
        
    }
    
}

/**
 只是为了不做任何响应
 */
- (void)clickNoneAction {
    
}

- (void)clickCancelAction {
    
    self.hidden = true;
    
}

@end

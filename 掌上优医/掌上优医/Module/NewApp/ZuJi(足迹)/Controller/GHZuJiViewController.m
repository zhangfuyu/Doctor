//
//  GHZuJiViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHZuJiViewController.h"

#import "GHNChooseTitleView.h"

#import "GHZuJiSicknessTableViewCell.h"
#import "GHZuJiDoctorTableViewCell.h"
#import "GHZuJiHospitalTableViewCell.h"
#import "GHZuJiInformationTableViewCell.h"

#import "GHDocterDetailViewController.h"
#import "GHInformationDetailViewController.h"


#import "GHArticleInformationModel.h"

#import "GHHospitalDetailViewController.h"
#import "GHSearchHospitalModel.h"

#import "GHNDiseaseDetailViewController.h"
/*****************add by zhangfuyu***************/
#import "GHSearchDoctorModel.h"
#import "GHSearchHospitalModel.h"
#import "GHNewDoctorDetailViewController.h"
#import "GHNewHospitalViewController.h"
/************************************************/

@interface GHZuJiViewController ()<GHNChooseTitleViewDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) GHNChooseTitleView *titleView;

@property (nonatomic, strong) NSMutableArray *tableViewArray;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) NSUInteger pageSize;

@property (nonatomic, strong) NSMutableArray *sicknessArray;
@property (nonatomic, strong) UITableView *sicknessTableView;

@property (nonatomic, strong) NSMutableArray *doctorArray;
@property (nonatomic, strong) UITableView *doctorTableView;
@property (nonatomic, assign) NSInteger doctorPage;

@property (nonatomic, strong) NSMutableArray *hospitalArray;
@property (nonatomic, strong) UITableView *hospitalTableView;
@property (nonatomic, assign) NSInteger hospitalPage;

@property (nonatomic, strong) NSMutableArray *informationArray;
@property (nonatomic, strong) UITableView *informationTableView;

@property (nonatomic, strong) UIView *sicknessEmptyView;
@property (nonatomic, strong) UIView *doctorEmptyView;
@property (nonatomic, strong) UIView *hospitalEmptyView;
@property (nonatomic, strong) UIView *informationEmptyView;

@end


@implementation GHZuJiViewController

- (UIView *)sicknessEmptyView{
    
    if (!_sicknessEmptyView) {
        _sicknessEmptyView = [[UIView alloc] init];
        _sicknessEmptyView.userInteractionEnabled = NO;
        _sicknessEmptyView.frame = CGRectMake(SCREENWIDTH * 0, 90, SCREENWIDTH, self.scrollView.contentSize.height);
        [self.scrollView addSubview:_sicknessEmptyView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_record"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_sicknessEmptyView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.centerX.mas_equalTo(imageView.superview).offset(-15);
            make.size.mas_equalTo(CGSizeMake(300, 110));
        }];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.font = H14;
        tipLabel.textColor = kDefaultGrayTextColor;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"暂无浏览记录";
        [_sicknessEmptyView addSubview:tipLabel];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(imageView.mas_bottom).offset(0);
            make.height.mas_equalTo(60);
        }];
        
        _sicknessEmptyView.hidden = YES;
        _sicknessEmptyView.userInteractionEnabled = false;
    }
    return _sicknessEmptyView;
    
}


- (UIView *)doctorEmptyView{
    
    if (!_doctorEmptyView) {
        _doctorEmptyView = [[UIView alloc] init];
        _doctorEmptyView.userInteractionEnabled = NO;
        _doctorEmptyView.frame = CGRectMake(SCREENWIDTH * 0, 90, SCREENWIDTH, self.scrollView.contentSize.height);
        [self.scrollView addSubview:_doctorEmptyView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_record"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_doctorEmptyView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.centerX.mas_equalTo(imageView.superview).offset(-15);
            make.size.mas_equalTo(CGSizeMake(300, 110));
        }];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.font = H14;
        tipLabel.textColor = kDefaultGrayTextColor;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"暂无浏览记录";
        [_doctorEmptyView addSubview:tipLabel];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(imageView.mas_bottom);
            make.height.mas_equalTo(60);
        }];
        
        _doctorEmptyView.hidden = YES;
        _doctorEmptyView.userInteractionEnabled = false;
    }
    return _doctorEmptyView;
    
}

- (UIView *)hospitalEmptyView{
    
    if (!_hospitalEmptyView) {
        _hospitalEmptyView = [[UIView alloc] init];
        _hospitalEmptyView.userInteractionEnabled = NO;
        _hospitalEmptyView.frame = CGRectMake(SCREENWIDTH * 1, 90, SCREENWIDTH, self.scrollView.contentSize.height);
        [self.scrollView addSubview:_hospitalEmptyView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_record"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_hospitalEmptyView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.centerX.mas_equalTo(imageView.superview).offset(-15);
            make.size.mas_equalTo(CGSizeMake(300, 110));
        }];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.font = H14;
        tipLabel.textColor = kDefaultGrayTextColor;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"暂无浏览记录";
        [_hospitalEmptyView addSubview:tipLabel];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(imageView.mas_bottom).offset(0);
            make.height.mas_equalTo(60);
        }];
        
        _hospitalEmptyView.hidden = YES;
        _hospitalEmptyView.userInteractionEnabled = false;
    }
    return _hospitalEmptyView;
    
}


- (UIView *)informationEmptyView{
    
    if (!_informationEmptyView) {
        _informationEmptyView = [[UIView alloc] init];
        _informationEmptyView.userInteractionEnabled = NO;
        _informationEmptyView.frame = CGRectMake(SCREENWIDTH * 3, 90, SCREENWIDTH, self.scrollView.contentSize.height);
        [self.scrollView addSubview:_informationEmptyView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_record"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_informationEmptyView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.centerX.mas_equalTo(imageView.superview).offset(-15);
            make.size.mas_equalTo(CGSizeMake(300, 110));
        }];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.font = H14;
        tipLabel.textColor = kDefaultGrayTextColor;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"暂无浏览记录";
        [_informationEmptyView addSubview:tipLabel];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(imageView.mas_bottom).offset(0);
            make.height.mas_equalTo(60);
        }];
        
        _informationEmptyView.hidden = YES;
        _informationEmptyView.userInteractionEnabled = false;
    }
    return _informationEmptyView;
    
}

- (NSMutableArray *)sicknessArray {
    
    if (!_sicknessArray) {
        _sicknessArray = [[[GHSaveDataTool shareInstance] getSandboxNoticeDataWithType:GHSaveDataType_Sickness] mutableCopy];
    }
    return _sicknessArray;
    
}

- (NSMutableArray *)doctorArray {
    
    if (!_doctorArray) {
        _doctorArray = [[[GHSaveDataTool shareInstance] getSandboxNoticeDataWithType:GHSaveDataType_Doctor] mutableCopy];
    }
    return _doctorArray;
    
}

- (NSMutableArray *)hospitalArray {
    
    if (!_hospitalArray) {
        _hospitalArray = [[[GHSaveDataTool shareInstance] getSandboxNoticeDataWithType:GHSaveDataType_Hospital] mutableCopy];
    }
    return _hospitalArray;
    
}

- (NSMutableArray *)informationArray {
    
    if (!_informationArray) {
        _informationArray = [[[GHSaveDataTool shareInstance] getSandboxNoticeDataWithType:GHSaveDataType_Information] mutableCopy];
    }
    return _informationArray;
    
}

- (NSMutableArray *)tableViewArray {
    
    if (!_tableViewArray) {
        _tableViewArray = [[NSMutableArray alloc] init];
    }
    return _tableViewArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的足迹";
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    self.doctorPage = 1;
    self.hospitalPage = 1;
    
    [self setupUI];
    [self requestData];
    
    [self addRightButton:@selector(clickCleanAction) title:@"清空"];
    
}

- (void)clickCleanAction {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否清空我的足迹" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSInteger contentType = 0;
        if (self.scrollView.contentOffset.x == SCREENWIDTH * 0)
        {
            contentType = 2;
        }
        else
        {
            contentType = 3;
        }
        
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiEmptyFootprint withParameter:@{@"contentType":@(contentType)} withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
            if (isSuccess) {
                if (contentType == 2) {
                    [self.doctorArray removeAllObjects];
                    [self.doctorTableView reloadData];
                    self.doctorEmptyView.hidden = self.doctorArray.count;
                }
                else
                {
                    [self.hospitalArray removeAllObjects];
                    [self.hospitalTableView reloadData];
                     self.hospitalEmptyView.hidden = self.hospitalArray.count;
                }
                [self requestData];

            }
        }];
        
        
//        [[GHSaveDataTool shareInstance] replaceArray:@[] withType:GHSaveDataType_Sickness];
//        [[GHSaveDataTool shareInstance] replaceArray:@[] withType:GHSaveDataType_Doctor];
//        [[GHSaveDataTool shareInstance] replaceArray:@[] withType:GHSaveDataType_Hospital];
//        [[GHSaveDataTool shareInstance] replaceArray:@[] withType:GHSaveDataType_Information];
//
//        [self.doctorArray removeAllObjects];
//        [self.sicknessArray removeAllObjects];
//        [self.hospitalArray removeAllObjects];
//        [self.informationArray removeAllObjects];
//
//        [self requestData];
//
//        [self.doctorTableView reloadData];
//        [self.sicknessTableView reloadData];
//        [self.hospitalTableView reloadData];
//        [self.informationTableView reloadData];
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    
    [self presentViewController:alertController animated:true completion:nil];
    
}

- (void)setupUI {
    
    NSArray *titleArray = @[/*@"疾病",*/ @"医生", @"医院", /*@"资讯"*/];
    
    GHNChooseTitleView *titleView = [[GHNChooseTitleView alloc] initWithTitleArray:titleArray];
    titleView.delegate = self;
    [self.view addSubview:titleView];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(SCREENWIDTH * titleArray.count, SCREENHEIGHT - Height_NavBar - 44 + kBottomSafeSpace);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.frame = CGRectMake(0, 44, SCREENWIDTH, SCREENHEIGHT - Height_NavBar - 44 + kBottomSafeSpace);
    scrollView.delegate = self;
    scrollView.scrollEnabled = false;
    [self.view addSubview:scrollView];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        
        UITableView *tableView = [[UITableView alloc] init];
        
//        if (index != 0 && index != 3) {
            tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
            tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
            
//        }
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tag = index;
        tableView.backgroundColor = kDefaultGaryViewColor;
        tableView.frame = CGRectMake(SCREENWIDTH * index, 0, SCREENWIDTH, scrollView.contentSize.height);
        
        [scrollView addSubview:tableView];
        
        [self.tableViewArray addObject:tableView];
        
        if (index == 0) {
//            self.sicknessTableView = tableView;
            self.doctorTableView = tableView;

        } else if (index == 1) {
//            self.doctorTableView = tableView;
            self.hospitalTableView = tableView;

        } else if (index == 2){
            self.hospitalTableView = tableView;
        } else if (index == 3){
            self.informationTableView = tableView;
        }
        
    }
    
    self.scrollView = scrollView;
    
}
- (void)getMoreData
{
    UITableView *tableview;
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];

    
    if (self.scrollView.contentOffset.x == SCREENWIDTH * 0) {
        
        parmas[@"contentType"] = @(2);
        
        tableview = self.doctorTableView;
        
        parmas[@"page"] = @(self.doctorPage + 1);
        parmas[@"pageSize"] = @(10);
     
        
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 1) {
        
        parmas[@"contentType"] = @(3);
        
        tableview = self.hospitalTableView;
        
        parmas[@"page"] = @(self.hospitalPage + 1);
        parmas[@"pageSize"] = @(10);
       
        
    }
    
    [self loaddataWith:tableview withParmas:parmas];
}


- (void)requestData {
    
    self.doctorPage = 1;
    self.hospitalPage = 1;
    
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"page"] = @(1);
    parmas[@"pageSize"] = @(10);
    
    UITableView *tableview;

    if (self.scrollView.contentOffset.x == SCREENWIDTH * 0) {
        
//        parmas[@"contentType"] = @(1);
//
//        tableview = self.sicknessTableView;
////        self.sicknessArray = [[[GHSaveDataTool shareInstance] getSandboxNoticeDataWithType:GHSaveDataType_Sickness] mutableCopy];
//
//        self.sicknessEmptyView.hidden = self.sicknessArray.count;
//
//        [self.sicknessArray removeAllObjects];
        
        parmas[@"contentType"] = @(2);
        
        tableview = self.doctorTableView;
        //        self.doctorArray = [[[GHSaveDataTool shareInstance] getSandboxNoticeDataWithType:GHSaveDataType_Doctor] mutableCopy];
        
        //        self.doctorEmptyView.hidden = self.doctorArray.count;
        [self.doctorArray removeAllObjects];
        
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 1) {
        
//        parmas[@"contentType"] = @(2);
//
//        tableview = self.doctorTableView;
////        self.doctorArray = [[[GHSaveDataTool shareInstance] getSandboxNoticeDataWithType:GHSaveDataType_Doctor] mutableCopy];
//
////        self.doctorEmptyView.hidden = self.doctorArray.count;
//        [self.doctorArray removeAllObjects];
        parmas[@"contentType"] = @(3);
        
        tableview = self.hospitalTableView;
        //        self.hospitalArray = [[[GHSaveDataTool shareInstance] getSandboxNoticeDataWithType:GHSaveDataType_Hospital] mutableCopy];
        //
        //        self.hospitalEmptyView.hidden = self.hospitalArray.count;
        [self.hospitalArray removeAllObjects];
        
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 2) {
        
        parmas[@"contentType"] = @(3);
        
        tableview = self.hospitalTableView;
//        self.hospitalArray = [[[GHSaveDataTool shareInstance] getSandboxNoticeDataWithType:GHSaveDataType_Hospital] mutableCopy];
//
//        self.hospitalEmptyView.hidden = self.hospitalArray.count;
        [self.hospitalArray removeAllObjects];
        
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 3) {
        parmas[@"contentType"] = @(4);
        
        tableview = self.informationTableView;
//        self.informationArray = [[[GHSaveDataTool shareInstance] getSandboxNoticeDataWithType:GHSaveDataType_Information] mutableCopy];
//
        self.informationEmptyView.hidden = self.informationArray.count;
        [self.informationArray removeAllObjects];
    }
    
    [self loaddataWith:tableview withParmas:parmas];
    
    
    
}

- (void)loaddataWith:(UITableView *)tableview withParmas:(NSMutableDictionary *)parmars
{
    
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiGetFootprint withParameter:parmars withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        [tableview.mj_footer endRefreshing];
        [tableview.mj_header endRefreshing];
        if (isSuccess) {
            
            NSDictionary *dataDic = response[@"data"];
            NSArray *footprintList = dataDic[@"footprintList"];
            
            if (footprintList.count > 0) {
                
                if ([parmars[@"contentType"] integerValue] == 2) {
                    self.doctorPage ++;
                    
                }
                else if ([parmars[@"contentType"] integerValue] == 3)
                {
                    self.hospitalPage ++;
                    
                }
                
                for (NSDictionary *dic in footprintList) {
                    
                    if ([parmars[@"contentType"] integerValue] == 2) {
                        
                        NSDictionary *detailsJson = dic[@"detailsJson"];
                        if (detailsJson.allKeys.count == 1) {
                            continue;
                        }
                        
                        GHSearchDoctorModel *model = [[GHSearchDoctorModel alloc]initWithDictionary:(NSDictionary *)detailsJson[@"doctor"] error:nil];
                        model.hospitalName = detailsJson[@"hospitalName"];
                        model.hospitalDepartment = [(NSArray *)detailsJson[@"hospitalDepartment"] firstObject];

                        [self.doctorArray addObject:model];
                        
                    }
                    else if ([parmars[@"contentType"] integerValue] == 3)
                    {
                        NSDictionary *detailsJson = dic[@"detailsJson"];
                        if (detailsJson.allKeys.count == 1) {
                            continue;
                        }
                        
                        GHSearchHospitalModel *model = [[GHSearchHospitalModel alloc]initWithDictionary:(NSDictionary *)detailsJson[@"hospital"] error:nil];

                        [self.hospitalArray addObject:model];
                    }
                    
                }
            }
            else
            {
                [tableview.mj_footer endRefreshingWithNoMoreData];
                
            }
            
           
            
            if ([parmars[@"contentType"] integerValue] == 2) {
                self.doctorEmptyView.hidden = self.doctorArray.count;
                [self.doctorTableView reloadData];
                
            }
            else if ([parmars[@"contentType"] integerValue] == 3)
            {
                self.hospitalEmptyView.hidden = self.hospitalArray.count;
                [self.hospitalTableView reloadData];
                
            }
        }
        
    }];
}
/**
 每当点击顶部按钮便刷新列表
 
 @param tag <#tag description#>
 */
- (void)clickButtonWithTag:(NSInteger)tag {
    
    [self.scrollView setContentOffset:CGPointMake(SCREENWIDTH * tag, 0) animated:NO];
    
    if (self.scrollView.contentOffset.x == SCREENWIDTH * 0) {
//
//        if (self.sicknessArray.count == 0) {
//            [self requestData];
//
//        }
        if (self.doctorArray.count == 0) {
            [self requestData];
            
        }
        
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 1) {
        
//        if (self.doctorArray.count == 0) {
//            [self requestData];
//
//        }
        if (self.hospitalArray.count == 0) {
            [self requestData];
            
        }
        
        
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 2) {
        
        if (self.hospitalArray.count == 0) {
            [self requestData];
            
        }
        
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 3) {
        if (self.informationArray.count == 0) {
            [self requestData];
            
        }
        
    }
    
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
//    if (tableView == self.doctorTableView) {
//        return self.doctorArray.count;
//    } else if (tableView == self.hospitalTableView) {
//        return self.hospitalArray.count;
//    } else if (tableView == self.informationTableView) {
//        return self.informationArray.count;
//    } else if (tableView == self.sicknessTableView) {
//        return self.sicknessArray.count;
//    }
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.doctorTableView) {
        
//        NSDictionary *dicInfo = [self.doctorArray objectOrNilAtIndex:section];
//
//        return ((NSArray *)dicInfo[@"data"]).count;
        return self.doctorArray.count;
        
    } else if (tableView == self.hospitalTableView) {
        
//        NSDictionary *dicInfo = [self.hospitalArray objectOrNilAtIndex:section];
//
//        return ((NSArray *)dicInfo[@"data"]).count;
        
        return self.hospitalArray.count;

        
    } else if (tableView == self.informationTableView) {
        
        NSDictionary *dicInfo = [self.informationArray objectOrNilAtIndex:section];
        
        return ((NSArray *)dicInfo[@"data"]).count;
        
    } else if (tableView == self.sicknessTableView) {
        
        NSDictionary *dicInfo = [self.sicknessArray objectOrNilAtIndex:section];
        
        return ((NSArray *)dicInfo[@"data"]).count;
        
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.doctorTableView) {
        return 108;
    } else if (tableView == self.hospitalTableView) {
        return 126;
    } else if (tableView == self.informationTableView) {
        return 87;
    } else if (tableView == self.sicknessTableView) {
        return 87;
    }
    return 0;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 36;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//    NSString *str;
//
//    if (tableView == self.doctorTableView) {
//        NSDictionary *dicInfo = [self.doctorArray objectOrNilAtIndex:section];
//        str = ISNIL(dicInfo[@"time"]);
//    } else if (tableView == self.hospitalTableView) {
//        NSDictionary *dicInfo = [self.hospitalArray objectOrNilAtIndex:section];
//        str = ISNIL(dicInfo[@"time"]);
//    } else if (tableView == self.informationTableView) {
//        NSDictionary *dicInfo = [self.informationArray objectOrNilAtIndex:section];
//        str = ISNIL(dicInfo[@"time"]);
//    } else if (tableView == self.sicknessTableView) {
//        NSDictionary *dicInfo = [self.sicknessArray objectOrNilAtIndex:section];
//        str = ISNIL(dicInfo[@"time"]);
//    }
//
//    if ([ISNIL(str) isEqualToString:ISNIL([[NSDate date] stringWithFormat:@"yyyy-MM-dd"])]) {
//        str = @"今天";
//    }
//
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = kDefaultGaryViewColor;
//    view.frame = CGRectMake(0, 0, SCREENWIDTH, 36);
//
//    UILabel *timeLabel = [[UILabel alloc] init];
//    timeLabel.font = H13;
//    timeLabel.textColor = kDefaultGrayTextColor;
//    timeLabel.text = ISNIL(str);
//
//    [view addSubview:timeLabel];
//
//    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(16);
//        make.right.mas_equalTo(-16);
//        make.height.mas_equalTo(16);
//        make.bottom.mas_equalTo(0);
//    }];
//
//    return view;
//
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.doctorTableView) {
        
        GHZuJiDoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHZuJiDoctorTableViewCell"];
        
        if (!cell) {
            cell = [[GHZuJiDoctorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHZuJiDoctorTableViewCell"];
        }
        
//        NSDictionary *dicInfo = [self.doctorArray objectOrNilAtIndex:indexPath.section];
//        NSArray *array = dicInfo[@"data"];
        
        cell.model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
        
        return cell;
        
    } else if (tableView == self.hospitalTableView) {
        
        GHZuJiHospitalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHZuJiHospitalTableViewCell"];
        
        if (!cell) {
            cell = [[GHZuJiHospitalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHZuJiHospitalTableViewCell"];
        }
        
//        NSDictionary *dicInfo = [self.hospitalArray objectOrNilAtIndex:indexPath.section];
//        NSArray *array = dicInfo[@"data"];
        
        cell.model = [self.hospitalArray objectOrNilAtIndex:indexPath.row];
        
        return cell;
        
    } else if (tableView == self.informationTableView) {
        
        GHZuJiInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHZuJiInformationTableViewCell"];
        
        if (!cell) {
            cell = [[GHZuJiInformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHZuJiInformationTableViewCell"];
        }
        
        NSDictionary *dicInfo = [self.informationArray objectOrNilAtIndex:indexPath.section];
        NSArray *array = dicInfo[@"data"];
        
        cell.model = [array objectOrNilAtIndex:indexPath.row];
        
        return cell;
        
    } else if (tableView == self.sicknessTableView) {
        
        GHZuJiSicknessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHZuJiSicknessTableViewCell"];
        
        if (!cell) {
            cell = [[GHZuJiSicknessTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHZuJiSicknessTableViewCell"];
        }
        
        NSDictionary *dicInfo = [self.sicknessArray objectOrNilAtIndex:indexPath.section];
        NSArray *array = dicInfo[@"data"];
        
        cell.model = [array objectOrNilAtIndex:indexPath.row];
        
        return cell;
        
    }
    
    return [UITableViewCell new];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView == self.doctorTableView) {
        
//        NSDictionary *dicInfo = [self.doctorArray objectOrNilAtIndex:indexPath.section];
//        NSArray *array = dicInfo[@"data"];
//        
//        GHZuJiDoctorModel *model = [array objectOrNilAtIndex:indexPath.row];
//        
//        GHDocterDetailViewController *vc = [[GHDocterDetailViewController alloc] init];
//        vc.doctorId = model.modelId;
//        [self.navigationController pushViewController:vc animated:true];
        
        
        GHSearchDoctorModel *model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
        GHNewDoctorDetailViewController *doctordetial = [[GHNewDoctorDetailViewController alloc]init];
        doctordetial.doctorId = model.modelId;
        [self.navigationController pushViewController:doctordetial animated:YES];
        
    } else if (tableView == self.hospitalTableView) {
        
//        NSDictionary *dicInfo = [self.hospitalArray objectOrNilAtIndex:indexPath.section];
//        NSArray *array = dicInfo[@"data"];
//
//        GHZuJiHospitalModel *model = [array objectOrNilAtIndex:indexPath.row];
//
//        GHHospitalDetailViewController *vc = [[GHHospitalDetailViewController alloc] init];
//        vc.model = [[GHSearchHospitalModel alloc] initWithDictionary:[model toDictionary] error:nil];
//        vc.model.modelId = model.modelId;
//        [self.navigationController pushViewController:vc animated:true];
        
        GHSearchHospitalModel *model = [self.hospitalArray objectOrNilAtIndex:indexPath.row];
        GHNewHospitalViewController *hospitalDetail = [[GHNewHospitalViewController alloc]init];
        hospitalDetail.hospitalID = model.modelId;
        [self.navigationController pushViewController:hospitalDetail animated:YES];
        
    } else if (tableView == self.informationTableView) {
        
        NSDictionary *dicInfo = [self.informationArray objectOrNilAtIndex:indexPath.section];
        NSArray *array = dicInfo[@"data"];
        
        GHZuJiInformationModel *model = [array objectOrNilAtIndex:indexPath.row];
        
        GHInformationDetailViewController *vc = [[GHInformationDetailViewController alloc] init];
        vc.informationId = model.modelId;
        
        GHArticleInformationModel *infomaModel = [[GHArticleInformationModel alloc] init];
        infomaModel.title = model.title;
        infomaModel.modelId = model.modelId;
        infomaModel.gmtCreate = model.gmtCreate;
        
        vc.model = infomaModel;
        
        [self.navigationController pushViewController:vc animated:true];
        
    } else if (tableView == self.sicknessTableView) {
        
        NSDictionary *dicInfo = [self.sicknessArray objectOrNilAtIndex:indexPath.section];
        NSArray *array = dicInfo[@"data"];
        
        GHZuJiSicknessModel *model = [array objectOrNilAtIndex:indexPath.row];
        
        GHNDiseaseDetailViewController *vc = [[GHNDiseaseDetailViewController alloc] init];
        vc.sicknessId = ISNIL(model.modelId);
        vc.sicknessName = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.diseaseName)];
        vc.symptom = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.symptom)];
        vc.departmentName = ISNIL(model.firstDepartmentName);
        [self.navigationController pushViewController:vc animated:true];
        
    }
    
    
}

@end

//
//  GHNMyCollectionViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/21.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNMyCollectionViewController.h"
#import "GHNChooseTitleView.h"

#import "GHNMyCollectionDoctorTableViewCell.h"
#import "GHMyCollectionHospitalTableViewCell.h"
#import "GHMyCollectionInformationTableViewCell.h"

#import "GHDocterDetailViewController.h"
#import "GHInformationDetailViewController.h"


#import "GHArticleInformationModel.h"

#import "GHHospitalDetailViewController.h"
#import "GHSearchHospitalModel.h"

/*****************add by zhangfuyu***************/
#import "GHSearchDoctorModel.h"
#import "GHSearchHospitalModel.h"
#import "GHNewDoctorDetailViewController.h"
#import "GHNewHospitalViewController.h"
#import "GHNewZiXunModel.h"
#import "GHNewZiXunTableViewCell.h"
#import "GHNewInformationDetailViewController.h"
/************************************************/

@interface GHNMyCollectionViewController ()<GHNChooseTitleViewDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, GHMyCollectionHospitalTableViewCellDelegate, GHMyCollectionInformationTableViewCellDelegate, GHNMyCollectionDoctorTableViewCellDelegate>

@property (nonatomic, strong) GHNChooseTitleView *titleView;

@property (nonatomic, strong) NSMutableArray *tableViewArray;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) NSUInteger pageSize;

@property (nonatomic, strong) NSMutableArray *doctorArray;
@property (nonatomic, assign) NSUInteger doctorCurrentPage;
@property (nonatomic, assign) NSUInteger doctorTotalPage;
@property (nonatomic, strong) UITableView *doctorTableView;

@property (nonatomic, strong) NSMutableArray *hospitalArray;
@property (nonatomic, assign) NSUInteger hospitalCurrentPage;
@property (nonatomic, assign) NSUInteger hospitalTotalPage;
@property (nonatomic, strong) UITableView *hospitalTableView;

@property (nonatomic, strong) NSMutableArray *informationArray;
@property (nonatomic, assign) NSUInteger informationCurrentPage;
@property (nonatomic, assign) NSUInteger informationTotalPage;
@property (nonatomic, strong) UITableView *informationTableView;

@property (nonatomic, strong) UIView *doctorEmptyView;
@property (nonatomic, strong) UIView *hospitalEmptyView;
@property (nonatomic, strong) UIView *informationEmptyView;

@end

@implementation GHNMyCollectionViewController


- (UIView *)doctorEmptyView{
    
    if (!_doctorEmptyView) {
        _doctorEmptyView = [[UIView alloc] init];
        _doctorEmptyView.userInteractionEnabled = NO;
        _doctorEmptyView.frame = CGRectMake(SCREENWIDTH * 0, 90, SCREENWIDTH, self.scrollView.contentSize.height);
        [self.scrollView addSubview:_doctorEmptyView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_collection"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_doctorEmptyView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.centerX.mas_equalTo(imageView.superview);
            make.size.mas_equalTo(CGSizeMake(300, 110));
        }];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.font = H14;
        tipLabel.textColor = kDefaultGrayTextColor;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"暂无收藏记录";
        [_doctorEmptyView addSubview:tipLabel];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(imageView.mas_bottom).offset(0);
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
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_collection"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_hospitalEmptyView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.centerX.mas_equalTo(imageView.superview);
            make.size.mas_equalTo(CGSizeMake(300, 110));
        }];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.font = H14;
        tipLabel.textColor = kDefaultGrayTextColor;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"暂无收藏记录";
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
        _informationEmptyView.frame = CGRectMake(SCREENWIDTH * 2, 90, SCREENWIDTH, self.scrollView.contentSize.height);
        [self.scrollView addSubview:_informationEmptyView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_collection"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_informationEmptyView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.centerX.mas_equalTo(imageView.superview);
            make.size.mas_equalTo(CGSizeMake(300, 110));
        }];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.font = H14;
        tipLabel.textColor = kDefaultGrayTextColor;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"暂无收藏记录";
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

- (NSMutableArray *)doctorArray {
    
    if (!_doctorArray) {
        _doctorArray = [[NSMutableArray alloc] init];
    }
    return _doctorArray;
    
}

- (NSMutableArray *)hospitalArray {
    
    if (!_hospitalArray) {
        _hospitalArray = [[NSMutableArray alloc] init];
    }
    return _hospitalArray;
    
}

- (NSMutableArray *)informationArray {
    
    if (!_informationArray) {
        _informationArray = [[NSMutableArray alloc] init];
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
    
    self.navigationItem.title = @"我的收藏";
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    [self setupConfig];
    [self setupUI];
    [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:kNotificationCancelDoctorCollectionSuccess object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:kNotificationDoctorCollectionSuccess object:nil];
    
}

- (void)setupConfig{
    
    self.pageSize = 10;
    self.doctorTotalPage = 1;
    self.hospitalTotalPage = 1;
    self.informationTotalPage = 1;
    self.doctorCurrentPage = 1;
    self.hospitalCurrentPage = 1;
    self.informationCurrentPage = 1;
    
}

- (void)setupUI {
    
    NSArray *titleArray = @[@"医生", @"医院", @"资讯"];
    
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
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tag = index;
        tableView.backgroundColor = kDefaultGaryViewColor;
        tableView.frame = CGRectMake(SCREENWIDTH * index, 0, SCREENWIDTH, scrollView.contentSize.height);
 
        [scrollView addSubview:tableView];
        
        [self.tableViewArray addObject:tableView];
        
        if (index == 0) {
            self.doctorTableView = tableView;
        } else if (index == 1){
            self.hospitalTableView = tableView;
        } else if (index == 2){
            self.informationTableView = tableView;
        }
        
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
        
    }
    
    self.scrollView = scrollView;
    
    
}

- (void)refreshData{
    
    if (self.scrollView.contentOffset.x == SCREENWIDTH * 0) {
        self.doctorCurrentPage = 1;
        self.doctorTotalPage = 2;
        [self.doctorArray removeAllObjects];
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 1) {
        self.hospitalCurrentPage = 1;
        self.hospitalTotalPage = 2;
        [self.hospitalArray removeAllObjects];
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 2) {
        self.informationCurrentPage = 1;
        self.informationTotalPage = 2;
        [self.informationArray removeAllObjects];

    }
    
    [self requestData];
    
}

- (void)getMoreData{
    
//    if (self.scrollView.contentOffset.x == SCREENWIDTH * 0) {
//        self.doctorCurrentPage ++ ;
//    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 1) {
//        self.hospitalCurrentPage ++;
//    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 2) {
//        self.informationCurrentPage ++ ;
//    }
    
    [self requestData];
    
}

- (void)requestData {
    
    NSMutableDictionary *parmars = [[NSMutableDictionary alloc]init];
    parmars[@"pageSize"] = @(self.pageSize);
    
    if (self.scrollView.contentOffset.x == SCREENWIDTH * 0) {
        
        parmars[@"page"] = @(self.doctorCurrentPage);
        parmars[@"contentType"] = @(1);
        
        
    
        
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 1) {
        
        parmars[@"page"] = @(self.hospitalCurrentPage);
        parmars[@"contentType"] = @(2);

        
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 2) {
        parmars[@"page"] = @(self.informationCurrentPage);
        parmars[@"contentType"] = @(3);
    
    }
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiGetConllection withParameter:parmars withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.doctorTableView.mj_header endRefreshing];
        [self.doctorTableView.mj_footer endRefreshing];
        [self.informationTableView.mj_header endRefreshing];
        [self.informationTableView.mj_footer endRefreshing];
        [self.hospitalTableView.mj_header endRefreshing];
        [self.hospitalTableView.mj_footer endRefreshing];
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            
            NSDictionary *dataDic = response[@"data"];
            NSArray *conllectionList = dataDic[@"conllectionList"];
            
            
            for (NSDictionary *dicInfo in conllectionList) {
                
                if ([parmars[@"contentType"] integerValue] == 1) {
                    
                    GHSearchDoctorModel *model = [[GHSearchDoctorModel alloc]initWithDictionary:dicInfo[@"detailsJson"][@"doctor"] error:nil];
                    model.hospitalName = dicInfo[@"detailsJson"][@"hospitalName"];
                    model.hospitalDepartment = [(NSArray *)dicInfo[@"detailsJson"][@"hospitalDepartment"] firstObject];
                    model.collectionId = dicInfo[@"id"];
                    model.profilePhoto = dicInfo[@"detailsJson"][@"doctor"][@"headImgUrl"];
                    
                   
                    [self.doctorArray addObject:model];

                    
                }
                else if ([parmars[@"contentType"] integerValue] == 2)
                {
                    GHSearchHospitalModel *model = [[GHSearchHospitalModel alloc]initWithDictionary:dicInfo[@"detailsJson"][@"hospital"] error:nil];
                    model.collectionId = dicInfo[@"id"];
                    [self.hospitalArray addObject:model];
                }
                else
                {
                    GHNewZiXunModel *model = [[GHNewZiXunModel alloc]initWithDictionary:dicInfo[@"detailsJson"][@"article"] error:nil];
                    [self.informationArray addObject:model];
                }
                
                
            }
            
            if (conllectionList.count >= 0) {
                
                if (self.scrollView.contentOffset.x == SCREENWIDTH * 0) {
                    self.doctorCurrentPage +=1;

                }
                else if (self.scrollView.contentOffset.x == SCREENWIDTH * 1)
                {
                    self.hospitalCurrentPage +=1;

                }
                else
                {
                    self.informationCurrentPage +=1;
                }
            } else {
                
                if (self.scrollView.contentOffset.x == SCREENWIDTH * 0) {
                    self.doctorCurrentPage --;
                    [self.doctorTableView.mj_footer endRefreshingWithNoMoreData];

                }
                else if (self.scrollView.contentOffset.x == SCREENWIDTH * 1)
                {
                    
                    self.hospitalCurrentPage --;
                    [self.hospitalTableView.mj_footer endRefreshingWithNoMoreData];
                }
                else
                {
                    self.informationCurrentPage --;
                    [self.informationTableView.mj_footer endRefreshingWithNoMoreData];
                }
                
                
            }
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationCollectionDoctorCellShouldReset" object:nil];
            
            
            if ([parmars[@"contentType"] integerValue] == 1) {
                if (self.doctorArray.count == 0) {
                    self.doctorEmptyView.hidden = false;
                }else{
                    self.doctorEmptyView.hidden = true;
                }
                [self.doctorTableView reloadData];
            }
            else if ([parmars[@"contentType"] integerValue] == 2)
            {
                if (self.hospitalArray.count == 0) {
                    self.hospitalEmptyView.hidden = false;
                }else{
                    self.hospitalEmptyView.hidden = true;
                }
                [self.hospitalTableView reloadData];
            }
            else
            {
                if (self.informationArray.count == 0) {
                    self.informationEmptyView.hidden = NO;
                }
                else{
                    self.informationEmptyView.hidden = YES;
                }
                [self.informationTableView reloadData];

            }
            
            
            
        }
        else
        {
            if (self.scrollView.contentOffset.x == SCREENWIDTH * 0) {
                self.doctorCurrentPage --;
                
            }
            else if (self.scrollView.contentOffset.x == SCREENWIDTH * 1)
            {
                
                self.hospitalCurrentPage --;
            }
            else
            {
                self.informationCurrentPage --;
            }
            
        }
        
    }];
    
}
- (NSString *)resetToReplaceWith:(NSString *)text
{
    NSMutableArray *changearry = [NSMutableArray arrayWithCapacity:0];
    NSArray *arry = [text componentsSeparatedByString:@","];
    if ([arry containsObject:@"主任医师"]) {
        [changearry addObject:@"4"];
    }
    if ([arry containsObject:@"副主任医师"]) {
        [changearry addObject:@"3"];
    }
    if ([arry containsObject:@"主治医师"]) {
        [changearry addObject:@"2"];
    }
    if ([arry containsObject:@"医师"]) {
        [changearry addObject:@"1"];
    }

    return  [changearry componentsJoinedByString:@","];
}
/**
 每当点击顶部按钮便刷新列表
 
 @param tag <#tag description#>
 */
- (void)clickButtonWithTag:(NSInteger)tag {
    
    [self.scrollView setContentOffset:CGPointMake(SCREENWIDTH * tag, 0) animated:NO];
    
    if (self.scrollView.contentOffset.x == SCREENWIDTH * 0) {
        
        if (self.doctorArray.count == 0) {
            [self refreshData];

        }
        
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 1) {
        
        if (self.hospitalArray.count == 0) {
            [self refreshData];
            
        }
        
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 2) {
        
        if (self.informationArray.count == 0) {
            [self refreshData];
            
        }
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.doctorTableView) {
        return self.doctorArray.count;
    } else if (tableView == self.hospitalTableView) {
        return self.hospitalArray.count;
    } else if (tableView == self.informationTableView) {
        return self.informationArray.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.doctorTableView) {
        return 108;
    } else if (tableView == self.hospitalTableView) {
        return 126;
    } else if (tableView == self.informationTableView) {
        return 130;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.doctorTableView) {
        
        GHNMyCollectionDoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNMyCollectionDoctorTableViewCell"];
        
        if (!cell) {
            cell = [[GHNMyCollectionDoctorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNMyCollectionDoctorTableViewCell"];
            cell.delegate = self;
        }
        
        cell.model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
        
        return cell;
        
    } else if (tableView == self.hospitalTableView) {
        
        GHMyCollectionHospitalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHMyCollectionHospitalTableViewCell"];
        
        if (!cell) {
            cell = [[GHMyCollectionHospitalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHMyCollectionHospitalTableViewCell"];
            cell.delegate = self;
        }
        
        cell.model = [self.hospitalArray objectOrNilAtIndex:indexPath.row];
        
        return cell;
        
    } else if (tableView == self.informationTableView) {
        
        GHNewZiXunTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GHNewZiXunTableViewCell"];
        if (!cell) {
            cell = [[GHNewZiXunTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNewZiXunTableViewCell"];
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        cell.model = [self.informationArray objectAtIndex:indexPath.row];
        return cell;
        
        
    }
    
    return [UITableViewCell new];
    

    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationCollectionDoctorCellShouldReset" object:nil];
    
}

- (void)cancelCollectionSuccessShouldReloadData {
    
    [self refreshData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationCollectionDoctorCellShouldReset" object:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.doctorTableView) {
        

        GHSearchDoctorModel *model = [self.doctorArray objectAtIndex:indexPath.row];
        GHNewDoctorDetailViewController *doctorDetail = [[GHNewDoctorDetailViewController alloc]init];
        doctorDetail.doctorId = model.modelId;
        doctorDetail.clickCollectionBlock = ^(BOOL collection) {
            if (collection) {
                [self refreshData];
            }
            else
            {
                [self.doctorArray removeObjectAtIndex:indexPath.row];
                [tableView reloadData];
            }
        };
        [self.navigationController pushViewController:doctorDetail animated:YES];
        
        
    } else if (tableView == self.hospitalTableView) {
        

        
        GHSearchHospitalModel *hospitalmodel = [self.hospitalArray objectAtIndex:indexPath.row];
        GHNewHospitalViewController *hospitalView = [[GHNewHospitalViewController alloc]init];
        hospitalView.hospitalID = hospitalmodel.modelId;
        hospitalView.clickCollectionBlock = ^(BOOL collection) {
            if (collection) {
                [self refreshData];
            }
            else
            {
                [self.hospitalArray removeObjectAtIndex:indexPath.row];
                [tableView reloadData];
            }
        };
        [self.navigationController pushViewController:hospitalView animated:YES];
        
    } else if (tableView == self.informationTableView) {
        
        
        GHNewInformationDetailViewController *vc = [[GHNewInformationDetailViewController alloc] init];
        GHNewZiXunModel *model = [self.informationArray objectOrNilAtIndex:indexPath.row];
        vc.clickCollectionBlock = ^(BOOL collection) {
            if (collection) {
                [self refreshData];
            }
            else
            {
                [self.informationArray removeObjectAtIndex:indexPath.row];
                [tableView reloadData];
            }
        };
        vc.model = model;
        [self.navigationController pushViewController:vc animated:true];
        
    } 
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

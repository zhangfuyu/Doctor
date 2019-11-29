//
//  GHInformationDetailViewController.m
//  掌上优医
//
//  Created by GH on 2018/11/9.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHInformationDetailViewController.h"

#import "GHCommonShareView.h"

#import "GHWebView.h"

#import "GHZuJiInformationModel.h"

#import "GHNewZiXunModel.h"

@interface GHInformationDetailViewController ()

@property (nonatomic, strong) GHCommonShareView *shareView;

@property (nonatomic, strong) GHWebView *webView;

@property (nonatomic, strong) NSString *urlStr;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIButton *collectionButton;

@end

@implementation GHInformationDetailViewController

- (GHCommonShareView *)shareView {
    
    if (!_shareView) {
        _shareView = [[GHCommonShareView alloc] init];
        _shareView.title = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.title)];
        _shareView.desc = @"了解医疗知识，关注健康生活。";
        _shareView.urlString = self.urlStr;
        [self.view addSubview:_shareView];
        
        [_shareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        _shareView.hidden = true;
    }
    return _shareView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"资讯详情";
    
    if (![[GHSaveDataTool shareInstance].readInformationIdArray containsObject:[NSString stringWithFormat:@"%ld", [self.informationId longValue]]]) {
        [[GHSaveDataTool shareInstance].readInformationIdArray addObject:[NSString stringWithFormat:@"%ld", [self.informationId longValue]]];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationVisitInformationShouldReloadHomeStatus object:nil];
    }
    
    
    
    self.urlStr = [[GHNetworkTool shareInstance] getArticleDetailURLWithArticleId:ISNIL(self.informationId)];
    
    [self addNavigationRightView];
    
    
    

    [self setupUI];
    
    GHZuJiInformationModel *model = [[GHZuJiInformationModel alloc] init];
    
    model.title = ISNIL(self.model.title);
    model.gmtCreate = ISNIL(self.model.gmtCreate);
    model.modelId = ISNIL(self.model.modelId);
    
    if (model && model.title.length && model.gmtCreate.length) {
        [[GHSaveDataTool shareInstance] addObject:model withType:GHSaveDataType_Information];
    }
    
    if ([GHUserModelTool shareInstance].isLogin) {
        [self getCollectionData];
    }
}

- (void)getCollectionData {
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiMyFavoriteNewses withParameter:@{@"id":self.informationId} withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            for (NSDictionary *dicInfo in response) {
                
                if ([dicInfo[@"contentId"] longValue] == [self.informationId longValue]) {
                    
                    
                    self.model.collectionId = [NSString stringWithFormat:@"%ld", [dicInfo[@"id"] longValue]];
                    
                    self.collectionButton.selected = true;

                    break;
                    
                }
                
                
            }
            
        }
        
    }];
    
}

- (void)addNavigationRightView {
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 86, 44);
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:[UIImage imageNamed:@"icon_hospital_share"] forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(0, 0, 50, 44);
//    [view addSubview:shareButton];
    
//    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.mas_equalTo(0);
//        make.width.mas_equalTo(40);
//        make.right.mas_equalTo(-6);
//    }];
    [shareButton addTarget:self action:@selector(clickShareAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectionButton setImage:[UIImage imageNamed:@"icon_hospital_uncollection"] forState:UIControlStateNormal];
    [collectionButton setImage:[UIImage imageNamed:@"icon_hospital_collection"] forState:UIControlStateSelected];
    collectionButton.frame = CGRectMake(0, 0, 30, 44);
    self.collectionButton = collectionButton;
//    [view addSubview:collectionButton];
    
//    [collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.mas_equalTo(0);
//        make.width.mas_equalTo(40);
//        make.left.mas_equalTo(0);
//    }];
    [collectionButton addTarget:self action:@selector(clickCollectionAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBtn1 = [[UIBarButtonItem alloc] initWithCustomView:collectionButton];
    UIBarButtonItem *rightBtn2 = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItems = @[rightBtn2, rightBtn1];

}

- (void)clickCollectionAction {
    
    NSLog(@"收藏文章");
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        if (self.collectionButton.selected == true) {
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"id"] = ISNIL(self.model.collectionId);

            [SVProgressHUD showWithStatus:kDefaultTipsText];

            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_DELETE withUrl:kApiMyFavoriteNews  withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {



                if (isSuccess) {

                    [SVProgressHUD dismiss];

                    [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];

                    self.collectionButton.selected = false;
                    
                    self.model.collectionId = nil;
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCancelDoctorCollectionSuccess object:nil];

//                    if ([self.delegate respondsToSelector:@selector(cancelCollectionSuccessShouldReloadData)]) {
//                        [self.delegate cancelCollectionSuccessShouldReloadData];
//                    }

                }

            }];
            
        } else {
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"contentId"] = ISNIL(self.model.modelId);
            
            params[@"title"] = ISNIL(self.model.title);
            params[@"userId"] = ISNIL([GHUserModelTool shareInstance].userInfoModel.modelId);
            
            [SVProgressHUD showWithStatus:kDefaultTipsText];
            
            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiMyFavoriteNews withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
                
                if (isSuccess) {
                    
                    [SVProgressHUD dismiss];
                    
                    [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
                    self.collectionButton.selected = true;
                    
                    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiMyFavoriteNewses withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
                        
                        if (isSuccess) {
                            
                            [SVProgressHUD dismiss];
                            
                            for (NSDictionary *dicInfo in response) {
                                
                                if ([dicInfo[@"contentId"] longValue] == [self.informationId longValue]) {
                                    
                                    
                                    self.model.collectionId = [NSString stringWithFormat:@"%ld", [dicInfo[@"id"] longValue]];
                                    
                                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDoctorCollectionSuccess object:nil];
                                    
                                    break;
                                    
                                }
                                
                                
                            }
                            
                        }
                        
                    }];
                    
                }
                
            }];
            
        }
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self presentViewController:vc animated:true completion:nil];
        
    }
    
}

- (void)setupUI {
    
    GHWebView *webView = [[GHWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT + kBottomSafeSpace - Height_NavBar)];
    [webView setUI:ISNIL(self.urlStr)];
    [self.view addSubview:webView];
    
    self.webView = webView;
    
    
}


/**

 @param animated <#animated description#>
 */
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    ((UILabel *)self.navigationItem.titleView).textColor = UIColorHex(0x333333);

    [self addLeftButton:@selector(clickCancelAction) image:[UIImage imageNamed:@"login_back"]];

}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
}

- (void)clickShareAction {
    
    self.shareView.hidden = false;
    
}

- (void)clickCancelAction {
    
    [self.navigationController popViewControllerAnimated:true];
    
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

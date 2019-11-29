//
//  GHNewInformationDetailViewController.m
//  掌上优医
//
//  Created by apple on 2019/9/19.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNewInformationDetailViewController.h"
#import "GHCommonShareView.h"
#import "GHWebView.h"
#import "GHNewZiXunModel.h"


@interface GHNewInformationDetailViewController ()

@property (nonatomic, strong) GHCommonShareView *shareView;

@property (nonatomic, strong) GHWebView *webView;

@property (nonatomic, strong) UIButton *collectionButton;

@property (nonatomic, strong) NSString *collectionId;//收藏id
@end

@implementation GHNewInformationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"资讯详情";
    [self addNavigationRightView];
    [self checkcollection];
    [self setupUI];
//    [self getCollectionData];

}
- (void)checkcollection
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"contentType"] = @(3);
    params[@"contentId"] = self.model.modelID;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiIsConllection  withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            if ([response[@"data"][@"isConllection"] boolValue]) {
                self.collectionButton.selected = YES;
                self.collectionId = [NSString stringWithFormat:@"%@",response[@"data"][@"id"]];
            }
            else
            {
                self.collectionButton.selected = NO;
            }
        }
        
    }];
}
//- (void)getCollectionData {
//
//    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiMyFavoriteNewses withParameter:@{@"id":self.model.modelID} withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
//
//        if (isSuccess) {
//
//
//            [SVProgressHUD dismiss];
//
//            GHNewZiXunModel *model = [[GHNewZiXunModel alloc]initWithDictionary:response[@"data"][@"article"] error:nil];
//            [self.webView setUIWithHtmlText:model.content];
//
//        }
//
//    }];
//
//}
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
- (void)setupUI {
    
    GHWebView *webView = [[GHWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT + kBottomSafeSpace - Height_NavBar)];
    [webView setUI:[[GHNetworkTool shareInstance]getNewsArticlesURLisShareid:self.model.modelID share:NO]];
//    [webView setUI:ISNIL(self.urlStr)];
    [self.view addSubview:webView];
    
    self.webView = webView;
    
    
//    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiMyFavoriteNewses withParameter:@{@"id":self.model.modelID} withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
//        
//        [SVProgressHUD dismiss];
//        
//        if (isSuccess) {
//            
//          NSLog(@"----->diyici");
//            
//        }
//        
//    }];
}

- (void)clickCollectionAction
{
    if ([GHUserModelTool shareInstance].isLogin) {
        
        if (self.collectionButton.selected == true) {
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"id"] = ISNIL(self.collectionId);
            
            [SVProgressHUD showWithStatus:kDefaultTipsText];
            
            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiMyDonotConllection  withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
                
                [SVProgressHUD dismiss];
                
                if (isSuccess) {
                    
                    [SVProgressHUD dismiss];
                    
                    [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
                    
                    if (self.clickCollectionBlock) {
                        self.clickCollectionBlock(NO);
                    }
                    
                    self.collectionButton.selected = false;
                    
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCancelDoctorCollectionSuccess object:nil];
                    
                }
                
            }];
            
        } else {
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"contentId"] = ISNIL(self.model.modelID);
            
            params[@"title"] = ISNIL(self.model.title);
            params[@"contentType"] = @(3);
            
            [SVProgressHUD showWithStatus:kDefaultTipsText];
            
            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiDoConllection withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
                
                if (isSuccess) {
                    
                    [SVProgressHUD dismiss];
                    self.collectionId = [NSString stringWithFormat:@"%@",response[@"data"][@"id"]];
                    
                    self.collectionButton.selected = true;
                    [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
                    if (self.clickCollectionBlock) {
                        self.clickCollectionBlock(YES);
                    }
                    
                    
                }
                
            }];
            
        }
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self presentViewController:vc animated:true completion:nil];
        
    }
    
}
- (void)clickShareAction {
    
    self.shareView.hidden = false;
    
}
- (GHCommonShareView *)shareView {
    
    if (!_shareView) {
        _shareView = [[GHCommonShareView alloc] init];
//        _shareView.title = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.title)];
        _shareView.desc = @"了解医疗知识，关注健康生活。";
        _shareView.urlString = [[GHNetworkTool shareInstance]getNewsArticlesURLisShareid:self.model.modelID share:YES];
        [self.view addSubview:_shareView];
        
        [_shareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        _shareView.hidden = true;
    }
    return _shareView;
    
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

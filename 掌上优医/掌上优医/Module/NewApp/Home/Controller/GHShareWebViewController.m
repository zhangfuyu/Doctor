//
//  GHShareWebViewController.m
//  掌上优医
//
//  Created by apple on 2019/10/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHShareWebViewController.h"
#import "GHCommonShareView.h"
#import "GHWebView.h"

@interface GHShareWebViewController ()
@property (nonatomic, strong) GHCommonShareView *shareView;

@property (nonatomic, strong) GHWebView *webView;

@end

@implementation GHShareWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.titleText;
    [self addNavigationRightView];
    [self setupUI];

}
- (void)setupUI {
    
    GHWebView *webView = [[GHWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT + kBottomSafeSpace - Height_NavBar)];
    [webView setUI:self.urlStr];
    [self.view addSubview:webView];
    
    self.webView = webView;
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
    
//    UIButton *collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [collectionButton setImage:[UIImage imageNamed:@"icon_hospital_uncollection"] forState:UIControlStateNormal];
//    [collectionButton setImage:[UIImage imageNamed:@"icon_hospital_collection"] forState:UIControlStateSelected];
//    collectionButton.frame = CGRectMake(0, 0, 30, 44);
//    self.collectionButton = collectionButton;
    //    [view addSubview:collectionButton];
    
    //    [collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.bottom.mas_equalTo(0);
    //        make.width.mas_equalTo(40);
    //        make.left.mas_equalTo(0);
    //    }];
//    [collectionButton addTarget:self action:@selector(clickCollectionAction) forControlEvents:UIControlEventTouchUpInside];
//
//    UIBarButtonItem *rightBtn1 = [[UIBarButtonItem alloc] initWithCustomView:collectionButton];
    UIBarButtonItem *rightBtn2 = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItems = @[rightBtn2];
    
}
- (void)clickShareAction {
    
    self.shareView.hidden = false;
    
}
- (GHCommonShareView *)shareView {
    
    if (!_shareView) {
        _shareView = [[GHCommonShareView alloc] init];
//        _shareView.title = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.title)];
        _shareView.desc = self.shareText.length > 0 ? self.shareText :@"了解医疗知识，关注健康生活。";
        _shareView.urlString = self.urlStr;
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

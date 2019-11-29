//
//  GHCommonWebViewController.m
//  掌上优医
//
//  Created by GH on 2018/11/21.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHCommonWebViewController.h"

#import "GHWebView.h"

#import "GHCommonShareView.h"

@interface GHCommonWebViewController ()

@property (nonatomic, strong) GHWebView *webView;

@property (nonatomic, strong) GHCommonShareView *shareView;

@end

@implementation GHCommonWebViewController

- (GHCommonShareView *)shareView {
    
    if (!_shareView) {
        _shareView = [[GHCommonShareView alloc] init];
        _shareView.title = ISNIL(self.shareTitle);
        _shareView.desc = ISNIL(self.shareTitle);
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
    
    self.navigationItem.title = ISNIL(self.navTitle);

    [self setupUI];
    
    if (self.shareTitle.length) {
        [self addRightButton:@selector(clickShareAction) image:[UIImage imageNamed:@"bg_sickness_share"]];
    }
    
}

- (void)clickShareAction {
    
    self.shareView.hidden = false;
    
}

- (void)clickDismissAction {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)setupUI {
    
    GHWebView *webView = [[GHWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT + kBottomSafeSpace - Height_NavBar)];
    webView.backgroundColor = kDefaultBlueColor;
    [webView setUI:ISNIL(self.urlStr)];
    [self.view addSubview:webView];
    
    self.webView = webView;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
    
    [self setupNavigationStyle:GHNavigationBarStyleWhite];
    
    if (self.navigationController.viewControllers.count == 1) {
        [self addLeftButton:@selector(clickDismissAction)];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
}

@end

//
//  GHWebView.m
//  掌上优医
//
//  Created by GH on 2018/11/12.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHWebView.h"

#import <WebKit/WebKit.h>

@interface GHWebView ()<WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;

//@property (nonatomic, strong) UIWebView *normalWebView;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation GHWebView

- (void)setUIWithHtmlText:(NSString *)text{
    
    
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    
    wkWebConfig.userContentController = wkUController;
    
    //自适应屏幕的宽度js
    
    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    //添加js调用
    
    [wkUController addUserScript:wkUserScript];
    
//    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1) configuration:wkWebConfig];
    
    WKWebView *webView = [[WKWebView alloc]initWithFrame:self.bounds configuration:wkWebConfig];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [self addSubview:webView];
    
    self.webView = webView;

    NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'><style>img{max-width:100%}</style></header>";
    [webView loadHTMLString:[headerString stringByAppendingString:text] baseURL:nil];
 
    
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 2)];
    self.progressView.backgroundColor = kDefaultBlueColor;
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self addSubview:self.progressView];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
//    [self.webView addObserver:self forKeyPath:@"" options:NSKeyValueObservingOptionNew context:nil];
}

/**
 设置文档 URL

 @param url <#url description#>
 */
- (void)setDocUrl:(NSString *)url{
    
    self.url = url;
    
    WKWebView *webView = [[WKWebView alloc]initWithFrame:self.bounds];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [self addSubview:webView];
    
    self.webView = webView;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:url]];
    //    [webView loadFileURL:self.url allowingReadAccessToURL:nil];
    [webView loadRequest:request];
    
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 2)];
    self.progressView.backgroundColor = kDefaultBlueColor;
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self addSubview:self.progressView];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)setUI:(NSString *)url
{
    
    self.url = url;

//    if (kSystemVersion >= 10) {
    
        WKWebView *webView = [[WKWebView alloc]initWithFrame:self.bounds];
        webView.UIDelegate = self;
        webView.navigationDelegate = self;
        [self addSubview:webView];
        
        self.webView = webView;
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
        
        [webView loadRequest:request];
        
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 2)];
        self.progressView.backgroundColor = kDefaultBlueColor;
        //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
        self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
        [self addSubview:self.progressView];
        
        [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];

        
//    } else {
//
//        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.bounds];
//        webView.delegate = self;
//        [self addSubview:webView];
//
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//
//        [webView loadRequest:request];
//
//    }
//

    
    
   
}

// 从web界面中接收到一个脚本时调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
}


// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    //    [MBProgressHUD showHUDAddedTo:self animated:YES];
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self bringSubviewToFront:self.progressView];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    self.progressView.hidden = YES;
}

//页面加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    self.progressView.hidden = YES;
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    
    NSString *urlStr = [navigationAction.request.URL absoluteString];

    decisionHandler(WKNavigationActionPolicyAllow);
    
}


#pragma mark -- 进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
                
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}


@end

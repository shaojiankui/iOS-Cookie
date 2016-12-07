//
//  WKWebViewViewController.m
//  iOS-Cookie
//
//  Created by Jakey on 2016/12/7.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import "WKWebViewViewController.h"

@interface WKWebViewViewController ()

@end

@implementation WKWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"WKWebView";
    
    WKUserContentController* userContentController = WKUserContentController.new;
    WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource: @"document.cookie ='TeskWKCookieKey1=TeskWKCookieValue1';document.cookie = 'TeskWKCookieKey2=TeskWKCookieValue2';"injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    
    [userContentController addUserScript:cookieScript];
    WKWebViewConfiguration* webViewConfig = WKWebViewConfiguration.new;
    webViewConfig.userContentController = userContentController;
    self.myWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:webViewConfig];
    
    
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://dev.skyfox.org/printCookie.php"]];
    [request setValue:[NSString stringWithFormat:@"%@=%@",@"testWKcookie", @"testWKcookievalue"] forHTTPHeaderField:@"Cookie"];
    
    //    Note that the javascript technique to set the cookies will not work for "HTTP Only" cookies
    
    [self.myWebView loadRequest:request];
    [self.view addSubview:self.myWebView];
    self.myWebView.navigationDelegate = self;
    self.myWebView.UIDelegate = self;
    
    self.myWebView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_myWebView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_myWebView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-58-[_myWebView]-40-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_myWebView)]];
    
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
    NSLog(@"\n====================================\n");
    //读取wkwebview中的cookie 方法1
    for (NSHTTPCookie *cookie in cookies) {
        //        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        NSLog(@"wkwebview中的cookie:%@", cookie);
    }
    NSLog(@"\n====================================\n");
    //读取wkwebview中的cookie 方法2 读取Set-Cookie字段
    NSString *cookieString = [[response allHeaderFields] valueForKey:@"Set-Cookie"];
    NSLog(@"wkwebview中的cookie:%@", cookieString);
    NSLog(@"\n====================================\n");
    //看看存入到了NSHTTPCookieStorage了没有
    NSHTTPCookieStorage *cookieJar2 = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in cookieJar2.cookies) {
        NSLog(@"NSHTTPCookieStorage中的cookie%@", cookie);
    }
    NSLog(@"\n====================================\n");

    decisionHandler(WKNavigationResponsePolicyAllow);
}
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    
    
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    WKWebsiteDataStore *dataStore = [WKWebsiteDataStore defaultDataStore];
    [dataStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes]
                     completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
                         for (WKWebsiteDataRecord *record  in records)
                         {
                             NSLog(@"WKWebsiteDataRecord:%@",[record description]);
                         }
                     }];
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
//uiwebview 中这个方法是私有方法 通过category可以拦截alert
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    //    NSLog(@"%s", __FUNCTION__);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

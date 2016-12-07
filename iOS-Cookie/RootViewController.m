//
//  RootViewController.m
//  iOS-Cookie
//
//  Created by Jakey on 2016/12/7.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import "RootViewController.h"
#import "WKWebViewViewController.h"
#import "UIWebViewViewController.h"
#import "AFNetworkingViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)wkwebviewTouched:(id)sender {
    WKWebViewViewController *wk = [[WKWebViewViewController alloc]init];
    [self.navigationController pushViewController:wk animated:YES];
}

- (IBAction)uiwebviewTouched:(id)sender {
    UIWebViewViewController *wk = [[UIWebViewViewController alloc]init];
    [self.navigationController pushViewController:wk animated:YES];
}

- (IBAction)afTouched:(id)sender {
    AFNetworkingViewController *af = [[AFNetworkingViewController alloc]init];
    [self.navigationController pushViewController:af animated:YES];
}
#define URL   @"http://dev.skyfox.org/cookie.php"

- (IBAction)cleanCookieTouched:(id)sender {
    NSLog(@"清除本地Cookie");
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookieArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in cookieArray) {
        [cookieJar deleteCookie:obj];
    }
  
    [[self.view viewWithTag:2333]removeFromSuperview];
}

- (IBAction)customCookieTouched:(id)sender {
    NSURL *url = [NSURL URLWithString:URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:@"username" forKey:NSHTTPCookieName];
    [cookieProperties setObject:@"my ios cookie" forKey:NSHTTPCookieValue];
    [cookieProperties setObject:@"dev.skyfox.org" forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:@"dev.skyfox.org" forKey:NSHTTPCookieOriginURL];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    [cookieProperties setObject:[NSDate dateWithTimeIntervalSinceNow:5] forKey:NSHTTPCookieExpires];//设置失效时间
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieDiscard]; //设置sessionOnly
    
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    [self.myWebview loadRequest:request];
}

- (IBAction)refreshWebView2Touched:(id)sender {
    [[self.view viewWithTag:2333]removeFromSuperview];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-200, self.view.frame.size.height-153, 200, 153)];
    webView.tag = 2333;
    NSURL *url = [NSURL URLWithString:URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [self.view addSubview:webView];
    
    [webView loadRequest:request];
}
@end

//
//  WKWebViewViewController.h
//  iOS-Cookie
//
//  Created by Jakey on 2016/12/7.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WKWebViewViewController : UIViewController<WKUIDelegate,WKNavigationDelegate>
@property (strong, nonatomic)  WKWebView *myWebView;
@end

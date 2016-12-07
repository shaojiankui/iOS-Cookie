//
//  UIWebViewViewController.m
//  iOS-Cookie
//
//  Created by Jakey on 2016/12/7.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import "UIWebViewViewController.h"

@interface UIWebViewViewController ()

@end

@implementation UIWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
//合适的时机保存Cookie
- (void)saveCookies{
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey:@"org.skyfox.cookiesave"];
    [defaults synchronize];
}
//合适的时机加载Cookie 一般都是app刚刚启动的时候
- (void)loadSavedCookies{
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"org.skyfox.cookiesave"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in cookies){
        NSLog(@"cookie,name:= %@,valuie = %@",cookie.name,cookie.value);
    }
    
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

@end

//
//  AFNetworkingViewController.m
//  iOS-Cookie
//
//  Created by Jakey on 2016/12/7.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import "AFNetworkingViewController.h"
#import "AFNetworking.h"
@interface AFNetworkingViewController ()

@end

@implementation AFNetworkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    [manager POST:@"http://dev.skyfox.org/cookie.php" parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\n======================================\n");
        NSDictionary *fields = ((NSHTTPURLResponse*)task.response).allHeaderFields;
        NSLog(@"fields = %@",[fields description]);
        NSURL *url = [NSURL URLWithString:@"http://dev.skyfox.org/cookie.php"];
        NSLog(@"\n======================================\n");
        //获取cookie方法1
        NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:url];
        for (NSHTTPCookie *cookie in cookies) {
            NSLog(@"cookie,name:= %@,valuie = %@",cookie.name,cookie.value);
        }
        NSLog(@"\n======================================\n");
//        //获取cookie方法2
//        NSString *cookies2 = [((NSHTTPURLResponse*)task.response) valueForKey:@"Set-Cookie"];
//        NSLog(@"cookies2 = %@",[cookies2 description]);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//合适的时机持久化Cookie
- (void)saveCookies{
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey:@"org.skyfox.cookiesave"];
    [defaults synchronize];
}
//合适的时机加载持久化后Cookie 一般都是app刚刚启动的时候
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

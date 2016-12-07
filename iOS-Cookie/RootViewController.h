//
//  RootViewController.h
//  iOS-Cookie
//
//  Created by Jakey on 2016/12/7.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *myWebview;
- (IBAction)wkwebviewTouched:(id)sender;
- (IBAction)uiwebviewTouched:(id)sender;
- (IBAction)afTouched:(id)sender;

- (IBAction)cleanCookieTouched:(id)sender;
- (IBAction)customCookieTouched:(id)sender;
- (IBAction)refreshWebView2Touched:(id)sender;
@end

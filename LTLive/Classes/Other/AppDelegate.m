//
//  AppDelegate.m
//  LTLive
//
//  Created by 孟令通 on 2017/4/25.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "AppDelegate.h"

#import "LTTabBarViewController.h"

#import "LTLocationManager.h"

#import "LTAdvertiseView.h"

#import "AppDelegate+LTUMeng.h"

#import <UMSocialCore/UMSocialCore.h>

#import "LTLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 设置友盟控件
    [self setupUMeng];
    
//    LTTabBarViewController *mainVC = [[LTTabBarViewController alloc] init];
    
    LTLoginViewController *mainVC = [[LTLoginViewController alloc] init];
    
    self.window.rootViewController = mainVC;
    
    [self.window makeKeyAndVisible];
    
    
    [[LTLocationManager shareLocationMnager] getLocation:^(NSString *lat, NSString *lon) {
        
        NSLog(@"纬度：%@ - 经度：%@", lat, lon);
    }];
    
    LTAdvertiseView *advertise = [LTAdvertiseView loadAdvertiseView];
    
    [self.window addSubview:advertise];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}



@end

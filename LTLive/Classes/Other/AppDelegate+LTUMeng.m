//
//  AppDelegate+LTUMeng.m
//  LTLive
//
//  Created by 孟令通 on 2017/5/3.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "AppDelegate+LTUMeng.h"

#import <UMSocialCore/UMSocialCore.h>

#define kWeiboKey @"255028652"
#define kWeiboSecret @"79716008a9145c90360d26d6b78a8c7f"

@implementation AppDelegate (LTUMeng)

- (void)setupUMeng
{
    // UMeng appkey = 5909c3144ad1561e26000cd9
    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5909c3144ad1561e26000cd9"];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
    
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:kWeiboKey  appSecret:kWeiboSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
    
}

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

@end

//
//  LTUserHelper.m
//  LTLive
//
//  Created by 孟令通 on 2017/5/4.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTUserHelper.h"

@implementation LTUserHelper

+ (instancetype)sharedUser
{
    static LTUserHelper *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[LTUserHelper alloc] init];
        
    });
    
    return manager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _nickName = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
        
        _iconUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"iconUrl"];
        
        
        
    }
    return self;
}


+ (BOOL)isAutoLogin
{
    if ([LTUserHelper sharedUser].nickName.length == 0) {
        
        return NO;
        
    }
    
    return YES;
}

+ (void)saveUser
{
    LTUserHelper *user = [LTUserHelper sharedUser];
    
    if (user.nickName.length != 0) {
        
        [[NSUserDefaults standardUserDefaults] setObject:user.nickName forKey:@"nickName"];
        
        [[NSUserDefaults standardUserDefaults] setObject:user.iconUrl forKey:@"iconUrl"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
}

@end

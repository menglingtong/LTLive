//
//  LTLocationManager.m
//  LTLive
//
//  Created by 孟令通 on 2017/5/1.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTLocationManager.h"

@implementation LTLocationManager

+ (instancetype)shareLocationMnager
{
    
    static LTLocationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[LTLocationManager alloc] init];
        
    });
    
    return manager;
}

@end

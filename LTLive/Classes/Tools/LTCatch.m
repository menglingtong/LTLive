//
//  LTCatch.m
//  LTLive
//
//  Created by 孟令通 on 2017/5/2.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTCatch.h"

static NSString *identifier = @"adImage";

@implementation LTCatch

+ (NSString *)getAdvertise
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:identifier];
}

+ (void)setAdvertise:(NSString *)adImage
{
    [[NSUserDefaults standardUserDefaults] setObject:adImage forKey:identifier];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

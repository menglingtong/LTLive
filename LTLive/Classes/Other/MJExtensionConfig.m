//
//  MJExtensionConfig.m
//  LTLive
//
//  Created by 孟令通 on 2017/4/28.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "LTLive.h"
#import "LTCreator.h"
#import "LTExtra.h"

@implementation MJExtensionConfig

+ (void)load
{
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        
        return @{
                 @"ID" : @"id"
                 };
    }];
    
    // 驼峰命名转下划线
    [LTCreator mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        
        return [propertyName mj_underlineFromCamel];
        
    }];
    
    [LTLive mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        
        return [propertyName mj_underlineFromCamel];
    }];
    
    [LTExtra mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        
        return [propertyName mj_underlineFromCamel];
    }];
    
    
}

@end

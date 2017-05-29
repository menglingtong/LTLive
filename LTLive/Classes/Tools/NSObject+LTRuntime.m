//
//  NSObject+LTRuntime.m
//  LTLive
//
//  Created by 孟令通 on 2017/5/29.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "NSObject+LTRuntime.h"

@implementation NSObject (LTRuntime)

// 获取类的方法列表
- (NSMutableArray *)getMethodListWithClassName:(NSString *)className
{
    NSMutableArray *result = [NSMutableArray array];
    
    unsigned int outCount = 0;
    
    Class checkClass = NSClassFromString(className);
    
    Method *methods = class_copyMethodList(checkClass, &outCount);
    
    for (int i = 0; i < outCount; i++) {
        
        Method method = methods[i];
        
        SEL methodName = method_getName(method);
        
    }
    
    free(methods);
    
    return result;
}

@end

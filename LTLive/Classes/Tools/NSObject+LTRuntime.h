//
//  NSObject+LTRuntime.h
//  LTLive
//
//  Created by 孟令通 on 2017/5/29.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <objc/runtime.h>

@interface NSObject (LTRuntime)

// 获取对象的方法列表
- (NSArray *)getMethodListWithClassName:(NSString *)className;

@end

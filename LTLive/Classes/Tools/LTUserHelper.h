//
//  LTUserHelper.h
//  LTLive
//
//  Created by 孟令通 on 2017/5/4.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTUserHelper : NSObject

@property (nonatomic, copy) NSString *iconUrl;

@property (nonatomic, copy) NSString *nickName;

+ (instancetype)sharedUser;

+ (BOOL)isAutoLogin;

+ (void)saveUser;

@end

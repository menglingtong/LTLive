//
//  LTLocationManager.h
//  LTLive
//
//  Created by 孟令通 on 2017/5/1.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LocationBlock)(NSString *lat, NSString *lon);

@interface LTLocationManager : NSObject

+ (instancetype)shareLocationMnager;

- (void)getLocation:(LocationBlock)location;

@property (nonatomic, strong) NSString *lat;

@property (nonatomic, strong) NSString *lon;

@end

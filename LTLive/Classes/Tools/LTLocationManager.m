//
//  LTLocationManager.m
//  LTLive
//
//  Created by 孟令通 on 2017/5/1.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTLocationManager.h"

#import <CoreLocation/CoreLocation.h>

@interface LTLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, copy) LocationBlock block;

@end

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

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _locationManager = [[CLLocationManager alloc] init];
        
        // 设置精确度
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        
        // 设置更新定位的最小米数 运动范围超过100米才会更新定位
        _locationManager.distanceFilter = 100;
        // _签代理
        _locationManager.delegate = self;
        
        // 判断定位服务是否开启
        if (![_locationManager locationServicesEnabled]) {
            
            NSLog(@"开启定位服务");
        }
        else
        {
            // 用户没有设置使用状态
            // kCLAuthorizationStatusNotDetermined = 0,
            
            // 应用未被授权使用定位，由于活动对位置服务的限制,用户不能改变这种状态,不得个人拒绝授权
            // kCLAuthorizationStatusRestricted,
            
            // 用户已经明确拒绝授权对于这个应用程序,或者在设置位置服务被禁用。
            // kCLAuthorizationStatusDenied,
            
            // 用户授权可以一直使用定位
            // kCLAuthorizationStatusAuthorizedAlways NS_ENUM_AVAILABLE(10_12, 8_0),
            
            // 使用期间可以使用定位
            // kCLAuthorizationStatusAuthorizedWhenInUse NS_ENUM_AVAILABLE(NA, 8_0),
            
            // 用户授权此应用程序使用定位服务。这个值是弃用或禁止在iOS,tvo watchOS。它应该在MacOS使用。
            // kCLAuthorizationStatusAuthorized NS_ENUM_DEPRECATED(10_6, NA, 2_0, 8_0, "Use kCLAuthorizationStatusAuthorizedAlways") __TVOS_PROHIBITED __WATCHOS_PROHIBITED = kCLAuthorizationStatusAuthorizedAlways
            
            // 获取当前状态 
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            
            if (status == kCLAuthorizationStatusNotDetermined) {
                
                // 请求在使用应用期间使用定位
                [_locationManager requestWhenInUseAuthorization];
            }
            
            
        }
        
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    
    NSString *lat = [NSString stringWithFormat:@"%@", @(coordinate.latitude)];
    
    NSString *lon = [NSString stringWithFormat:@"%@", @(coordinate.longitude)];
    
    [LTLocationManager shareLocationMnager].lat = lat;
    
    [LTLocationManager shareLocationMnager].lon = lon;
    
    // 回传获取到的定位
    self.block(lat, lon);
    
    // 关闭定位
    [self.locationManager stopUpdatingLocation];
}


- (void)getLocation:(LocationBlock)location
{
    self.block = location;
    
    [self.locationManager startUpdatingLocation];
}


@end

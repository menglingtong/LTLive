//
//  LTLiveModel.h
//  LTLive
//
//  Created by 孟令通 on 2017/4/28.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTCreator.h"
#import "LTExtra.h"

@interface LTLive : NSObject

@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) LTCreator * creator;
@property (nonatomic, strong) LTExtra * extra;
@property (nonatomic, assign) NSInteger group;
@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * image;
@property (nonatomic, assign) NSInteger landscape;
@property (nonatomic, strong) NSArray * like;
@property (nonatomic, assign) NSInteger link;
@property (nonatomic, strong) NSString * liveType;
@property (nonatomic, assign) NSInteger multi;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger onlineUsers;
@property (nonatomic, assign) NSInteger optimal;
@property (nonatomic, assign) NSInteger pubStat;
@property (nonatomic, assign) NSInteger roomId;
@property (nonatomic, assign) NSInteger rotate;
@property (nonatomic, strong) NSString * shareAddr;
@property (nonatomic, assign) NSInteger slot;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString * streamAddr;
@property (nonatomic, strong) NSString * tagId;
@property (nonatomic, strong) NSString * token;
@property (nonatomic, assign) NSInteger version;

@end

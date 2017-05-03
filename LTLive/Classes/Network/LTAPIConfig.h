//
//  LTAPIConfig.h
//  LTLive
//
//  Created by 孟令通 on 2017/4/27.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTAPIConfig : NSObject

#define SERVER_HOST @"http://218.11.0.112"

#define IMAGE_HOST @"http://img.meelive.cn/"

//首页数据
#define API_LiveGetTop @"api/live/gettop?uid=319901879"

//广告地址
#define API_Advertise @"advertise/get"

//热门话题
#define API_TopicIndex @"api/live/topicindex"

//附近的人
#define API_NearLocation @"api/live/near_recommend"//?uid=85149891&latitude=40.090562&longitude=116.413353

// api/live/near_flow_old?uid=319901879

//欢哥直播地址
#define Live_Dahuan @"rtmp://live.hkstv.hk.lxdns.com:1935/live/dahuan"

// 我的直播地址
#define Live_MLT @"rtmp://live.hkstv.hk.lxdns.com:1935/live/lrymlt"


@end

//
//  LTShowHandler.h
//  LTLive
//
//  Created by 孟令通 on 2017/4/27.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTBaseHandler.h"

@interface LTShowHandler : LTBaseHandler

// 获取热门直播信息
+ (void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

@end

//
//  LTShowHandler.m
//  LTLive
//
//  Created by 孟令通 on 2017/4/27.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTShowHandler.h"
#import "HttpTool.h"

#import "LTLive.h"

@implementation LTShowHandler

+(void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed
{
    [HttpTool getWithPath:API_LiveGetTop params:nil success:^(id json) {
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json[@"error_msg"]);
        }
        else
        {
            
            NSArray *lives = [LTLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            
            success(lives);
        }
        
    } failure:^(NSError *error) {
        
        failed(error);
    }];
}

@end

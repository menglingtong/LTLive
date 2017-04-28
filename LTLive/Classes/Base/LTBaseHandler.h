//
//  LTBaseHandler.h
//  LTLive
//
//  Created by 孟令通 on 2017/4/27.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompleteBlock)();

typedef void(^SuccessBlock)(id obj);

typedef void(^FailedBlock)(id obj);

@interface LTBaseHandler : NSObject

@end

//
//  LTVideoPlayerController.h
//  LTLive
//
//  Created by 孟令通 on 2017/5/29.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTBaseViewController.h"

@interface LTVideoPlayerController : LTBaseViewController

@property (nonatomic, copy) NSString *url;

+ (LTVideoPlayerController *) sharePlayerInstance;

@end

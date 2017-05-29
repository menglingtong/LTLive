//
//  LTPlayView.h
//  LTLive
//
//  Created by 孟令通 on 2017/5/29.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

#import <AVKit/AVKit.h>

#import <MediaPlayer/MediaPlayer.h>

@protocol LTPlayeViewDelegate <NSObject>

- (void)playerGoBack;

@end

typedef NS_ENUM(NSUInteger, LTPlayerLayerGravity) {
    LTPlayerLayerGravityResize,           // 非均匀模式
    LTPlayerLayerGravityResizeAspect,     // 等比例填充
    LTPlayerLayerGravityResizeAspectFill  // 等比例填充(维度会被裁剪)
};


@interface LTPlayView : UIView

@property (nonatomic, copy) NSString *url;

@property (nonatomic, weak) id<LTPlayeViewDelegate> delegate;

@property (nonatomic, assign) LTPlayerLayerGravity playerLayerGravity;

@end

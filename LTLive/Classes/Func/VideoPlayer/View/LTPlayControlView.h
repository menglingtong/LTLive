//
//  LTPlayControlView.h
//  LTLive
//
//  Created by 孟令通 on 2017/5/29.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTPlayControlView : UIView

/** 顶部遮罩层 */
@property (nonatomic, strong) UIView *topBackView;

/** 返回按钮 */
@property (nonatomic, strong) UIButton *playBackBtn;

/** 底部遮罩层 */
@property (nonatomic, strong) UIView *bottomBackView;

/** 播放按钮 */
@property (nonatomic, strong) UIButton *playBtn;

/** 当前时间 */
@property (nonatomic, strong) UILabel *currentTimeLabel;

/** 全屏按钮 */
@property (nonatomic, strong) UIButton *fullScreenBtn;

@property (nonatomic, strong) UIProgressView *playerProgressView;

/** 总时长 */
@property (nonatomic, strong) UILabel *totalTimeLabel;

/** 进度条 */
@property (nonatomic, strong) UISlider *playerSlider;

/** 加载等待图 */
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (void) showControlView;

- (void) hiddenControlView;

@end

//
//  LTPlayView.m
//  LTLive
//
//  Created by 孟令通 on 2017/5/29.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTPlayView.h"

#import "LTPlayControlView.h"

// 播放器的状态
typedef NS_ENUM(NSUInteger, LTPlayerState) {
    LTPlayerStateFailed,     // 播放失败
    LTPlayerStateBuffering,  //缓冲中
    LTPlayerStatePlaying,    //播放中
    LTPlayerStateStopped,    //停止播放
    LTPlayerStatePause       //暂停播放
};

// 滑动手势类型
typedef NS_ENUM(NSUInteger, LTPanState) {
    LTPanVerticalState, //上下滑动
    LTPanHorizontalState //左右滑动
};

@interface LTPlayView ()

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) AVPlayerItem *playerItem;

@property (nonatomic, strong) AVPlayerLayer *playerLayer;


/** 音量滑条 */
@property (nonatomic, strong) UISlider *volumeSlider;

@property (nonatomic, strong) LTPlayControlView *playerControlView;


/** 播放状态 */
@property (nonatomic, assign) LTPlayerState state;

/** 滑动手势类型 */
@property (nonatomic, assign) LTPanState panState;

@property (nonatomic,assign) CGRect tmpRect;

@property (nonatomic,copy) NSString *totalTime;


/** 快进快退时间 */
@property (nonatomic,assign) CGFloat tmpTime;

@property (nonatomic,assign) BOOL isPlayControlShow;

@end

@implementation LTPlayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _tmpRect = frame;
        
        self.backgroundColor = [UIColor blackColor];
        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.playerLayer.frame = self.bounds;
    self.playerControlView.frame = self.bounds;
    
    [self layoutIfNeeded];
    
}

- (void)createPlayer
{
    // 初始化 playerItem
    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:_url]];
    
    // 初始化 player
    self.player = [AVPlayer playerWithPlayerItem:_playerItem];
    
    // 初始化playerLayer
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    
    // 设置视频默认填充模式
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    // 将playerLayer 添加到 self.layer上
    [self.layer insertSublayer:_playerLayer atIndex:0];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    [self createGesture];
    
    // 获取系统音量
    [self getVolumeOfSystem];
    
    
}

/**
 *  添加监听
 */
- (void)addNotification
{
    // app退到后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];
    
    // app进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterPlayGround) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    // 播放按钮点击事件
    [self.playerControlView.playBtn addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 返回按钮点击事件
    [self.playerControlView.playBackBtn addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 全屏按钮点击事件
    [self.playerControlView.fullScreenBtn addTarget:self action:@selector(fullScreenAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.playerControlView.playerSlider addTarget:self action:@selector(touchDownSlider:) forControlEvents:UIControlEventTouchDown];
    [self.playerControlView.playerSlider addTarget:self action:@selector(valueChangeSlider:) forControlEvents:UIControlEventValueChanged];
    [self.playerControlView.playerSlider addTarget:self action:@selector(endSlider:) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchUpOutside|UIControlEventTouchUpInside];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    
}

- (void) createGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self addGestureRecognizer:pan];
    
}

#pragma mark --------- 手势事件 ---------
/**
 *  滑动手势
 */
- (void)panAction:(UIPanGestureRecognizer *)senderPan
{
    
    CGPoint veloctyPoint = [senderPan velocityInView:self];
    
    switch (senderPan.state) {
            
        case UIGestureRecognizerStateBegan:{
            
            // fabs 返回绝对值
            CGFloat x = fabs(veloctyPoint.x);
            
            CGFloat y = fabs(veloctyPoint.y);
            
            if (x > y) { // 水平移动
                
                self.panState = LTPanHorizontalState;
                
                CMTime time       = self.player.currentTime;
                
                // The timescale of the CMTime. value/timescale = seconds.
                self.tmpTime      = time.value / time.timescale;
                
                [self pause];
                
            }
            else if (x < y){ // 垂直移动
                
                self.panState = LTPanVerticalState;
                
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{ // 正在移动
            
            switch (self.panState) {
                    
                case LTPanHorizontalState:{
                    
                    [self horizontalMoved:veloctyPoint.x]; // 水平移动计算快进快退时间
                    
                    break;
                }
                case LTPanVerticalState:{
                    
                    [self verticalMoved:veloctyPoint.y]; // 垂直移动计算音量改变大小
                    
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case UIGestureRecognizerStateEnded:{ // 移动停止
            
            switch (self.panState) {
                    
                case LTPanHorizontalState:{
                    
                    // 继续播放
                    [self play];
                    
                    CMTime dragTime = CMTimeMake(self.tmpTime, 1);
                    
                    [self.player seekToTime:dragTime];
                    
                    self.tmpTime = 0;
                    
                    break;
                }
                case LTPanVerticalState:{
                    
                    NSLog(@"垂直滑动结束");
                    
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    
}
/**
 *  pan垂直移动方法
 */
- (void)verticalMoved:(CGFloat)value
{
    self.volumeSlider.value -= value / 10000;
}

/**
 *  pan水平移动的方法
 */
- (void)horizontalMoved:(CGFloat)value
{
    
    NSLog(@"滑动时间--- %f",value);
    
    // 每次滑动需要叠加时间
    self.tmpTime += value / 200;
    
    // 需要限定sumTime的范围
    CMTime totalTime           = self.playerItem.duration;
    
    CGFloat totalMovieDuration = (CGFloat)totalTime.value/totalTime.timescale;
    
    if (self.tmpTime > totalMovieDuration) { self.tmpTime = totalMovieDuration;}
    
    if (self.tmpTime < 0){ self.tmpTime = 0; }
    
}


/**
 *  轻点手势
 */
- (void)tapAction:(UIGestureRecognizer *)senderTap
{
    if (senderTap.state == UIGestureRecognizerStateRecognized) {
        
        self.isPlayControlShow ? ([self hideControlView]) : ([self showControlView]);
    }
}

// 获取系统音量
- (void)getVolumeOfSystem
{
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    
    self.volumeSlider = nil;
    
    for (UIView *view in [volumeView subviews]) {
        
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]) {
            
            self.volumeSlider = (UISlider *)view;
            break;
            
        }
        
    }
    
}

#pragma mark --------- set or get ---------

- (void)setPlayerItem:(AVPlayerItem *)playerItem
{
    if (_playerItem == playerItem) {return;}
    
    if (_playerItem) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
        
        [_playerItem removeObserver:self forKeyPath:@"status"];
        
        [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        
        [_playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
        
        [_playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
        
    }
    
    _playerItem = playerItem;
    
    if (playerItem) {
        
        [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        
        [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        
        // 缓冲区空了，需要等待数据
        [playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
        
        // 缓冲区有足够数据可以播放了
        [playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
        
    }
}

-(void)setUrl:(NSString *)url
{
    if (url == nil) {
        
        return;
    }
    _url = url;
    
    [self addNotification];
    [self createPlayer];
}

-(void)setState:(LTPlayerState)state
{
    _state = state;
    
    // 若正在缓存 显示缓存菊花
    state == LTPlayerStateBuffering ? ([self.playerControlView.activityIndicator startAnimating]) : ([self.playerControlView.activityIndicator stopAnimating]);
}

- (void)setPlayerLayerGravity:(LTPlayerLayerGravity)playerLayerGravity
{
    _playerLayerGravity = playerLayerGravity;
    
    switch (playerLayerGravity) {
            
        case LTPlayerLayerGravityResize:
            
            self.playerLayer.videoGravity = AVLayerVideoGravityResize;
            
            break;
            
        case LTPlayerLayerGravityResizeAspect:
            
            self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
            
            break;
            
        case LTPlayerLayerGravityResizeAspectFill:
            
            self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            
            break;
        default:
            break;
    }
    
}

-(LTPlayControlView *)playerControlView
{
    if (_playerControlView == nil) {
        
        _playerControlView = [[LTPlayControlView alloc] init];
        
        [self addSubview:_playerControlView];
        
        
    }
    
    return _playerControlView;
}

#pragma mark --------- slider事件处理 ---------
- (void)touchDownSlider:(UISlider *)slider
{
    /** 这里涉及到 NSRunloop 还不太懂 **/
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
}

- (void)valueChangeSlider:(UISlider *)slider
{
    if(self.player.currentItem.status == AVPlayerStatusReadyToPlay){
        [self pause];
        
        CGFloat total           = (CGFloat)_playerItem.duration.value / _playerItem.duration.timescale;
        
        //计算出拖动的当前秒数
        NSInteger dragedSeconds = floorf(total * slider.value);
        
        //转换成CMTime才能给player来控制播放进度
        
        CMTime dragedCMTime     = CMTimeMake(dragedSeconds, 1);
        // 拖拽的时长
        NSInteger proMin        = (NSInteger)CMTimeGetSeconds(dragedCMTime) / 60;//当前秒
        NSInteger proSec        = (NSInteger)CMTimeGetSeconds(dragedCMTime) % 60;//当前分钟
        
        NSString *currentTime   = [NSString stringWithFormat:@"%02zd:%02zd", proMin, proSec];
        
        
        if (total > 0) {
            self.playerControlView.currentTimeLabel.text  = currentTime;
        }else {
            // 此时设置slider值为0
            slider.value = 0;
        }
        
    }else { // player状态加载失败
        // 此时设置slider值为0
        slider.value = 0;
    }
    
}
- (void)endSlider:(UISlider *)slider
{
    
    CGFloat total = self.playerItem.duration.value/self.playerItem.duration.timescale;
    
    NSInteger dragedTime = floorf(total *slider.value);
    
    CMTime cmTime = CMTimeMake(dragedTime, 1);
    
    [self.player seekToTime:cmTime];
    
    [self play];
    [self autoHiddenControllView];
}


#pragma mark --------- KVC about playVideoState---------

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.player.currentItem) {
        if ([keyPath isEqualToString:@"status"]) {
            if (self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
                
                [self play];
                
                self.state = LTPlayerStatePlaying;
                
                CGFloat totalSecond = _playerItem.duration.value / _playerItem.duration.timescale;// 转换成秒
                _totalTime = [self convertTime:totalSecond];// 转换成播放时间
                self.playerControlView.totalTimeLabel.text = [NSString stringWithFormat:@"%@",_totalTime];
                [self monitoringPlayback:self.playerItem];// 监听播放状态
                
                
                
            } else if (self.player.currentItem.status == AVPlayerItemStatusFailed){
                
                self.state = LTPlayerStateFailed;
                
                NSError *error = [self.player.currentItem error];
                NSLog(@"视频加载失败===%@",error.description);
                
            }
        } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
            
            // 计算缓冲进度
            NSTimeInterval timeInterval = [self getBufferZones];
            CMTime duration             = self.playerItem.duration;
            CGFloat totalDuration       = CMTimeGetSeconds(duration);
            [self.playerControlView.playerProgressView setProgress:timeInterval / totalDuration animated:NO];
            
            
            
        } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
            
            // 当缓冲是空的时候
            if (self.playerItem.playbackBufferEmpty) {
                self.state = LTPlayerStateBuffering;
                NSLog(@"缓冲为空");
                [self pause];
                
            }
            
        } else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
            
            // 当缓冲好的时候
            if (self.playerItem.playbackLikelyToKeepUp && self.state == LTPlayerStateBuffering){
                self.state = LTPlayerStatePlaying;
                [self play];
                NSLog(@"缓冲完毕");
            }
            
        }
    }
}


/**
 *  监听播放进度
 */
- (void)monitoringPlayback:(AVPlayerItem *)playerItem {
    
    //    __weak typeof(self) weakSelf = self;
    
    LTPlayView *weakSelf = self;
    
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        CGFloat currentSecond = playerItem.currentTime.value/playerItem.currentTime.timescale;// 计算当前在第几秒
        NSString *timeString = [weakSelf convertTime:currentSecond];
        
        CGFloat totalSecond = playerItem.duration.value/playerItem.duration.timescale;
        weakSelf.playerControlView.playerSlider.value = currentSecond/totalSecond;
        
        weakSelf.playerControlView.currentTimeLabel.text = [NSString stringWithFormat:@"%@",timeString];
        
    }];
    
    
}

/**
 *  时间转换为显示的格式
 */
- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
}
/**
 *  获取缓冲大小
 */

- (NSTimeInterval)getBufferZones {
    NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
    // 获取缓冲区域
    CMTimeRange timeRange     = [loadedTimeRanges.firstObject CMTimeRangeValue];
    float startSeconds        = CMTimeGetSeconds(timeRange.start);
    float durationSeconds     = CMTimeGetSeconds(timeRange.duration);
    // 计算缓冲总进度
    NSTimeInterval result     = startSeconds + durationSeconds;
    return result;
}


#pragma mark --------- Notification ---------
- (void)appDidEnterBackground
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self pause];
    self.state = LTPlayerStatePause;
}

- (void)appDidEnterPlayGround
{
    [self showControlView];
    [self play];
    self.state = LTPlayerStatePlaying;
}
/**
 *  屏幕方向监测
 */
- (void)deviceOrientationChange
{
    UIDeviceOrientation orientation             = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:{
            self.playerControlView.fullScreenBtn.selected = NO;
            [self setFrame:_tmpRect];
            self.playerControlView.playBackBtn.hidden = NO;
            
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            self.playerControlView.fullScreenBtn.selected = YES;
            [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            self.playerControlView.playBackBtn.hidden = NO;
            
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            self.playerControlView.fullScreenBtn.selected = YES;
            [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            self.playerControlView.playBackBtn.hidden = NO;
            
        }
            break;
            
        default:
            break;
    }
    
}


#pragma mark --------- controlView显示与隐藏 ---------


- (void)showControlView
{
    if(self.isPlayControlShow){
        return;
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        self.playerControlView.bottomBackView.alpha = 1;
        self.playerControlView.topBackView.alpha = 1;
    } completion:^(BOOL finished) {
        self.isPlayControlShow = YES;
        [self autoHiddenControllView];
        
    }];
    
}

- (void)autoHiddenControllView
{
    if(!self.isPlayControlShow){
        return;
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideControlView) object:nil];
    [self performSelector:@selector(hideControlView) withObject:nil afterDelay:6];
    
}
- (void)hideControlView
{
    if(!self.isPlayControlShow){
        return;
    }
    [UIView animateWithDuration:0.25f animations:^{
        self.playerControlView.bottomBackView.alpha = 0;
        self.playerControlView.topBackView.alpha = 0;
    } completion:^(BOOL finished) {
        self.isPlayControlShow = NO;
    }];
    
}

#pragma mark --------- ButtonClike ---------

/**
 *  播放按钮
 */

- (void)startAction:(UIButton *)senderBtn
{
    senderBtn.selected = !senderBtn.selected;
    if(senderBtn.selected){
        // 播放时显示暂停按钮
        [self.playerControlView.playBtn setImage:[UIImage imageNamed:@"tipsPlayerPause"] forState:UIControlStateNormal];
        
        [self play];
    }else{
        // 暂停时显示播放按钮
        [self.playerControlView.playBtn setImage:[UIImage imageNamed:@"tipsPlayerPlay"] forState:UIControlStateNormal];
        
        [self pause];
    }
}


/**
 *  全屏按钮
 */
- (void)fullScreenAction:(UIButton *)senderBtn
{
    senderBtn.selected = !senderBtn.selected;
    if(senderBtn.selected){
        
        [self.playerControlView.fullScreenBtn setImage:[UIImage imageNamed:@"tipsPlayerExitFullScreen"] forState:UIControlStateNormal];
        [self changeOrientation:UIInterfaceOrientationLandscapeRight];
        [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }else{
        
        [self.playerControlView.fullScreenBtn setImage:[UIImage imageNamed:@"tipsPlayerFullScreen"] forState:UIControlStateNormal];
        [self changeOrientation:UIInterfaceOrientationPortrait];
        [self setFrame:_tmpRect];
    }
}
/**
 *  强制改变屏幕方向
 */
- (void)changeOrientation:(UIInterfaceOrientation)senderOrientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = senderOrientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)backButtonAction:(UIButton *)sender
{
    
    
    [self pause];
    [self changeOrientation:UIInterfaceOrientationPortrait];
    [self.playerControlView.playBtn setImage:[UIImage imageNamed:@"tipsPlay"] forState:UIControlStateNormal];
    [self.delegate playerGoBack];
}


#pragma mark 播放控制
- (void)play
{
    [self.player play];
    self.playerControlView.playBtn.selected = YES;
    
}

- (void)pause
{
    [self.player pause];
    self.playerControlView.playBtn.selected = NO;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

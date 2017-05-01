//
//  LTPlayerViewController.m
//  LTLive
//
//  Created by 孟令通 on 2017/4/30.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTPlayerViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

#import "LTPlayerCoverViewController.h"

#import "AppDelegate.h"
@interface LTPlayerViewController ()

@property(atomic, retain) id<IJKMediaPlayback> player;

@property (nonatomic, strong) UIImageView *blurImageView;

@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) LTPlayerCoverViewController *playerChatVC;

@end

@implementation LTPlayerViewController

- (LTPlayerCoverViewController *)playerChatVC
{
    if (!_playerChatVC) {
        
        _playerChatVC = [[LTPlayerCoverViewController alloc] init];
    }
    
    return _playerChatVC;
}

- (UIButton *)closeBtn
{
    if (!_closeBtn) {
        
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_closeBtn setImage:[UIImage imageNamed:@"mg_room_btn_guan_h"] forState:UIControlStateNormal];
        
        [_closeBtn sizeToFit];
        
        _closeBtn.frame = CGRectMake(SCREEN_WIDTH - _closeBtn.width - 20, SCREEN_HEIGHT - _closeBtn.height - 10, _closeBtn.width, _closeBtn.height);
        
        [_closeBtn addTarget:self action:@selector(didClickedCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    return _closeBtn;
}

- (void)didClickedCloseBtn:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    // 注册直播需要用的通知
    [self installMovieNotificationObservers];
    
    // 开始播放
    [self.player prepareToPlay];
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    [window addSubview:self.closeBtn];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    // 关闭直播
    [self.player shutdown];
    [self removeMovieNotificationObservers];
    
    [self.closeBtn removeFromSuperview];
}

#pragma mark Install Movie Notifications

/* Register observers for the various movie object notifications. */
-(void)installMovieNotificationObservers
{
    // 网络环境监听，监听缓冲方法
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    
    // 监听直播完成回调
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    // 监听用户操作
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
}

- (void)loadStateDidChange:(NSNotification*)notification
{
    //    MPMovieLoadStateUnknown        = 0,未知
    //    MPMovieLoadStatePlayable       = 1 << 0, 缓冲结束，可以播放
    //    MPMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES 缓冲结束，自动播放
    //    MPMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started 暂停
    
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    //    MPMovieFinishReasonPlaybackEnded, 直播结束
    //    MPMovieFinishReasonPlaybackError, 直播错误
    //    MPMovieFinishReasonUserExited     用户退出
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    
    switch (reason)
    {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification
{
    NSLog(@"mediaIsPreparedToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification
{
    //    MPMoviePlaybackStateStopped,
    //    MPMoviePlaybackStatePlaying,
    //    MPMoviePlaybackStatePaused,
    //    MPMoviePlaybackStateInterrupted,
    //    MPMoviePlaybackStateSeekingForward,
    //    MPMoviePlaybackStateSeekingBackward
    
    switch (_player.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
    
    self.blurImageView.hidden = YES;
    [self.blurImageView removeFromSuperview];
}



#pragma mark Remove Movie Notification Handlers

/* Remove the movie notification observers from the movie object. */
-(void)removeMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_player];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initPlayer];
    
    [self initUI];
    
    [self addChatVC];
}

- (void)addChatVC
{
    [self addChildViewController:self.playerChatVC];
    
    [self.view addSubview:self.playerChatVC.view];
    
    [self.playerChatVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
        
    }];
    
    self.playerChatVC.live = self.live;
     
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor blackColor];
    
    _blurImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    [_blurImageView downloadImage:_live.creator.portrait placeholder:@"default_room"];
    
    [self.view addSubview:_blurImageView];
    
    // 创建毛玻璃效果
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    // 创建毛玻璃视图
    UIVisualEffectView *visualEffect = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    visualEffect.frame = self.blurImageView.bounds;
    
    [self.blurImageView addSubview:visualEffect];
    
    
    
}

- (void) initPlayer
{
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    
    IJKFFMoviePlayerController *player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:_live.streamAddr withOptions:options];
    
    self.player = player;
    
    self.player.view.frame = self.view.bounds;
    
    self.player.shouldAutoplay = YES;
    
    [self.view addSubview:self.player.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

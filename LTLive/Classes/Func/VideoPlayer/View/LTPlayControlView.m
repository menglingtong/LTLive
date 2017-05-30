//
//  LTPlayControlView.m
//  LTLive
//
//  Created by 孟令通 on 2017/5/29.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTPlayControlView.h"

@implementation LTPlayControlView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 初始化顶部遮罩层
        _topBackView = [[UIView alloc] init];
        _topBackView.backgroundColor = [UIColor colorWithRed:0.04 green:0.04 blue:0.04 alpha:0.40];
        [self addSubview:_topBackView];
        
        
        // 初始化返回按钮
        _playBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBackBtn setImage:[UIImage imageNamed:@"tipsPlayerBack"] forState:UIControlStateNormal];
        [_topBackView addSubview:_playBackBtn];
        
        // 初始化底部遮罩层
        _bottomBackView = [[UIView alloc] init];
        _bottomBackView.backgroundColor = [UIColor colorWithRed:0.04 green:0.04 blue:0.04 alpha:0.40];
        [self addSubview:_bottomBackView];
        
        
        // 播放按钮
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"tipsPlayerPause"] forState:UIControlStateNormal];
        [_bottomBackView addSubview:_playBtn];
        
        // 初始化当前时间Label
        _currentTimeLabel = [[UILabel alloc] init];
        [_currentTimeLabel setFont:[UIFont systemFontOfSize:14]];
        _currentTimeLabel.textColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1.00];
        [_bottomBackView addSubview:_currentTimeLabel];
        
        
        // 初始化全屏按钮
        _fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenBtn setImage:[UIImage imageNamed:@"tipsPlayerFullScreen"] forState:UIControlStateNormal];
        [_bottomBackView addSubview:_fullScreenBtn];
        
        // 初始化播放器进度条
        _playerProgressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        [_bottomBackView addSubview:_playerProgressView];
        
        
        // 初始化总时长
        _totalTimeLabel = [[UILabel alloc] init];
        [_totalTimeLabel setFont:[UIFont systemFontOfSize:14]];
        _totalTimeLabel.textColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1.00];
        [_bottomBackView addSubview:_totalTimeLabel];
        
        
        // 初始化进度滑条
        _playerSlider = [[UISlider alloc] init];
        [_playerSlider setThumbImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        [_bottomBackView addSubview:_playerSlider];
        
        
        // 初始化加载等待图标
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self addSubview:_activityIndicator];
        
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 布局顶部遮罩层
    [_topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(0);
        
        make.left.equalTo(self).offset(0);
        
        make.right.equalTo(self).offset(0);
        
        make.height.equalTo(40);
        
    }];
    
    // 布局返回按钮
    [_playBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(10);
        
        make.left.equalTo(self).offset(5);
        
        make.height.equalTo(20);
        
        make.width.equalTo(20);
        
    }];
    
    // 布局底部遮罩层
    [_bottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self).offset(0);
        
        make.left.equalTo(self).offset(0);
        
        make.right.equalTo(self).offset(0);
        
        make.height.equalTo(40);
        
    }];
    
    // 布局播放按钮
    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(_bottomBackView.top).equalTo(10);
        
        make.left.mas_equalTo(_bottomBackView.left).equalTo(10);
        
        make.height.equalTo(20);
        
        make.width.equalTo(20);
        
    }];
    
    // 布局当前时间Label
    [_currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.playBtn.right).offset(40);
        
        make.top.equalTo(_bottomBackView.top).offset(5);
        
        make.width.equalTo(40);
        
        make.bottom.equalTo(_bottomBackView.bottom).offset(-5);
        
    }];
    _currentTimeLabel.text = @"00:00";
    
    
    // 布局全屏按钮
    [_fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_bottomBackView.right).offset(-10);
        
        make.top.equalTo(_bottomBackView.top).offset(10);
        
        make.bottom.equalTo(_bottomBackView.bottom).offset(-10);
        
        make.width.equalTo(20);
        
    }];
    
    // 布局总时长
    [_totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_bottomBackView.top).offset(5);
        
        make.right.equalTo(self.fullScreenBtn.left).offset(-40);
        
        make.bottom.equalTo(_bottomBackView.bottom).offset(-5);
        
        make.width.equalTo(40);
        
    }];
    _totalTimeLabel.text = @"00:00";
    
//    _totalTimeLabel.backgroundColor = [UIColor redColor];
    
    // 布局进度条
    [_playerProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_bottomBackView.top).offset(20);
        
        make.left.equalTo(_currentTimeLabel.right).offset(100);
        
        make.right.equalTo(_totalTimeLabel.left).offset(-100);
        
        make.height.equalTo(1);
        
    }];
    _playerProgressView.progressTintColor = [UIColor colorWithRed:0.38 green:0.69 blue:0.89 alpha:1.00];
    
    
    // 布局进度滑条
    [_playerSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_bottomBackView.top).offset(20);
        
        make.left.equalTo(_currentTimeLabel.right).offset(100);
        
        make.right.equalTo(_totalTimeLabel.left).offset(-100);
        
        make.height.equalTo(1);
        
    }];
    _playerSlider.maximumTrackTintColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:0.00];
    _playerSlider.minimumTrackTintColor = [UIColor colorWithRed:0.99 green:0.75 blue:0.18 alpha:1.00];
    
    //    // 布局加载等待图标
    //    [self.activityIndicator makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(self).offset(ScreenWidth / 2.0);
    //
    //        make.top.equalTo(self).offset(ScreenHeight / 2.0);
    //
    //        make.width.equalTo(20);
    //
    //        make.height.equalTo(20);
    //
    //    }];
    
}

-(void)showControlView
{
    self.topBackView.alpha = 1.0f;
    
    self.bottomBackView.alpha = 1.0f;
}

-(void)hiddenControlView
{
    self.topBackView.alpha = 0;
    
    self.bottomBackView.alpha = 0;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

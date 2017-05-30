//
//  LTVideoPlayerController.m
//  LTLive
//
//  Created by 孟令通 on 2017/5/29.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTVideoPlayerController.h"

#import "LTPlayView.h"

@interface LTVideoPlayerController ()<LTPlayeViewDelegate>

@property (nonatomic, strong) LTPlayView *playView;

@end

@implementation LTVideoPlayerController

+ (LTVideoPlayerController *)sharePlayerInstance
{
    static LTVideoPlayerController * manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[LTVideoPlayerController alloc] init];
        
    });
    
    return manager;
}

- (void)setUrl:(NSString *)url
{
    if (_url != url) {
        
        _url = [url copy];
        
    }
    
    self.playView.url = _url;
    
    [self.view addSubview:self.playView];
}

- (LTPlayView *)playView
{
    if (!_playView) {
        
        _playView = [[LTPlayView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        
    }
    
    _playView.delegate = self;
    
    _playView.playerLayerGravity = LTPlayerLayerGravityResizeAspectFill;
    
    return _playView;
}


- (void)playerGoBack
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

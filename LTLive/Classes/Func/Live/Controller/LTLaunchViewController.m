//
//  LTLaunchViewController.m
//  LTLive
//
//  Created by 孟令通 on 2017/4/26.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTLaunchViewController.h"

#import "LFLivePreview.h"

@interface LTLaunchViewController ()


@end

@implementation LTLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (IBAction)closeLaunch:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)startLive:(id)sender {
    
    LFLivePreview *preView = [[LFLivePreview alloc] initWithFrame:self.view.bounds];
    
    preView.vc = self;
    
    [preView startLive];
    [self.view addSubview:preView];
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

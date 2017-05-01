//
//  LTPlayerCoverViewController.m
//  LTLive
//
//  Created by 孟令通 on 2017/5/1.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTPlayerCoverViewController.h"



@interface LTPlayerCoverViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;



@end

@implementation LTPlayerCoverViewController

- (void)setLive:(LTLive *)live
{
    if (!_live) {
        
        _live = live;
    }
    
    
    [_headImageView downloadImage:live.creator.portrait placeholder:@"default_room"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.headImageView.layer.cornerRadius = 20;
    
    
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

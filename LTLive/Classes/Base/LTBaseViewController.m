//
//  LTBaseViewController.m
//  LTLive
//
//  Created by 孟令通 on 2017/4/26.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTBaseViewController.h"

@interface LTBaseViewController ()

@end

@implementation LTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.view.backgroundColor = RGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
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

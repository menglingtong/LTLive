//
//  LTBaseNavViewController.m
//  LTLive
//
//  Created by 孟令通 on 2017/4/26.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTBaseNavViewController.h"

@interface LTBaseNavViewController ()

@end

@implementation LTBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.barTintColor = [UIColor colorWithRed:0.95 green:0.24 blue:0.11 alpha:1.00];
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    if (self.viewControllers.count) {
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
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

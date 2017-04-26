//
//  LTTabBarViewController.m
//  LTLive
//
//  Created by 孟令通 on 2017/4/26.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTTabBarViewController.h"

#import "LTTabBar.h"

#import "LTBaseNavViewController.h"

@interface LTTabBarViewController ()<LTTabBarDelegate>

@property (nonatomic, strong) LTTabBar *ltTabBar;

@end

@implementation LTTabBarViewController

- (LTTabBar *)ltTabBar
{
    if (!_ltTabBar) {
        
        _ltTabBar = [[LTTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        
        _ltTabBar.delegate = self;
    }
    
    return _ltTabBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 加载控制器
    [self configViewControllers];
    
    // 加载tabbar
    [self.tabBar addSubview:self.ltTabBar];
}

- (void)configViewControllers
{
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"LTMainViewController", @"LTMineViewController"]];
    
    for (NSInteger i = 0; i < array.count; i++) {
        
        NSString *vcName = array[i];
        
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
        
        LTBaseNavViewController *nav = [[LTBaseNavViewController alloc] initWithRootViewController:vc];
        
        [array replaceObjectAtIndex:i withObject:nav];
    }
    
    self.viewControllers = array;
    
}


#pragma mark LTTabBar delegate方法
- (void)tabBar:(LTTabBar *)tabBar clickButton:(LTButtonType)buttonId
{
    
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

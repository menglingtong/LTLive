//
//  LTVideoViewController.m
//  LTLive
//
//  Created by 孟令通 on 2017/5/28.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTVideoViewController.h"

#import "LTVideoCell.h"

#import "LTTabBarViewController.h"

#import <objc/runtime.h>

#import "NSObject+LTRuntime.h"

#import "LTVideoPlayerController.h"

static NSString *identifier = @"LTVideoCell";

@interface LTVideoViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) CGFloat contentOffsetY;

@property (nonatomic, assign) CGFloat newContentOffsetY;

@property (nonatomic, assign) CGFloat oldContentOffsetY;


@property (nonatomic, assign) CGFloat tabBarOriginalY;

@end

@implementation LTVideoViewController

+ (void)load
{
    NSLog(@"开始加载");
    
    
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray arrayWithObjects:@"http://baobab.wdjcdn.com/145345719887961975219.mp4",
                                                  @"http://baobab.wdjcdn.com/1461897495660000111.mp4",
                                                  @"http://baobab.wdjcdn.com/145076769089714.mp4",
                                                  @"http://baobab.wdjcdn.com/1455782903700jy.mp4",
                                                  @"http://baobab.wdjcdn.com/1442142801331138639111.mp4",
                                                  @"http://baobab.wdjcdn.com/143625320119607.mp4",
                                                  @"http://baobab.wdjcdn.com/143323298510702.mp4",
                                                  @"http://baobab.wdjcdn.com/14399887845852_x264.mp4",
                                                  @"http://baobab.wdjcdn.com/1451826889080C.mp4",
                                                  @"http://baobab.wdjcdn.com/14564977406580.mp4", nil];
        
    }
    
    return _dataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // 初始化UI
    [self initUI];
    
    [self initData];
}

- (void)initUI{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LTVideoCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    LTTabBarViewController *tabBarVC = (LTTabBarViewController *)self.tabBarController;
    
    _tabBarOriginalY = tabBarVC.tabBar.frame.origin.y;
    
}

- (void)initData{
    
    _contentOffsetY = 0;
    
    _oldContentOffsetY = 0;
    
    _newContentOffsetY = 0;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.hidesBottomBarWhenPushed = YES;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.hidesBottomBarWhenPushed = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    LTVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (indexPath.row % 2 == 0) {
        
        cell.bgImageView.image = [UIImage imageNamed:@"image001"];
        
    }
    else
    {
        cell.bgImageView.image = [UIImage imageNamed:@"image002"];
    }
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    _contentOffsetY = scrollView.contentOffset.y;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    LTTabBarViewController *tabBarVC = (LTTabBarViewController *)self.tabBarController;
    
    
    _newContentOffsetY = scrollView.contentOffset.y;
    
    
    NSLog(@"new:%f -- old:%f -- pres%f", _newContentOffsetY, _oldContentOffsetY, _contentOffsetY);
    
    
    if (_newContentOffsetY > _oldContentOffsetY && _oldContentOffsetY > _contentOffsetY) {
        
        // 向上滚动
        [self tabBarHidden:tabBarVC];
        
    }
    else if(_newContentOffsetY < _oldContentOffsetY && _oldContentOffsetY < _contentOffsetY)
    {
        // 向下滚动
        [self tabBarShow:tabBarVC];
    }
    else
    {
        
        NSLog(@"当前正在拖拽");
        
    }
    
    
    if (scrollView.dragging) {
        
        if ((scrollView.contentOffset.y - _contentOffsetY) > 5.0f) {  // 向上拖拽

            // 隐藏导航栏和选项栏
            [self tabBarHidden:tabBarVC];
            
            
        } else if ((_contentOffsetY - scrollView.contentOffset.y) > 5.0f) {   // 向下拖拽
            
            // 显示导航栏和选项栏
            [self tabBarShow:tabBarVC];
            
  
        } else {
            
            
            
        }
        
    }
    
    
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    _oldContentOffsetY = scrollView.contentOffset.y;
}


- (void)tabBarHidden:(LTTabBarViewController *)tabBarVC{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        tabBarVC.tabBar.frame = CGRectMake(0, SCREEN_HEIGHT + 40, SCREEN_WIDTH, 44);
        
    }];
}

- (void)tabBarShow:(LTTabBarViewController *)tabBarVC{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        tabBarVC.tabBar.frame = CGRectMake(0, _tabBarOriginalY, SCREEN_WIDTH, 44);
        
    }];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LTVideoPlayerController *playerVC = [LTVideoPlayerController new];
    
    playerVC.url = [self.dataSource objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:playerVC animated:YES];
    
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

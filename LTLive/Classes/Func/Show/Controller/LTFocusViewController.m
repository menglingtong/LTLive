//
//  LTFocusViewController.m
//  LTLive
//
//  Created by 孟令通 on 2017/4/27.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTFocusViewController.h"

#import "LTShowHandler.h"

#import "LTHotCell.h"

#import "LTPlayerViewController.h"

static NSString *identifier = @"LTHotCell";

@interface LTFocusViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation LTFocusViewController

- (NSArray *)dataSource
{
    if (!_dataSource) {
        
        _dataSource = [NSArray array];
    }
    
    return _dataSource;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LTHotCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.live = [_dataSource objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LTLive *live = [self.dataSource objectAtIndex:indexPath.row];
    
    LTPlayerViewController *playerVC = [[LTPlayerViewController alloc] init];
    
    playerVC.live = live;
    
    [self.navigationController pushViewController:playerVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70 + SCREEN_WIDTH;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self loadData];
    
}

- (void)initUI
{
    [self.tableView registerNib:[UINib nibWithNibName:@"LTHotCell" bundle:nil] forCellReuseIdentifier:identifier];
}

- (void)loadData
{
//    [LTShowHandler executeGetHotLiveTaskWithSuccess:^(id obj) {
//        
//        [self.dataSource addObjectsFromArray:obj];
//        
//        [self.tableView reloadData];
//        
//    } failed:^(id obj) {
//        
//        NSLog(@"%@", obj);
//        
//    }];
    
    
    LTLive *live = [[LTLive alloc] init];
    
    LTCreator *creator = [[LTCreator alloc] init];
    
    live.city = @"火星";
    
    live.onlineUsers = 983019202;
    
    live.streamAddr = Live_MLT;
    
    live.creator = creator;
    
    creator.nick = @"😝麻辣烫";
    
    creator.portrait = @"MLT";
    
    self.dataSource = @[live];
    
    [self.tableView reloadData];
    
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

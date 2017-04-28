//
//  LTHotViewController.m
//  LTLive
//
//  Created by 孟令通 on 2017/4/27.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTHotViewController.h"

#import "LTShowHandler.h"

@interface LTHotViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation LTHotViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self loadData];
    
}

- (void)initUI
{
    
}

- (void)loadData
{
    [LTShowHandler executeGetHotLiveTaskWithSuccess:^(id obj) {
        
        [self.dataSource addObjectsFromArray:obj];
        
        [self.tableView reloadData];
        
    } failed:^(id obj) {
        
        NSLog(@"%@", obj);
        
    }];
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

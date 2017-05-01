//
//  LTNearViewController.m
//  LTLive
//
//  Created by 孟令通 on 2017/4/27.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTNearViewController.h"

#import "LTShowHandler.h"

#import "LTNearCell.h"

static NSString *identifier = @"LTNearCell";

@interface LTNearViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation LTNearViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    [self initUI];
    
    [self loadData];
    
}

- (void)initUI
{
    
    [self.mainCollectionView registerNib:[UINib nibWithNibName:@"LTNearCell" bundle:nil] forCellWithReuseIdentifier:identifier];
}

- (void)loadData
{
    [LTShowHandler executeGetNearLiveTaskWithSuccess:^(id obj) {
        
        self.dataSource = obj;
        
        [self.mainCollectionView reloadData];
        
    } failed:^(id obj) {
        
        
    }];
}

#pragma mark collectionview delegate 方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LTNearCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.live = self.dataSource[indexPath.item];
    
    return cell;
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

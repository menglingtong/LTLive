//
//  LTMainViewController.m
//  LTLive
//
//  Created by 孟令通 on 2017/4/26.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTMainViewController.h"
#import "LTMainTopView.h"

@interface LTMainViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScroll;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) LTMainTopView *topView;

@end

@implementation LTMainViewController

- (LTMainTopView *)topView
{
    if (!_topView) {
        
        _topView = [[LTMainTopView alloc] initWithFrame:CGRectMake(0, 0, 200, 50) titleNames:self.dataSource];
        
        @weakify(self);
        
        _topView.block = ^(NSInteger tag){
            
            @strongify(self);
          
            CGPoint point = CGPointMake(tag * SCREEN_WIDTH, self.contentScroll.contentOffset.y);
            
            [self.contentScroll setContentOffset:point animated:YES];
            
        };
    }
    
    return _topView;
}

- (NSArray *)dataSource
{
    if (!_dataSource) {
        
        _dataSource = @[@"关注", @"热门", @"附近"];
    }
    
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
}

- (void)initUI
{
    // 添加左右按钮
    [self setupNav];
    
    // 添加子视图控制器
    [self setupChildViewControllers];
    
}

- (void)setupChildViewControllers
{
    NSArray *vcNames = @[@"LTFocusViewController", @"LTHotViewController", @"LTNearViewController"];
    
    for (NSInteger i = 0; i < vcNames.count; i++) {
        
        UIViewController *vc = [[NSClassFromString(vcNames[i]) alloc] init];
        
        vc.title = self.dataSource[i];
        // 执行addChildViewController这句话时，没有执行该vc的viewdidload方法
        [self addChildViewController:vc];
        
    }
    
    // 将子控制器的view 添加到 mainVC 的scrollView上
    
    
    // 设置scrollview的contentsize
    self.contentScroll.contentSize = CGSizeMake(SCREEN_WIDTH * self.dataSource.count, 0);
    
    // 默认先展示第二个页面
    self.contentScroll.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    
    // 进入主控制器加载第一个页面
    [self scrollViewDidEndDecelerating:self.contentScroll];
    
}

- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.titleView = self.topView;
}

// 动画结束调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGFloat width = SCREEN_WIDTH;
    
    CGFloat height = SCREEN_HEIGHT;
    
    CGFloat offset = scrollView.contentOffset.x;
    
    // 获取vc索引值
    NSInteger vcIndex = offset / width;
    
    [self.topView scrollLineView:vcIndex];
    
    // 根据索引值获取vc引用
    UIViewController *vc = self.childViewControllers[vcIndex];
    
    // 判断当前vc 是否执行过viewDidLoad
    if ([vc isViewLoaded]) {
        
        return;
    }
    
    // 设置控制器view的大小
    vc.view.frame = CGRectMake(offset, 0, scrollView.frame.size.width, height);
    // 将控制器的view 添加到 scrollview上
    [scrollView addSubview:vc.view];
}

// 滑动结束调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
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

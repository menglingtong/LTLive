//
//  LTTabBar.m
//  LTLive
//
//  Created by 孟令通 on 2017/4/26.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTTabBar.h"

@interface LTTabBar ()

@property (nonatomic, strong) UIImageView *tabBgVeiw;

@property (nonatomic, strong) NSArray *sourceList;

@property (nonatomic, strong) UIButton *lastButton;

@property (nonatomic, strong) UIButton *cameraButton;

@end

@implementation LTTabBar

- (UIButton *)cameraButton
{
    if (!_cameraButton) {
        
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _cameraButton.tag = LTButtonTypeLaunch;
        
        [_cameraButton setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        
        _cameraButton.adjustsImageWhenHighlighted = NO;
        
        [_cameraButton addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cameraButton;
}

- (NSArray *)sourceList
{
    if (!_sourceList) {
        
        _sourceList = @[@"tab_live", @"tab_me"];
    }
    
    return _sourceList;
}

- (UIImageView *)tabBgVeiw
{
    if (!_tabBgVeiw) {
        
        _tabBgVeiw = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
        
    }
    
    return _tabBgVeiw;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 加载背景图
        [self addSubview:self.tabBgVeiw];
        
        for (NSInteger i = 0; i < self.sourceList.count; i++) {
            
            
            
            UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
            
            // 不让图片在高亮下改变
            item.adjustsImageWhenHighlighted = NO;
            
            // 按钮正常状态
            [item setImage:[UIImage imageNamed:[self.sourceList objectAtIndex:i]] forState:UIControlStateNormal];
            
            // 按钮选中状态
            [item setImage:[UIImage imageNamed:[[self.sourceList objectAtIndex:i] stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
            
            [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
            
            item.tag = LTButtonTypeLive + i;
            
            if (i == 0) {
                
                item.selected = YES;
                
                self.lastButton = item;
                
            }
            
            [self addSubview:item];
            
        }
        
        // 添加直播按钮
        [self addSubview:self.cameraButton];
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tabBgVeiw.frame = self.bounds;
    
    CGFloat width = self.bounds.size.width / self.sourceList.count;
    
    for (NSInteger i = 0; i < [self subviews].count; i++) {
        
        UIView *view = [self subviews][i];
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            view.frame = CGRectMake((view.tag - LTButtonTypeLive) * width, 0, width, self.frame.size.height);
            
        }
        
    }
    
    
    [self.cameraButton sizeToFit];
    self.cameraButton.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height - 50);
}

- (void)clickItem:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(tabBar:clickButton:)]) {
        
        [self.delegate tabBar:self clickButton:button.tag];
        
    }
    
    if (self.block) {
        self.block(self, button.tag);
    }
    
    if (button.tag == LTButtonTypeLaunch) {
        
        return; 
    }
    
    self.lastButton.selected = NO;
    
    button.selected = YES;
    
    self.lastButton = button;
    
    // 设置动画
    [UIView animateWithDuration:0.2 animations:^{
        
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
    } completion:^(BOOL finished) {
        // 恢复动画
        [UIView animateWithDuration:0.2 animations:^{
            
            button.transform = CGAffineTransformIdentity;
            
        }];
        
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

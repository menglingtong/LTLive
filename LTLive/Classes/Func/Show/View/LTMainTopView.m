//
//  LTMainTopView.m
//  LTLive
//
//  Created by 孟令通 on 2017/4/27.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTMainTopView.h"

@interface LTMainTopView ()

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSMutableArray *buttonArr;

@end

@implementation LTMainTopView

- (NSMutableArray *)buttonArr
{
    if (!_buttonArr) {
        _buttonArr = [NSMutableArray array];
    }
    
    return _buttonArr;
}

- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titleNames
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat btnW = self.width / titleNames.count;
        
        CGFloat btnH= self.height;
        
        for (NSInteger i = 0; i < titleNames.count; i++) {
            
            UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [self.buttonArr addObject:titleBtn];
            
            titleBtn.tag = i;
            
            [titleBtn setTitle:[titleNames objectAtIndex:i] forState:UIControlStateNormal];
            
            [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            titleBtn.titleLabel.font = [UIFont systemFontOfSize:18];
            
            titleBtn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
            
            [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:titleBtn];
            
            if (i == 1) {
                
                CGFloat h = 2;
                
                CGFloat y = 40;
                
                [titleBtn.titleLabel sizeToFit];
                
                _lineView = [[UIView alloc] init];
                
                _lineView.backgroundColor = [UIColor whiteColor];
                
                _lineView.height = h;
                
                _lineView.width = titleBtn.titleLabel.width;
                
                _lineView.top = y;
                
                _lineView.centerX = titleBtn.centerX;
                
                [self addSubview:_lineView];
                
                
            }
            
        }
        
    }
    return self;
}

// 点击事件
- (void)titleClick:(UIButton *)btn
{
    if (_block) {
        
        _block(btn.tag);
    }
    
    [self scrollLineView:btn.tag];
}

// mainVC 滚动时调用
- (void)scrollLineView:(NSInteger)tag
{
    UIButton *btn = [self.buttonArr objectAtIndex:tag];
    
    [UIView animateWithDuration:0.4 animations:^{
        
        _lineView.centerX = btn.centerX;
        
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

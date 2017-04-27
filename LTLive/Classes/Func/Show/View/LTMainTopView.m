//
//  LTMainTopView.m
//  LTLive
//
//  Created by 孟令通 on 2017/4/27.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTMainTopView.h"

@implementation LTMainTopView

- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titleNames
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat btnW = self.width / titleNames.count;
        
        CGFloat btnH= self.height;
        
        for (NSInteger i = 0; i < titleNames.count; i++) {
            
            UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [titleBtn setTitle:[titleNames objectAtIndex:i] forState:UIControlStateNormal];
            
            [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            titleBtn.titleLabel.font = [UIFont systemFontOfSize:18];
            
            titleBtn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
            
            [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:titleBtn];
        }
        
    }
    return self;
}

- (void)titleClick:(UIButton *)btn
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

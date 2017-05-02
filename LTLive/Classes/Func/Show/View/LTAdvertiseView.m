//
//  LTAdvertiseView.m
//  LTLive
//
//  Created by 孟令通 on 2017/5/2.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTAdvertiseView.h"

@interface LTAdvertiseView ()

@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation LTAdvertiseView

+ (instancetype)loadAdvertiseView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LTAdvertiseView.xib" owner:self options:nil] lastObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

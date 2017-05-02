//
//  LTNearCell.m
//  LTLive
//
//  Created by 孟令通 on 2017/5/2.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTNearCell.h"

@interface LTNearCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation LTNearCell

- (void)showAnimation
{
    
    if ( [self.live isShow]) {
        
        return;
    }
    
    self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.layer.transform = CATransform3DMakeScale(1, 1, 1);
        
        self.live.show = YES;
    }];
}

- (void)setLive:(LTLive *)live
{
    if (_live != live) {
        
        _live = live;
    }
    
    [self.bigImageView downloadImage:_live.creator.portrait placeholder:@"default_room"];
    
    self.distanceLabel.text = _live.distance;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end

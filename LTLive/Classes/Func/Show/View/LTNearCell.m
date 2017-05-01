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

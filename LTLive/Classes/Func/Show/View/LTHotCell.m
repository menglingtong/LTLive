//
//  LTHotCell.m
//  LTLive
//
//  Created by 孟令通 on 2017/4/28.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTHotCell.h"

@interface LTHotCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UILabel *onlineLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@end

@implementation LTHotCell

- (void)setLive:(LTLive *)live
{
    if (_live != live) {
        
        _live = live;
    }
    
    if ([_live.creator.portrait isEqualToString:@"MLT"]) {
        
        self.headView.image = [UIImage imageNamed:@"MLT.jpg"];
        self.bigImageView.image = [UIImage imageNamed:@"MLT.jpg"];
        
    }else
    {
        [self.headView downloadImage:live.creator.portrait placeholder:@"default_room"];
        
        [self.bigImageView downloadImage:live.creator.portrait placeholder:@"default_room"];
    }
    
    
    
    self.nameLabel.text = live.creator.nick;
    
    self.onlineLabel.text = [@(live.onlineUsers) stringValue];
    
    self.locationLabel.text = live.city;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.headView.layer.cornerRadius = self.headView.width / 2.0;
    
    self.headView.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

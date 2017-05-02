//
//  LTNearCell.h
//  LTLive
//
//  Created by 孟令通 on 2017/5/2.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LTLive.h"

@interface LTNearCell : UICollectionViewCell

@property (nonatomic, strong) LTLive *live;

- (void)showAnimation;

@end

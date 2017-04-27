//
//  LTMainTopView.h
//  LTLive
//
//  Created by 孟令通 on 2017/4/27.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainTopBlock)(NSInteger tag);

@interface LTMainTopView : UIView

@property (nonatomic, copy) MainTopBlock block;

- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titleNames;

- (void)scrollLineView:(NSInteger)tag;

@end

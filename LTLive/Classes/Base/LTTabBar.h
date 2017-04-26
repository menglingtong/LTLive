//
//  LTTabBar.h
//  LTLive
//
//  Created by 孟令通 on 2017/4/26.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LTButtonType) {
    
    LTButtonTypeLive = 100, // 直播展示
    LTButtonTypeMine, // 我的页面
    
};


@class LTTabBar;

typedef void(^TabBlock)(LTTabBar * tabBar, LTButtonType buttonId);

@protocol LTTabBarDelegate <NSObject>

- (void)tabBar:(LTTabBar *)tabBar clickButton:(LTButtonType)buttonId;

@end

@interface LTTabBar : UIView

@property (nonatomic, weak) id<LTTabBarDelegate> delegate;

@property (nonatomic, copy) TabBlock block;

@end

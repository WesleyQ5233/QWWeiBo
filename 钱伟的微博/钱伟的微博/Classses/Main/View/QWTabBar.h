//
//  QWTabBar.h
//  钱伟的微博
//
//  Created by mac on 16/1/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QWTabBar;

@protocol QWTabBarDelegate <NSObject>

@optional
- (void)tabBar:(QWTabBar *)tabBar didClickButton:(NSInteger)index;

/**
 *  点击加号按钮的时候调用
 *
 
 */
- (void)tabBarDidClickPlusButton:(QWTabBar *)tabBar;

@end


@interface QWTabBar : UIView

//@property (nonatomic, assign) NSUInteger tabBarButtonCount;

// items:保存每一个按钮对应tabBarItem模型
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id<QWTabBarDelegate> delegate;

@end

//
//  QWComposeToolBar.h
//  钱伟的微博
//
//  Created by mac on 16/1/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QWComposeToolBar;
@protocol QWComposeToolBarDelegate <NSObject>

@optional
- (void)composeToolBar:(QWComposeToolBar *)toolBar didClickBtn:(NSInteger)index;

@end

@interface QWComposeToolBar : UIView

@property (nonatomic, weak) id<QWComposeToolBarDelegate> delegate;

@end

//
//  AppDelegate.m
//  钱伟的微博
//
//  Created by mac on 16/1/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "QWTabBarController.h"
#import "QWNewFeatureViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "QWOAuthViewController.h"
#import "QWAccountTool.h"
#import "QWRootVcTool.h"
#import "UIImageView+WebCache.h"

@interface AppDelegate ()

@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation AppDelegate
// 补充：控制器的view
// UITabBarController控制器的view在一创建控制器的时候就会加载view
// UIViewController的view，才是懒加载。
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 注册通知
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:setting];
    
    
    // 设置音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // 后台播放
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    // 单独播放一个后台程序
    [session setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    
    [session setActive:YES error:nil];
    
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    // 选择根控制器
    // 判断下有没有授权
    if ([QWAccountTool account]) { // 已经授权
        
        // 选择根控制器
        [QWRootVcTool chooseRootViewController:self.window];
        
    }else{ // 进行授权
        QWOAuthViewController *oauthVc = [[QWOAuthViewController alloc] init];
        
        // 设置窗口的根控制器
        self.window.rootViewController = oauthVc;
        
    }
    
    
    
    // 显示窗口
    [self.window makeKeyAndVisible];
    // makeKeyAndVisible底层实现
    // 1. application.keyWindow = self.window
    // 2. self.window.hidden = NO;
    
    
    
    return YES;
}


// 接收到内存警告的时候调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    
    // 停止所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
    // 删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    
}

// 失去焦点
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"天黑黑.mp3" withExtension:nil];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    // 无限播放
    player.numberOfLoops = -1;
    
    [player play];
    
    _player = player;
}

// 程序进入后台的时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // 开启一个后台任务,时间不确定，优先级比较低，假如系统要关闭应用，首先就考虑
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        
        // 当后台任务结束的时候调用
        [application endBackgroundTask:ID];
        
    }];
    
    // 如何提高后台任务的优先级，欺骗苹果，我们是后台播放程序
    
    // 但是苹果会检测你的程序当时有没有播放音乐，如果没有，有可能就干掉你
    
    // 微博：在程序即将失去焦点的时候播放静音音乐.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
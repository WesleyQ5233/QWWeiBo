//
//  QWAccountTool.h
//  钱伟的微博
//
//  Created by mac on 16/1/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QWAccount;

@interface QWAccountTool : NSObject

+ (void)saveAccount:(QWAccount *)account;

+ (QWAccount *)account;

+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end

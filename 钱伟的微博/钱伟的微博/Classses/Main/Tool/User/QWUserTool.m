//
//  QWUserTool.m
//  钱伟的微博
//
//  Created by mac on 16/1/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "QWUserTool.h"
#import "QWUserParam.h"
#import "QWUserResult.h"

#import "QWHttpTool.h"

#import "QWAccountTool.h"
#import "QWAccount.h"
#import "MJExtension.h"
#import "QWUser.h"

@implementation QWUserTool

+ (void)unreadWithSuccess:(void (^)(QWUserResult *))success failure:(void (^)(NSError *))failure
{
    
    // 创建参数模型
    QWUserParam *param = [QWUserParam param];
    param.uid = [QWAccountTool account].uid;
    
    [QWHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
        
        // 字典转换模型
        QWUserResult *result = [QWUserResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
        
    }];
}

+ (void)userInfoWithSuccess:(void (^)(QWUser *))success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    QWUserParam *param = [QWUserParam param];
    param.uid = [QWAccountTool account].uid;
    
    [QWHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
        
        // 用户字典转换用户模型
        QWUser *user = [QWUser objectWithKeyValues:responseObject];
        
        if (success) {
            success(user);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
}

@end
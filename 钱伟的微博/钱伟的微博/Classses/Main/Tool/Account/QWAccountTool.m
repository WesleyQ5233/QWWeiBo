//
//  QWAccountTool.m
//  钱伟的微博
//
//  Created by mac on 16/1/9.
//  Copyright © 2016年 mac. All rights reserved.
//



#import "QWAccountTool.h"
#import "QWAccount.h"

#import "QWHttpTool.h"
#import "QWAccountParam.h"

#import "MJExtension.h"


#define QWAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define QWClient_id        @"808916944"
#define QWRedirect_uri     @"http://www.baidu.com"
#define QWClient_secret    @"9a65e14d9c0c492064b47272992f3d03"


// 账号的存储路径
#define QWAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation QWAccountTool

// 类方法一般用静态变量代替成员属性
static QWAccount *_account;
+ (void)saveAccount:(QWAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:QWAccountFileName];
}

+ (QWAccount *)account
{
    if (_account == nil) {
        
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:QWAccountFileName];
        
        // 判断下账号是否过期，如果过期直接返回Nil
        // 2015 < 2017
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) { // 过期
            return nil;
        }
        
    }
    
    
    return _account;
}

+ (void)accountWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure
{
    
    // 创建参数模型
    QWAccountParam *param = [[QWAccountParam alloc] init];
    param.client_id = QWClient_id;
    param.client_secret = QWClient_secret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = QWRedirect_uri;
    
    [QWHttpTool Post:@"https://api.weibo.com/oauth2/access_token" parameters:param.keyValues success:^(id responseObject) {
        // 字典转模型
        QWAccount *account = [QWAccount accountWithDict:responseObject];
        
        // 保存账号信息:
        // 数据存储一般我们开发中会搞一个业务类，专门处理数据的存储
        // 以后我不想归档，用数据库，直接改业务类
        [QWAccountTool saveAccount:account];
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end

//
//  QWComposeTool.m
//  钱伟的微博
//
//  Created by mac on 16/1/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "QWComposeTool.h"
#import "QWHttpTool.h"
#import "QWComposeParam.h"
#import "MJExtension.h"

#import "QWUploadParam.h"


@implementation QWComposeTool
+ (void)composeWithStatus:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure
{
    
    QWComposeParam *param = [QWComposeParam param];
    param.status = status;
    
    [QWHttpTool Post:@"https://api.weibo.com/2/statuses/update.json" parameters:param.keyValues success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void (^)())success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    QWComposeParam *param = [QWComposeParam param];
    param.status = status;
    
    // 创建上传的模型
    QWUploadParam *uploadP = [[QWUploadParam alloc] init];
    uploadP.data = UIImagePNGRepresentation(image);
    uploadP.name = @"pic";
    uploadP.fileName = @"image.png";
    uploadP.mimeType = @"image/png";
    
    // 注意：以后如果一个方法，要传很多参数，就把参数包装成一个模型
    [QWHttpTool Upload:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.keyValues uploadParam:uploadP success:^(id responseObject) {
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
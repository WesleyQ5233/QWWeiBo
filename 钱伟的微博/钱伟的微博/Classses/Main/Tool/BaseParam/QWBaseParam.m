//
//  QWBaseParam.m
//  钱伟的微博
//
//  Created by mac on 16/1/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "QWBaseParam.h"
#import "QWAccountTool.h"
#import "QWAccount.h"

@implementation QWBaseParam

+ (instancetype)param
{
    QWBaseParam *param = [[self alloc] init];
    
    param.access_token = [QWAccountTool account].access_token;
    
    return param;
}

@end
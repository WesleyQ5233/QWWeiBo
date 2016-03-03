//
//  QWStatusResult.m
//  钱伟的微博
//
//  Created by mac on 16/1/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "QWStatusResult.h"
#import "QWStatus.h"



@implementation QWStatusResult

// 告诉MJ框架，数组里的字典转换成哪个模型
+ (NSDictionary *)objectClassInArray
{
    return @{@"statuses":[QWStatus class]};
}

@end

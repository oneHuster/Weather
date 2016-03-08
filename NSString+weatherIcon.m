//
//  NSString+weatherIcon.m
//  html解析
//
//  Created by 邹应天 on 15/8/24.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import "NSString+weatherIcon.h"
#import "FontHeader.h"
@implementation NSString (weatherIcon)

-(NSString*)transToIcon:(NSString *)type{
    if([type isEqualToString:@"晴"]){type=kSun;}
    if ([type isEqualToString:@"多云"]) {type=kCloudSun;}
    if ([type isEqualToString:@"雷阵雨"]) {type=kLightningRain ;}
    if ([type isEqualToString:@"小雨"]||[type isEqualToString:@"阵雨"]) {type=DrizzleAlt;}
    if ([type isEqualToString:@"阴"]) {type=kCloud;}
    if ([type isEqualToString:@"中雨"]) {type=kDrizzle;}
    return type;
}
-(NSString*)transToName:(NSString *)date{
    if ([date isEqualToString:@"日星期五"]) {date=@"Fri";}
    if ([date isEqualToString:@"日星期一"]) {date=@"Mon";}
    if ([date isEqualToString:@"日星期二"]) {date=@"Tue";}
    if ([date isEqualToString:@"日星期三"]) {date=@"Wed";}
    if ([date isEqualToString:@"日星期四"]) {date=@"Thu";}
    if ([date isEqualToString:@"日星期六"]) {date=@"Sat";}
    if ([date isEqualToString:@"日星期天"]) {date=@"Sun";}
    return date;
}
@end

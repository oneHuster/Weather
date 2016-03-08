//
//  ForeDataLoad.m
//  html解析
//
//  Created by 邹应天 on 15/8/24.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import "ForeDataLoad.h"
#import "weatherdata.h"
#import "FMDB.h"
#import <sqlite3.h>
@implementation ForeDataLoad

-(id)init{
    weatherdata *weather=[[weatherdata alloc]init];
    [weather StartRequest];
    if (!weather.offline) {
       
        self.todayWeather=weather.forecastArray[0];
        self.forelist1=weather.forecastArray[1];
        self.forelist2=weather.forecastArray[2];
        self.forelist3=weather.forecastArray[3];
        self.forelist4=weather.forecastArray[4];
        self.forelist5=weather.forecastArray[5];
//        for (int i=1; i<5; i++) {
//            [self writeToSqlite:weather.forecastArray[i]];
//        }
        
        return self;
    }
    else{
        //NSLog(@"foredataload is nil");
        return nil;
    }
}
-(void)writeToSqlite:(NSDictionary*)weatherData{
    //在NSUserDomainMask代表的（～）区域内寻找文件夹NSDocumentDirectory。
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //Documents目录 索引值为0
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
    //将数据库内容读取到fmdatabase对象中。其实例变量包含了sqlite实例。
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
    if (![db open]) {
        NSLog(@"Could not open db.");
        
    }
    NSLog(@"%@",dbPath);
    //创建数据库表
    [db executeUpdate:@"CREATE TABLE WeatherList (date text,high integer,low integer,type text)"];
    //插入数据
    [db executeUpdate:@"INSERT INTO WeatherList (date, high, low, type) VALUES (?,?,?,?)",[weatherData objectForKey:@"date"],[weatherData objectForKey:@"high"],[weatherData objectForKey:@"low"],[weatherData objectForKey:@"type"]];
   
//    FMResultSet *rs = [db executeQuery:@"SELECT  date,high,low,type WeatherList"];
//    while ([rs next]) {
//        NSString *name = [rs stringForColumn:@"high"];
//        NSLog(@"%@",name);
//    }
//    [db close];
}
@end

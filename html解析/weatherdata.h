//
//  weatherdata.h
//  weather
//
//  Created by 邹应天 on 15/8/8.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface weatherdata : NSObject<NSXMLParserDelegate>
-(void)StartRequest;
@property(nonatomic,strong)NSMutableString *element;
@property(nonatomic,strong)NSMutableDictionary *information;
@property(nonatomic,strong)NSMutableDictionary *foreinfo;
@property(nonatomic,strong)NSMutableArray *forecastArray;
@property BOOL day;
@property BOOL forecast;

@property BOOL offline;
@end

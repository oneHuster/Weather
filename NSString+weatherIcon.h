//
//  NSString+weatherIcon.h
//  html解析
//
//  Created by 邹应天 on 15/8/24.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (weatherIcon)

-(NSString*)transToIcon:(NSString*)type;
-(NSString *)transToName:(NSString*)date;
@end

//
//  drawLine.m
//  html解析
//
//  Created by 邹应天 on 15/9/16.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import "drawLine.h"

@implementation drawLine
-(void)drawLineX:(NSNumber *)x1 drawLineY:(NSNumber *)y1 ToLineX:(NSNumber *)x2 ToLineY:(NSNumber *)y2{
    

    self.lineWidth=1.f;
    self.strokeColor= [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.6].CGColor;
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, [x1 floatValue],[y1 floatValue]);
    CGPathAddLineToPoint(pathRef, NULL, [x2 floatValue], [y2 floatValue]);
    self.path=pathRef;
    self.strokeStart = 0;
    self.strokeEnd=0.1;
}
@end

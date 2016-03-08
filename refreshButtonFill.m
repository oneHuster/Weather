//
//  refreshButtonFill.m
//  html解析
//
//  Created by 邹应天 on 15/9/25.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import "refreshButtonFill.h"

@implementation refreshButtonFill
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    return  self;
}

-(void)drawRect:(CGRect)rect{
    //[super drawRect:rect];
    self.backgroundColor=[UIColor blackColor];
    //uiview 自生成一个context并存放在栈顶
    CGContextRef context=UIGraphicsGetCurrentContext();
    //CGContextSaveGState(context);

    NSLog(@"%@",context);
//    CGPoint aPoints[2];//坐标点
//    aPoints[0] =CGPointMake(0, 400);//坐标1
//    aPoints[1] =CGPointMake(0, 400+60);//坐标2
//    CGContextSetLineWidth(context, 4);
//    CGContextAddLines(context, aPoints, 2);//添加线
//    CGContextSetRGBFillColor(context,0,0,0,1);
//    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
//    CGContextAddEllipseInRect(context, CGRectMake(0,0,100,100));
//
//    CGContextStrokePath(context);
//    CGContextRestoreGState(context);
}
@end

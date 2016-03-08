//
//  CAShapeLayer+Init.m
//  html解析
//
//  Created by 邹应天 on 15/9/16.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import "CAShapeLayer+Init.h"

@implementation CAShapeLayer (Init)
-(void)initlize{
    self.bounds=CGRectMake(0, 0, 150,150);
    self.position=CGPointMake(110, 425);
    self.fillColor=[UIColor clearColor].CGColor;
    self.lineWidth=1.f;
    self.strokeColor=[UIColor grayColor].CGColor;
    UIBezierPath *circlePath=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 115, 115)];
    self.path=circlePath.CGPath;
    self.strokeStart = 0.125;
    self.strokeEnd = 0.175;
}
-(void)initLize{
    self.bounds=CGRectMake(0, 0, 150,150);
    self.position=CGPointMake(110, 425);
    self.fillColor=[UIColor clearColor].CGColor;
    self.lineWidth=2.f;
    self.strokeColor=[UIColor blackColor].CGColor;
    UIBezierPath *circlePath=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 115, 115)];
    self.path=circlePath.CGPath;
    self.strokeStart = 0.125;
    self.strokeEnd = 0.175;
}
@end

//
//  SunriseLayer.m
//  html解析
//
//  Created by 邹应天 on 15/9/16.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import "SunriseLayer.h"

@implementation SunriseLayer
-(void)sunriseAnimation{
    self.frame=CGRectMake(200, 500, 100, 100);
    //self.position=CGPointMake(200, 500);
    self.masksToBounds=YES;
    CALayer *sunRise=[[CALayer alloc]init];
    sunRise.bounds=CGRectMake(0, 0, 50, 50);
    sunRise.position=CGPointMake(50,70);
    sunRise.contents=(id)[UIImage imageNamed:@"sun.png"].CGImage;
    sunRise.masksToBounds=YES;
    [self addSublayer:sunRise];
    
    CABasicAnimation *sunriseAnimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    sunriseAnimation.fromValue=[NSNumber numberWithFloat:60];
    sunriseAnimation.toValue=[NSNumber numberWithFloat:0];
    sunriseAnimation.duration=3;
    [sunRise addAnimation:sunriseAnimation forKey:@"sunrise"];
 
    
    
//    CAShapeLayer *lineRise=[CAShapeLayer layer];
//    lineRise.lineWidth=1.f;
//    lineRise.strokeColor= [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.8].CGColor;
//    CGMutablePathRef pathRef1 = CGPathCreateMutable();
//    CGPathMoveToPoint(pathRef1, NULL, 210.f,600.f);
//    CGPathAddLineToPoint(pathRef1, NULL, 290,600);
//    lineRise.path=pathRef1;
//    lineRise.strokeStart = 0;
//    lineRise.strokeEnd=1;
    //[self.scrollView.layer addSublayer:lineRise];
}
-(void)moonriseAnimation{
    self.frame=CGRectMake(200,600, 100, 100);
    self.masksToBounds=YES;
    CALayer *moonrise=[[CALayer alloc]init];
    moonrise.bounds=CGRectMake(0, 0, 50, 50);
    moonrise.position=CGPointMake(50, -30);
    moonrise.contents=(id)[UIImage imageNamed:@"moon.png"].CGImage;
    [self addSublayer:moonrise];
    
    CABasicAnimation *moonriseAnimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    moonriseAnimation.fromValue=[NSNumber numberWithFloat:60];
    moonriseAnimation.toValue=[NSNumber numberWithFloat:0];
    moonriseAnimation.duration=3;
    [moonrise addAnimation:moonriseAnimation forKey:@"moonrise"];
}
@end

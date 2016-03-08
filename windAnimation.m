//
//  windAnimation.m
//  html解析
//
//  Created by 邹应天 on 15/9/15.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import "windAnimation.h"

@implementation windAnimation
-(void)rotationAnimation:(NSNumber *)angle{
    self.bounds=CGRectMake(0, 0, 6, 30);
    self.position=CGPointMake(250, 380);
    self.anchorPoint=CGPointMake(0.5, 1.2);
    self.masksToBounds=YES;
    self.opacity=0;
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //2.设置动画属性初始值、结束值
    basicAnimation.fromValue=angle;
    NSNumber *toAngle=[NSNumber numberWithFloat:[angle floatValue]+M_PI*2];
    basicAnimation.toValue=toAngle;
    //设置其他动画属性
    basicAnimation.duration=6.0;
    basicAnimation.repeatCount=HUGE_VALF;//设置无限循环
    basicAnimation.removedOnCompletion=NO;
    //4.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [self addAnimation:basicAnimation forKey:@"Wind_Rotation"];
}

@end

//
//  drawLine.h
//  html解析
//
//  Created by 邹应天 on 15/9/16.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface drawLine : CAShapeLayer
-(void)drawLineX:(NSNumber*)x1   drawLineY:(NSNumber*)y1 ToLineX:(NSNumber*)x2
         ToLineY:(NSNumber*)y2;
@end

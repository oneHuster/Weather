
//
//  LabelGlow.m
//  study
//
//  Created by 邹应天 on 15/8/31.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import "LabelGlow.h"

@implementation LabelGlow

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        [self initialize];
        
    }
    return self;
}
- (void)setGlowColor:(UIColor *)newGlowColor
{
    if (newGlowColor != glowColor) {
        glowColor = newGlowColor;
        glowColorRef = CGColorCreate(colorSpaceRef, CGColorGetComponents(glowColor.CGColor));
    }
}
- (void)initialize {
    colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    // glowColorRef = CGColorCreate(colorSpaceRef, CGColorGetComponents(glowColor.CGColor));
    self.glowOffset = CGSizeMake(0.0, 0.0);
    self.glowAmount = 0.0;
    self.glowColor = [UIColor clearColor];
}
- (void)drawTextInRect:(CGRect)rect {
    /*
     CGContextSaveGState函数的作用是将当前图形状态推入堆栈。之后，您对图形状态所做的修改会影响随后的描画操作，但不影响存储在堆栈中的拷贝。在修改完成后，您可以通过CGContextRestoreGState函数把堆栈顶部的状态弹出，返回到之前的图形状态。这种推入和弹出的方式是回到之前图形状态的快速方法，避免逐个撤消所有的状态修改；这也是将某些状态（比如裁剪路径）恢复到原有设置的唯一方式。
     */
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetShadow(context, self.glowOffset, self.glowAmount);
    CGContextSetShadowWithColor(context, self.glowOffset, self.glowAmount, glowColorRef);
    [super drawTextInRect:rect];
    CGContextRestoreGState(context);
}


@end

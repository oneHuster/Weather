//
//  LabelGlow.h
//  study
//
//  Created by 邹应天 on 15/8/31.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelGlow : UILabel{
    UIColor *glowColor;
    CGColorRef glowColorRef;
    CGColorSpaceRef colorSpaceRef;
}

@property (nonatomic, assign) CGSize glowOffset;
@property (nonatomic, assign) CGFloat glowAmount;
@property (nonatomic, retain) UIColor *glowColor;

@end

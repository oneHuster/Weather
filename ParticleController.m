//
//  ParticleController.m
//  study
//
//  Created by 邹应天 on 15/8/30.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import "ParticleController.h"
#import <QuartzCore/QuartzCore.h>
@interface ParticleController (){
    CAEmitterLayer *fireEmitter;
}
//-(void)labelglow:(NSTimer *)timer;
@end

@implementation ParticleController

- (void)viewDidLoad {
    [super viewDidLoad];
    //把背景色设置成黑色
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"texture.jpg"]];
    //CAEmitterLayer 提供的是一个Core animation的粒子发射系统，例子用CAEmiterrCell来初始化。
    //self.view.alpha=0.7;
    //创建一个发射器
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    snowEmitter.emitterPosition = CGPointMake(self.view.bounds.size.width / 2.0, -30);
    snowEmitter.emitterSize		= CGSizeMake(self.view.bounds.size.width * 2.0, 0.0);;
    // Spawn points for the flakes are within on the outline of the line
    snowEmitter.emitterMode		= kCAEmitterLayerOutline;
    snowEmitter.emitterShape	= kCAEmitterLayerLine;
    
    // Configure the snowflake emitter cell
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    
    snowflake.birthRate		= 20.0;
    snowflake.lifetime		= 100.0;
    
    snowflake.velocity		= -10;				// falling down slowly
    snowflake.velocityRange = 10;
    snowflake.yAcceleration = 4;
    snowflake.emissionRange = 0.5 * M_PI;		// some variation in angle
    snowflake.spinRange		= 0.5*M_PI;		// slow spin
    snowflake.alphaRange    = 1;
    snowflake.alphaSpeed    =-0.06;
    snowflake.contents		= (id) [[UIImage imageNamed:@"snow.png"] CGImage];
    // Make the flakes seem inset in the background
    //snowEmitter.shadowOpacity = 1.0;
    snowEmitter.shadowRadius  = 0.0;
    snowEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
    snowEmitter.shadowColor   = [[UIColor whiteColor] CGColor];
    
    // Add everything to our backing layer below the UIContol defined in the storyboard
    snowEmitter.emitterCells = [NSArray arrayWithObject:snowflake];
    
    //插入视图66的。。
    [self.view.layer insertSublayer:snowEmitter atIndex:0];
    [self setLabel];
    [self.view addSubview:self.update];

   

}
-(void)setLabel{
    UIColor *colorOne = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.6];
    UIColor *colorTwo = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
    //Create the gradient and add it to our view's root layer
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height);
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil]];
    self.update=[[LabelGlow alloc]init];
    self.update.text=@"Updating..";
    self.update.frame=CGRectMake(0, 400, self.view.bounds.size.width, 200);
    self.update.textAlignment=NSTextAlignmentCenter;
    [self.update setFont:[UIFont fontWithName:@"Lato-Light" size:30]];
    self.update.textColor=[UIColor clearColor];
    self.update.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    self.update.glowColor=self.update.textColor;
    self.update.glowOffset = CGSizeMake(0.0, 0.0);
    self.update.glowAmount=10.0;
    self.update.transform=CGAffineTransformMakeTranslation(-30, 0);

    [UIView animateWithDuration:3 animations:^{
        self.update.transform=CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        NSLog(@"transform done");
    }];
    //这里多创建的timer却可以使用。
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(labelglow) userInfo:nil repeats:YES];
    }
-(void)labelglow{
        if (self.update.glowAmount==30) {
            self.update.glowAmount=0;
    }
        self.update.glowAmount+=1;
        [self.update setNeedsDisplay];
}
@end

//
//  pullotionLayer.m
//  html解析
//
//  Created by 邹应天 on 15/10/2.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import "pullotionLayer.h"

@implementation pullotionLayer
-(void)createPM{
    self.bounds=CGRectMake(0, 0, 150, 150);
    CAEmitterLayer *pmEmitter = [CAEmitterLayer layer];
    pmEmitter.emitterPosition = CGPointMake(self.bounds.size.width / 2.0, -30);
    pmEmitter.emitterSize		= CGSizeMake(self.bounds.size.width * 2.0, 0.0);;
    // Spawn points for the flakes are within on the outline of the line
    pmEmitter.emitterMode	  = kCAEmitterLayerOutline;
    pmEmitter.emitterShape	  = kCAEmitterLayerLine;
    
    // Configure the snowflake emitter cell
    CAEmitterCell *pmflake  = [CAEmitterCell emitterCell];
    
    pmflake.birthRate		= 1.0;
    pmflake.lifetime		= 100;
    
    pmflake.velocity		= 0;//-10;				// falling down slowly
    pmflake.velocityRange   = 10;
    pmflake.yAcceleration   = 0;
    pmflake.emissionRange   = 0.5 * M_PI;		// some variation in angle
    pmflake.spinRange		= 0.5*M_PI;		// slow spin
    pmflake.alphaRange      = 1;
    pmflake.alphaSpeed      = -0.06;
 //   pmflake.contents        = cgc
   // pmflake.contents		= (id) [[UIImage imageNamed:@"snow.png"] CGImage];
    // Make the flakes seem inset in the background
    //snowEmitter.shadowOpacity = 1.0;
    pmEmitter.shadowRadius  = 0.0;
    pmEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
    //pmEmitter.shadowColor   = [[UIColor whiteColor] CGColor];
    pmEmitter.emitterCells = [NSArray arrayWithObject:pmflake];

}
@end

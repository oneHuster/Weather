//
//  ParticleController.h
//  study
//
//  Created by 邹应天 on 15/8/30.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LabelGlow.h"
@interface ParticleController : UIViewController
@property(nonatomic,strong)LabelGlow *update;
-(void)setLabel;
@end

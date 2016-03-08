//
//  ViewController.m
//  html解析
//
//  Created by 邹应天 on 15/8/9.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import "ViewController.h"
#import "WeatherView.h"
#import "ParticleController.h"
#import "failView.h"
@interface ViewController (){
    WeatherView *secondView;
    failView *failview;
    ParticleController *firstView;
    UINavigationController *nav;
}

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    firstView =[[ParticleController alloc]init];
    dispatch_queue_t aHQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(aHQueue, ^{
        secondView=[[WeatherView alloc]init];
        failview=[[failView alloc]init];
        [secondView addObserver:self forKeyPath:@"offline" options:NSKeyValueObservingOptionNew context:NULL];
        [failview addObserver:self forKeyPath:@"refresh" options:NSKeyValueObservingOptionNew context:NULL];
    });
     nav=[[UINavigationController alloc]init];
    [nav setNavigationBarHidden:YES animated:YES];
    [nav pushViewController:secondView animated:YES];
    [nav pushViewController:failview animated:YES];
    [self addChildViewController:firstView];
    [self addChildViewController:nav];
    [self.view insertSubview:firstView.view atIndex:0];
    
        [self.view insertSubview:nav.view atIndex:0];
    
    [UIView animateWithDuration:1.0 delay:2 options:UIViewAnimationOptionTransitionNone animations:^{
        firstView.view.alpha=0;
    } completion:^(BOOL finished) {
        [firstView.view removeFromSuperview];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (secondView.offline) {
                [self failToNetworlk] ;
            }
            else if(!secondView.offline){
                [self refreshToNetwork];
            }
        });
    }];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"refresh"]) {
        NSLog(@"%@",change);
        dispatch_async(        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [secondView loadData];
         });
        firstView =[[ParticleController alloc]init];
        [self.view addSubview:firstView.view];
        [UIView animateWithDuration:1.0 delay:4 options:UIViewAnimationOptionTransitionNone animations:^{
            firstView.view.alpha=0;
        } completion:^(BOOL finished) {
            [firstView.view removeFromSuperview];
            dispatch_async(dispatch_get_main_queue(), ^{
                 if (secondView.offline) {
                    [self failToNetworlk] ;
                 }
                else if(!secondView.offline){
                     [self refreshToNetwork];
                }
            });

        }];
    }
  
    
}

-(void)refreshToNetwork{
    [nav popViewControllerAnimated:NO];
    [secondView ParternTransform];
    [secondView setTimer];
    [secondView rotationAnimation];
    [secondView shapeLayer];
    [secondView drawline];
    [secondView drawSunset];
    [secondView shapehumidity];
    [secondView drawPM];
    
}
-(void)failToNetworlk{
    [failview failAnimation];
    [failview initializeBanner];
    [failview initializeButton];
}
@end

//
//  Transiton.m
//  study
//
//  Created by 邹应天 on 15/8/23.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import "Transiton.h"
#import <Foundation/Foundation.h>
@implementation Transiton
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

/**
 *  在这里设置转场动画
 
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // 可以看做为前往的页面
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 可以看做为来自那一页
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
     toViewController.view.transform = CGAffineTransformMakeTranslation(0, 500);
    // 添加toView到容器上
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.alpha = 0.5;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toViewController.view.transform = CGAffineTransformMakeTranslation(0, 0);
        toViewController.navigationController.view.transform=CGAffineTransformMakeTranslation(0, 0);
        toViewController.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        // 别忘了在过渡结束时调用 completeTransition: 这个方法
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
        
}

@end

//
//  TransitionBack.m
//  html解析
//
//  Created by 邹应天 on 15/9/5.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import "TransitionBack.h"
#import <Foundation/Foundation.h>
@interface TransitionBack()
@property (nonatomic, strong) id <UIViewControllerContextTransitioning> transitionContext;
@end
@implementation TransitionBack
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
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toViewController.view];
    CATransition *tr = [CATransition animation];
    tr.type = kCATransitionReveal ;
    tr.subtype =  kCATransitionFromBottom;
    tr.duration = [self transitionDuration:transitionContext];
    tr.removedOnCompletion = NO;
    tr.fillMode = kCAFillModeForwards;
    tr.delegate = self;
    [fromViewController.view removeFromSuperview];
    [containerView.layer addAnimation:tr forKey:nil];
}
- (void)animationDidStop:(CATransition *)anim finished:(BOOL)flag {
    [_transitionContext completeTransition:![_transitionContext transitionWasCancelled]];
}

@end

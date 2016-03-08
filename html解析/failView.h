//
//  failView.h
//  html解析
//
//  Created by 邹应天 on 15/9/22.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//
#import <UIKit/UIKit.h>
#include <iAd/iAd.h>
@interface failView : UIViewController<ADBannerViewDelegate,UIGestureRecognizerDelegate>{
    ADBannerView *bannerview;
    
}
@property BOOL refresh;
-(void)failAnimation;
- (void)initializeBanner ;
-(void)initializeButton;
@end

//
//  failView.m
//  html解析
//
//  Created by 邹应天 on 15/9/22.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import "failView.h"
#import "FontHeader.h"
#import "drawLine.h"
#import "refreshButtonFill.h"
@interface failView()

@property UILabel *label;
@property drawLine *line1;
@property drawLine *line2;

@property drawLine *line3;

@property drawLine *line4;

@property BOOL isPressed;
@property refreshButtonFill *buttonFill;
@end
@implementation failView
-(void)viewDidLoad{
    self.view.backgroundColor=[UIColor whiteColor];
    self.label=[[UILabel alloc]init];
    self.label.frame=CGRectMake(self.view.bounds.size.width/2-100, self.view.bounds.size.height/2-200, 200, 150);
    [self.label setFont:[UIFont fontWithName:KFontName size:100]];
    [self.label setTextAlignment:NSTextAlignmentCenter];
    [self.label setText:kCloudMoon];
    [self.view addSubview:self.label];
    
    
}
-(void)failAnimation{
    self.label.transform=CGAffineTransformMakeTranslation(0, 0);
    [UIView animateWithDuration:1.5 animations:^{
        self.label.transform=CGAffineTransformMakeTranslation(0, 50);
    } completion:^(BOOL finished) {
        
    }];
}


- (void)initializeBanner {
    
    bannerview = [[ADBannerView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 50.0)];
    bannerview.userInteractionEnabled = NO;
    bannerview.delegate=self;
    bannerview.backgroundColor=[UIColor grayColor];
    UILabel *netFailed=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    netFailed.text=@"network is disconnected";
    netFailed.textColor=[UIColor redColor];
    netFailed.textAlignment=NSTextAlignmentCenter;
    //[bannerview addSubview:netFailed];
    [self.view addSubview:bannerview];
    
}
-(void)initializeButton{
    self.line1=[[drawLine alloc]init];
    self.line2=[[drawLine alloc]init];
    self.line3=[[drawLine alloc]init];
    self.line4=[[drawLine alloc]init];
    float baseX=70;
    float baseY=400;
    [self.line1 drawLineX:[NSNumber numberWithFloat:baseX] drawLineY:[NSNumber numberWithFloat:baseY] ToLineX:[NSNumber numberWithFloat:baseX+250] ToLineY:[NSNumber numberWithFloat:baseY]];
    [self.line2 drawLineX:[NSNumber numberWithFloat:baseX] drawLineY:[NSNumber numberWithFloat:baseY] ToLineX:[NSNumber numberWithFloat:baseX] ToLineY:[NSNumber numberWithFloat:baseY+60]];
    [self.line3 drawLineX:[NSNumber numberWithFloat:baseX+250] drawLineY:[NSNumber numberWithFloat:baseY+60] ToLineX:[NSNumber numberWithFloat:baseX] ToLineY:[NSNumber numberWithFloat:baseY+60]];
    [self.line4 drawLineX:[NSNumber numberWithFloat:baseX+250] drawLineY:[NSNumber numberWithFloat:baseY+60] ToLineX:[NSNumber numberWithFloat:baseX+250] ToLineY:[NSNumber numberWithFloat:baseY]];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(drawline:) userInfo:nil repeats:YES];
    [self.view.layer addSublayer:self.line1];
    [self.view.layer addSublayer:self.line2];
    [self.view.layer addSublayer:self.line3];
    [self.view.layer addSublayer:self.line4];
    
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(baseX, baseY, 250, 60)];
    [butt setTitle:@"Long Press To refresh"  forState:UIControlStateNormal];
    [butt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //长按手势不好用。
    //butt.backgroundColor=[UIColor greenColor];
//    UILongPressGestureRecognizer *longpress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressBut)];
//    longpress.minimumPressDuration=2;
//    longpress.delegate=self;
    //self.isPressed=[self gestureRecognizer:longpress shouldReceiveTouch:UITouchPhaseBegan];
//    [butt addGestureRecognizer:longpress];
    [butt addTarget:self action:@selector(longPressBut) forControlEvents:UIControlEventTouchDown];
    [butt addTarget:self action:@selector(cancellLongPress) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.buttonFill=[[refreshButtonFill alloc]init];
    //[self.buttonFill drawRect:CGRectMake(100, 100, 250, 60)];
    [self.buttonFill setNeedsDisplay];
    [self.view addSubview:self.buttonFill];
    [self.view addSubview: butt];
    

}
-(void)drawline:(NSTimer *)timer{
   
    if (self.isPressed&&self.line1.strokeEnd<1.2) {
        self.line1.strokeEnd+=0.1;
        self.line2.strokeEnd+=0.1;
        self.line3.strokeEnd+=0.1;
        self.line4.strokeEnd+=0.1;
        NSLog(@"%f",self.line1.strokeEnd);
    }
    if (self.line1.strokeEnd==1.2) {
     
        self.refresh=YES;
        
        self.line1.strokeEnd+=0.1;
    }
    if (!self.isPressed&&self.line1.strokeEnd>0.2&&self.line1.strokeEnd<1) {
        self.line1.strokeEnd-=0.1;
        self.line2.strokeEnd-=0.1;
        self.line3.strokeEnd-=0.1;
        self.line4.strokeEnd-=0.1;
        
    }


}
#pragma mark  长按手势事件处理
-(void)longPressBut{
    self.isPressed=YES;
}
-(void)cancellLongPress{
    self.isPressed=NO;
}
@end

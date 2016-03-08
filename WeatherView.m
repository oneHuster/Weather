//
//  WeatherView.m
//  html解析
//
//  Created by 邹应天 on 15/8/9.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import "WeatherView.h"
//#import "weatherdata.h"
#import "FontHeader.h"
#import "ForeDataLoad.h"
#import "ForecastList.h"
#import "NSString+weatherIcon.h"
#import "Transiton.h"
#import "ParticleController.h"
#import "windAnimation.h"
#import "SunriseLayer.h"
#import "drawLine.h"
#import "CAShapeLayer+Init.h"
#import "pullotionLayer.h"
//@class  pullotionLayer;
#import <math.h>
@interface WeatherView (){
    int wendu;
    NSString *tempstr2;
    int t;
    ForeDataLoad *foreDataLoad;
    float width;
    float height;
}
-(void)draw;

@property(nonatomic,strong)windAnimation *Wind1;
@property(nonatomic,strong)windAnimation *Wind2;
@property(nonatomic,strong)windAnimation *Wind3;
@property(nonatomic,strong)CALayer *center;
@property(nonatomic,strong)CALayer *pillar;
@property SunriseLayer *sunRise;
@property SunriseLayer *moonRise;
@property(nonatomic,strong)CAShapeLayer *shapePillar;
@property(nonatomic,strong)CAShapeLayer *humidity;
@property(nonatomic,strong)CAShapeLayer *humidityReal;
@property(nonatomic,strong)CALayer *weatherPartern;


@property drawLine *line1;
@property drawLine *line2;
@property drawLine *line3;
@property drawLine *line4;

@property Transiton *Animator;
@property ForecastList *forelist;
@property ParticleController *maskUpdate;

@property pullotionLayer *pollotion;
@end

@implementation WeatherView
- (void)viewDidLoad {
    [super viewDidLoad];
    width=self.view.bounds.size.width;
    height=self.view.bounds.size.height;
    self.navigationController.delegate=self;
    self.forelist=[[ForecastList alloc]init];
    self.Animator = [[Transiton alloc]init];
    self.scrollView.delegate=self;
    self.scrollView.scrollEnabled=YES;
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.contentSize=CGSizeMake(375, 668);
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    //self.scrollView.center=self.view.center;
    [self.view addSubview:self.scrollView];
    [self loadData];
    self.Wind1=[[windAnimation alloc]init];
    self.Wind2=[[windAnimation alloc]init];
    self.Wind3=[[windAnimation alloc]init];
    [self draw];

}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"%f  %f  %f",self.view.bounds.size.height,self.scrollView.contentOffset.y,self.scrollView.contentSize.height);
}
-(void)setTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                      target:self
                                                    selector:@selector(drawlineAnimation:)
                                                    userInfo:nil
                                                     repeats:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<=-60) {
        self.refresh=YES;
    }
    if (scrollView.contentOffset.y>100) {
        self.pullToMore=YES;
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{   if(self.refresh){
    self.maskUpdate=[[ParticleController alloc]init];
    [self.view addSubview:self.maskUpdate.view];
    self.maskUpdate.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    self.maskUpdate.view.alpha=0;
    //self.pattern.transform=CGAffineTransformMakeTranslation(0, 0);
    [UIView animateWithDuration:1 animations:^{
        self.maskUpdate.view.alpha=1;
        //self.pattern.transform=CGAffineTransformMakeTranslation(0, 20);
        self.pattern.alpha=0;
        self.humidness.alpha=0;
    } completion:^(BOOL finished) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self loadData];
        });
    
    }];
}
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{   if(self.refresh){
    
    self.humidness.transform=CGAffineTransformScale(self.humidness.transform, 1.25, 1.25);
    
    [self.view addSubview:self.maskUpdate.view];
    //self.city.transform=CGAffineTransformMakeTranslation(20, 0);

    [UIView animateWithDuration:2 delay:1.5 options:UIViewAnimationOptionTransitionNone animations:^{
        self.maskUpdate.view.alpha=0;
        self.city.transform=CGAffineTransformMakeTranslation(0, 0);
        self.city.alpha=0;
        self.weather.transform=CGAffineTransformMakeTranslation(0, 0);
        self.weather.alpha=0;
        self.humidness.alpha=1;
        self.humidness.transform=CGAffineTransformScale(self.humidness.transform, 0.8 , 0.8);
        CABasicAnimation *sunDismiss=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        sunDismiss.fromValue=[NSNumber numberWithFloat:0];
        sunDismiss.toValue=[NSNumber numberWithFloat:-20];
        CABasicAnimation *sunFade=[CABasicAnimation animationWithKeyPath:@"opacity"];
        sunFade.fromValue=[NSNumber numberWithFloat:1];
        sunFade.toValue=[NSNumber numberWithFloat:0];
        //sunFade.beginTime=1;
        sunFade.duration=3.6;
        //sunDismiss.beginTime=1;
        sunDismiss.duration=3.6;
        [self.sunRise addAnimation:sunDismiss forKey:@"sunDismiss"];
        [self.sunRise addAnimation:sunFade forKey:@"sunFade"];
        
    } completion:^(BOOL finished) {
        [self.maskUpdate.view removeFromSuperview];
//        //NSLog(@"update finish");
        self.refresh=NO;
        //[self loadData];
        [self.sunRise removeFromSuperlayer];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self ParternTransform];
            [self shapehumidity];
            [self rotationAnimation];
            [self shapeLayer];
            [self drawline];
            [self drawSunset];
            
            
        });

      }];
}
    if (self.pullToMore) {
        self.scrollView.alwaysBounceHorizontal=NO;
        [self pushToForeList];
    }
}

-(void)ParternTransform{
    [self.weather setText:[foreDataLoad.forelist1 objectForKey:@"type"]];
    self.weather.alpha=1;
    [self.city setText:[foreDataLoad.todayWeather objectForKey:@"city"]];
    self.city.alpha=1;
    NSString *icon=[[NSString alloc]init];
    [self.pattern setText:[icon transToIcon:[foreDataLoad.forelist1 objectForKey:@"type"]]];
    self.pattern.transform=CGAffineTransformMakeTranslation(0, -30);
    self.pattern.alpha=0;
    self.city.transform=CGAffineTransformMakeTranslation(-90, 0);
    self.weather.transform=CGAffineTransformMakeTranslation(-80, 0);
    [UIView animateWithDuration:1.5 animations:^{
        self.pattern.transform=CGAffineTransformMakeTranslation(0, 0);
        self.city.transform=CGAffineTransformMakeTranslation(0, 0);
        self.pattern.alpha=1;
    } completion:^(BOOL finished) {
       // NSLog(@"transform done");
    }];
    [UIView animateWithDuration:1.5 delay:1 options:UIViewAnimationOptionCurveEaseOut   animations:^{
        self.weather.transform=CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        
    }];
}
//风车图层
-(void)draw{
    self.center=[[CALayer alloc]init];
    self.center.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0].CGColor;
    self.center.bounds=CGRectMake(0, 0, 5, 5);
    self.center.cornerRadius=3;
    self.center.position=CGPointMake(250, 380);
    self.center.anchorPoint=CGPointMake(0.5, 0.5);
    self.center.masksToBounds=YES;
    [self.scrollView.layer addSublayer:self.center];
}

//扇叶旋转
-(void)rotationAnimation{
    //anchorpointY=1.2;
    [self.Wind1 rotationAnimation:[NSNumber numberWithFloat:0]];
    [self.Wind2 rotationAnimation:[NSNumber numberWithFloat:M_PI*2/3]];
    [self.Wind3 rotationAnimation:[NSNumber numberWithFloat:M_PI*4/3]];
    self.Wind1.contents=(id)[UIImage imageNamed:@"WindSpeed@2x.png"].CGImage;
    self.Wind2.contents=(id)[UIImage imageNamed:@"WindSpeed@2x.png"].CGImage;
    self.Wind3.contents=(id)[UIImage imageNamed:@"WindSpeed@2x.png"].CGImage;
    //NSLog(@"%f %f",self.Wind1.position.x,self.Wind1.position.y);
    [self.scrollView.layer addSublayer:self.Wind1];
    [self.scrollView.layer addSublayer:self.Wind2];
    [self.scrollView.layer addSublayer:self.Wind3];
}
//日出日落图层。
-(void)drawSunset{
    //太阳升起
    self.sunRise =[[SunriseLayer alloc]init];
    [self.sunRise sunriseAnimation];
    [self.scrollView.layer addSublayer:self.sunRise];
    //月亮升起
    self.moonRise=[[SunriseLayer alloc]init];
    [self.moonRise moonriseAnimation];
    [self.scrollView.layer addSublayer:self.moonRise];
    CAShapeLayer *lineRise=[CAShapeLayer layer];
    lineRise.lineWidth=1.f;
    lineRise.strokeColor= [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.8].CGColor;
    CGMutablePathRef pathRef1 = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef1, NULL, 210.f, 600.f);
    CGPathAddLineToPoint(pathRef1, NULL, 290,600);
    lineRise.path=pathRef1;
    lineRise.strokeStart = 0;
    lineRise.strokeEnd=1;
    [self.scrollView.layer addSublayer:lineRise];
}
//画风车杆
-(void)shapeLayer{
    self.shapePillar = [CAShapeLayer layer];
    self.shapePillar.fillColor=[UIColor clearColor].CGColor;
    //set line width and color
    self.shapePillar.lineWidth=2.f;
    self.shapePillar.strokeColor= [UIColor blackColor].CGColor;
    // 创建一个Path句柄
    CGMutablePathRef pathRef = CGPathCreateMutable();
    // 初始化该path到一个初始点
    CGPathMoveToPoint(pathRef, NULL, 250.f, 460.f);
    CGPathAddLineToPoint(pathRef, NULL, 250.0f, 380.0f);
    self.shapePillar.path=pathRef;
    //一次划线占全路径的10%
    self.shapePillar.strokeStart = 0;
    self.shapePillar.strokeEnd=0.1;
    [self.scrollView.layer addSublayer:self.shapePillar];
    
    
    
}

-(void)drawline{
    self.line1=[drawLine layer];
    self.line2=[drawLine layer];
    self.line3=[drawLine layer];
    self.line4=[drawLine layer];
    [self.line1 drawLineX:[NSNumber numberWithFloat:0] drawLineY:[NSNumber numberWithFloat:100] ToLineX:[NSNumber numberWithFloat:width] ToLineY:[NSNumber numberWithFloat:100]];
    [self.line2 drawLineX:[NSNumber numberWithFloat:0] drawLineY:[NSNumber numberWithFloat:300] ToLineX:[NSNumber numberWithFloat:width] ToLineY:[NSNumber numberWithFloat:300]];
    [self.line3 drawLineX:[NSNumber numberWithFloat:0] drawLineY:[NSNumber numberWithFloat:500] ToLineX:[NSNumber numberWithFloat:width] ToLineY:[NSNumber numberWithFloat:500]];
    [self.line4 drawLineX:[NSNumber numberWithFloat:width/2] drawLineY:[NSNumber numberWithFloat:100] ToLineX:[NSNumber numberWithFloat:width/2] ToLineY:[NSNumber numberWithFloat:height]];
    [self.scrollView.layer addSublayer:self.line1];
    [self.scrollView.layer addSublayer:self.line2];
    [self.scrollView.layer addSublayer:self.line3];
    [self.scrollView.layer addSublayer:self.line4];

    
}
-(void)drawlineAnimation:(NSTimer *)timer{
       //设置画笔步幅，也是划线速度
    CGPoint anchorpoint=self.Wind1.anchorPoint;
    if (!self.refresh) {
        
    
     t++;
        if(self.shapePillar.strokeStart == 0){
            self.shapePillar.strokeEnd += 0.1;
        }
        if (self.humidity.strokeEnd<0.775) {
            self.humidity.strokeEnd+=0.1;
        }
    float fl=0.65*humidityValue/100+0.125;
        if (self.humidityReal.strokeEnd<fl) {
            self.humidityReal.strokeEnd+=0.1;
        }
        if (wendu<[tempstr2 intValue]) {
            if (wendu<[tempstr2 intValue]-5) {
                wendu++;
            }
            else if (t%2==0&&wendu>=[tempstr2 intValue]-5 &&wendu<[tempstr2 intValue]-2) {
                wendu++;
            }
            else if(t%4==0&&wendu>=[tempstr2 intValue]-2){
                wendu++;
            }
            NSString *a=[[NSString alloc]initWithFormat:@"%dº",wendu];
            self.temp2.alpha=1;
            [self.temp2 setText:a];
        }
    
        if (t==8) {
            t=0;
        }
        if (self.line1.strokeEnd<1) {
            self.line1.strokeEnd+=0.1;
        }
        if (self.line2.strokeEnd<1) {
            self.line2.strokeEnd+=0.1;
        }
        if (self.line3.strokeEnd<1) {
            self.line3.strokeEnd+=0.1;
        }
        if (self.line4.strokeEnd<1) {
            self.line4.strokeEnd+=0.1;
        }
        if (self.Wind1.anchorPoint.y>1) {
            anchorpoint.y-=0.01;
            self.Wind1.opacity+=0.05;
            self.Wind2.opacity+=0.05;
            self.Wind3.opacity+=0.05;
            
        }
    }
    if (self.refresh) {
        self.shapePillar.strokeEnd-=0.2;
        self.humidity.strokeEnd-=0.1;
        self.humidityReal.strokeEnd-=0.1;
        self.line1.strokeEnd-=0.1;
        self.line2.strokeEnd-=0.1;
        self.line3.strokeEnd-=0.1;
        self.line4.strokeEnd-=0.1;
        if (self.Wind1.anchorPoint.y<1.2) {
            anchorpoint.y+=0.01;
            self.Wind1.opacity-=0.05;
            self.Wind2.opacity-=0.05;
            self.Wind3.opacity-=0.05;
        }
    }
    self.Wind1.anchorPoint=anchorpoint;
    self.Wind2.anchorPoint=anchorpoint;
    self.Wind3.anchorPoint=anchorpoint;

}
//画湿度进度条
-(void)shapehumidity{
    self.humidity=[CAShapeLayer layer];
    self.humidityReal=[CAShapeLayer layer];
    [self.humidity initlize];
    [self.humidityReal initLize];
    [self.scrollView.layer addSublayer:self.humidity];
    [self.scrollView.layer addSublayer:self.humidityReal];
}

-(void)drawPM{
    self.pollotion=[[pullotionLayer alloc]init];
    self.pollotion.position=CGPointMake(100, 500);
    [self.pollotion createPM];
    [self.scrollView.layer addSublayer:self.pollotion];
}

//没有数据抽象的必要了。。设置式样。
-(void)loadData{
    [self.title_weather setFont:[UIFont  fontWithName:@"Lato-Light" size:20]];
    [self.title_temperature setFont:[UIFont  fontWithName:@"Lato-Light"size:20]];
    [self.title_humidity setFont:[UIFont  fontWithName:@"Lato-Light" size:20]];
    [self.title_windspeed setFont:[UIFont  fontWithName:@"Lato-Light"size:20]];
    [self.title_sunSet setFont:[UIFont  fontWithName:@"Lato-Light"size:20]];
    
    foreDataLoad=[[ForeDataLoad alloc]init];
    if (foreDataLoad==nil) {
        self.offline=YES;
        NSLog(@"it's nil");
    }
    else{
        self.offline=NO;
        [self.pattern setFont:[UIFont fontWithName:KFontName size:100]];
        [self.pattern setTextAlignment:NSTextAlignmentCenter];
        self.pattern.alpha=0;
        [self.weather setFont:[UIFont  fontWithName: @"TrebuchetMS-Bold" size:15]];
        self.weather.alpha=0;
        [self.city setFont:[UIFont  fontWithName: @"TrebuchetMS-Bold" size:24]];
        self.city.alpha=0;
        [self.temp2 setFont:[UIFont  fontWithName:LatoFont size:70]];
        tempstr2=[foreDataLoad.todayWeather objectForKey:@"wendu"];
        self.temp2.alpha=0;
        wendu=0;
        [self.temp2 setTextAlignment:NSTextAlignmentCenter];
        [self.temp2 setTextColor:[UIColor purpleColor]];
        
        NSString *windSpeed=[foreDataLoad.todayWeather objectForKey:@"fengxiang"];
        [self.windspeed setText:[NSString stringWithFormat:@"%@",windSpeed]];
        [self.humidness setFont:[UIFont fontWithName:@"Zapfino" size:25]];
        [self.humidness setText:[foreDataLoad.todayWeather objectForKey:@"shidu"]];
        [self.humidness setTextAlignment:NSTextAlignmentCenter];
        
        humidityValue=[[foreDataLoad.todayWeather objectForKey:@"shidu"] intValue];
        
        [self.updateTime setFont:[UIFont fontWithName:@"Lato-Thin" size:30]];
        [self.updateTime setText:[foreDataLoad.todayWeather objectForKey:@"updatetime"]];
        [self.updateTime setTextAlignment:NSTextAlignmentCenter];
        self.updateTime.textColor =[UIColor whiteColor];
        self.updateTime.backgroundColor=[UIColor redColor];
        
        [self.sunrise setFont:[UIFont fontWithName:@"Lato-Thin" size:20]];
        [self.sunrise setTextColor:[UIColor blueColor]];
        [self.sunrise setText:[foreDataLoad.todayWeather objectForKey:@"sunrise_1"]];
        [self.sunset setFont:[UIFont fontWithName:@"Lato-Thin" size:20]];
        [self.sunset setTextColor:[UIColor orangeColor]];
        [self.sunset setText:[foreDataLoad.todayWeather objectForKey:@"sunrise_2"]];
    }
    
}

-(void)pushToForeList{
    
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController pushViewController:self.forelist animated:YES];
}
#pragma mark - UINavigationControllerDelegate iOS7新增的2个方法
// 动画特效
- (id<UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    
    if (operation == UINavigationControllerOperationPush) {
        NSLog(@"touchone");
        
        return self.Animator;
    }else{
        return nil;
    }
    
}
@end

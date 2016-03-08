//
//  WeatherView.h
//  html解析
//
//  Created by 邹应天 on 15/8/9.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherView : UIViewController<UIGestureRecognizerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>{
    int humidityValue;
}
@property (strong, nonatomic) IBOutlet UILabel *pattern;
@property (strong, nonatomic) IBOutlet UILabel *city;
@property (strong, nonatomic) IBOutlet UILabel *weather;

//@property (strong, nonatomic) IBOutlet UILabel *temp1;
@property (strong, nonatomic) IBOutlet UILabel *temp2;
-(void)loadData;
-(void)initrotationAnimation;
-(void)ParternTransform;
//-(void)extendAnimation;
-(void)shapeLayer;
-(void)shapehumidity;
-(void)drawline;
-(void)pushToForeList;
-(void)rotationAnimation;
-(void)setTimer;
-(void)drawSunset;
-(void)drawPM;
@property (strong, nonatomic) IBOutlet UILabel *title_weather;
@property (strong, nonatomic) IBOutlet UILabel *title_temperature;
@property (strong, nonatomic) IBOutlet UILabel *title_humidity;
@property (strong, nonatomic) IBOutlet UILabel *title_windspeed;
@property (strong, nonatomic) IBOutlet UILabel *title_sunSet;
-(void)animation;
@property (strong, nonatomic) IBOutlet UILabel *humidness;
@property (strong, nonatomic) IBOutlet UILabel *windspeed;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *updateTime;
@property (strong, nonatomic) IBOutlet UILabel *sunrise;
@property (strong, nonatomic) IBOutlet UILabel *sunset;

@property BOOL refresh;
@property BOOL pullToMore;
@property BOOL offline;
//@property(strong,nonatomic)UINavigationController *navi;
@end

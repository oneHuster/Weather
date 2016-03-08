//
//  ForecastList.m
//  study
//
//  Created by 邹应天 on 15/8/16.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import "ForecastList.h"
#import "ForeDataLoad.h"
#import "TableViewCell.h"
#import "NSString+weatherIcon.h"
#import "TransitionBack.h"
@class ForeDataLoad;
@interface ForecastList ()
@property TransitionBack *Animator;
@end

@implementation ForecastList
-(void)viewWillAppear:(BOOL)animated{
     self.navigationController.navigationBar.frame=CGRectMake(0,0, self.view.bounds.size.width, 100);
    self.navigationController.navigationBar.alpha=0.6;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
     //整个表视图的大致 frame
    self.tableList=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    //NSLog(@"%f",self.tableList.contentOffset.y);
   
    self.tableList.delegate=self;
    self.tableList.dataSource=self;
    
    [self.tableList setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    // 设置navigationItem式样
    self.navigationItem.hidesBackButton=YES;
   
    self.navigationController.delegate=self;
    UILabel *cityTitle=[[UILabel alloc]init];
    cityTitle.textColor=[UIColor blackColor];
    cityTitle.alpha=1;
    [cityTitle setFont:[UIFont fontWithName:@"Lato-Light" size:40]];
    cityTitle.text=@"Wuhan";
    //cityTitle.textColor=[UIColor purpleColor];
    cityTitle.frame=CGRectMake(100, 30, 400, 70);
    [self.navigationController.navigationBar addSubview:cityTitle];
    [self.view addSubview:self.tableList];
    ForeDataLoad *foreDataLoad=[[ForeDataLoad alloc]init];
    self.data=foreDataLoad;
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //无可复用队列的cell可使用时需要创建新的cell！！
    if (cell==nil) {
        cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        NSString *weathertype=[[NSString alloc]init];
        NSString *weekday=[[NSString alloc]init];
        //md完全不按网上标准正则匹配的来，^[0-9]*$,[0-9]*,\s[0-9]*没一个可以用。匹配能力太屎了吧这也！！！！！
    
        //NSString *marchtemp=@"^[0-9]+&";
        NSString *marchtemp=@"^[0-9]";
        NSString *weatherText=[[NSString alloc]initWithString:[self.data.forelist2 objectForKey:@"high"]];
        NSRegularExpression *regular= [NSRegularExpression regularExpressionWithPattern:marchtemp options:NSRegularExpressionCaseInsensitive error:nil];
        NSTextCheckingResult *result = [regular firstMatchInString:weatherText options:0 range:NSMakeRange(0, [weatherText length])];
        
        

       // NSRange range = [weatherText rangeOfString:marchtemp options:NSRegularExpressionSearch];

        
       // NSLog(@"%@",text);
        
//       NSRange range=[a rangeOfString:marchtemp options:NSRegularExpressionSearch];
       // NSLog(@"%@",NSStringFromRange(range));
        
        
        

//        NSLog(@"Range is: %@", [[self.data.forelist2 objectForKey:@"high"] substringWithRange:range]);
        
        [cell.partern setFont:[UIFont fontWithName:KFontName size:60]];
        [cell.weekday setFont:[UIFont fontWithName:@"Lato-Thin" size:40]];
        
        switch (indexPath.row) {
            case 0:{
                //cell.label1.text=[self.data.forelist1 objectForKey:@"type"];
                cell.partern.text=[weathertype transToIcon:[self.data.forelist1 objectForKey:@"type"]];
                NSRange rangeh1=[[self.data.forelist1 objectForKey:@"high"] rangeOfString:marchtemp options:NSRegularExpressionSearch];
                cell.high.text=[[self.data.forelist1 objectForKey:@"high"] substringWithRange:rangeh1];
                NSRange rangel1=[[self.data.forelist1 objectForKey:@"low"] rangeOfString:marchtemp options:NSRegularExpressionSearch];
                cell.low.text=[[self.data.forelist1 objectForKey:@"low"] substringWithRange:rangel1];
                cell.weekday.text=[weekday transToName:[self.data.forelist1 objectForKey:@"date"]];
                cell.weekday.transform=CGAffineTransformMakeTranslation(15, 0);
                [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionCurveEaseOut  animations:^{
                    cell.weekday.transform=CGAffineTransformMakeTranslation(0, 0);
                } completion:^(BOOL finished) {
                    //NSLog(@"done");
                }];}
                break;
            case 1:
            {
                cell.partern.text=[weathertype transToIcon:[self.data.forelist2 objectForKey:@"type"]];
                NSRange rangeh2=[[self.data.forelist2 objectForKey:@"high"] rangeOfString:marchtemp options:NSRegularExpressionSearch];
                cell.high.text=[[self.data.forelist2 objectForKey:@"high"] substringWithRange:rangeh2];
                NSRange rangel2=[[self.data.forelist2 objectForKey:@"low"] rangeOfString:marchtemp options:NSRegularExpressionSearch];
                cell.low.text=[[self.data.forelist2 objectForKey:@"low"] substringWithRange:rangel2];
                 cell.weekday.text=[weekday transToName:[self.data.forelist2 objectForKey:@"date"]];
                cell.weekday.transform=CGAffineTransformMakeTranslation(15, 0);
                [UIView animateWithDuration:1 delay:1.3 options:UIViewAnimationOptionCurveEaseOut  animations:^{
                    cell.weekday.transform=CGAffineTransformMakeTranslation(0, 0);
                } completion:^(BOOL finished) {
                }];
            }

                break;
            case 2:
            {
                //cell.label1.text=[self.data.forelist3 objectForKey:@"type"];
                cell.partern.text=[weathertype transToIcon:[self.data.forelist3 objectForKey:@"type"]];
                NSRange rangeh3=[[self.data.forelist3 objectForKey:@"high"] rangeOfString:marchtemp options:NSRegularExpressionSearch];
                cell.high.text=[[self.data.forelist3 objectForKey:@"high"] substringWithRange:rangeh3];
                NSRange rangel3=[[self.data.forelist3 objectForKey:@"low"] rangeOfString:marchtemp options:NSRegularExpressionSearch];
                cell.low.text=[[self.data.forelist3 objectForKey:@"low"] substringWithRange:rangel3];
                 cell.weekday.text=[weekday transToName:[self.data.forelist3 objectForKey:@"date"]];
                cell.weekday.transform=CGAffineTransformMakeTranslation(15, 0);
                [UIView animateWithDuration:1 delay:1.6 options:UIViewAnimationOptionCurveEaseOut  animations:^{
                    cell.weekday.transform=CGAffineTransformMakeTranslation(0, 0);
                } completion:^(BOOL finished) {
                   // NSLog(@"done");
                }];
            }

                break;
            case 3:
            {
                cell.partern.text=[weathertype transToIcon:[self.data.forelist4 objectForKey:@"type"]];
                NSRange rangeh4=[[self.data.forelist4 objectForKey:@"high"] rangeOfString:marchtemp options:NSRegularExpressionSearch];
                cell.high.text=[[self.data.forelist4 objectForKey:@"high"] substringWithRange:rangeh4];
                NSRange rangel4=[[self.data.forelist4 objectForKey:@"low"] rangeOfString:marchtemp options:NSRegularExpressionSearch];
                cell.low.text=[[self.data.forelist4 objectForKey:@"low"] substringWithRange:rangel4];
                 cell.weekday.text=[weekday transToName:[self.data.forelist4 objectForKey:@"date"]];
                cell.weekday.transform=CGAffineTransformMakeTranslation(15, 0);
                [UIView animateWithDuration:1 delay:1.9 options:UIViewAnimationOptionCurveEaseOut  animations:^{
                    cell.weekday.transform=CGAffineTransformMakeTranslation(0, 0);
                } completion:^(BOOL finished) {
                    //NSLog(@"done");
                }];
            }

                break;
            case 4:
            {
                cell.partern.text=[weathertype transToIcon:[self.data.forelist5 objectForKey:@"type"]];
                NSRange rangeh5=[[self.data.forelist5 objectForKey:@"high"] rangeOfString:marchtemp options:NSRegularExpressionSearch];
                cell.high.text=[[self.data.forelist5 objectForKey:@"high"] substringWithRange:rangeh5];
                NSRange rangel5=[[self.data.forelist5 objectForKey:@"low"] rangeOfString:marchtemp options:NSRegularExpressionSearch];
                cell.low.text=[[self.data.forelist5 objectForKey:@"low"] substringWithRange:rangel5];
                 cell.weekday.text=[weekday transToName:[self.data.forelist5 objectForKey:@"date"]];
                cell.weekday.transform=CGAffineTransformMakeTranslation(15, 0);
                [UIView animateWithDuration:1 delay:2.2 options:UIViewAnimationOptionCurveEaseOut  animations:^{
                    cell.weekday.transform=CGAffineTransformMakeTranslation(0, 0);
                } completion:^(BOOL finished) {
                   // NSLog(@"done");
                }];
            }

                break;
            default:
                break;
                
        }
        
        if ([cell.weekday.text isEqualToString:@"Sun"]) {
            cell.weekday.textColor=[UIColor redColor];
        }
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    //NSLog(@"4");
    return 80;
}
//无需再设置滑动代理，直接由tableview偏移判断来设定。
-(void)popToWeather{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
//tableView继承自scrollerView,不用写scroller的delegate,直接用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<-180){
        NSLog(@"%f",scrollView.contentOffset.y);
        [self popToWeather];
    }
}
#pragma mark - UINavigationControllerDelegate iOS7新增的2个方法
// 动画特效
- (id<UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    
    if (operation == UINavigationControllerOperationPop) {
        NSLog(@"touchtwo");
        self.Animator = [[TransitionBack alloc]init];
        return self.Animator;
        //return nil;
    }else{
        return nil;
    }
    
}

@end

//
//  ForecastList.h
//  study
//
//  Created by 邹应天 on 15/8/16.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForeDataLoad.h"
#import "FontHeader.h"
@interface ForecastList : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UITableView *tableList;
@property(nonatomic,strong)UINavigationController *nav;
@property(nonatomic,strong)ForeDataLoad *data;
@end

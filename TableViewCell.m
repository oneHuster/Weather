//
//  TableViewCell.m
//  study
//
//  Created by 邹应天 on 15/8/16.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //_label1=[[UILabel alloc] initWithFrame:CGRectMake(200, 20, 40, 10)];
    _partern=[[UILabel alloc]initWithFrame:CGRectMake(300, 10, 60, 60)];
    _high=[[UILabel alloc]initWithFrame:CGRectMake(220, 10, 60, 60)];
    _low=[[UILabel alloc]initWithFrame:CGRectMake(140, 10, 60, 60)];
    _weekday=[[UILabel alloc]initWithFrame:CGRectMake(30, 10, 90, 60)];
    //[self.contentView addSubview:_label1];
    
    [self.contentView addSubview:_partern];
    [self.contentView addSubview:_high];
    [self.contentView addSubview:_low];
    [self.contentView addSubview:_weekday];
    return self;
    
}
- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

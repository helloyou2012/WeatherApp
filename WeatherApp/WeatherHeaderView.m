//
//  WeatherHeaderView.m
//  WeatherApp
//
//  Created by ZhenzhenXu on 4/30/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "WeatherHeaderView.h"

@implementation WeatherHeaderView

@synthesize backBtn=_backBtn;
@synthesize refreshBtn=_refreshBtn;
@synthesize dateLabel=_dateLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _backBtn=[[UIButton alloc] initWithFrame:CGRectMake(15, 10, 24, 24)];
        [_backBtn setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
        [self addSubview:_backBtn];
        
        _refreshBtn=[[UIButton alloc] initWithFrame:CGRectMake(281, 10, 24, 24)];
        [_refreshBtn setImage:[UIImage imageNamed:@"refresh_btn"] forState:UIControlStateNormal];
        [self addSubview:_refreshBtn];
        
        UILabel *cityLabel=[[UILabel alloc] initWithFrame:CGRectMake((frame.size.width-200.0f)/2.0f, 4, 200, 20)];
        cityLabel.font=[UIFont systemFontOfSize:17.0f];
        cityLabel.textColor=[UIColor whiteColor];
        cityLabel.backgroundColor=[UIColor clearColor];
        cityLabel.textAlignment=NSTextAlignmentCenter;
        cityLabel.text=@"松江";
        [self addSubview:cityLabel];
        
        _dateLabel=[[UILabel alloc] initWithFrame:CGRectMake((frame.size.width-200.0f)/2.0f, 24, 200, 16)];
        _dateLabel.font=[UIFont systemFontOfSize:14.0f];
        _dateLabel.textColor=[UIColor whiteColor];
        _dateLabel.backgroundColor=[UIColor clearColor];
        _dateLabel.textAlignment=NSTextAlignmentCenter;
        //_dateLabel.text=@"2013年5月1日 星期日";
        [self addSubview:_dateLabel];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
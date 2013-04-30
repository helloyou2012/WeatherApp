//
//  ForecastWeatherView.m
//  WeatherApp
//
//  Created by ZhenzhenXu on 4/30/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "ForecastWeatherView.h"

static NSString *bundleURL = @"weather_icon.bundle/icon/daily_forecast_70x70/";

@implementation ForecastWeatherView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(8, 5, 288, 20)];
        titleLabel.font=[UIFont systemFontOfSize:17.0f];
        titleLabel.textColor=[UIColor whiteColor];
        titleLabel.backgroundColor=[UIColor clearColor];
        titleLabel.text=@"预报";
        [self addSubview:titleLabel];
        //Line
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(8, 29, 288, 1)];
        lineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:lineView];
        //Row Height:67
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(8, 30, 288, 178)];
        imageView.image=[UIImage imageNamed:@"Forecast"];
        imageView.backgroundColor=[UIColor clearColor];
        [self addSubview:imageView];
        self.backgroundColor=[UIColor colorWithWhite:0.0f alpha:0.5f];
        [self createDetailViews];
    }
    return self;
}

- (void)createDetailViews{
    NSArray *images=[NSArray arrayWithObjects:@"clear_day", @"cloudy_day_night", @"fair_day", @"flash_flood_day_night", @"snow_day_night", nil];
    NSArray *names=[NSArray arrayWithObjects:@"星期一", @"星期二", @"星期三", @"星期四", @"星期五", nil];
    for (int i=0; i<5; i++) {
        CGFloat curHeight=i*33.5f+30.0f;
        
        UILabel *dayLabel=[[UILabel alloc] initWithFrame:CGRectMake(8, curHeight+7, 78, 20)];
        dayLabel.font=[UIFont systemFontOfSize:17.0f];
        dayLabel.textColor=[UIColor whiteColor];
        dayLabel.backgroundColor=[UIColor clearColor];
        dayLabel.text=[names objectAtIndex:i];
        [self addSubview:dayLabel];
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(8+128, curHeight+2, 30, 30)];
        imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",bundleURL,[images objectAtIndex:i]]];
        imageView.backgroundColor=[UIColor clearColor];
        [self addSubview:imageView];
        
        UILabel *upTempLabel=[[UILabel alloc] initWithFrame:CGRectMake(8+178, curHeight+7, 55, 20)];
        upTempLabel.font=[UIFont systemFontOfSize:17.0f];
        upTempLabel.textColor=[UIColor whiteColor];
        upTempLabel.backgroundColor=[UIColor clearColor];
        upTempLabel.textAlignment=NSTextAlignmentRight;
        upTempLabel.text=@"23°";
        [self addSubview:upTempLabel];
        
        UILabel *lowTempLabel=[[UILabel alloc] initWithFrame:CGRectMake(8+178+55, curHeight+7, 55, 20)];
        lowTempLabel.font=[UIFont systemFontOfSize:17.0f];
        lowTempLabel.textColor=[UIColor whiteColor];
        lowTempLabel.backgroundColor=[UIColor clearColor];
        lowTempLabel.textAlignment=NSTextAlignmentRight;
        lowTempLabel.text=@"12°";
        [self addSubview:lowTempLabel];
    }
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

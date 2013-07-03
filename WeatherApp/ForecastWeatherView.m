//
//  ForecastWeatherView.m
//  WeatherApp
//
//  Created by ZhenzhenXu on 4/30/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "ForecastWeatherView.h"
//#import "GetForecastWeather.h"

static NSString *bundleURL = @"weather_icon.bundle/icon/daily_forecast_70x70/";

@implementation ForecastWeatherView

@synthesize delegate=_delegate;
@synthesize dayLabels=_dayLabels;
@synthesize imageViews=_imageViews;
@synthesize upTempLabels=_upTempLabels;
@synthesize downTempLabels=_downTempLabels;

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
        [self getWeatherInfo];
    }
    return self;
}
-(void)getWeatherInfo
{
    GetForecastWeather *fcweather=[[GetForecastWeather alloc]init];
    fcweather.delegate=self;
    [fcweather getWeather];

}

- (void)createDetailViews{
    _dayLabels=[[NSMutableArray alloc] init];
    _imageViews=[[NSMutableArray alloc] init];
    _upTempLabels=[[NSMutableArray alloc] init];
    _downTempLabels=[[NSMutableArray alloc] init];
    for (int i=0; i<5; i++) {
        CGFloat curHeight=i*33.5f+30.0f;
        
        UILabel *dayLabel=[[UILabel alloc] initWithFrame:CGRectMake(8, curHeight+7, 78, 20)];
        dayLabel.font=[UIFont systemFontOfSize:17.0f];
        dayLabel.textColor=[UIColor whiteColor];
        dayLabel.backgroundColor=[UIColor clearColor];
        [_dayLabels addObject:dayLabel];
        [self addSubview:dayLabel];
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(8+128, curHeight+2, 30, 30)];
        imageView.backgroundColor=[UIColor clearColor];
        [_imageViews addObject:imageView];
        [self addSubview:imageView];
        
        UILabel *upTempLabel=[[UILabel alloc] initWithFrame:CGRectMake(8+178, curHeight+7, 55, 20)];
        upTempLabel.font=[UIFont systemFontOfSize:17.0f];
        upTempLabel.textColor=[UIColor whiteColor];
        upTempLabel.backgroundColor=[UIColor clearColor];
        upTempLabel.textAlignment=NSTextAlignmentRight;
        [_upTempLabels addObject:upTempLabel];
        [self addSubview:upTempLabel];
        
        UILabel *lowTempLabel=[[UILabel alloc] initWithFrame:CGRectMake(8+178+55, curHeight+7, 55, 20)];
        lowTempLabel.font=[UIFont systemFontOfSize:17.0f];
        lowTempLabel.textColor=[UIColor whiteColor];
        lowTempLabel.backgroundColor=[UIColor clearColor];
        lowTempLabel.textAlignment=NSTextAlignmentRight;
        [_downTempLabels addObject:lowTempLabel];
        [self addSubview:lowTempLabel];
    }
}

-(void) passWeatherInfo:(NSMutableDictionary *)weather
{
    NSString *plistPath=[[NSBundle mainBundle] pathForResource:@"Weather" ofType:@"plist"];
    NSDictionary *image_dict=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    for (NSInteger i=0; i<5; i++) {
        //Week
        UILabel *dayLabel=[_dayLabels objectAtIndex:i];
        dayLabel.text=[self getWeekOffset:i from:[NSDate date]];
        //Image
        NSString *imageKey=[NSString stringWithFormat:@"img%d",2*i+3];
        NSString *image=[weather objectForKey:imageKey];
        UIImageView *imageView=[_imageViews objectAtIndex:i];
        imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",bundleURL,[image_dict objectForKey:image]]];
        //Temp
        NSString *tempKey=[NSString stringWithFormat:@"temp%d", i+2];
        NSString *temp=[weather objectForKey:tempKey];
        NSArray *temps=[self parserTemp:temp];
        if (temps&&temps.count>1) {
            NSLog(@"%@",temps);
            UILabel *upLabel=[_upTempLabels objectAtIndex:i];
            upLabel.text=[NSString stringWithFormat:@"%@°",[temps objectAtIndex:0]];
            UILabel *downLabel=[_downTempLabels objectAtIndex:i];
            downLabel.text=[NSString stringWithFormat:@"%@°",[temps objectAtIndex:1]];
        }
    }
}

- (NSArray*)parserTemp:(NSString*)temp{
    temp=[temp stringByReplacingOccurrencesOfString:@"℃" withString:@""];
    return [temp componentsSeparatedByString:@"~"];
}

- (NSString*)getWeekOffset:(NSInteger)offset from:(NSDate*)date{
    NSArray *daySymbols = [[NSArray alloc] initWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    int weekday = [comps weekday];
    NSInteger cur=(offset+weekday)%7;
    return [daySymbols objectAtIndex:cur];
}

@end

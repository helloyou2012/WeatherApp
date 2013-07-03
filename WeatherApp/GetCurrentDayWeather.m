//
//  GetCurrentDayWeather.m
//  WeatherApp
//
//  Created by user on 13-5-3.
//  Copyright (c) 2013年 ZhenzhenXu. All rights reserved.
//

#import "GetCurrentDayWeather.h"

@implementation GetCurrentDayWeather

@synthesize delegate=_delegate;

-(void)getWeather
{
    WeatherRequest *weatherRequest=[[WeatherRequest alloc]initWithUrl:@"http://www.weather.com.cn/data/sk/101020900.html"];
    weatherRequest.delegate=self;
    [weatherRequest createConnection];
}
-(void)weatherRequestFinished:(NSMutableDictionary *)data withError:(NSString *)error
{
    NSMutableDictionary *weatherinfo=[data objectForKey:@"weatherinfo"];
    [_delegate passWeatherInfo:weatherinfo];
}



@end

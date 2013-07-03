//
//  GetForecastWeather.h
//  WeatherApp
//
//  Created by user on 13-5-3.
//  Copyright (c) 2013年 ZhenzhenXu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherRequest.h"

@protocol WeatherInfoDelegage

-(void)passWeatherInfo:(NSMutableDictionary *) weather;

@end

@interface GetForecastWeather : NSObject<WeatherRequestDelegage>
{
    NSObject<WeatherInfoDelegage> *delegate;
}
@property (nonatomic, retain) NSObject<WeatherInfoDelegage> *delegate;
-(void)getWeather;

@end

//
//  CurrentDayWeatherView.h
//  WeatherApp
//
//  Created by ZhenzhenXu on 4/30/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetForecastWeather.h"
#import "ForecastWeatherView.h"

@interface CurrentDayWeatherView : UIView<WeatherInfoDelegage,CurrentWeatherDelegate>
{
    NSMutableDictionary *weather_dict;
}


@property (nonatomic, strong) UIImageView *weatherView;
@property (nonatomic, strong) UILabel *weatherLabel;
@property (nonatomic, strong) UILabel *upTempLabel;
@property (nonatomic, strong) UILabel *downTempLabel;
@property (nonatomic, strong) UILabel *curTempLabel;

- (void)createViews;
- (void)fillViewWith:(NSDictionary*)dict;
@end

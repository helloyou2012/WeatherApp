//
//  ViewController.h
//  WeatherApp
//
//  Created by ZhenzhenXu on 4/30/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CurrentDayWeatherView.h"
#import "ForecastWeatherView.h"
#import "WeatherHeaderView.h"
#import "DayWeatherRequest.h"
#import "ForecastWeatherRequest.h"

@interface WeatherViewController : UIViewController<UIScrollViewDelegate,DayWeatherRequestDelegage,ForecastWeatherRequestDelegage>
{
    NSInteger page;
}

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) CurrentDayWeatherView *curWeatherView;
@property (nonatomic, strong) ForecastWeatherView *forecastWeatherView;
@property (nonatomic, strong) DayWeatherRequest *dayWeatherRequest;
@property (nonatomic, strong) ForecastWeatherRequest *forecastWeatherRequest;
@property (nonatomic, strong) WeatherHeaderView *headerView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *imageList;
@property (nonatomic, strong) NSDictionary *dictType;


- (void)createGradientBackground:(CGRect)rect with:(NSString*)bgurl;
- (void)createViews;
- (void)switchImages;
- (void)refreshData;
@end
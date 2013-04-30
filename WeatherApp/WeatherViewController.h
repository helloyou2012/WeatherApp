//
//  ViewController.h
//  WeatherApp
//
//  Created by ZhenzhenXu on 4/30/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrentDayWeatherView.h"
#import "WeatherHeaderView.h"

@interface WeatherViewController : UIViewController<UIScrollViewDelegate>
{
    NSInteger page;
}

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) CurrentDayWeatherView *curWeatherView;
@property (nonatomic, strong) WeatherHeaderView *headerView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *imageList;


- (void)createGradientBackground:(CGRect)rect with:(NSString*)bgurl;
- (void)createViews;
- (void)switchImages;
@end

//
//  ForecastWeatherView.h
//  WeatherApp
//
//  Created by ZhenzhenXu on 4/30/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastWeatherView : UIView

@property (nonatomic, strong) NSMutableArray *dayLabels;
@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, strong) NSMutableArray *upTempLabels;
@property (nonatomic, strong) NSMutableArray *downTempLabels;

- (void)createDetailViews;
-(void) fillViewWith:(NSDictionary *)weather;
- (NSArray*)parserTemp:(NSString*)temp;
- (NSString*)getWeekOffset:(NSInteger)offset from:(NSDate*)date;
@end
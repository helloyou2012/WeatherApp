//
//  CurrentDayWeatherView.h
//  WeatherApp
//
//  Created by ZhenzhenXu on 4/30/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentDayWeatherView : UIView

@property (nonatomic, strong) UIImageView *weatherView;
@property (nonatomic, strong) UILabel *weatherLabel;
@property (nonatomic, strong) UILabel *upTempLabel;
@property (nonatomic, strong) UILabel *downTempLabel;
@property (nonatomic, strong) UILabel *curTempLabel;

- (void)createViews;
- (void)fillViewWith:(NSDictionary*)dict;
@end

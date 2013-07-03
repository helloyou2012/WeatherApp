//
//  CurrentDayWeatherView.m
//  WeatherApp
//
//  Created by ZhenzhenXu on 4/30/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "CurrentDayWeatherView.h"

static NSString *bundleURL = @"weather_icon.bundle/icon/top_condition_60x60/";

@implementation CurrentDayWeatherView

@synthesize weatherLabel=_weatherLabel;
@synthesize weatherView=_weatherView;
@synthesize upTempLabel=_upTempLabel;
@synthesize downTempLabel=_downTempLabel;
@synthesize curTempLabel=_curTempLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createViews];
    }
    return self;
}

- (void)createViews{
    CGFloat offsetY=self.frame.size.height-164.0f;
    _weatherView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10+offsetY, 28.0f, 28.0f)];
    _weatherView.backgroundColor=[UIColor clearColor];
    [self addSubview:_weatherView];
    
    _weatherLabel=[[UILabel alloc] initWithFrame:CGRectMake(42, 13+offsetY, 268.0f, 21)];
    _weatherLabel.font=[UIFont systemFontOfSize:17.0f];
    _weatherLabel.textColor=[UIColor whiteColor];
    _weatherLabel.backgroundColor=[UIColor clearColor];
    [self addSubview:_weatherLabel];
    
    UIImageView *upperImage=[[UIImageView alloc] initWithFrame:CGRectMake(21, 49+offsetY, 6, 14)];
    upperImage.image=[UIImage imageNamed:@"Info_high"];
    [self addSubview:upperImage];
    
    _upTempLabel=[[UILabel alloc] initWithFrame:CGRectMake(36.0f, 45+offsetY, 40, 20)];
    _upTempLabel.font=[UIFont systemFontOfSize:16.0f];
    _upTempLabel.textColor=[UIColor whiteColor];
    _upTempLabel.backgroundColor=[UIColor clearColor];
    [self addSubview:_upTempLabel];
    
    UIImageView *lowerImage=[[UIImageView alloc] initWithFrame:CGRectMake(91, 49+offsetY, 6, 14)];
    lowerImage.image=[UIImage imageNamed:@"Info_low"];
    [self addSubview:lowerImage];
    
    _downTempLabel=[[UILabel alloc] initWithFrame:CGRectMake(106.0f, 45+offsetY, 40, 20)];
    _downTempLabel.font=[UIFont systemFontOfSize:16.0f];
    _downTempLabel.textColor=[UIColor whiteColor];
    _downTempLabel.backgroundColor=[UIColor clearColor];
    [self addSubview:_downTempLabel];
    
    _curTempLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 70+offsetY, 300, 80)];
    _curTempLabel.font=[UIFont systemFontOfSize:100.0f];
    _curTempLabel.textColor=[UIColor whiteColor];
    _curTempLabel.backgroundColor=[UIColor clearColor];
    [self addSubview:_curTempLabel];
}

- (void)fillCurrentTempWith:(NSDictionary*)dict{
    _curTempLabel.text=[NSString stringWithFormat:@"%@°", [dict objectForKey:@"temp"]];
}

-(void) fillViewWith:(NSDictionary *)weather{
    _weatherLabel.text=[weather objectForKey:@"weather1"];
    NSString *plistPath=[[NSBundle mainBundle] pathForResource:@"Weather" ofType:@"plist"];
    NSDictionary *image_dict=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
    //Image
    NSString *imageKey=[NSString stringWithFormat:@"img%d",1];
    NSString *image=[weather objectForKey:imageKey];
    _weatherView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",bundleURL,[image_dict objectForKey:image]]];
    //Temp
    NSString *tempKey=[NSString stringWithFormat:@"temp%d", 1];
    NSString *temp=[weather objectForKey:tempKey];
    NSArray *temps=[self parserTemp:temp];
    if (temps&&temps.count>1) {
        _upTempLabel.text=[NSString stringWithFormat:@"%@°",[temps objectAtIndex:1]];
        _downTempLabel.text=[NSString stringWithFormat:@"%@°",[temps objectAtIndex:0]];
    }
}

- (NSArray*)parserTemp:(NSString*)temp{
    temp=[temp stringByReplacingOccurrencesOfString:@"℃" withString:@""];
    return [temp componentsSeparatedByString:@"~"];
}

@end
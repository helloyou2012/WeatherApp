//
//  ForecastWeatherRequest.h
//  WeatherApp
//
//  Created by ZhenzhenXu on 5/8/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ForecastWeatherRequestDelegage

-(void) forecastWeatherRequestFinished:(NSDictionary*)data withError:(NSString*)error;

@end


@interface ForecastWeatherRequest : NSObject

@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, strong) NSString *requestUrl;
@property (nonatomic, retain) id<ForecastWeatherRequestDelegage> delegate;
@property (nonatomic, strong) NSURLConnection *connection;

- (id)initRequest;
- (void)createConnection;

@end

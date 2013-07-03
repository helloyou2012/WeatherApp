//
//  DayWeatherRequest.h
//  WeatherApp
//
//  Created by ZhenzhenXu on 5/8/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DayWeatherRequestDelegage

-(void) dayWeatherRequestFinished:(NSDictionary*)data withError:(NSString*)error;

@end


@interface DayWeatherRequest : NSObject

@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, strong) NSString *requestUrl;
@property (nonatomic, retain) id<DayWeatherRequestDelegage> delegate;
@property (nonatomic, strong) NSURLConnection *connection;

- (id)initRequest;
- (void)createConnection;

@end

//
//  WeatherRequest.h
//  WeatherApp
//
//  Created by user on 13-5-3.
//  Copyright (c) 2013年 ZhenzhenXu. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol WeatherRequestDelegage

-(void) weatherRequestFinished:(NSMutableDictionary*)data withError:(NSString*)error;

@end


@interface WeatherRequest : NSObject


@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, strong) NSString *requestUrl;
@property (nonatomic, retain) id<WeatherRequestDelegage> delegate;
@property (nonatomic, strong) NSURLConnection *connection;

- (id)initWithUrl:(NSString*)url;
- (void)createConnection;

@end

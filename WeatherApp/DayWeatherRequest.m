//
//  DayWeatherRequest.m
//  WeatherApp
//
//  Created by ZhenzhenXu on 5/8/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "DayWeatherRequest.h"

@implementation DayWeatherRequest

@synthesize receivedData=_receivedData;
@synthesize requestUrl=_requestUrl;
@synthesize delegate=_delegate;
@synthesize connection=_connection;

- (id)initRequest{
    if (self=[super init]) {
        _requestUrl=@"http://www.weather.com.cn/data/sk/101020900.html";
    }
    return self;
}

- (void)createConnection{
    // Create the request.
    NSURL *url=[NSURL URLWithString:_requestUrl];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    [request setTimeoutInterval:30.0f];
    [request setHTTPMethod:@"GET"];
    // create the connection with the request
    // and start loading the data
    
    _connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (_connection) {
        // Create the NSMutableData to hold the received data.
        _receivedData = [NSMutableData data];
        
    } else {
        // Inform the user that the connection failed.
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    // NSLog(@"response=%@",response);
    [_receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    [_receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [_delegate dayWeatherRequestFinished:nil withError:@"网络连接失败！"];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    NSError *jsonError = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:_receivedData options:NSJSONReadingMutableContainers error:&jsonError];
    if (json==nil) {
        [_delegate dayWeatherRequestFinished:nil withError:@"网络连接失败！"];
    } else {
        [_delegate dayWeatherRequestFinished:json withError:nil];
    }
    
}

@end

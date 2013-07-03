//
//  ViewController.m
//  WeatherApp
//
//  Created by ZhenzhenXu on 4/30/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "WeatherViewController.h"
#import "ForecastWeatherView.h"
#import "SVProgressHUD.h"

@implementation WeatherViewController

@synthesize scrollView=_scrollView;
@synthesize curWeatherView=_curWeatherView;
@synthesize forecastWeatherView=_forecastWeatherView;
@synthesize dayWeatherRequest=_dayWeatherRequest;
@synthesize forecastWeatherRequest=_forecastWeatherRequest;
@synthesize headerView=_headerView;
@synthesize timer=_timer;
@synthesize imageList=_imageList;
@synthesize dictType=_dictType;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _imageList=[[NSMutableArray alloc] initWithObjects:@"show_image_1.png", @"show_image_2.png", @"show_image_3.png", @"show_image_4.png", nil];
    [self createGradientBackground:self.view.bounds with:[_imageList objectAtIndex:0]];
    page=1;
    
    _dayWeatherRequest=[[DayWeatherRequest alloc] initRequest];
    _dayWeatherRequest.delegate=self;
    [_dayWeatherRequest createConnection];
    
    _forecastWeatherRequest=[[ForecastWeatherRequest alloc] initRequest];
    _forecastWeatherRequest.delegate=self;
    [_forecastWeatherRequest createConnection];
}

- (void)createGradientBackground:(CGRect)rect with:(NSString*)bgurl{
    //Image background
    UIImage *bgImage=[UIImage imageNamed:bgurl];
    CGSize bgSize=bgImage.size;
    CGRect imageRect;
    if ((bgSize.width/bgSize.height)>(rect.size.width/rect.size.height)) {
        imageRect=CGRectMake(0, 0, rect.size.height*bgImage.size.width/bgImage.size.height, rect.size.height);
    }else{
        imageRect=CGRectMake(0, 0, rect.size.width,rect.size.width*bgImage.size.height/bgImage.size.width);
    }
    
    UIGraphicsBeginImageContext(imageRect.size);
    [bgImage drawInRect:imageRect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createViews];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.timer==nil) {
        self.timer=[NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(switchImages) userInfo:nil repeats:YES];
    }
}

- (void)switchImages
{
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:@"EaseInOut"];
    
    NSString *imageUrl = [_imageList objectAtIndex:page];
    [self createGradientBackground:self.view.bounds with:imageUrl];
    page=(page+1)%_imageList.count;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (_timer!=nil) {
        [_timer invalidate];
        _timer=nil;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sheight=scrollView.contentOffset.y;
    if(sheight>=0&&sheight<=260){
        CGFloat alpha=0.7f*sheight/260.0f;
        _scrollView.backgroundColor=[UIColor colorWithWhite:0.0f alpha:alpha];
        _headerView.backgroundColor=[UIColor colorWithWhite:0.0f alpha:alpha];
    }else if (sheight>260){
        _scrollView.backgroundColor=[UIColor colorWithWhite:0.0f alpha:0.5f];
        _headerView.backgroundColor=[UIColor colorWithWhite:0.0f alpha:0.5f];
    }
}

- (void)createViews{
    _headerView=[[WeatherHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    //[_headerView.backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [_headerView.refreshBtn addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_headerView];
    
    CGRect rect=self.view.bounds;
    rect.origin.y=44.0f;
    rect.size.height-=44.0f;
    _scrollView.frame=rect;
    
    _curWeatherView=[[CurrentDayWeatherView alloc] initWithFrame:CGRectMake(0, 0, 320, rect.size.height)];
    [_curWeatherView fillViewWith:nil];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [_curWeatherView addGestureRecognizer:singleTap];
    [_scrollView addSubview:_curWeatherView];
    
    _forecastWeatherView=[[ForecastWeatherView alloc] initWithFrame:CGRectMake(8, _curWeatherView.frame.origin.y+_curWeatherView.frame.size.height, 304, 208)];
    [_scrollView addSubview:_forecastWeatherView];
    
    _scrollView.contentSize=CGSizeMake(320, _forecastWeatherView.frame.origin.y+_forecastWeatherView.frame.size.height+60.0f);
    _scrollView.backgroundColor=[UIColor clearColor];
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.delegate=self;
    _scrollView.clipsToBounds=YES;
}

- (void)singleTapGestureCaptured:(id)sender{
    CGRect rect=_scrollView.frame;
    if(_scrollView.contentOffset.y>0){
        rect.origin=CGPointMake(0, 0);
    }else{
        rect.origin=CGPointMake(0, self.view.bounds.size.height-208.0f);
    }
    [_scrollView scrollRectToVisible:rect animated:YES];
}

- (void)refreshData{
    [_dayWeatherRequest createConnection];
    [_forecastWeatherRequest createConnection];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

-(void) forecastWeatherRequestFinished:(NSDictionary*)data withError:(NSString*)error{
    if (error) {
        [SVProgressHUD showErrorWithStatus:error];
    }else{
        NSDictionary *dict=[data objectForKey:@"weatherinfo"];
        [_forecastWeatherView fillViewWith:dict];
        [_curWeatherView fillViewWith:dict];
        NSString *dateTime=[NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"date_y"],[dict objectForKey:@"week"]];
        _headerView.dateLabel.text=dateTime;
    }
}

-(void) dayWeatherRequestFinished:(NSDictionary*)data withError:(NSString*)error{
    [SVProgressHUD dismiss];
    if (error) {
        [SVProgressHUD showErrorWithStatus:error];
    }else{
        [_curWeatherView fillCurrentTempWith:[data objectForKey:@"weatherinfo"]];
    }
}

@end
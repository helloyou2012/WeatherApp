//
//  ViewController.m
//  WeatherApp
//
//  Created by ZhenzhenXu on 4/30/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "WeatherViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ForecastWeatherView.h"

@implementation WeatherViewController

@synthesize scrollView=_scrollView;
@synthesize curWeatherView=_curWeatherView;
@synthesize headerView=_headerView;
@synthesize timer=_timer;
@synthesize imageList=_imageList;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _imageList=[[NSMutableArray alloc] initWithObjects:@"bg2.jpg", @"bg3.jpg", nil];
    [self createGradientBackground:self.view.bounds with:[_imageList objectAtIndex:0]];
    page=1;
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
        self.timer=[NSTimer scheduledTimerWithTimeInterval:15.0f target:self selector:@selector(switchImages) userInfo:nil repeats:YES];
    }
}

- (void)switchImages
{
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
    
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
        _scrollView.backgroundColor=[UIColor colorWithWhite:0.0f alpha:0.7f];
        _headerView.backgroundColor=[UIColor colorWithWhite:0.0f alpha:0.7f];
    }
}

- (void)createViews{
    _headerView=[[WeatherHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [self.view addSubview:_headerView];
    
    _curWeatherView=[[CurrentDayWeatherView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-44.0f)];
    [_curWeatherView fillViewWith:nil];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [_curWeatherView addGestureRecognizer:singleTap];
    [_scrollView addSubview:_curWeatherView];
    
    ForecastWeatherView *forecastView=[[ForecastWeatherView alloc] initWithFrame:CGRectMake(8, _curWeatherView.frame.origin.y+_curWeatherView.frame.size.height, 304, 208)];
    [_scrollView addSubview:forecastView];
    
    _scrollView.contentSize=CGSizeMake(320, forecastView.frame.origin.y+forecastView.frame.size.height+60.0f);
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

@end

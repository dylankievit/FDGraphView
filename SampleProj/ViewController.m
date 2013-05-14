//
//  ViewController.m
//  SampleProj
//
//  Created by Francesco Di Lorenzo on 15/03/13.
//  Copyright (c) 2013 Francesco Di Lorenzo. All rights reserved.
//

#import "ViewController.h"
#import "FDGraphView.h"
#import "FDGraphScrollView.h"
#import "FDDataPoint.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    FDGraphView *graphView = [[FDGraphView alloc] initWithFrame:CGRectMake(10, 130, 300, 200)];
    //FDGraphScrollView *graphView = [[FDGraphScrollView alloc] initWithFrame:CGRectMake(10, 130, 300, 200)];
    [self.view addSubview:graphView];


    NSMutableArray *myDataPoints = [[NSMutableArray alloc] init];

    FDDataPoint *dp = [[FDDataPoint alloc] initWithX:1 Y:1];
    [myDataPoints addObject:dp];
    dp = [[FDDataPoint alloc] initWithX:3 Y:1 type:FDDataPointTypeMinor];
    [myDataPoints addObject:dp];
    dp = [[FDDataPoint alloc] initWithX:2 Y:25];
    [myDataPoints addObject:dp];
    dp = [[FDDataPoint alloc] initWithX:4 Y:15];
    [myDataPoints addObject:dp];
    dp = [[FDDataPoint alloc] initWithX:5 Y:12 type:FDDataPointTypeMajor];
    [myDataPoints addObject:dp];
    dp = [[FDDataPoint alloc] initWithX:10 Y:100];
    [myDataPoints addObject:dp];

    graphView.dataPoints = [[NSArray alloc] initWithArray:myDataPoints];
}

@end

//
//  ViewController.m
//  FDGraphView
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

    [myDataPoints addObject:[[FDDataPoint alloc] initWithX:1 Y:1]];
    [myDataPoints addObject:[[FDDataPoint alloc] initWithX:2 Y:5 type:FDDataPointTypeMinor]];
    [myDataPoints addObject:[[FDDataPoint alloc] initWithX:3 Y:26 type:FDDataPointTypeMajor]];
    [myDataPoints addObject:[[FDDataPoint alloc] initWithX:4 Y:102]];
    [myDataPoints addObject:[[FDDataPoint alloc] initWithX:6 Y:58]];


    graphView.dataPoints = myDataPoints;
}

@end

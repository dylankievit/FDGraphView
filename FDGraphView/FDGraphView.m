//
//  FDGraphView.m
//  disegno
//
//  Created by Francesco Di Lorenzo on 14/03/13.
//  Copyright (c) 2013 Francesco Di Lorenzo. All rights reserved.
//

#import "FDGraphView.h"
#import "FDDataPoint.h"

#define gStandardColor
#define gMinorColor
#define gMajorColor

@interface FDGraphView()

@end

@implementation FDGraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // default values
        _edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        //_defaultDataPointColor = [self colorForDataPointType:FDDataPointTypeStandard];//[UIColor whiteColor];
        //_defaultDataPointStrokeColor = [UIColor colorWithRed:0.440 green:0.525 blue:0.673 alpha:1.000];
        _linesColor = [UIColor colorWithRed:54.0/255.0 green:139.0/255.0 blue:229/255.0 alpha:1.0];
        _autoresizeToFitData = NO;
        _dataPointsXoffset = 100.0f;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (FDDataPoint *)maxDataPointUsingSelector:(SEL)comp {
    if (self.dataPoints.count)
    {
        NSArray *sortedArray = [self.dataPoints sortedArrayUsingSelector:comp];
        return (FDDataPoint *)sortedArray[sortedArray.count-1];
    }
    else
        return nil;
}

- (FDDataPoint *)minDataPointUsingSelector:(SEL)comp {
    if (self.dataPoints.count)
    {
        NSArray *sortedArray = [self.dataPoints sortedArrayUsingSelector:comp];
        return (FDDataPoint *)sortedArray[0];
    }
    else
        return nil;
}

- (CGFloat)widthToFitData {
    CGFloat res = 0;
    
    if (self.dataPoints.count) {
        res += (self.dataPoints.count - 1)*self.dataPointsXoffset; // space occupied by data points
        res += (self.edgeInsets.left + self.edgeInsets.right) ; // lateral margins;
    }
    
    return res;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // STYLE
    // lines color
    [self.linesColor setStroke];
    // lines width
    CGContextSetLineWidth(context, 3);
    
    // CHART POINT CALCULATION
    NSInteger count = self.dataPoints.count;
    CGPoint graphPoints[count];

    CGFloat drawingWidth = rect.size.width - self.edgeInsets.left - self.edgeInsets.right;
    CGFloat drawingHeight = rect.size.height - self.edgeInsets.top - self.edgeInsets.bottom;
    CGFloat minY = ((FDDataPoint *)[self minDataPointUsingSelector:@selector(compareY:)]).y;
    CGFloat maxY = ((FDDataPoint *)[self maxDataPointUsingSelector:@selector(compareY:)]).y;
    CGFloat minX = ((FDDataPoint *)[self minDataPointUsingSelector:@selector(compareX:)]).x;
    CGFloat maxX = ((FDDataPoint *)[self maxDataPointUsingSelector:@selector(compareX:)]).x;

    if (count > 0) {
        for (int i = 0; i < count; ++i) {
            CGFloat x, y;

            FDDataPoint *dataPointValue = (FDDataPoint *)self.dataPoints[i];

            // determine x coordinate
            if (maxX != minX)
                x = rect.size.width - (self.edgeInsets.left + drawingWidth*((dataPointValue.x-maxX) / (minX-maxX)));
            else    // the graph is a vertical line
                x = rect.size.width/2;

            // determine y coordinate
            if (maxY != minY)
                y = rect.size.height - (self.edgeInsets.bottom + drawingHeight*((dataPointValue.y-minY) / (maxY-minY)));
            else // the graph is a horizontal line
                y = rect.size.height/2;

            graphPoints[i] = CGPointMake(x, y);
        }
    } else {
        return;
    }

    // CREATE THE CHART
    CGContextAddLines(context, graphPoints, count);
    CGContextStrokePath(context);
    
    // DRAW THE CIRCLES
    for (int i = 0; i < count; ++i) {
        CGRect ellipseRect = CGRectMake(graphPoints[i].x-3, graphPoints[i].y-3, 6, 6);
        CGContextAddEllipseInRect(context, ellipseRect);
        CGContextSetLineWidth(context, 2);

        // set the datapoint colors
        FDDataPoint *dataPointValue = (FDDataPoint *)self.dataPoints[i];

        [self setColorsForDataPointType:dataPointValue.type];

        CGContextFillEllipseInRect(context, ellipseRect);
        CGContextStrokeEllipseInRect(context, ellipseRect);
    }
}

#pragma mark - Custom setters

- (void)changeFrameWidthTo:(CGFloat)width {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

- (void)autoresizeIfSet {
    if (self.autoresizeToFitData) {
        CGFloat widthToFitData = [self widthToFitData];
        if (widthToFitData > self.frame.size.width) {
            [self changeFrameWidthTo:widthToFitData];
        }
    }
}

- (void)setDataPointsXoffset:(CGFloat)dataPointsXoffset {
    _dataPointsXoffset = dataPointsXoffset;
    
    [self autoresizeIfSet];
}

- (void)setAutoresizeToFitData:(BOOL)autoresizeToFitData {
    _autoresizeToFitData = autoresizeToFitData;
    
    [self autoresizeIfSet];
}

- (void)setDataPoints:(NSArray *)dataPoints {
    _dataPoints = dataPoints;
    
    [self autoresizeIfSet];
}

- (void)setColorsForDataPointType:(FDDataPointType)type {
    switch (type) {
        case FDDataPointTypeStandard:
            [[UIColor whiteColor] setFill];
            [[UIColor colorWithRed:0.440 green:0.525 blue:0.673 alpha:1.000] setStroke];
            break;
        case FDDataPointTypeMajor:
            [[UIColor blackColor] setFill];
            [[UIColor redColor] setStroke];
            break;
        case FDDataPointTypeMinor:
            [[UIColor whiteColor] setFill];
            [[UIColor colorWithRed:0.0 green:0.525 blue:0.673 alpha:0.5] setStroke];
            break;
    }
}

@end

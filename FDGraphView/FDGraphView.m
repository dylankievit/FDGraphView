//
//  FDGraphView.m
//  FDGraphView
//
//  Created by Francesco Di Lorenzo on 14/03/13.
//  Copyright (c) 2013 Francesco Di Lorenzo. All rights reserved.
//

#import "FDGraphView.h"
#import "FDDataPoint.h"


@interface FDGraphView()

@end

@implementation FDGraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // default values
        _edgeInsets = UIEdgeInsetsMake(10, 30, 18, 10);
        _lineColor = [UIColor colorWithRed:54.0/255.0 green:139.0/255.0 blue:229/255.0 alpha:1.0];
        _drawShadow = YES;
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

- (CGFloat)xCoordForVal:(CGFloat)xVal rect:(CGRect)rect {
    CGFloat drawingWidth = rect.size.width - self.edgeInsets.left - self.edgeInsets.right;

    // determine x coordinate
    if (self.maxX != self.minX)
        return rect.size.width - (self.edgeInsets.right + drawingWidth*((xVal-self.maxX) / (self.minX-self.maxX)));
    else    // the graph is a vertical line
        return rect.size.width/2;
}

- (CGFloat)yCoordForVal:(CGFloat)yVal rect:(CGRect)rect {
    CGFloat drawingHeight = rect.size.height - self.edgeInsets.top - self.edgeInsets.bottom;

    // determine y coordinate
    if (self.maxY != self.minY)
        return rect.size.height - (self.edgeInsets.bottom + drawingHeight*((yVal-self.minY) / (self.maxY-self.minY)));
    else // the graph is a horizontal line
        return rect.size.height/2;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    [self drawAxes:rect];
    CGContextSaveGState(context);
    
    // STYLE
    // shadow color
    if (self.drawShadow)
        CGContextSetShadowWithColor(context, CGSizeMake(0,-1), 1, [[UIColor lightGrayColor] CGColor]);
    // lines color
    [self.lineColor setStroke];
    // lines width
    CGContextSetLineWidth(context, 3);
    
    // CHART POINT CALCULATION
    NSInteger count = self.dataPoints.count;
    CGPoint graphPoints[count];

    if (count > 0) {
        for (int i = 0; i < count; ++i) {
            CGFloat x, y;

            FDDataPoint *dataPointValue = (FDDataPoint *)self.dataPoints[i];

            x = [self xCoordForVal:dataPointValue.x rect:rect];
            y = [self yCoordForVal:dataPointValue.y rect:rect];

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
    CGContextRestoreGState(context);
}

- (void)drawAxes:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);   // save the context state

    // set axes number label format
    NSNumberFormatter *numberFormat = [[NSNumberFormatter alloc]init];
    [numberFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormat setRoundingMode:NSNumberFormatterRoundHalfUp];
    [numberFormat setMaximumFractionDigits:1];
    [numberFormat setMinimumFractionDigits:0];
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0.298 alpha:1.000].CGColor);

    // set grid line style
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.800 alpha:0.500].CGColor);

    CGFloat drawingWidth = rect.size.width - self.edgeInsets.left - self.edgeInsets.right;
    CGFloat drawingHeight = rect.size.height - self.edgeInsets.top - self.edgeInsets.bottom;


    // draw y axis
    int yIntervals = 5; // number of horizontal lines to draw. this should probably be determined by vertical span or graph height
    double yAxisInterval = (self.maxY-self.minY)/(yIntervals-1);    // difference between intervals
    int yAxisDivs = ceil((self.maxY-self.minY) / yAxisInterval) + 1;
    double divHeight = drawingHeight / (yAxisDivs-1);
    CGFloat yAxisTextSize = self.edgeInsets.left/3;

    // draw each y-axis gridline and associate text label
    for (int i=0; i<yAxisDivs; ++i) {
		double yAxisVal = self.maxY - i*yAxisInterval;  // value for label
		double yGridLoc = self.edgeInsets.top + divHeight*i;

        CGRect textFrame = CGRectMake(0,yGridLoc-yAxisTextSize+1,self.edgeInsets.left-3.5,15);

        // format and print the label for this grid line
		NSString *yAxisLabel = [numberFormat stringFromNumber:[NSNumber numberWithDouble:yAxisVal]];
		[yAxisLabel drawInRect:textFrame withFont:[UIFont fontWithName:@"Futura-Medium" size:yAxisTextSize] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentRight];

		// draw a grid line
		CGContextMoveToPoint(context, self.edgeInsets.left, yGridLoc);
		CGContextAddLineToPoint(context, self.frame.size.width-self.edgeInsets.right, yGridLoc);
		CGContextStrokePath(context);
	}


    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.200 alpha:0.700].CGColor);    // darken grid line style for tick marks

    int xAxisDivs = self.dataPoints.count;
    //double xAxisInterval = self.dataPoints.count/xAxisDivs;
    CGFloat xAxisLabelWidth = drawingWidth/xAxisDivs;
    for (int i=0; i<xAxisDivs; ++i) {
        double xAxisVal = ((FDDataPoint *)self.dataPoints[i]).x;
        CGFloat xGridLoc = [self xCoordForVal:xAxisVal rect:rect];

        CGRect textFrame = CGRectMake(xGridLoc-xAxisLabelWidth/2,rect.size.height-self.edgeInsets.bottom+2,xAxisLabelWidth,15);

        // format and print the label
		NSString *xAxisLabel = [numberFormat stringFromNumber:[NSNumber numberWithDouble:xAxisVal]];
		[xAxisLabel drawInRect:textFrame withFont:[UIFont fontWithName:@"Futura-Medium" size:self.edgeInsets.bottom/1.5] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];

        // draw a grid tick mark
		CGContextMoveToPoint(context, xGridLoc, rect.size.height-self.edgeInsets.bottom+2);
		CGContextAddLineToPoint(context, xGridLoc, rect.size.height-self.edgeInsets.bottom-3);
		CGContextStrokePath(context);
    }

    CGContextRestoreGState(context);    // restore context state so these settings don't persist
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

    self.minY = ((FDDataPoint *)[self minDataPointUsingSelector:@selector(compareY:)]).y;
    self.maxY = ((FDDataPoint *)[self maxDataPointUsingSelector:@selector(compareY:)]).y;
    self.minX = ((FDDataPoint *)[self minDataPointUsingSelector:@selector(compareX:)]).x;
    self.maxX = ((FDDataPoint *)[self maxDataPointUsingSelector:@selector(compareX:)]).x;
    
    [self autoresizeIfSet];
}

- (void)setColorsForDataPointType:(FDDataPointType)type {
    [self.backgroundColor setFill];
    switch (type) {
        case FDDataPointTypeStandard:
            [[UIColor colorWithRed:0.400 green:0.800 blue:1.000 alpha:1.000] setStroke];
            break;
        case FDDataPointTypeMajor:
            [[UIColor colorWithRed:1.000 green:220/255.0 blue:0.000 alpha:1.000] setStroke];
            break;
        case FDDataPointTypeMinor:
            [[UIColor colorWithWhite:0.902 alpha:1.000] setStroke];
            break;
    }
}

@end

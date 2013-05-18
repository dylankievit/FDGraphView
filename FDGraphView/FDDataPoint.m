//
//  FDDataPoint.m
//  FDGraphView
//
//  Created by Dylan Kievit on 5/11/13.
//  Copyright (c) 2013 Dylan Kievit. All rights reserved.
//

#import "FDDataPoint.h"

@implementation FDDataPoint

- (id)initWithX:(CGFloat)initX Y:(CGFloat)initY
{
    return [self initWithX:initX Y:initY type:FDDataPointTypeStandard];
}

- (id)initWithX:(CGFloat)initX Y:(CGFloat)initY type:(FDDataPointType)type
{
    self.x = initX;
    self.y = initY;

    self.type = type;

    return self;
}

- (NSComparisonResult)compareX:(FDDataPoint *)otherDataPoint
{
    if (self.x < otherDataPoint.x)
        return NSOrderedAscending;
    else if (self.x > otherDataPoint.x)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}

- (NSComparisonResult)compareY:(FDDataPoint *)otherDataPoint
{
    if (self.y < otherDataPoint.y)
        return NSOrderedAscending;
    else if (self.y > otherDataPoint.y)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}



@end

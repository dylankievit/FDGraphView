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
    return self.x - otherDataPoint.x;
}

- (NSComparisonResult)compareY:(FDDataPoint *)otherDataPoint
{
    return self.y - otherDataPoint.y;
}



@end

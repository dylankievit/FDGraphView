//
//  FDDataPoint.m
//
//  Created by Dylan Kievit on 5/11/13.
//  Copyright (c) 2013 Dylan Kievit. All rights reserved.
//

#import "FDDataPoint.h"

@implementation FDDataPoint

- (id)initWithX:(CGFloat)initX Y:(CGFloat)initY
{
    return [self initWithX:initX Y:initY withColor:nil withStroke:nil];
}

- (id)initWithX:(CGFloat)initX Y:(CGFloat)initY withColor:(UIColor*)color withStroke:(UIColor *)stroke
{
    self.x = initX;
    self.y = initY;

    self.color = color;
    self.strokeColor = stroke;

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

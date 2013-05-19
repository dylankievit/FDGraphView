//
//  FDDataPoint.h
//  FDGraphView
//
//  Created by Dylan Kievit on 5/11/13.
//  Copyright (c) 2013 Dylan Kievit. All rights reserved.
//


typedef enum : NSInteger {
	FDDataPointTypeStandard,
	FDDataPointTypeMajor,
	FDDataPointTypeMinor
} FDDataPointType;

@interface FDDataPoint : NSObject

- (id)initWithX:(CGFloat)initX Y:(CGFloat)initY;
- (id)initWithX:(CGFloat)initX Y:(CGFloat)initY type:(FDDataPointType)type;

- (NSComparisonResult)compareX:(FDDataPoint *)otherDataPoint;
- (NSComparisonResult)compareY:(FDDataPoint *)otherDataPoint;

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

@property (nonatomic) FDDataPointType type;

@end

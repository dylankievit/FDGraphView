//
//  FDDataPoint.h
//
//  Created by Dylan Kievit on 5/11/13.
//  Copyright (c) 2013 Dylan Kievit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDDataPoint : NSObject

- (id)initWithX:(CGFloat)initX Y:(CGFloat)initY;
- (id)initWithX:(CGFloat)initX Y:(CGFloat)initY withColor:(UIColor*)color withStroke:(UIColor *)stroke;

- (NSComparisonResult)compareX:(FDDataPoint *)otherDataPoint;
- (NSComparisonResult)compareY:(FDDataPoint *)otherDataPoint;

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *strokeColor;

@end

//
//  FDGraphView.h
//  disegno
//
//  Created by Francesco Di Lorenzo on 14/03/13.
//  Copyright (c) 2013 Francesco Di Lorenzo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDGraphView : UIView

// Data
@property (nonatomic, strong) NSArray *dataPoints;

@property (nonatomic) CGFloat minX;
@property (nonatomic) CGFloat maxX;
@property (nonatomic) CGFloat minY;
@property (nonatomic) CGFloat maxY;

// Style
@property (nonatomic) UIEdgeInsets edgeInsets;
@property (nonatomic) CGFloat dataPointsXoffset;
@property (nonatomic) BOOL drawShadow;
// -- colors
@property (nonatomic, strong) UIColor *linesColor;

// Behaviour
@property (nonatomic) BOOL autoresizeToFitData;

@end

//
//  FDGraphScrollView.h
//  FDGraphView
//
//  Created by Francesco Di Lorenzo on 20/03/13.
//  Copyright (c) 2013 Francesco Di Lorenzo. All rights reserved.
//

#import "FDGraphView.h"

@class FDGraphScrollView;

@protocol FDCaptionGraphViewDataSource <NSObject>

@optional
- (NSString *)FDGraphScrollView:(FDGraphScrollView *)graphView titleForItemAtIndex:(NSInteger)index;
- (NSString *)FDGraphScrollView:(FDGraphScrollView *)graphView subtitleForItemAtIndex:(NSInteger)index;

@end

@interface FDGraphScrollView : UIScrollView

@property (strong, nonatomic) FDGraphView *graphView;

- (void)setDataPoints:(NSArray *)dataPoints;

@end

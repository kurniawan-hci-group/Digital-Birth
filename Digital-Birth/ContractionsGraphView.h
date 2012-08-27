//
//  ContractionsGraphView.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 ContractionGraphView is a custom view that shows a graph of some value, 
 over time, continuously scrolling after every new data point is added.
 
 ContractionGraphView does not support user interaction.
 
 In Digital Birth, a ContractionGraphView is used for the contraction monitor.
 */

#import <UIKit/UIKit.h>

@interface ContractionsGraphView : UIView
{
	UIBezierPath* graph;
}

-(void) drawDataPoint:(CGFloat)value;

@end


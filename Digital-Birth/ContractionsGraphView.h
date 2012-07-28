//
//  ContractionsGraphView.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContractionsGraphView : UIView
{
//	Line* latestGraphLine;
	UIBezierPath* graph;
}

//@property (nonatomic, retain) Line* latestGraphLine;
@property (nonatomic, retain) UIBezierPath* graph;

-(void) drawDataPoint:(CGFloat)value;

@end


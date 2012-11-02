//
//  ContractionsGraphView.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ContractionsGraphView.h"

@implementation ContractionsGraphView

- (id) initWithCoder:(NSCoder *)aCoder
{
	if(self = [super initWithCoder:aCoder])
	{
		printf("initializing contractions view\n");

		graph = [UIBezierPath bezierPath];
		[graph moveToPoint:CGPointMake(0, self.frame.size.height)];
		[graph addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
		[graph retain];
    }
	return self;
}

-(void) drawDataPoint:(CGFloat)value
{
	[graph applyTransform:CGAffineTransformMakeTranslation(-3, 0)];
	[graph addLineToPoint:CGPointMake(self.frame.size.width - 12, self.frame.size.height - value)];
	
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
	[[UIColor blackColor] setStroke];
	graph.lineWidth = 1;
	[graph stroke];
}

@end



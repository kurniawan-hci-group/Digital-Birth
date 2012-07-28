//
//  ContractionsGraphView.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ContractionsGraphView.h"

@implementation ContractionsGraphView

//@synthesize latestGraphLine;
@synthesize graph;

- (id) initWithCoder:(NSCoder *)aCoder
{
	if(self = [super initWithCoder:aCoder])
	{
		printf("initializing contractions view\n");

		graph = [UIBezierPath bezierPath];
		[graph moveToPoint:CGPointMake(0, self.frame.size.height - 1)];
		[graph addLineToPoint:CGPointMake(self.frame.size.width - 1, self.frame.size.height - 1)];
		[graph retain];
    }
	return self;
}

-(void) drawDataPoint:(CGFloat)value
{
//	Point2D* newDataPoint = [[Point2D alloc] initWithX:self.frame.size.width - 50 Y:self.frame.size.height - value];
//	Line* lineToNewDataPoint = [[Line alloc] initWithPoint1:latestGraphLine.P2 Point2:newDataPoint];
//	[latestGraphLine release];
//	latestGraphLine = [lineToNewDataPoint retain];
	
	[graph applyTransform:CGAffineTransformMakeTranslation(-3, 0)];
	[graph addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height - value)];
	
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
//	CGContextRef ctx = UIGraphicsGetCurrentContext();

//	printf("redrawing...\n");
	
	[[UIColor blackColor] setStroke];
	graph.lineWidth = 1;
	[graph stroke];
	
//	printf("drawing line from %f,%f to %f,%f\n", latestGraphLine.P1.X, latestGraphLine.P1.Y, latestGraphLine.P2.X, latestGraphLine.P2.Y); 
	
//	CGContextSetRGBStrokeColor(ctx, 0, 0, 0, 1);
//	CGContextSetLineWidth(ctx, 1.0);
//	CGPoint linePoints[2] = { CGPointMake(300, 100), CGPointMake(460, 100) };
//	CGContextStrokeLineSegments(ctx, linePoints, 2);
}

@end



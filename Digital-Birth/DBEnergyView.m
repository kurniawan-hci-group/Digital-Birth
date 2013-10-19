//
//  DBEnergyView.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DBEnergyView.h"

@implementation DBEnergyView

-(float)energyLevel
{
	return energyLevel;
}

-(void)setEnergyLevel:(float)level
{
	energyLevel = level;
	[self setNeedsDisplay];
}

@synthesize fillColor;
@synthesize emptyColor;

- (id)initWithCoder:(NSCoder *)aCoder
{
    if(self = [super initWithCoder:aCoder])
	{
		energyLevel = 0.0;
		
		emptyColor = [UIColor redColor];
		fillColor = [UIColor greenColor];
		
		emptyPath = [UIBezierPath bezierPath];
		fillPath = [UIBezierPath bezierPath];
		
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Draw the empty part of the energy display.
	[emptyPath removeAllPoints];
	[emptyPath moveToPoint:CGPointMake(0, 0)];
	[emptyPath addLineToPoint:CGPointMake(self.frame.size.width, 0)];
	[emptyPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
	[emptyPath addLineToPoint:CGPointMake(0, self.frame.size.height)];
	[emptyPath closePath];
	[emptyColor setFill];
	[emptyPath fill];
	
	// Draw the filled part of the energy display.
	[fillPath removeAllPoints];
	[fillPath moveToPoint:CGPointMake(0, self.frame.size.height - energyLevel * self.frame.size.height)];
	[fillPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height - energyLevel * self.frame.size.height)];
	[fillPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
	[fillPath addLineToPoint:CGPointMake(0, self.frame.size.height)];
	[fillPath closePath];
	[fillColor setFill];
	[fillPath fill];
		
	// Draw a black rectangle around the edges.
	CGColorRef black = [UIColor blackColor].CGColor;
	CGContextSetFillColorWithColor(context, black);
	CGContextSetLineWidth(context, 1.0);
	CGContextStrokeRect(context, rectFor1PxStroke(self.bounds));
}

@end

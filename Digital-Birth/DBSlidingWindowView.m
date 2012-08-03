//
//  DBSlidingWindowView.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DBSlidingWindowView.h"

@implementation DBSlidingWindowView

#pragma mark - Accessors

-(float)targetNumber
{
	return targetNumber;
}

-(void)setTargetNumber:(float)number
{
	targetNumber = number;
	[self setNeedsDisplay];
}

-(float)windowWidth
{
	return windowWidth;
}

-(void)setWindowWidth:(float)width
{
	windowWidth = width;
	[self setNeedsDisplay];
}

-(float)currentValue
{
	return currentValue;
}

-(void)setCurrentValue:(float)value
{
	currentValue = value;
	[self setNeedsDisplay];
}

@synthesize colorOutsideWindow;
@synthesize colorInsideWindow;
@synthesize useGradient;

#pragma mark - Object lifetime

- (id) initWithCoder:(NSCoder *)aCoder
{
	if(self = [super initWithCoder:aCoder])
	{
		printf("initializing support view\n");
		
		targetNumber = 0.5;
		windowWidth = 0.1;
		currentValue = targetNumber;
		
		colorInsideWindow = [UIColor greenColor];
		[colorInsideWindow retain];
		colorOutsideWindow = [UIColor redColor];
		[colorOutsideWindow retain];
		
		outsideWindowPath = [UIBezierPath bezierPath];
		[outsideWindowPath retain];
		insideWindowPath = [UIBezierPath bezierPath];
		[insideWindowPath retain];
		targetNumberPath = [UIBezierPath bezierPath];
		[targetNumberPath retain];
		currentValuePath = [UIBezierPath bezierPath];
		[currentValuePath retain];
		
		self.backgroundColor = [UIColor clearColor];
		useGradient = NO;
	}
	return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	if(useGradient)
	{
		size_t num_locations = 3;
		CGFloat locations[3] = { 0.0, 0.5, 1.0 };
		CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
		CGFloat components[12] = { 0.0, 0.0, 0.0, 1.0,
			0.0, 0.0, 0.0, 0.0,
			0.0, 0.0, 0.0, 1.0 };
		
	//	[colorOutsideWindow getRed:&components[4] green:&components[5] blue:&components[6] alpha:&components[7]];
		const CGFloat* outsideColorComponents = CGColorGetComponents(colorOutsideWindow.CGColor);
		components[4] = outsideColorComponents[0];
		components[5] = outsideColorComponents[1];
		components[6] = outsideColorComponents[2];
		components[7] = outsideColorComponents[3];
		outsideWindowGradient = CGGradientCreateWithColorComponents (colorSpace, components,locations, num_locations);
		
	//	[colorInsideWindow getRed:&components[4] green:&components[5] blue:&components[6] alpha:&components[7]];
		const CGFloat* insideColorComponents = CGColorGetComponents(colorInsideWindow.CGColor);
		components[4] = insideColorComponents[0];
		components[5] = insideColorComponents[1];
		components[6] = insideColorComponents[2];
		components[7] = insideColorComponents[3];
		insideWindowGradient = CGGradientCreateWithColorComponents (colorSpace, components,locations, num_locations);
	}
	
	// Draw the part of the support display that's outside the "desired support" window.
	[outsideWindowPath removeAllPoints];
	[outsideWindowPath moveToPoint:CGPointMake(0, 10)];
	[outsideWindowPath addLineToPoint:CGPointMake(self.frame.size.width, 10)];
	[outsideWindowPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
	[outsideWindowPath addLineToPoint:CGPointMake(0, self.frame.size.height)];
	[outsideWindowPath closePath];
	[colorOutsideWindow setFill];
	[outsideWindowPath fill];
	
	// Draw the part of the support display that's inside the "desired support" window.
	insideWindowRect.origin.x = self.frame.size.width * (targetNumber - windowWidth);
	insideWindowRect.origin.y = 10;
	insideWindowRect.size.width = self.frame.size.width * windowWidth * 2;
	insideWindowRect.size.height = self.frame.size.height - 10;
	
	[insideWindowPath removeAllPoints];
	[insideWindowPath moveToPoint:insideWindowRect.origin];
	[insideWindowPath addLineToPoint:CGPointMake(insideWindowRect.origin.x + insideWindowRect.size.width, 10)];
	[insideWindowPath addLineToPoint:CGPointMake(insideWindowRect.origin.x + insideWindowRect.size.width, self.frame.size.height)];
	[insideWindowPath addLineToPoint:CGPointMake(insideWindowRect.origin.x, self.frame.size.height)];
	[insideWindowPath closePath];
	[colorInsideWindow setFill];
	[insideWindowPath fill];
	
	// Draw the line indicating optimal support level.
	[targetNumberPath removeAllPoints];
	[targetNumberPath moveToPoint:CGPointMake(targetNumber * self.frame.size.width, 10)];
	[targetNumberPath addLineToPoint:CGPointMake(targetNumber * self.frame.size.width, self.frame.size.height)];
	[[UIColor blackColor] setStroke];
	[targetNumberPath stroke];
	
	// Draw the marker indicating current actual support level.
	[currentValuePath removeAllPoints];
	[currentValuePath moveToPoint:CGPointMake(currentValue * self.frame.size.width, 9)];
	[currentValuePath addLineToPoint:CGPointMake(currentValue * self.frame.size.width - 3, 0)];
	[currentValuePath addLineToPoint:CGPointMake(currentValue * self.frame.size.width + 3, 0)];
	[currentValuePath closePath];
	[[UIColor blackColor] setFill];
	[currentValuePath fill];

	if(useGradient)
	{
		CGPoint myStartPoint, myEndPoint;
		myStartPoint.x = 0.0;
		myStartPoint.y = 10.0;
		myEndPoint.x = 0.0;
		myEndPoint.y = self.frame.size.height;
		CGContextDrawLinearGradient (context, outsideWindowGradient, myStartPoint, myEndPoint, 0);
	}
	
	// Draw a black rectangle around the edges.
	CGColorRef black = [UIColor blackColor].CGColor;
	CGContextSetFillColorWithColor(context, black);
	CGContextSetLineWidth(context, 1.0);
	CGRect outlineRect = rectFor1PxStroke(CGRectMake(self.bounds.origin.x, self.bounds.origin.y + 10, self.bounds.size.width, self.bounds.size.height - 10));
	CGContextStrokeRect(context, outlineRect);
}

@end

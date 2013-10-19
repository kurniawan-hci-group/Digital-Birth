//
//  DBSlidingWindowView.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DBSlidingWindowView.h"

@implementation DBSlidingWindowView
{
	float				targetNumber;
	float				windowWidth;
	float				currentValue;

	NSInteger			numPreviousValues;
	NSMutableArray*		previousValues;
		
	UIColor*			colorOutsideWindow;
	UIColor*			colorInsideWindow;
	
	UIBezierPath*		outsideWindowPath;
	CGRect				insideWindowRect;
	UIBezierPath*		insideWindowPath;
	UIBezierPath*		targetNumberPath;
	UIBezierPath*		currentValuePath;
	UIBezierPath*		previousValuePath;
//	NSMutableArray*		previousValuePaths;
	
	bool				useGradient;
	CGGradientRef		outsideWindowGradient;
	CGGradientRef		insideWindowGradient;
	
	UIImageView*		leftBracket;
	UIImageView*		rightBracket;
	UIImageView*		targetIndicator;
	UIImageView*		valueIndicator;
}

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
	if(previousValues.count >= numPreviousValues)
		[previousValues removeLastObject];
	
	[previousValues insertObject:@(currentValue) atIndex:0];
	
	currentValue = value;
	[self setNeedsDisplay];
}

@synthesize drawTrail;

-(void)clearTrail
{
	[previousValues removeAllObjects];
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
		
		drawTrail = YES;
		numPreviousValues = 100;
		previousValues = [NSMutableArray arrayWithCapacity:numPreviousValues];
		previousValues[0] = @(currentValue);
		
		colorInsideWindow = [UIColor greenColor];
		colorOutsideWindow = [UIColor redColor];
		
		outsideWindowPath = [UIBezierPath bezierPath];
		insideWindowPath = [UIBezierPath bezierPath];
		targetNumberPath = [UIBezierPath bezierPath];
		currentValuePath = [UIBezierPath bezierPath];
		previousValuePath = [UIBezierPath bezierPath];
		
//		previousValuePaths = [NSMutableArray arrayWithCapacity:numPreviousValues];
//		for(int i = 0; i < numPreviousValues; i++)
//			previousValuePaths[i] = [UIBezierPath bezierPath];
		
		self.backgroundColor = [UIColor clearColor];
		useGradient = YES;
	}
	return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Create the gradients, if necessary.
	if(useGradient)
	{
		size_t num_locations = 3;
		CGFloat locations[3] = { 0.0, 0.5, 1.0 };
		CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
		CGFloat components[12] =
			{ 0.0, 0.0, 0.0, 1.0,
			  0.0, 0.0, 0.0, 1.0,
			  0.0, 0.0, 0.0, 1.0 };
		
		const CGFloat* outsideColorComponents = CGColorGetComponents(colorOutsideWindow.CGColor);
		components[ 0] = outsideColorComponents[0] / 4;
		components[ 1] = outsideColorComponents[1] / 4;
		components[ 2] = outsideColorComponents[2] / 4;
		components[ 3] = outsideColorComponents[3];
		components[ 4] = outsideColorComponents[0];
		components[ 5] = outsideColorComponents[1];
		components[ 6] = outsideColorComponents[2];
		components[ 7] = outsideColorComponents[3];
		components[ 8] = outsideColorComponents[0] / 4;
		components[ 9] = outsideColorComponents[1] / 4;
		components[10] = outsideColorComponents[2] / 4;
		components[11] = outsideColorComponents[3];
		outsideWindowGradient = CGGradientCreateWithColorComponents (colorSpace, components,locations, num_locations);
		
		const CGFloat* insideColorComponents = CGColorGetComponents(colorInsideWindow.CGColor);
		components[ 0] = insideColorComponents[0] / 4;
		components[ 1] = insideColorComponents[1] / 4;
		components[ 2] = insideColorComponents[2] / 4;
		components[ 3] = insideColorComponents[3];
		components[ 4] = insideColorComponents[0];
		components[ 5] = insideColorComponents[1];
		components[ 6] = insideColorComponents[2];
		components[ 7] = insideColorComponents[3];
		components[ 8] = insideColorComponents[0] / 4;
		components[ 9] = insideColorComponents[1] / 4;
		components[10] = insideColorComponents[2] / 4;
		components[11] = insideColorComponents[3];
		insideWindowGradient = CGGradientCreateWithColorComponents (colorSpace, components,locations, num_locations);
	}
	
	// Draw the part of the support display that's outside the "desired support" window.
	
	if(useGradient)
	{
		CGPoint myStartPoint, myEndPoint;
		myStartPoint.x = 0.0;
		myStartPoint.y = 10.0;
		myEndPoint.x = 0.0;
		myEndPoint.y = self.frame.size.height;
		CGContextDrawLinearGradient (context, outsideWindowGradient, myStartPoint, myEndPoint, 0);
	}
	else
	{
		[outsideWindowPath removeAllPoints];
		[outsideWindowPath moveToPoint:CGPointMake(0, 10)];
		[outsideWindowPath addLineToPoint:CGPointMake(self.frame.size.width, 10)];
		[outsideWindowPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
		[outsideWindowPath addLineToPoint:CGPointMake(0, self.frame.size.height)];
		[outsideWindowPath closePath];
		[colorOutsideWindow setFill];
		[outsideWindowPath fill];
	}
	
	// Draw the part of the support display that's inside the "desired support" window.
	
	insideWindowRect.origin.x = self.frame.size.width * (targetNumber - windowWidth);
	insideWindowRect.origin.y = 10;
	insideWindowRect.size.width = self.frame.size.width * windowWidth * 2;
	insideWindowRect.size.height = self.frame.size.height - 10;
	
	if(useGradient)
	{
		CGContextSaveGState(context);

		[insideWindowPath removeAllPoints];
		[insideWindowPath moveToPoint:insideWindowRect.origin];
		[insideWindowPath addLineToPoint:CGPointMake(insideWindowRect.origin.x + insideWindowRect.size.width, 10)];
		[insideWindowPath addLineToPoint:CGPointMake(insideWindowRect.origin.x + insideWindowRect.size.width, self.frame.size.height)];
		[insideWindowPath addLineToPoint:CGPointMake(insideWindowRect.origin.x, self.frame.size.height)];
		[insideWindowPath closePath];
		CGContextAddPath(context, insideWindowPath.CGPath);
		CGContextClip(context);

		CGPoint myStartPoint, myEndPoint;
		myStartPoint.x = insideWindowRect.origin.x;
		myStartPoint.y = 10.0;
		myEndPoint.x = insideWindowRect.origin.x;
		myEndPoint.y = self.frame.size.height;
		CGContextDrawLinearGradient (context, insideWindowGradient, myStartPoint, myEndPoint, 0);
		
		CGContextRestoreGState(context);
	}
	else
	{
		[insideWindowPath removeAllPoints];
		[insideWindowPath moveToPoint:insideWindowRect.origin];
		[insideWindowPath addLineToPoint:CGPointMake(insideWindowRect.origin.x + insideWindowRect.size.width, 10)];
		[insideWindowPath addLineToPoint:CGPointMake(insideWindowRect.origin.x + insideWindowRect.size.width, self.frame.size.height)];
		[insideWindowPath addLineToPoint:CGPointMake(insideWindowRect.origin.x, self.frame.size.height)];
		[insideWindowPath closePath];
		[colorInsideWindow setFill];
		[insideWindowPath fill];
	}
	
	// Draw the line indicating optimal support level.
	[targetNumberPath removeAllPoints];
	[targetNumberPath moveToPoint:CGPointMake(targetNumber * self.frame.size.width, 10)];
	[targetNumberPath addLineToPoint:CGPointMake(targetNumber * self.frame.size.width, self.frame.size.height)];
	[[UIColor blackColor] setStroke];
	[targetNumberPath stroke];
	
	// Draw the "trail" (the markers indicating previous support levels).
	if(drawTrail)
	{
//		[previousValuePaths makeObjectsPerformSelector:@selector(removeAllPoints)];
//		
//		for(int i = 0; i < previousValues.count; i++)
//		{
//			[previousValuePaths[i] moveToPoint:CGPointMake([previousValues[i] floatValue] * self.frame.size.width, 10)];
//			[previousValuePaths[i] addLineToPoint:CGPointMake([previousValues[i] floatValue] * self.frame.size.width - 4, 0)];
//			[previousValuePaths[i] addLineToPoint:CGPointMake([previousValues[i] floatValue] * self.frame.size.width + 4, 0)];
//			[previousValuePaths[i] closePath];
//			
//			CGFloat opacity = (1.0 / (i + 2));
//			NSLog(@"opacity of trail: %f", opacity);
//			[[UIColor colorWithWhite:0.3 alpha:opacity] setFill];
//			
//			[previousValuePaths[i] fill];
//		}

		for(int i = 0; i < previousValues.count; i++)
		{
			[previousValuePath removeAllPoints];
			
			[previousValuePath moveToPoint:CGPointMake([previousValues[i] floatValue] * self.frame.size.width, 10)];
			[previousValuePath addLineToPoint:CGPointMake([previousValues[i] floatValue] * self.frame.size.width - 4, 0)];
			[previousValuePath addLineToPoint:CGPointMake([previousValues[i] floatValue] * self.frame.size.width + 4, 0)];
			[previousValuePath closePath];
			
			CGFloat opacity = (1.0 / (i + 2));
			NSLog(@"opacity of trail: %f", opacity);
			[[UIColor colorWithWhite:0.3 alpha:opacity] setFill];
			
			[previousValuePath fill];
		}
	}
	
	// Draw the marker indicating current actual support level.
	[currentValuePath removeAllPoints];
	[currentValuePath moveToPoint:CGPointMake(currentValue * self.frame.size.width, 10)];
	[currentValuePath addLineToPoint:CGPointMake(currentValue * self.frame.size.width - 4, 0)];
	[currentValuePath addLineToPoint:CGPointMake(currentValue * self.frame.size.width + 4, 0)];
	[currentValuePath closePath];
	[[UIColor blackColor] setFill];
	[currentValuePath fill];
	
	// Draw a black rectangle around the edges.
	CGColorRef black = [UIColor blackColor].CGColor;
	CGContextSetFillColorWithColor(context, black);
	CGContextSetLineWidth(context, 1.0);
	CGRect outlineRect = rectFor1PxStroke(CGRectMake(self.bounds.origin.x, self.bounds.origin.y + 10, self.bounds.size.width, self.bounds.size.height - 10));
	CGContextStrokeRect(context, outlineRect);
}

@end

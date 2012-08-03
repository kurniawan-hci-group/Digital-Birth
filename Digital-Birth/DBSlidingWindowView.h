//
//  DBSlidingWindowView.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Functions.h"

@interface DBSlidingWindowView : UIView
{
	float				targetNumber;
	float               windowWidth;
	float				currentValue;
	
	UIColor*            colorOutsideWindow;
	UIColor*            colorInsideWindow;
	
	UIBezierPath*		outsideWindowPath;
	CGRect				insideWindowRect;
	UIBezierPath*		insideWindowPath;
	UIBezierPath*		targetNumberPath;
	UIBezierPath*		currentValuePath;
	
	bool				useGradient;
	CGGradientRef		outsideWindowGradient;
	CGGradientRef		insideWindowGradient;
	
	UIImageView*        leftBracket;
	UIImageView*		rightBracket;
	UIImageView*		targetIndicator;
	UIImageView*		valueIndicator;
}

@property (nonatomic) float targetNumber;
@property (nonatomic) float windowWidth;
@property (nonatomic) float currentValue;
@property (nonatomic, retain) UIColor* colorOutsideWindow;
@property (nonatomic, retain) UIColor* colorInsideWindow;
@property (nonatomic) bool useGradient;

@end

//
//  DBEnergyView.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 DBEnergyView is a custom view that displays a vertical rectangle with
 a red color background. It fills with green color to a percent of the height
 specified by its energyLevel property.
 
 DBEnergyView does not support user interaction.
 DBEnergyView uses CoreGraphics for drawing.
 
 In Digital Birth, a DBEnergyView is used as a "tiredness meter", which shows, 
 on the main game screen, how tired the woman is.
 */

#import <UIKit/UIKit.h>
#import "Functions.h"

@interface DBEnergyView : UIView
{
	float energyLevel;
	
	UIColor* fillColor;
	UIColor* emptyColor;
	
	UIBezierPath*		emptyPath;
	CGRect				fillRect;
	UIBezierPath*		fillPath;
}

@property (nonatomic) float energyLevel;

@property (nonatomic, strong) UIColor* fillColor;
@property (nonatomic, strong) UIColor* emptyColor;

@end

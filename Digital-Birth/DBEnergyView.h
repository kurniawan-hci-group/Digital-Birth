//
//  DBEnergyView.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

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

@property (nonatomic, retain) UIColor* fillColor;
@property (nonatomic, retain) UIColor* emptyColor;

@end

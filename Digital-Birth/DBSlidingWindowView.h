//
//  DBSlidingWindowView.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 DBSlidingWindowView is a custom view that displays a horizontal rectangle
 filled with red color, a portion of which is instead colored green; a black 
 vertical line down the middle of the green region; and a downward-pointing 
 triangle outside the rectangle, at the top.
 
 The width and position of the sliding green window, and the position
 of the triangle, are adjustable with the windowWidth, targetNumber, 
 and currentValue properties, respectively.
 
 DBSlidingWindowView allows user interaction.
 
 In Digital Birth, a DBSlidingWindowView is used as the support display, 
 shown in the upper-left of the main game screen. The target number is
 desired support, the window width is the allowable variance in desired 
 support, and the current value is current support.
 */

#import <UIKit/UIKit.h>
#import "Functions.h"

@interface DBSlidingWindowView : UIView

@property float targetNumber;
@property float windowWidth;
@property float currentValue;

@property bool drawTrail;
-(void)clearTrail;

@property (nonatomic, strong) UIColor* colorOutsideWindow;
@property (nonatomic, strong) UIColor* colorInsideWindow;

@property bool useGradient;

@end

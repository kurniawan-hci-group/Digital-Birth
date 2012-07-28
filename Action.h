//
//  Action.h
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Action : NSObject
{
	int actionID;

	NSString* name;
	double effectRate;
	double successRate;

	NSString* description;
	NSString* prosString;
	NSString* consString;
	
	float supportEffect;
	float copingEffect;
	float energyEffect;
//	float focusEffect;
	float dilationEffect;
	float contractionStrengthEffect;
	float contractionFrequencyEffect;
}

@property int actionID;
@property (copy) NSString* name;
@property (copy) NSString* description;
@property double effectRate;
@property double successRate;
@property (copy) NSString* prosString;
@property (copy) NSString* consString;

@property (readonly) float supportEffect;
@property (readonly) float copingEffect;
@property (readonly) float energyEffect;
//@property (readonly) float focusEffect;
@property (readonly) float dilationEffect;
@property (readonly) float contractionStrengthEffect;
@property (readonly) float contractionFrequencyEffect;

@end

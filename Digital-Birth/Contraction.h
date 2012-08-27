//
//  Contraction.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 A Contraction object is a single contraction event. Its initial stats
 (maxStrength and totalDuration) are set at initialization. When
 -(void)start is called, a timer is instantiated, runs for the totalDuration,
 and sets the strength variable to a function of the elapsed duration
 (sine function is used for this version). When elapsedDuration reaches
 totalDuration, the timer is invalidated and the Contraction sets its own
 status to inactive.
 
 In Digital Birth, Contractions are instantiated and started by the Lady class.
 */

#import <Foundation/Foundation.h>

@interface Contraction : NSObject
{
	int strength;
	int maxStrength;
	float elapsedDuration;
	float totalDuration;
	
	bool active;
	
	NSTimer* timer;
}

@property (readonly) int strength;
@property (readonly, getter = isActive) bool active;

-(id)initWithMax:(int)max andDuration:(float)duration;
-(void)start;

@end

//
//  Contraction.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Contraction.h"
#import "Constants.h"

static int total_strength = 0;

@implementation Contraction

@synthesize strength;

-(bool)isActive
	{ return active; }

-(id)init
{
	if(self = [super init])
	{
		strength = 0;
		maxStrength = 10;
		totalDuration = 1.0;
		elapsedDuration = 0.0;
		
		active = YES;
	}
	return self;
}

-(id)initWithMax:(int)max andDuration:(float)duration
{
	if(self = [super init])
	{
		strength = 0;
		maxStrength = max;
		totalDuration = duration;
		elapsedDuration = 0.0;
		
		active = YES;
	}
	return self;
}

-(void)start
{
	timer = [NSTimer scheduledTimerWithTimeInterval:CONTRACTION_TIMER_TICK target:self selector:@selector(contractionTick:) userInfo:nil repeats:YES];
	total_strength = 0;
}

-(void)end
{
	[timer invalidate];
	timer = nil;
	active = NO;
}

-(void)contractionTick:(NSTimer*)timer
{
	total_strength += strength;
	
	strength = sin(M_PI * elapsedDuration / totalDuration) * maxStrength;
	elapsedDuration += 1.0;
	
	if(strength > maxStrength)
	{
		strength = maxStrength;
	}
	else if(strength < 0)
	{
		strength = 0;
		[self end];
		
		printf("total strength of this ctx: %d\n", total_strength);
	}
}

-(void) dealloc
{
	[super dealloc];
	[timer release];
}

@end

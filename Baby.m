//
//  Baby.m
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Baby.h"
#import "Functions.h"

@implementation Baby

@synthesize heartRate;

-(int)getNormalHR
{
	return get_random_int_with_variance(150, 29);
}

-(bool)inDistress
{
	if (heartRate > 120 && heartRate < 180)
		return NO;
	else
		return YES;
}

-(id)init
{
	if(self = [super init])
	{
		self.heartRate = [self getNormalHR];
	}
	return self;
}


@end

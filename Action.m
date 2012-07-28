//
//  Action.m
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Action.h"


@implementation Action

@synthesize actionID;
@synthesize name;
@synthesize description;
@synthesize effectRate;
@synthesize successRate;
@synthesize prosString;
@synthesize consString;

@synthesize supportEffect;
@synthesize copingEffect;
@synthesize energyEffect;
//@synthesize focusEffect;
@synthesize dilationEffect;
@synthesize contractionStrengthEffect;
@synthesize contractionFrequencyEffect;

-(id)init
{
	if (self = [super init])
	{
		actionID = 100;
		name = @"name";
		description = @"desc";
		effectRate = 50;
		successRate = 50;
		prosString = @"pros";
		consString = @"cons";
		
		supportEffect = 0;
		copingEffect = 0;
		energyEffect = 0;
//		focusEffect = 0;
		dilationEffect = 0;
		contractionStrengthEffect = 0;
		contractionFrequencyEffect = 0;
	}
	return self;
}

@end

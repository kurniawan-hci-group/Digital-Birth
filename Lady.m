//
//  Lady.m
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Lady.h"
#import "Constants.h"
#import "Functions.h"

#pragma mark - Stats class implementation

@implementation Stats

@synthesize desiredSupport;

@synthesize likesBeingTouched;
@synthesize startingEnergy;
@synthesize hatesNoise;
@synthesize fastLabor;
@synthesize painThreshold;
@synthesize needy;
@synthesize visualSensitivity;
@synthesize smellSensitivity;
@synthesize focusSkill;

@synthesize doesNotLikeYou;
@synthesize everythingIsAwesome;

-(id)init
{
	if(self = [super init])
	{
		desiredSupport = arc4random() % (int) MAX_SUPPORT;
		printf("%f\n", desiredSupport);
		
		startingEnergy = (double) arc4random() / ARC4RANDOM_MAX;
		printf("%f\n", startingEnergy);

		likesBeingTouched = (double) arc4random() / ARC4RANDOM_MAX;
		printf("%f\n", likesBeingTouched);
		hatesNoise = (double) arc4random() / ARC4RANDOM_MAX;
		printf("%f\n", hatesNoise);
		fastLabor = (double) arc4random() / ARC4RANDOM_MAX;
		printf("%f\n", fastLabor);
		painThreshold = (double) arc4random() / ARC4RANDOM_MAX;
		printf("%f\n", painThreshold);
		needy = (double) arc4random() / ARC4RANDOM_MAX;
		printf("%f\n", needy);
		visualSensitivity = (double) arc4random() / ARC4RANDOM_MAX;
		printf("%f\n", visualSensitivity);
		smellSensitivity = (double) arc4random() / ARC4RANDOM_MAX;
		printf("%f\n", smellSensitivity);
		focusSkill = (double) arc4random() / ARC4RANDOM_MAX;
		printf("%f\n", focusSkill);
		
		doesNotLikeYou = arc4random() % 2;
		printf("%d\n", doesNotLikeYou);
		everythingIsAwesome = arc4random() % 2;
		printf("%d\n", everythingIsAwesome);
	}
	return self;
}

@end


#pragma mark - Lady class implementation

@implementation Lady

#pragma mark - properties & accessors

@synthesize baby;

// Variables whose values are displayed to the user (aka "displayed stats").
@synthesize support;

// Getter method for supportWindow property.
-(float) supportWindow
{
	return (0.2 * MAX_SUPPORT) - (0.1 * dilation * 10);
}

-(float)desiredSupport
{
	return factors.desiredSupport;
}

@synthesize coping;
@synthesize energy;
//@synthesize focus;
@synthesize dilation;
@synthesize position;

// Variables that are displayed, but only on demand (not in the main view).
@synthesize effacement;
@synthesize station;

// Water broke?
@synthesize watersReleased;

// Have we had the baby already? (i.e. are we done?)
@synthesize hadBaby;

@synthesize stateOfLabor;

// Getter method for contractionStrength property.
-(int) contractionStrength
{
	int strength = 0;
	
	for(int i = 0; i < currentContractions.count; i++)
		if([[currentContractions objectAtIndex:i] strength] > strength)
			strength = [[currentContractions objectAtIndex:i] strength];
	
	return strength;
}

// Getter method for havingContraction property.
-(bool)havingContraction
{
	return currentContractions.count > 0;
}

@synthesize laborStartTime;

// Getter method for laborDuration property.
-(NSTimeInterval) laborDuration
{
	return [laborStartTime timeIntervalSinceNow];
}

#pragma mark - methods: object lifetime

-(id)init
{
	if(self = [super init])
	{
		baby = [[Baby alloc] init];
		
		// Generate initial stats here.
		factors = [[Stats alloc] init];
		
		support = factors.desiredSupport;
//		supportWindow = 0.2 * MAX_SUPPORT;
		
		coping = MAX_COPING;
		energy = MAX_ENERGY * factors.startingEnergy;
//		focus = MAX_FOCUS;
		dilation = ((double) arc4random() / ARC4RANDOM_MAX) * 3;
		position = SIT_BACKWARDS_ON_CHAIR;
		
		effacement = 0.0;
		station = -2;
		
		hadBaby = NO;
		
		stateOfLabor = EARLY;
		laborStageDuration = get_random_float_with_variance(12, 4) * 60 * 60; // 12 hours average.
		// It might be as low as 2... model that somehow.
		
		maxContractionStrength = 50.0;
		contractionDuration = 60.0;
		contractionFrequency = TWELVEMIN;
		
		currentContractions = [[NSMutableArray alloc] init];
	}
	return self;
}

-(void)dealloc
{
	[super dealloc];
	[baby release];
	[laborStartTime release];
	[contractionTimer release];
	[currentContractions release];
}

#pragma mark - methods: other

-(void)startLabor
{
	printf("starting labor\n");	

	laborStartTime = [NSDate date];
	
	// Schedule the first contraction.
	timeToNextContraction = 0;
	contractionTimer = [NSTimer scheduledTimerWithTimeInterval:timeToNextContraction target:self selector:@selector(startContraction:) userInfo:nil repeats:NO];
}

-(void)endLabor
{
	[contractionTimer invalidate];
}

// Selector for contractionTimer.
-(void)startContraction: (NSTimer*)timer
{
	static float total_time_between_contractions = 0;
	static int num_contractions = 0;

	float variance;
	float thisContractionDuration;
	float thisContractionStrength;
	
	static int contractions_without_position_switch = 0;
	
	// If the woman spends several contractions in a row in the same position, she decides to change position.
	// (Being in the same position for an extended period of time gets uncomfortable.)
	if(contractions_without_position_switch < 4 + arc4random() % 2)
		contractions_without_position_switch++;
	else
	{
		// Change positions.
		printf("It has been %d contractions without a position switch. Changing position.\n", contractions_without_position_switch);
		position = arc4random() % NUM_POSITIONS;
		
		contractions_without_position_switch = 0;
	}
	
	printf("starting a contraction\n");
	
	// Randomly determine contraction strength, between 75% and 100% of current max.
	thisContractionStrength = (0.75 + ((double) arc4random() / ARC4RANDOM_MAX) / 4) * maxContractionStrength;
	printf("this contraction will be at strength %f\n", thisContractionStrength);
	
	// Randomly determine contraction duration, with current avg duration
	// and with a variance depending on stage of labor.
	switch (stateOfLabor)
	{
		case EARLY:
			variance = 0.0;
			break;
		case LATE_ACTIVE:
		case TRANSITION:
		case ACTIVE:
		case PUSHING:
			variance = 15.0;
			break;
		default:
			break;
	}
	thisContractionDuration = get_random_float_with_variance(contractionDuration, variance);
	
	// Start the contraction.
	[currentContractions addObject:[[Contraction alloc] initWithMax:(thisContractionStrength) andDuration:contractionDuration]];
	[(Contraction*) [currentContractions objectAtIndex:(currentContractions.count - 1)] start];
	
	// Randomly determine time to next contraction, with current frequency
	// and with a variance depending on stage of labor.
	switch (stateOfLabor)
	{
		case EARLY:
			variance = 8 * 60.0;
			break;
		case ACTIVE:
		case LATE_ACTIVE:
		case PUSHING:
			variance = 1 * 60.0;
			break;
		case TRANSITION:
			variance = 0.0;
			break;
		default:
			break;
	}
	timeToNextContraction = get_random_float_with_variance(contractionFrequency, variance) * GAME_TIMER_TICK;
	printf("time to next contraction: %f\n", timeToNextContraction);

	// Schedule the next contraction.
	contractionTimer = [NSTimer scheduledTimerWithTimeInterval:timeToNextContraction target:self selector:@selector(startContraction:) userInfo:nil repeats:NO];
	
	total_time_between_contractions += timeToNextContraction;
	num_contractions++;
	
	printf("avg time between contractions: %f\n", total_time_between_contractions / num_contractions);
}

-(void)timerTick
{
	static int ticks = 0;
	static int contractions_happened = 0;
	
	// Remove any contractions that have ended (become inactive) from currentContractions.
	for(int i = 0; i < currentContractions.count; i++)
		if(![[currentContractions objectAtIndex:i] isActive])
		{
			[currentContractions removeObjectAtIndex:i];
			
			contractions_happened++;
			
			// If all happening contractions have ended, 
			// replenish half of the focus lost during a contraction.
			// NOTE: this formula is half of the average total focus lost during a contraction.
//			focus += 0.4 * (double) MAX_FOCUS / (M_PI * maxContractionStrength);

			// If all happening contractions have ended, 
			// replenish half of the coping lost during a contraction.
			// NOTE: this formula is half of the average total focus lost during a contraction.
			printf("coping before replenishment: %f\n", coping);
			coping += 0.4 * (2 * MAX_COPING * maxContractionStrength) / ((double) MAX_POSSIBLE_CONTRACTION_STRENGTH * M_PI);
			printf("coping after replenishment: %f\n", coping);

		}

	// How much stronger contractions get over this period of labor.
	// Default (starting value) is for early labor.
	static float percent_increase = 0.4;

	// Check for labor phase change;
	// generate length of labor phase, when entering said phase;
	// update contraction frequency and duration
	switch (stateOfLabor)
	{
		case EARLY:
			if(dilation >= 4.0)
			{
				stateOfLabor = ACTIVE;
				laborStageDuration = get_random_float_with_variance(8, 2) * 60 * 60; // 8 hours.
				percent_increase = 0.15;
				contractionFrequency *= 4.0/12.0;
				contractionDuration = 60;
				station++;
			}
			break;
		case ACTIVE:
			if(dilation >= 6.0)
			{
				stateOfLabor = LATE_ACTIVE;
				laborStageDuration = get_random_float_with_variance(4, 1) * 60 * 60; // 4 hours.
				percent_increase = 0.25;
				contractionFrequency *= 3.0/4.0;
				contractionDuration = 105;
				station++;
			}
			break;
		case LATE_ACTIVE:
			if(dilation >= 8.0 && dilation < 10.0)
			{
				stateOfLabor = TRANSITION;
				laborStageDuration = 1 * 60 * 60; // 1 hour.
				percent_increase = 0.0;
				contractionFrequency *= 2.0/3.0;
				contractionDuration = 105;
			}
			break;
		case TRANSITION:
			if(dilation >= 10.0)
			{
				stateOfLabor = PUSHING;
				contractionFrequency *= 5.0/2.0;
				contractionDuration = 120;
				station += (double) arc4random() / ARC4RANDOM_MAX;
			}
			break;
		case PUSHING:
			if(station >= 3.0)
			{
				stateOfLabor = BABYBORN;
				hadBaby = YES;
			}
			break;
		default:
			break;
	}

	// Increase contraction strength.
	maxContractionStrength += ((double) MAX_POSSIBLE_CONTRACTION_STRENGTH * percent_increase / laborStageDuration);
	printf("max ctx str: %f\n", maxContractionStrength);
//	printf("contractions happening: %d\n", currentContractions.count);
	
	// Dilate, if having contraction and not already fully dilated.
	if(stateOfLabor != PUSHING && self.havingContraction)
	{
		switch(stateOfLabor)
		{
			// MAGIC NUMBERS. DO NOT TOUCH.
			// Numbers are explained in comments, but that doesn't mean you can touch them.
			// Seriously. Hands off.
				
			// A certain amount of contraction strength causes a certain amount of dilation.
			// This varies by stage of labor but not by anything else.
			
			case EARLY:
				// 4.0 / (60 [expected ctx count] * ((2 [integral from 0 to pi of sin(x)]
				// * 60 [avg ctx duration] * 100 * [avg ctx str]) / pi))
				// * 1.032 [error margin of discrete integral from continuous integral
				//          (i.e. idealized curve with no discrete ticks)]
				dilation += 0.000018011797881 * self.contractionStrength;
				effacement += 0.75 / laborStageDuration;
				break;
			case ACTIVE:
				// 2.0 / (120 [expected ctx count] * ((2 [integral from 0 to pi of sin(x)]
				// * 60 [avg ctx duration] * 172 * [avg ctx str]) / pi))
				// * 1.032 [error margin of discrete integral from continuous integral
				//          (i.e. idealized curve with no discrete ticks)]
				dilation += 0.000002617993878 * self.contractionStrength;
				effacement += 0.15 / laborStageDuration;
			case LATE_ACTIVE:
				// 2.0 / (80 [expected ctx count] * ((2 [integral from 0 to pi of sin(x)]
				// * 105 [avg ctx duration] * 223 * [avg ctx str]) / pi))
				// * 1.032 [error margin of discrete integral from continuous integral
				//          (i.e. idealized curve with no discrete ticks)]
				dilation += 0.000001730794159 * self.contractionStrength;
				effacement += 0.10 / laborStageDuration;
			case TRANSITION:
				// 2.0 / (30 [expected ctx count] * ((2 [integral from 0 to pi of sin(x)]
				// * 105 [avg ctx duration] * 255 * [avg ctx str]) / pi))
				// * 1.032 [error margin of discrete integral from continuous integral
				//          (i.e. idealized curve with no discrete ticks)]
				dilation += 0.000004036257228 * self.contractionStrength;
			case PUSHING:
			default:
				break;
		}
		
		printf("dilation: %f\n", dilation);
	}

	// If pushing (and thus already fully dilated), descend baby instead.
	if(stateOfLabor == PUSHING && self.havingContraction)
	{
		// MAGIC NUMBERS. DO NOT TOUCH.
		// Numbers are explained in comments, but that doesn't mean you can touch them.
		// Seriously. Hands off.
		
		// 2.0 / (24 [expected ctx count] * ((2 [integral from 0 to pi of sin(x)]
		// * 120 [avg ctx duration] * 255 * [avg ctx str]) / pi))
		// * 1.032 [error margin of discrete integral from continuous integral
		//          (i.e. idealized curve with no discrete ticks)]
		station += 0.000005518315246 * self.contractionStrength;			
	}

	// Tick down (update) stats.
	support = MAX(support - MAX_SUPPORT * 0.001, 0);
	energy = MAX(energy - MAX_ENERGY * 0.001, 0);
	
	// Decrease focus if having contraction.
//	if(self.havingContraction)
//		focus = MAX(focus - ((MAX_FOCUS * (double) self.contractionStrength / MAX_POSSIBLE_CONTRACTION_STRENGTH) / contractionDuration), 0);
	
	// Decrease coping level if having contraction.
	if(self.havingContraction)
		coping = MAX(coping - ((MAX_COPING * (double) self.contractionStrength / MAX_POSSIBLE_CONTRACTION_STRENGTH) / contractionDuration), 0);
	printf("coping: %f\n", coping);
	
	ticks++;
	printf("%d ticks\n", ticks);
	printf("%d contractions have happened\n", contractions_happened);
}

-(bool)applyAction:(NSDictionary*)action
{
	// Return true if action successfully applied, false otherwise.
	
	printf("attempting to apply action: %s\n", [[action objectForKey:@"name"] UTF8String]);
	
	// Generate modifier (multiplier) on action effects by composing (somehow!)
	// all factors by which this action is affected.
	float aggregatedFactorMultiplier = 1;
	
	// First, look through the action's "affecting factors" set and find any
	// relevant ones.
	
	// Apply effects of actions.
	// Don't forget to do this probabilistically, based on failure chance from
	// labor stage!
	support += [[action objectForKey:@"supportEffect"] floatValue] * aggregatedFactorMultiplier;
//	coping += action.copingEffect * aggregatedFactorMultiplier;
//	energy += action.energyEffect * aggregatedFactorMultiplier;
//	focus += action.focusEffect * aggregatedFactorMultiplier;
//	dilation += action.dilationEffect * aggregatedFactorMultiplier;
//	maxContractionStrength += action.contractionStrengthEffect * aggregatedFactorMultiplier;
//	contractionFrequency += action.contractionFrequencyEffect * aggregatedFactorMultiplier;
	
	return false;
}

@end

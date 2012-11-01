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
#import "Flurry.h"

static NSDictionary* positionList;

NSString* laborStageString(laborStageType stage);

NSString* laborStageString(laborStageType stage)
{
	switch (stage) {
		case EARLY:
			return @"EARLY";
			break;
		case ACTIVE:
			return @"ACTIVE";
			break;
		case LATE_ACTIVE:
			return @"LATE_ACTIVE";
			break;
		case TRANSITION:
			return @"TRANSITION";
			break;
		case PUSHING:
			return @"PUSHING";
			break;
		case BABYBORN:
			return @"BABYBORN";
			break;
		default:
			break;
	}
}

//#pragma mark - Stats class implementation
//
//@implementation Stats
//
//@synthesize doesNotLikeYou;
//@synthesize everythingIsAwesome;
//
//-(id)init
//{
//	if(self = [super init])
//	{
//		doesNotLikeYou = arc4random() % 2;
//		printf("%d\n", doesNotLikeYou);
//		everythingIsAwesome = arc4random() % 2;
//		printf("%d\n", everythingIsAwesome);
//	}
//	return self;
//}
//
//@end
//

#pragma mark - Lady class implementation

@implementation Lady

#pragma mark - properties & accessors

@synthesize delegate;

@synthesize baby;

// Variables whose values are displayed to the user (aka "displayed stats").
@synthesize support;
@synthesize supportWindow;
@synthesize desiredSupport;

// Getter method for supportWindow property.
//-(float) supportWindow
//{
//	return 0.15 * MAX_SUPPORT;
////	return (0.2 * MAX_SUPPORT) - (dilation * 0.01 * MAX_SUPPORT);
//}

@synthesize coping;
@synthesize energy;
@synthesize sleeping;
@synthesize dilation;
@synthesize position;

// Variables that are displayed, but only on demand (not in the main view).
@synthesize effacement;
@synthesize station;

// Water broke?
@synthesize watersReleased;

// Have we had the baby already? (i.e. are we done?)
@synthesize hadBaby;

@synthesize laborStage;

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
//	return [[laborStats objectForKey:@"laborStartTime"] timeIntervalSinceNow] * -1;
	return [laborStartTime timeIntervalSinceNow] * -1;
}

@synthesize laborStats;

#pragma mark - helper methods

-(NSString*)getRandomPosition
{
	NSArray* allPositions = [positionList allKeys];
	int num_positions = [allPositions count];
	return [allPositions objectAtIndex:(arc4random() % num_positions)];
}

#pragma mark - object lifetime

-(id)init
{
	if(self = [super init])
	{
		baby = [[Baby alloc] init];
		
		// Generate initial stats here.
		NSString* factorsListPath = [[NSBundle mainBundle] pathForResource:@"Factors" ofType:@"plist"];
		NSArray* temp_factors = [NSArray arrayWithContentsOfFile:factorsListPath];
//		if(temp_factors)
//			printf("Factors list loaded successfully.\n");
//		else
//			printf("Could not load factors list!\n");
		factors = [[NSMutableDictionary alloc] init];
		for(NSString* factorName in temp_factors)
			[factors setObject:[NSNumber numberWithFloat:((double) arc4random() / ARC4RANDOM_MAX)] forKey:factorName];
			
		desiredSupport = [[factors objectForKey:@"initialDesiredSupport"] floatValue] * MAX_SUPPORT;
		support = desiredSupport;
		supportWindow = (0.1 + 0.1 * ((double) arc4random() / ARC4RANDOM_MAX)) * MAX_SUPPORT;
		
		coping = MAX_COPING;
		energy = MAX_ENERGY * (double) arc4random() / ARC4RANDOM_MAX;
		sleeping = NO;
		dilation = ((double) arc4random() / ARC4RANDOM_MAX) * 3;
		
		// Load position list.
		NSString* positionListPath = [[NSBundle mainBundle] pathForResource:@"Positions" ofType:@"plist"];
		positionList = [NSDictionary dictionaryWithContentsOfFile:positionListPath];
		if(positionList)
			printf("Position list loaded successfully.\n");
		else
			printf("Could not load position list!\n");
		[positionList retain];

		position = @"lieOnSide";
		
		effacement = 0.0;
		station = -2;
		
		hadBaby = NO;
		
		laborStage = EARLY;
		laborStageDuration = get_random_float_with_variance(12, 4) * 60 * 60; // 12 hours average.
		// It might be as low as 2... model that somehow.
		
		maxContractionStrength = 50.0;
		contractionDuration = 60.0;
		contractionFrequency = TWELVEMIN;
		contractionsWithoutPositionSwitch = 0;
		currentContractions = [[NSMutableArray alloc] init];
		
		currentActions = [[NSMutableDictionary alloc] init];
		ongoingActionTimers = [[NSMutableDictionary alloc] init];
		
		laborStats = [[NSMutableDictionary alloc] init];
		[laborStats setObject:[NSDate date] forKey:@"laborStartTime"];
		[laborStats setObject:[NSDate date] forKey:@"earlyLaborStartTime"];
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

-(void)setStartingDilation:(float)startingValue
{
	if(contractionTimer == nil)
		dilation = startingValue;
}

-(void)startLabor
{
	printf("starting labor\n");	

	laborStartTime = [NSDate date];
	[laborStartTime retain];
	
	// Schedule the first contraction.
	timeToNextContraction = 0;
	contractionTimer = [NSTimer scheduledTimerWithTimeInterval:timeToNextContraction target:self selector:@selector(startContraction:) userInfo:nil repeats:NO];
}

-(void)endLabor
{
	[contractionTimer invalidate];
	
	for(NSString* actionName in currentActions)
	{
		// Parameters for analytics event logging.
		NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
								actionName, @"action_name", 
								@"Game ended", @"termination_reason", 
								[NSNumber numberWithFloat:dilation], @"dilation", 
								[NSNumber numberWithFloat:effacement], @"effacement", 
								[NSNumber numberWithFloat:station], @"station", 
								[NSNumber numberWithFloat:support], @"support", 
								[NSNumber numberWithFloat:energy], @"energy", 
								[NSNumber numberWithFloat:maxContractionStrength], @"contraction_strength", 
								[NSNumber numberWithFloat:contractionFrequency], @"contraction_frequency", 
								nil];
		
		NSString* actionEventName = [NSString stringWithFormat:@"Action_started_%s", [actionName UTF8String]];
		[Flurry endTimedEvent:actionEventName withParameters:params];
		
		[(NSTimer*)[ongoingActionTimers objectForKey:actionName] invalidate];
		[ongoingActionTimers removeObjectForKey:actionName];
		[currentActions removeObjectForKey:actionName];		
	}
}

// Selector for contractionTimer.
-(void)startContraction:(NSTimer*)timer
{
	static float total_time_between_contractions = 0;
	static int num_contractions = 0;

	float thisContractionDuration;
	float thisContractionStrength;
	
	// If the woman spends several contractions in a row in the same position, she decides to change position.
	// (Being in the same position for an extended period of time gets uncomfortable.)
	if(contractionsWithoutPositionSwitch < 4 + arc4random() % 2)
		contractionsWithoutPositionSwitch++;
	else if(!sleeping)
	{
		// Change positions.
		printf("It has been %d contractions without a position switch. Changing position.\n", contractionsWithoutPositionSwitch);
		NSDictionary* positionChangeAction = [delegate getAction:[self getRandomPosition]];
		[self applyAction:positionChangeAction];
		printf("switching to position: %s\n", [position UTF8String]);
		
		contractionsWithoutPositionSwitch = 0;
	}
	
	printf("starting a contraction\n");
	
	// Randomly determine contraction strength, between 75% and 100% of current max.
	thisContractionStrength = (0.75 + ((double) arc4random() / ARC4RANDOM_MAX) / 4) * maxContractionStrength;
	printf("this contraction will be at strength %f\n", thisContractionStrength);
	
	// Randomly determine contraction duration, with current avg duration
	// and with a variance depending on stage of labor.
	float variance;
	switch (laborStage)
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
	
	// Inform the delegate (the game) that the contraction has started.
	[delegate contractionStarted];
	
	// Randomly determine time to next contraction, with current frequency
	// and with a variance depending on stage of labor.
	switch (laborStage)
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
	{
		if(![[currentContractions objectAtIndex:i] isActive])
		{
			[currentContractions removeObjectAtIndex:i];
			
			// If all contractions have ended, inform the delegate (game) of this.
			if([currentContractions count] == 0)
				[delegate contractionEnded];
			
			contractions_happened++;
			
			// If a contraction has ended, replenish half of the coping lost during the contraction.
			// NOTE: this formula is half of the average total coping lost during a contraction.
			printf("coping before replenishment: %f\n", coping);
			coping += 0.4 * (1.0 - 0.5 * [[factors objectForKey:@"painTolerance"] floatValue]) * (2 * MAX_COPING * maxContractionStrength) / ((double) MAX_POSSIBLE_CONTRACTION_STRENGTH * M_PI);
			printf("coping after replenishment: %f\n", coping);
		}
	}
	
	// How much stronger contractions get over this period of labor.
	// Default (starting value) is for early labor.
	static float percent_increase = 0.4;

	// Check for labor phase change;
	// generate length of labor phase, when entering said phase;
	// update contraction frequency and duration
	switch (laborStage)
	{
		case EARLY:
			if(dilation >= 4.0)
			{
				laborStage = ACTIVE;
				laborStageDuration = get_random_float_with_variance(8, 2) * 60 * 60; // 8 hours.
				percent_increase = 0.15;
				contractionFrequency *= 4.0/12.0;
				contractionDuration = 60;
				station++;
				
				[laborStats setObject:[NSDate date] forKey:@"activeLaborStartTime"];
				
				NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:([laborStartTime timeIntervalSinceNow] * -1)], @"timeSinceGameStart", nil];
				[Flurry logEvent:@"reachedActiveLabor" withParameters:params];
			}
			break;
		case ACTIVE:
			if(dilation >= 6.0)
			{
				laborStage = LATE_ACTIVE;
				laborStageDuration = get_random_float_with_variance(4, 1) * 60 * 60; // 4 hours.
				percent_increase = 0.25;
				contractionFrequency *= 3.0/4.0;
				contractionDuration = 105;
				station++;
				
				[laborStats setObject:[NSDate date] forKey:@"lateActiveLaborStartTime"];
				
				NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:([laborStartTime timeIntervalSinceNow] * -1)], @"timeSinceGameStart", nil];
				[Flurry logEvent:@"reachedLateActiveLabor" withParameters:params];
			}
			break;
		case LATE_ACTIVE:
			if(dilation >= 8.0 && dilation < 10.0)
			{
				laborStage = TRANSITION;
				laborStageDuration = 1 * 60 * 60; // 1 hour.
				percent_increase = 0.0;
				contractionFrequency *= 2.0/3.0;
				contractionDuration = 105;
				
				[laborStats setObject:[NSDate date] forKey:@"transitionStartTime"];
				
				NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:([laborStartTime timeIntervalSinceNow] * -1)], @"timeSinceGameStart", nil];
				[Flurry logEvent:@"reachedTransition" withParameters:params];
			}
			break;
		case TRANSITION:
			if(dilation >= 10.0)
			{
				laborStage = PUSHING;
				laborStageDuration = get_random_float_with_variance(3, 1) * 60 * 60; // 3 hours.
				contractionFrequency *= 5.0/2.0;
				contractionDuration = 120;
				station += (double) arc4random() / ARC4RANDOM_MAX;
				
				[laborStats setObject:[NSDate date] forKey:@"pushingStartTime"];
				
				NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:([laborStartTime timeIntervalSinceNow] * -1)], @"timeSinceGameStart", nil];
				[Flurry logEvent:@"reachedPushing" withParameters:params];
			}
			break;
		case PUSHING:
			if(station >= 3.0)
			{
				laborStage = BABYBORN;
				
				[laborStats setObject:[NSDate date] forKey:@"hadBabyTime"];
								
				NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:([laborStartTime timeIntervalSinceNow] * -1)], @"timeSinceGameStart", nil];
				[Flurry logEvent:@"hadBaby" withParameters:params];
				
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
	if(laborStage != PUSHING && self.havingContraction)
	{
		switch(laborStage)
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
                break;
			case LATE_ACTIVE:
				// 2.0 / (80 [expected ctx count] * ((2 [integral from 0 to pi of sin(x)]
				// * 105 [avg ctx duration] * 223 * [avg ctx str]) / pi))
				// * 1.032 [error margin of discrete integral from continuous integral
				//          (i.e. idealized curve with no discrete ticks)]
				dilation += 0.000001730794159 * self.contractionStrength;
				effacement += 0.10 / laborStageDuration;
                break;
			case TRANSITION:
				// 2.0 / (30 [expected ctx count] * ((2 [integral from 0 to pi of sin(x)]
				// * 105 [avg ctx duration] * 255 * [avg ctx str]) / pi))
				// * 1.032 [error margin of discrete integral from continuous integral
				//          (i.e. idealized curve with no discrete ticks)]
				dilation += 0.000004036257228 * self.contractionStrength;
                effacement = 1;
                break;
			case PUSHING:
			default:
				break;
		}
		
		printf("dilation: %f; effacement: %f\n", dilation, effacement);
	}

	// If pushing (and thus already fully dilated), descend baby instead.
	if(laborStage == PUSHING && self.havingContraction)
	{
		// MAGIC NUMBERS. DO NOT TOUCH.
		// Numbers are explained in comments, but that doesn't mean you can touch them.
		// Seriously. Hands off.
		
		// 2.0 / (24 [expected ctx count] * ((2 [integral from 0 to pi of sin(x)]
		// * 120 [avg ctx duration] * 255 * [avg ctx str]) / pi))
		// * 1.032 [error margin of discrete integral from continuous integral
		//          (i.e. idealized curve with no discrete ticks)]
		station += 0.000005518315246 * self.contractionStrength;			
		printf("station: %f\n", station);
	}

	// Tick down (update) support.
	support = MIN(MAX(support - MAX_SUPPORT * 0.001, 0), MAX_SUPPORT);

	// If awake, tick down energy; if asleep, regenerate energy.
	if(!sleeping)
		energy = MIN(MAX(energy - MAX_ENERGY * 0.001, 0), MAX_ENERGY);
	else
		energy = MIN(MAX(energy + MAX_ENERGY * 0.001, 0), MAX_ENERGY);
		
	// If tired and not having contraction, go to sleep.
	if(!sleeping && !self.havingContraction && energy < MAX_ENERGY * 0.05)
	{
		sleeping = YES;
		
		printf("Going to sleep.\n");
		
		// If already in a comfortable sleeping position, stay there; 
		// otherwise, lie on side (on the bed).
		if([[[positionList objectForKey:position] objectForKey:@"canSleep"] boolValue] == NO)
		{
			NSDictionary* positionChangeAction = [delegate getAction:@"lieOnSide"];
			[self applyAction:positionChangeAction];
			printf("switching to position: %s\n", [position UTF8String]);
			
			contractionsWithoutPositionSwitch = 0;
		}
	}
	// If having painful contraction, wake up!
	// Also wake up if energy is full.
	else if(sleeping && (self.contractionStrength / MAX_POSSIBLE_CONTRACTION_STRENGTH > 0.20 * [[factors objectForKey:@"painTolerance"] floatValue] || energy == MAX_ENERGY))
	{
		sleeping = NO;
		
		printf("Waking up.\n");
	}
	
	// Decrease coping level if having contraction.
	if(self.havingContraction)
		coping = MAX(coping - ((1.0 - 0.5 * [[factors objectForKey:@"painTolerance"] floatValue]) * (MAX_COPING * (double) self.contractionStrength / MAX_POSSIBLE_CONTRACTION_STRENGTH) / contractionDuration), 0);
	printf("coping: %f\n", coping);
	
	// Adjust coping level based on support.
	float copingAdjustmentFactor = (supportWindow - ABS(support - desiredSupport)) / supportWindow;
	coping = MAX(MIN(coping + 0.001 * MAX_COPING * copingAdjustmentFactor, MAX_COPING), 0);
	
	// Adjust desired support based on coping.
	desiredSupport = MIN([[factors objectForKey:@"initialDesiredSupport"] floatValue] * MAX_SUPPORT * (2.0 - (coping / (float) MAX_COPING)), MAX_SUPPORT);
	
	ticks++;
	printf("%d ticks\n", ticks);
	printf("%d contractions have happened\n", contractions_happened);
}

-(void)applyActionEffects:(NSMutableDictionary*)effectsOfAction
{
	support += [[effectsOfAction objectForKey:@"supportEffect"] floatValue];
	energy += [[effectsOfAction objectForKey:@"energyEffect"] floatValue];
	maxContractionStrength += [[effectsOfAction objectForKey:@"contractionStrengthEffect"] floatValue];
	contractionFrequency += [[effectsOfAction objectForKey:@"supportEffect"] floatValue];
}

-(void)actionTickWithEffects:(NSMutableDictionary*)effectsOfAction timer:(NSTimer*)timer
{
	[self applyActionEffects:effectsOfAction];
	
	int num_ticks = [[effectsOfAction objectForKey:@"num_ticks"] intValue];
	num_ticks--;
	if(num_ticks == 0)
	{
		[timer invalidate];
		[currentActions removeObjectForKey:[effectsOfAction objectForKey:@"name"]];
		
		// Parameters for analytics event logging.
		NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
								[effectsOfAction objectForKey:@"name"], @"action_name", 
								@"Action duration expired", @"termination_reason", 
								[NSNumber numberWithFloat:dilation], @"dilation", 
								[NSNumber numberWithFloat:effacement], @"effacement", 
								[NSNumber numberWithFloat:station], @"station", 
								[NSNumber numberWithFloat:support], @"support", 
								[NSNumber numberWithFloat:energy], @"energy", 
								[NSNumber numberWithFloat:maxContractionStrength], @"contraction_strength", 
								[NSNumber numberWithFloat:contractionFrequency], @"contraction_frequency", 
								nil];
		
		NSString* actionEventName = [NSString stringWithFormat:@"Action_started_%s", [[effectsOfAction objectForKey:@"name"] UTF8String]];
		[Flurry endTimedEvent:actionEventName withParameters:params];
	}
	else
		// Update the number of ticks to the new (decremented) value.
		[effectsOfAction setObject:[NSNumber numberWithInt:num_ticks] forKey:@"num_ticks"];
	
	// If the action drains energy and we're already at 0 energy, stop the action.
	if(energy == 0 && [[effectsOfAction objectForKey:@"energyEffect"] floatValue] < 0)
	{
		// Parameters for analytics event logging.
		NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
								[effectsOfAction objectForKey:@"name"], @"action_name", 
								@"Energy drained to zero", @"termination_reason", 
								[NSNumber numberWithFloat:dilation], @"dilation", 
								[NSNumber numberWithFloat:effacement], @"effacement", 
								[NSNumber numberWithFloat:station], @"station", 
								[NSNumber numberWithFloat:support], @"support", 
								[NSNumber numberWithFloat:energy], @"energy", 
								[NSNumber numberWithFloat:maxContractionStrength], @"contraction_strength", 
								[NSNumber numberWithFloat:contractionFrequency], @"contraction_frequency", 
								nil];
		
		NSString* actionEventName = [NSString stringWithFormat:@"Action_started_%s", [[effectsOfAction objectForKey:@"name"] UTF8String]];
		[Flurry endTimedEvent:actionEventName withParameters:params];
		
		[timer invalidate];
		[currentActions removeObjectForKey:[effectsOfAction objectForKey:@"name"]];
	}
}

-(bool)applyAction:(NSDictionary*)action
{
	printf("attempting to apply action: %s\n", [[action objectForKey:@"name"] UTF8String]);
	
	// Return false if not eligible for action.
	if(![self eligibleForAction:action])
	{
		printf("failed to apply action.\n");
		return false;
	}
	
	// If we're sleeping, wake up.
	if(sleeping)
		sleeping = NO;
	
	// If there are any other actions with the same tags, cancel the other action.
	for(NSString* ongoingActionName in currentActions)
	{
		if(actionsShareTags([currentActions objectForKey:ongoingActionName], action))
		{
			[(NSTimer*)[ongoingActionTimers objectForKey:ongoingActionName] invalidate];
			[ongoingActionTimers removeObjectForKey:ongoingActionName];
			[currentActions removeObjectForKey:ongoingActionName];
			
			// Parameters for analytics event logging.
			NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
									ongoingActionName, @"action_name", 
									@"Canceled by new action", @"termination_reason", 
									[NSNumber numberWithFloat:dilation], @"dilation", 
									[NSNumber numberWithFloat:effacement], @"effacement", 
									[NSNumber numberWithFloat:station], @"station", 
									[NSNumber numberWithFloat:support], @"support", 
									[NSNumber numberWithFloat:energy], @"energy", 
									[NSNumber numberWithFloat:maxContractionStrength], @"contraction_strength", 
									[NSNumber numberWithFloat:contractionFrequency], @"contraction_frequency", 
									nil];
			
			NSString* actionEventName = [NSString stringWithFormat:@"Action_started_%s", [ongoingActionName UTF8String]];
			[Flurry endTimedEvent:actionEventName withParameters:params];
		}
	}
	
	// Look through the action's "affecting factors" set and find any relevant ones.
	// Generate modifier (multiplier) on action effects by averaging in
	// all factors by which this action is affected.
	float aggregatedFactorMultiplier = 1;
	for(NSString* factorName in [action objectForKey:@"factorEffects"])
		aggregatedFactorMultiplier += [[factors objectForKey:factorName] floatValue];
	aggregatedFactorMultiplier /= [[action objectForKey:@"factorEffects"] count] + 1;
	
	// Get number of ticks. If action is instant (duration = 0), only 1 tick.
	NSNumber* num_ticks;
	if([[action objectForKey:@"duration"] intValue] == 0)
		num_ticks = [NSNumber numberWithInt:1];
	else
		num_ticks = [NSNumber numberWithInt:[[action objectForKey:@"duration"] intValue]];
	
	// Calculate effects of action.
	NSNumber* supportEffect = [NSNumber numberWithFloat: [[[action objectForKey:@"supportEffect"] objectForKey:laborStageString(laborStage)] floatValue] * MAX_SUPPORT * aggregatedFactorMultiplier / [num_ticks intValue]];
	NSNumber* energyEffect = [NSNumber numberWithFloat: [[[action objectForKey:@"energyEffect"] objectForKey:laborStageString(laborStage)] floatValue] * MAX_ENERGY * aggregatedFactorMultiplier / [num_ticks intValue]];
	NSNumber* contractionStrengthEffect = [NSNumber numberWithFloat: [[[action objectForKey:@"contractionStrengthEffect"] objectForKey:laborStageString(laborStage)] floatValue] * aggregatedFactorMultiplier / [num_ticks intValue]];
	NSNumber* contractionFrequencyEffect = [NSNumber numberWithFloat: [[[action objectForKey:@"contractionFrequencyEffect"] objectForKey:laborStageString(laborStage)] floatValue] * aggregatedFactorMultiplier / [num_ticks intValue]];
	
	NSMutableDictionary* effectsOfAction = [NSMutableDictionary dictionaryWithObjectsAndKeys:
									 supportEffect, @"supportEffect", 
									 energyEffect, @"energyEffect", 
									 contractionStrengthEffect, @"contractionStrengthEffect", 
									 contractionFrequencyEffect, @"contractionFrequencyEffect", 
									 num_ticks, @"num_ticks",
									 [action objectForKey:@"name"], @"name", nil];
	
	// Parameters for analytics event logging.
	NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
							[action objectForKey:@"name"], @"action_name", 
							[NSNumber numberWithFloat:dilation], @"dilation", 
							[NSNumber numberWithFloat:effacement], @"effacement", 
							[NSNumber numberWithFloat:station], @"station", 
							[NSNumber numberWithFloat:support], @"support", 
							[NSNumber numberWithFloat:energy], @"energy", 
							[NSNumber numberWithFloat:maxContractionStrength], @"contraction_strength", 
							[NSNumber numberWithFloat:contractionFrequency], @"contraction_frequency", 
							nil];
	
	// If only 1 tick, simply apply the action.
	if([num_ticks intValue] == 1)
	{
		[self applyActionEffects:effectsOfAction];
		
		NSString* actionEventName = [NSString stringWithFormat:@"Action_performed_%s", [[action objectForKey:@"name"] UTF8String]];
		[Flurry logEvent:actionEventName withParameters:params];
	}
	// If > 1 tick, generate an invocation with effectsOfAction and apply effects with a timer.
	else
	{
		NSMethodSignature* sig = [self methodSignatureForSelector:@selector(actionTickWithEffects:timer:)];
		NSInvocation* inv = [NSInvocation invocationWithMethodSignature:sig];
		NSTimer* actionTickTimer = [NSTimer timerWithTimeInterval:GAME_TIMER_TICK invocation:inv repeats:YES];
		[inv setSelector:@selector(actionTickWithEffects:timer:)];
		[inv setTarget:self];
		[inv setArgument:&effectsOfAction atIndex:2];
		[inv setArgument:&actionTickTimer atIndex:3];
		[[NSRunLoop currentRunLoop] addTimer:actionTickTimer forMode:NSDefaultRunLoopMode];
		
		// Add the action to currentActions.
		[currentActions setObject:action forKey:[action objectForKey:@"name"]];
		[ongoingActionTimers setObject:actionTickTimer forKey:[action objectForKey:@"name"]];
		
		NSString* actionEventName = [NSString stringWithFormat:@"Action_started_%s", [[action objectForKey:@"name"] UTF8String]];
		[Flurry logEvent:actionEventName withParameters:params timed:YES];
	}
	
	// *** SPECIAL CASES ***
	
	// If the action is a position change action, change the current position.
	if(isPosition(action))
	{
		position = [action objectForKey:@"name"];
		contractionsWithoutPositionSwitch = 0;
		
		// Inform the delegate (the game) that position has been changed.
		[delegate positionChanged];
	}
	
	// If the action is rubTummy, immediately begin the next contraction.
	if([(NSString*)[action objectForKey:@"name"] isEqualToString:@"rubTummy"])
	{
		[contractionTimer fire];
	}
	
	// *** END SPECIAL CASES ***
	
	return true;
}

-(bool)eligibleForAction:(NSDictionary*)action
{
	// Return false if not enough energy.
	if(energy + [[[action objectForKey:@"energyEffect"] objectForKey:laborStageString(laborStage)] floatValue] < 0.0)
		return false;
	
	// Return false if this action does nothing in this labor stage.
	if(!([[[action objectForKey:@"supportEffect"] objectForKey:laborStageString(laborStage)] floatValue] || [[[action objectForKey:@"energyEffect"] objectForKey:laborStageString(laborStage)] floatValue] || [[[action objectForKey:@"contractionStrengthEffect"] objectForKey:laborStageString(laborStage)] floatValue] || [[[action objectForKey:@"contractionFrequencyEffect"] objectForKey:laborStageString(laborStage)] floatValue]))
		return false;
	
	return true;
}

@end

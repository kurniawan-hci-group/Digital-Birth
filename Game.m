//
//  Game.m
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Game.h"
#import "Lady.h"
#import "Constants.h"
#import "Flurry.h"

static NSDictionary* actionList;

float GAME_TIMER_TICK;
float CONTRACTION_TIMER_TICK;

@implementation Game

@synthesize delegate;

@synthesize gameStatus;
@synthesize playerScore;

//@synthesize actionList;

#pragma mark - Object lifetime

-(id)init
{
	if(self = [super init])
	{
		lady = [[Lady alloc] init];
		lady.delegate = self;
		gameStatus = IN_PROGRESS;
		
		// Load the action list.
		actionList = [Game actionList];
	}
	return self;
}

#pragma mark - Methods

-(void)setStartingDilation:(float)dilation
{
	if(gameTimer == nil)
		[lady setStartingDilation:dilation];
}

-(void)startGame
{
	NSDictionary* params = @{@"gameSpeed": @((int) (1.0/GAME_TIMER_TICK))};
	[Flurry logEvent:@"Game_started" withParameters:params timed:YES];
	
	gameTimer = [NSTimer scheduledTimerWithTimeInterval:GAME_TIMER_TICK target:self selector:@selector(gameTimerTick:) userInfo:nil repeats:YES];
	
	[lady startLabor];
}

-(void)endGame
{
	NSDictionary* params = @{@"laborDuration": @(lady.laborDuration)};
	[Flurry endTimedEvent:@"Game_started" withParameters:params];
}

+(NSDictionary*)loadActionList
{
	NSString* actionListPath = [[NSBundle mainBundle] pathForResource:@"Actions" ofType:@"plist"];
	actionList = [NSDictionary dictionaryWithContentsOfFile:actionListPath];
	if(actionList)
		printf("Action list loaded successfully.\n");
	else
		printf("Could not load action list!\n");
	return actionList;
}

+(NSDictionary*)actionList
{
	if(actionList == nil)
		[Game loadActionList];
	
	return actionList;
}

-(void)gameTimerTick:(NSTimer*)timer
{
	static int consecutive_ticks_of_bad_support = 0;
	static int total_ticks_of_bad_support = 0;
	
	[lady timerTick];
	
	if(lady.hadBaby)
	{
		[gameTimer invalidate];
		// Consider NOT ending labor after baby is born. After all, contractions continue after birth, right?
		[lady endLabor];
		gameStatus = WON_GAME;
		
		// Determine player grade.
		if(total_ticks_of_bad_support < 60.0)
			playerScore = 99;
		else if(total_ticks_of_bad_support < 3 * 60.0)
			playerScore = 89;
		else if(total_ticks_of_bad_support < 5 * 60.0)
			playerScore = 79;
		else if(total_ticks_of_bad_support < 7 * 60.0)
			playerScore = 69;
		else
			playerScore = 50;
	}
	else if(lady.support > lady.desiredSupport + lady.supportWindow || lady.support < lady.desiredSupport - lady.supportWindow)
	{
		total_ticks_of_bad_support++;
		consecutive_ticks_of_bad_support++;
		
		if(consecutive_ticks_of_bad_support > 10 * 60.0)
		{
			[gameTimer invalidate];
			[lady endLabor];
			gameStatus = LOST_GAME;
			
			playerScore = 50;
		}
	}
	else
		consecutive_ticks_of_bad_support = 0;
}

-(bool)performAction:(NSString*)actionName
{
	if(actionList[actionName])
	{
		printf("attempting to perform action: %s\n", [actionName UTF8String]);
		if([lady applyAction:actionList[actionName]])
			return true;
		else
		{
			printf("could not perform action: %s\n", [actionName UTF8String]);
			return false;
		}
	}
	else
	{
		printf("action with name \"%s\" not found\n", [actionName UTF8String]);
		return false;
	}
}

-(NSTimeInterval)getCooldown:(NSString*)actionName
{
	return (NSTimeInterval) [actionList[actionName][@"cooldown"] floatValue];
}

-(bool)canPerformAction:(NSString*)actionName
{
	return [lady eligibleForAction:actionList[actionName]];
}

#pragma mark - Delegate methods

-(NSDictionary*)getAction:(NSString*)actionName
{
	return actionList[actionName];
}

-(void)contractionStarted
{
	// Pass along to the delegate (the view controller) that a contraction has started.
	[delegate contractionStarted];
}

-(void)contractionEnded
{
	// Pass along to the delegate (the view controller) that a contraction has ended.
	[delegate contractionEnded];
}

-(void)positionChanged
{
	// Instruct the delegate (the view controller) to update display of the woman's position.
	[delegate displayPosition];
}

-(void)copingChanged
{
	printf("coping changed, requesting VC to display it...\n");
	
	// Instruct the delegate (the view controller) to show, and pulse, the coping scale display.
	[delegate pulseCoping];
}

#pragma mark - Accessors

-(int)getBabyHeartRate
{
	return lady.baby.heartRate;
}

-(bool)babyIsDistressed
{
	return lady.baby.inDistress;
}

-(float)getSupport
{
	return lady.support;
}

-(float)getDesiredSupport
{
	return lady.desiredSupport;
}

-(float)getSupportWindow
{
	return lady.supportWindow;
}

-(int)getCoping
{
	// Round to the nearest integer.
	return (int) floor(lady.coping + 0.5);
}

-(float)getEnergy
{
	return lady.energy;
}

-(bool)isSleeping
{
	return lady.sleeping;
}

-(int)getDilation
{
	return lady.dilation;
}

-(NSString*)getPosition
{
	return lady.position;
}

-(float)getEffacement
{
	return lady.effacement <= 1.0 ? lady.effacement : 1.0;
}

-(int)getStation
{
	// Round to the nearest integer.
	return (int) floor(lady.station + 0.5);
}

-(int)getContractionStrength
{
	return lady.contractionStrength;
}

-(bool)hadBaby
{
	return lady.hadBaby;
}

-(bool)watersReleased
{
	return lady.watersReleased;
}

-(NSTimeInterval)getLaborDuration
{
	return lady.laborDuration;
}

-(NSDictionary*)getLaborStats
{
	return lady.laborStats;
}

@end

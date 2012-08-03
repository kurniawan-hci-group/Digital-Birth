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

@synthesize lady;
@synthesize gameStatus;
@synthesize playerScore;
@synthesize gameTimer;

#pragma mark - Object lifetime

-(id)init
{
	if(self = [super init])
	{
		lady = [[Lady alloc] init];
		gameStatus = IN_PROGRESS;
		
//		GAME_TIMER_TICK = .01;
//		CONTRACTION_TIMER_TICK = .01;
		
		// Load the action list.
		NSString* actionListPath = [[NSBundle mainBundle] pathForResource:@"Actions" ofType:@"plist"];
		actionList = [NSDictionary dictionaryWithContentsOfFile:actionListPath];
		if(actionList)
			printf("Action list loaded successfully.\n");
		else
			printf("Could not load action list!\n");
		[actionList retain];
	}
	return self;
}

#pragma mark - Methods

-(void)startGame
{
	[Flurry logEvent:@"Game_started" timed:YES];
	
	gameTimer = [NSTimer scheduledTimerWithTimeInterval:GAME_TIMER_TICK target:self selector:@selector(gameTimerTick:) userInfo:nil repeats:YES];
	
	[self.lady startLabor];
}

-(void)endGame
{
	[Flurry endTimedEvent:@"Game_started" withParameters:nil];
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
	if([actionList objectForKey:actionName])
	{
		printf("attempting to perform action: %s\n", [actionName UTF8String]);
		if([self.lady applyAction:[actionList objectForKey:actionName]])
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
	return (NSTimeInterval) [[[actionList objectForKey:actionName] objectForKey:@"cooldown"] floatValue];
}

#pragma mark - Accessors

-(int)getBabyHR
{
	return self.lady.baby.heartRate;
}

-(bool)babyIsDistressed
{
	return self.lady.baby.inDistress;
}

-(float)getSupport
{
	return self.lady.support;
}

-(float)getDesiredSupport
{
	return self.lady.desiredSupport;
}

-(float)getSupportWindow
{
	return self.lady.supportWindow;
}

-(int)getCoping
{
	// Round to the nearest integer.
	return (int) floor(self.lady.coping + 0.5);
}

-(float)getEnergy
{
	return self.lady.energy;
}

-(int)getDilation
{
	return self.lady.dilation;
}

-(positionType)getPosition
{
	return self.lady.position;
}

-(float)getEffacement
{
	return self.lady.effacement <= 1.0 ? self.lady.effacement : 1.0;
}

-(int)getStation
{
	// Round to the nearest integer.
	return (int) floor(self.lady.station + 0.5);
}

-(int)getContractionStrength
{
	return self.lady.contractionStrength;
}

-(bool)hadBaby
{
	return self.lady.hadBaby;
}

-(bool)watersReleased
{
	return self.lady.watersReleased;
}

-(void)dealloc
{
	[lady release];
	[actionList release];
	[super dealloc];
}

@end

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

static NSMutableDictionary* actionList;

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
		
		actionList = [[NSMutableDictionary alloc] init];

		// Code to load the actions from a file (xml?) and add them to the actionList.
		// For now, the following placeholder test code.
		Action* action;
		action = [[Action alloc] init];
//		action.supportEffect = 0.01 * MAX_SUPPORT;
		[actionList setObject:action forKey:@"lightTouchMassage"];
		[action release];
	}
	return self;
}

#pragma mark - Methods

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

-(void)startGame
{
	gameTimer = [NSTimer scheduledTimerWithTimeInterval:GAME_TIMER_TICK target:self selector:@selector(gameTimerTick:) userInfo:nil repeats:YES];

	[self.lady startLabor];
}

-(void)performAction:(NSString*)actionName
{
	if([actionList objectForKey:actionName])
	{
		printf("performing action: %s\n", [actionName UTF8String]);
		[self.lady applyAction:[actionList objectForKey:actionName]];
	}
	else
		printf("action with name \"%s\" not found\n", [actionName UTF8String]);
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

//-(int)getFocus
//{
//	// Round to the nearest integer.
//	return (int) floor(self.lady.focus + 0.5);
//}
//
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
	[super dealloc];
}

@end

//
//  Lady.m
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Lady.h"
#import "Constants.h"

@implementation Lady

@synthesize baby;

// Variables whose values are displayed to the user (aka "displayed stats").
@synthesize support;
@synthesize tiredness;
@synthesize hunger;
@synthesize focus;
@synthesize dilation;

// Variables that are displayed, but only on demand (not in the main view).
@synthesize effacement;
@synthesize station;

// Have we had the baby already? (i.e. are we done?)
@synthesize hadBaby;

// Deprecated variables.
//@synthesize energy;
//@synthesize copingNum;

// Internal variables.
@synthesize strengthOfContractions;

@synthesize contractionNum;
@synthesize stateOfLabor;
@synthesize chanceOfContraction;
@synthesize havingContraction;

@synthesize start = _start;
@synthesize incrContraction = _incrContraction;
//@synthesize timeSinceLastContraction = _timeSinceLastContraction;
@synthesize contractionTimer = _contractionTimer;

//randomly choose number between 1 and 10
//-(int)getInitialCopingNum
//{
//	int r = arc4random() %10;
//	if (r == 0)
//	{
//		return 10;
//	}
//	else
//	{
//		return r;
//	}
//}

-(void)printFloat:(float)num withMessage:(NSString*)msg
{
	NSString *a = [msg stringByAppendingString:@" %f"];
	NSLog(a, [NSString stringWithFormat:@"%f", num]);
}

-(id)init
{
	if(self = [super init])
	{
		self.baby = [[Baby alloc] init];
		
		// CHANGE this to be like, initial support = optimal support?
		self.support = MAX_SUPPORT / 2;
		
		// CHANGE this to be dependent on whether the woman has slept, i.e. if hasn't slept then tiredness is some bigger number, else it's 0.
		self.tiredness = 0;
		
		self.hunger = 0;
		
		self.focus = 0;
		
		self.dilation = 1;
		self.effacement = 1; //???
		self.station = 1;
		
		self.strengthOfContractions = 0;
		
		self.hadBaby = NO;
		
//		self.energy = 255;
//		self.copingNum = [self getInitialCopingNum];

		self.contractionNum = 0;
		self.stateOfLabor = ACTIVE;
		self.chanceOfContraction = 100;
		self.havingContraction = NO;
		self.incrContraction = YES;
	}
	return self;
}

-(void)startLabor
{
	
}

-(void)endContraction
{
	[self.contractionTimer invalidate];
	self.contractionTimer = nil;
	self.havingContraction = NO;
	self.contractionNum = 0;
	NSLog(@"contractionNum: %d", self.contractionNum);
	self.incrContraction = YES;
	self.chanceOfContraction = 0;
}

-(void)changeContractionNumBy:(int)number greaterThan:(int)max
{
	if (self.incrContraction)
	{
		if (self.contractionNum >= max)
		{
			self.incrContraction = NO;
			self.contractionNum -= number;
		}
		self.contractionNum += number; 
	}
	else
	{
		if (self.contractionNum <= 0)
		{
			[self endContraction];
			//reevaluate lady's focus and energy, etc.?
		}
		else
		{
			self.contractionNum -= number;
		}
	}
}

-(int)getRandomBetween:(int)low and:(int)high
{
	int diff = high - low;
	int rand = arc4random() %diff;
	return rand + low;
}

//selector for contractionTimer
-(void)incrementContractionNum:(NSTimer*)timer
{
	//NSTimeInterval a = -[self.start timeIntervalSinceNow];
//	NSString *timeString = [NSString stringWithFormat:@"%f", a];
//	NSLog(@"interval %@", timeString);
	if (self.stateOfLabor == EARLY)
	{
		NSLog(@"Contraction Strength %d", self.contractionNum);
		//use 100/15 = 6.6
		int low = 5; //6 - 1
		int high = 9; // 6 + 3
		int maxContractionStrength = 100;
		int num = [self getRandomBetween:low and:high];
		[self changeContractionNumBy:num greaterThan:maxContractionStrength];
		//increment contractionNum
		//effect focus, energy, support?
		
	}
	else if (self.stateOfLabor == ACTIVE)
	{
		NSLog(@"Contraction Strength %d", self.contractionNum);
	   //use 200/22.5 = 8.8
		int low = 8;
	   int high = 11;
	   int maxContractionStrength = 200;
	   int num = [self getRandomBetween:low and:high];
	   [self changeContractionNumBy:num greaterThan:maxContractionStrength];
	}
	else if (self.stateOfLabor == TRANSITION)
	{
	   //use 255/30 = 8.5
	   int low = 7;
	   int high = 11;
	   int maxContractionStrength = 255;
	   int num = [self getRandomBetween:low and:high];
	   [self changeContractionNumBy:num greaterThan:maxContractionStrength];
	}
	else if (self.stateOfLabor == PUSHING)
	{
	   //use 255/30 = 8.5
	   int low = 6;
	   int high = 11;
	   int maxContractionStrength = 255;
	   int num = [self getRandomBetween:low and:high];
	   [self changeContractionNumBy:num greaterThan:maxContractionStrength];
	}
	/*else if (self.stateOfLabor == BABYBORN)
	{
		<#statements#>
	}
	*/
}

-(void)startContraction
{
	NSLog(@"start contraction");
	self.havingContraction = YES;
	self.start = [NSDate date];
	NSLog(@"start: %f", [NSString stringWithFormat:@"%f", self.start]);
	self.contractionTimer = [NSTimer scheduledTimerWithTimeInterval:1 
									 target:self 
									 selector:@selector(incrementContractionNum:) 
									 userInfo:nil 
									 repeats:YES];
}

//gets called 
-(void)increaseChanceOfContraction
{
	
	//[self printFloat:self.start withMessage:@"start:"];
	NSLog(@"Increase chance of contraction");
	NSTimeInterval timeSinceLastContraction = ([self.start timeIntervalSinceNow]);
	//NSString *timeString = [NSString stringWithFormat:@"%f", timeSinceLastContraction];
	NSLog(@"Chance of Contraction: %d", self.chanceOfContraction);
	if (self.stateOfLabor == EARLY)
	{
		if (timeSinceLastContraction < FIVEMIN)
		{
			self.chanceOfContraction = 0;
		}
		else if (timeSinceLastContraction < TENMIN)
		{
			self.chanceOfContraction += 1;
		}
		else if (timeSinceLastContraction < FIFTEENMIN)
		{
			self.chanceOfContraction += 1;
		}
		else if (timeSinceLastContraction < TWENTYMIN)
		{
			self.chanceOfContraction += 2;
		}
		else
		{
			self.chanceOfContraction += 2;
		}
	}
	else if (self.stateOfLabor == ACTIVE)
	{
		if (timeSinceLastContraction < THREEMIN)
		{
			self.chanceOfContraction += 1;
		}
		else if (timeSinceLastContraction < FOURMIN)
		{
			self.chanceOfContraction += 10;
		}
		else if (timeSinceLastContraction < FIVEMIN)
		{
			self.chanceOfContraction += 10;
		}
		else
		{
			self.chanceOfContraction += 2;
		}
	}
	/*
	else if (self.stateOfLabor == TRANSITION)
	{
		<#statements#>
	}
	else if (self.stateOfLabor == PUSHING)
	{
		<#statements#>
	}
	else if (self.stateOfLabor == BABYBORN)
	{
		<#statements#>
	}
	*/
}



-(void)dealloc
{
	[super dealloc];
	[baby release];
	//[_start release];
	//[_timeSinceLastContraction release];
	[_contractionTimer release];
}

@end

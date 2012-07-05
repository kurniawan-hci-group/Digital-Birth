//
//  Game.m
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Game.h"
#import "Lady.h"

@implementation Game

@synthesize lady;

-(id)init
{
	if(self = [super init])
	{
		self.lady = [[Lady alloc] init];
	}
	return self;
}


-(void)handleTimerTick
{
	self.lady.strengthOfContractions++;
	
//	int rand = arc4random() %100;
//	if(!self.lady.havingContraction)
//	{
//		if (rand < self.lady.chanceOfContraction)
//		{
//			NSLog(@"Rand: %d Chance: %d", rand, self.lady.chanceOfContraction);
//			[self.lady startContraction];
//			
//		}
//		else
//		{
//			[self.lady increaseChanceOfContraction];
//		}
//	}
}

-(int)getBabyHR
{
	return self.lady.baby.heartRate;
}

-(bool)babyIsDistressed
{
	return [[self.lady baby] inDistress];
}

-(int)getSupport
{
	return self.lady.support;
}

-(int)getHunger
{
	return self.lady.hunger;
}

-(int)getTiredness
{
	return self.lady.tiredness;
}

-(int)getFocus
{
	return self.lady.focus;
}

-(int)getDilation
{
	return self.lady.dilation;
}

-(int)getEffacement
{
	return self.lady.effacement;
}

-(int)getStation
{
	return self.lady.station;
}

-(int)getContractionStrength
{
	return self.lady.strengthOfContractions;
}

//-(int)getContractionNum
//{ //0 no contraction, 255 contraction peak
//	return self.lady.contractionNum;
//}

-(bool)hadBaby
{
	return self.lady.hadBaby;
}

//-(void)performAction:(*Action) action
//{
//
//}


-(void)dealloc
{
	[lady release];
	[super dealloc];
}

@end

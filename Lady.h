//
//  Lady.h
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Baby.h"

@interface Lady : NSObject
{
	Baby *baby;

	float support;
	float tiredness;
	float hunger;
	int focus;
	float dilation;

	float effacement;
	int station;
	
	bool hadBaby;
	
	//	int energy;
	//	int copingNum;
	
	int strengthOfContractions;

	int contractionNum;
	int stateOfLabor;
	int chanceOfContraction;
	bool havingContraction;
	bool incrContraction;
	NSDate *start;
	//NSTimeInterval _timeSinceLastContraction;
	NSTimer *contractionTimer;
}

@property (nonatomic, retain) Baby *baby;

@property float support;
@property float tiredness;
@property float hunger;
@property int focus;
@property float dilation;

@property float effacement;
@property int station;

@property bool hadBaby;

//@property int energy;
//@property int copingNum;

@property int strengthOfContractions;

@property int contractionNum;
@property int stateOfLabor;
@property int chanceOfContraction;
@property bool havingContraction;
@property bool incrContraction;
@property (nonatomic, retain) NSDate *start;
//@property NSTimeInterval timeSinceLastContraction;
@property (nonatomic, retain) NSTimer *contractionTimer;

-(void)startLabor;
-(void)startContraction;
-(void)increaseChanceOfContraction;

@end

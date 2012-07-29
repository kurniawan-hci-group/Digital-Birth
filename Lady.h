//
//  Lady.h
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Baby.h"
#import "Contraction.h"

typedef enum
{
	EARLY,
	ACTIVE,
	LATE_ACTIVE,
	TRANSITION,
	PUSHING,
	BABYBORN
} laborStage;

typedef enum
{
	WALK,
	STAND,
	SLOW_DANCE,
	LEAN_ON_WALL,
	ROCKING_CHAIR,
	SIT_BACKWARDS_ON_CHAIR,
	SIT_ON_BIRTH_BALL,
	LUNGE_ON_STAIR,
	KNEEL,
	SQUAT,
	CRAWL,
	LIE_ON_SIDE,
	ALL_FOURS,
	TOILET,
	BOTTOM_IN_AIR
} positionType;

#define NUM_POSITIONS	15

@interface Stats : NSObject
{
	// Initial stats ("factors") — these influence how the woman responds to various actions
	
	float desiredSupport;
	
	float likesBeingTouched;
	float startingEnergy;
	float hatesNoise;
	float fastLabor;
	float painThreshold;
	float needy;
	float visualSensitivity;
	float smellSensitivity;
	float focusSkill;
	
	bool doesNotLikeYou;
	bool everythingIsAwesome;
}

@property (readonly) float desiredSupport;

@property (readonly) float likesBeingTouched;
@property (readonly) float startingEnergy;
@property (readonly) float hatesNoise;
@property (readonly) float fastLabor;
@property (readonly) float painThreshold;
@property (readonly) float needy;
@property (readonly) float visualSensitivity;
@property (readonly) float smellSensitivity;
@property (readonly) float focusSkill;

@property (readonly) bool doesNotLikeYou;
@property (readonly) bool everythingIsAwesome;

@end


@interface Lady : NSObject
{
	Baby *baby;

	float support;
//	float supportWindow;
	
	float coping;
	float energy;
//	float focus;
	float dilation;
	positionType position;

	float effacement;
	float station;
	
	bool watersReleased;
	bool hadBaby;
	
	laborStage stateOfLabor;
	float laborStageDuration;
	
	// Initial stats ("factors").
//	NSMutableDictionary* factors;
	Stats* factors;

	// Variables for the contraction model.
	float timeToNextContraction;
	float maxContractionStrength;
	float contractionDuration;
	float contractionFrequency;
	NSTimer* contractionTimer;
	NSMutableArray* currentContractions;

	NSDate* laborStartTime;
	
}

@property (nonatomic, readonly) Baby *baby;

@property (readonly) float support;
@property (readonly) float supportWindow;
@property (readonly) float desiredSupport;

@property (readonly) float coping;
@property (readonly) float energy;
//@property (readonly) float focus;
@property (readonly) float dilation;
@property (readonly) positionType position;

@property (readonly) float effacement;
@property (readonly) float station;

@property (readonly) bool watersReleased;
@property (readonly) bool hadBaby;

@property (readonly) laborStage stateOfLabor;

@property (readonly) int contractionStrength;
@property (readonly) bool havingContraction;

@property (nonatomic, readonly) NSDate* laborStartTime;
@property (readonly) NSTimeInterval laborDuration;

-(void)startLabor;
-(void)endLabor;
-(void)timerTick;
-(bool)applyAction:(NSDictionary*)action;

@end

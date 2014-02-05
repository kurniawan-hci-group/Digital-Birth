//
//  Lady.h
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
/*
 The Lady class represents the woman in labor, and is the main implementation 
 of the data model of Digital Birth.
 
 A Lady contains a Baby object; the Baby doesn't do anything interesting
 (in this version).
 
 A Lady contains a timer (on the main run loop), that fires with a frequency
 specified by the game's game speed setting. On every tick of the timer, a number 
 of internal stats are updated, labor stage transitions are checked for, and 
 various other data model tasks are performed. See the -(void)timerTick method
 for details.
 
 Another timer schedules contractions. When the timer fires, the 
 -(void)startContraction: method is called; a Contraction is instantiated and 
 added to the currentContractions array; and the next contraction is scheduled.
 See Contraction.h for details.
 
 The Lady class also has an API for applying player actions: the 
 -(bool)eligibleForAction: and -(bool)applyAction: methods. See those
 method descriptions for details.
 */

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
} laborStageType;

NSString* laborStageString(laborStageType stage);

//@interface Stats : NSObject
//{
//	// Initial stats ("factors") — these influence how the woman responds to various actions
//	
//	float initialDesiredSupport;
//	
//	bool doesNotLikeYou;
//	bool everythingIsAwesome;
//}
//
//@property (readonly) bool doesNotLikeYou;
//@property (readonly) bool everythingIsAwesome;
//
//@end
//
@protocol LadyDelegate <NSObject>

-(NSDictionary*)getAction:(NSString*)actionName;
-(void)contractionStarted;
-(void)contractionEnded;
-(void)positionChanged;
-(void)copingChanged;

@end

@interface Lady : NSObject
{
	id <LadyDelegate> __weak delegate;
	
	Baby* baby;

	float support;
	float supportWindow;
	float desiredSupport;
	
	float coping;
	float energy;
	bool sleeping;
	float dilation;
	NSString* position;

	float effacement;
	float station;
	
	bool watersReleased;
	bool hadBaby;
	
	laborStageType laborStage;
	float laborStageDuration;
	
	// Initial stats ("factors").
	NSMutableDictionary* factors;

	// Variables for the contraction model.
	float timeToNextContraction;
	float maxContractionStrength;
	float contractionDuration;
	float contractionFrequency;
	NSTimer* contractionTimer;
	NSMutableArray* currentContractions;
	int contractionsWithoutPositionSwitch;
	
	// Ongoing actions!
	NSMutableDictionary* currentActions;
	NSMutableDictionary* ongoingActionTimers;
	
	NSMutableDictionary* laborStats;

	NSDate* laborStartTime;
}

@property (nonatomic, weak) id delegate;

@property (nonatomic, readonly) Baby *baby;

@property (readonly) float support;
@property (readonly) float supportWindow;
@property (readonly) float desiredSupport;

@property (readonly) float coping;
@property (readonly) float energy;
@property (readonly) bool sleeping;
@property (readonly) float dilation;
@property (readonly) NSString* position;

@property (readonly) float effacement;
@property (readonly) float station;

@property (readonly) bool watersReleased;
@property (readonly) bool hadBaby;

@property (readonly) laborStageType laborStage;

@property (readonly) int contractionStrength;
@property (readonly) bool havingContraction;

@property (nonatomic, readonly) NSDate* laborStartTime;
@property (readonly) NSTimeInterval laborDuration;
@property (nonatomic, readonly) NSDictionary* laborStats;

-(void)setStartingDilation:(float)startingValue;

-(void)startLabor;
-(void)endLabor;
-(void)timerTick;
-(bool)applyAction:(NSDictionary*)action;
-(bool)eligibleForAction:(NSDictionary*)action;

@end

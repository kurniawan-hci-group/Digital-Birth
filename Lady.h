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
} laborStageType;

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

@end

@interface Lady : NSObject
{
	id <LadyDelegate> delegate;
	
	Baby* baby;

	float support;
	float supportWindow;
	float desiredSupport;
	
	float coping;
	float energy;
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

@property (nonatomic, assign) id delegate;

@property (nonatomic, readonly) Baby *baby;

@property (readonly) float support;
@property (readonly) float supportWindow;
@property (readonly) float desiredSupport;

@property (readonly) float coping;
@property (readonly) float energy;
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

-(void)startLabor;
-(void)endLabor;
-(void)timerTick;
-(bool)applyAction:(NSDictionary*)action;
-(bool)eligibleForAction:(NSDictionary*)action;

@end

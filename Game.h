//
//  Game.h
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
/*
 The game object. Game is basically an interface to the Lady object; additionally, 
 it handles selection of actions from the action list (it also loads the action list).
 
 The owning view controller (a GameViewController, in Digital Birth) passes to the
 Game a message containing an action name as a string. The Game finds the action of 
 that name in the action list, and tells the Lady to apply said action.
 */

#import <Foundation/Foundation.h>
#import "Lady.h"

typedef enum
{
	IN_PROGRESS,
	LOST_GAME,
	WON_GAME
} gameStatusType;

@protocol GameDelegate <NSObject>

-(void)contractionStarted;
-(void)contractionEnded;
-(void)displayPosition;

@end

@interface Game : NSObject <LadyDelegate>
{
	id <GameDelegate> delegate;
	
	Lady* lady;
	NSDictionary* actionList;
	
	gameStatusType gameStatus;
	int playerScore;
	
	NSTimer* gameTimer;
}

@property (nonatomic, assign) id delegate;

@property (readonly) gameStatusType gameStatus;
@property (readonly) int playerScore;

@property (readonly) NSDictionary* actionList;

@property (readonly, getter = getBabyHR) int babyHR;
@property (readonly, getter = babyIsDistressed) bool babyIsDistressed;
@property (readonly, getter = getSupport) float support;
@property (readonly, getter = getDesiredSupport) float desiredSupport;
@property (readonly, getter = getSupportWindow) float supportWindow;
@property (readonly, getter = getCoping) int coping;
@property (readonly, getter = getEnergy) float energy;
@property (readonly, getter = isSleeping) bool sleeping;
@property (readonly, getter = getDilation) int dilation;
@property (readonly, getter = getPosition) NSString* position;
@property (readonly, getter = getEffacement) float effacement;
@property (readonly, getter = getStation) int station;
@property (readonly, getter = getContractionStrength) int contractionStrength;
@property (readonly, getter = watersReleased) bool watersReleased;
@property (readonly, getter = hadBaby) bool hadBaby;
@property (readonly, getter = getLaborDuration) NSTimeInterval laborDuration;
@property (readonly, getter = getLaborStats) NSDictionary* laborStats;

-(void)setStartingDilation:(float)dilation;

-(void)startGame;
-(void)endGame;
-(bool)performAction:(NSString*)actionName;
-(NSTimeInterval)getCooldown:(NSString*)actionName;
-(bool)canPerformAction:(NSString*)actionName;

// Delegate methods.
-(NSDictionary*)getAction:(NSString*)actionName;
-(void)contractionStarted;
-(void)contractionEnded;
-(void)positionChanged;

@end

//
//  Game.h
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lady.h"

typedef enum
{
	IN_PROGRESS,
	LOST_GAME,
	WON_GAME
} gameStatusType;

@protocol GameDelegate <NSObject>



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
@property (readonly, getter = getDilation) int dilation;
@property (readonly, getter = getPosition) NSString* position;
@property (readonly, getter = getEffacement) float effacement;
@property (readonly, getter = getStation) int station;
@property (readonly, getter = getContractionStrength) int contractionStrength;
@property (readonly, getter = watersReleased) bool watersReleased;
@property (readonly, getter = hadBaby) bool hadBaby;

-(void)startGame;
-(void)endGame;
-(bool)performAction:(NSString*)actionName;
-(NSTimeInterval)getCooldown:(NSString*)actionName;
-(bool)canPerformAction:(NSString*)actionName;

-(NSDictionary*)getAction:(NSString*)actionName;

@end

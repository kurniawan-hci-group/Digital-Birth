//
//  Game.h
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lady.h"
#import "Action.h"

typedef enum
{
	IN_PROGRESS,
	LOST_GAME,
	WON_GAME
} gameStatusType;

@interface Game : NSObject
{
	Lady *lady;
	gameStatusType gameStatus;
	int playerScore;
	NSTimer* gameTimer;
}

@property (readonly) Lady *lady;
@property (readonly) gameStatusType gameStatus;
@property (readonly) int playerScore;
@property (readonly) NSTimer* gameTimer;

-(void)startGame;
-(void)performAction:(NSString*)actionName;

-(int)getBabyHR;
-(bool)babyIsDistressed;

-(float)getSupport;
-(float)getDesiredSupport;
-(float)getSupportWindow;

-(int)getCoping;
-(float)getEnergy;
//-(int)getFocus;
-(int)getDilation;
-(positionType)getPosition;

-(float)getEffacement;
-(int)getStation;

-(int)getContractionStrength;

-(bool)watersReleased;
-(bool)hadBaby;

@end

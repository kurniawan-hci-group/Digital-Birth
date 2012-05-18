//
//  Lady.h
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Baby.h"


@interface Lady : NSObject {
	Baby *_baby;
	int _focus; //bar from 0 to 4 bad to good
	int _energy;
	int _support;//from 0 to 100
	int _copingNum;
	int _dilation;
	int _effacement;
	bool _hadBaby;
	
	int _contractionNum;
	int _stateOfLabor;
	int _chanceOfContraction;
	bool _havingContraction;
	bool _incrContraction;
	NSDate *_start;
	//NSTimeInterval _timeSinceLastContraction;
	NSTimer *_contractionTimer;
}

@property (nonatomic, retain) Baby *baby;
@property int focus;
@property int energy;
@property int support;
@property int copingNum;
@property int dilation;
@property int effacement;
@property bool hadBaby;
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

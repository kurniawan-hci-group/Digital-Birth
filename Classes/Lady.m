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

@synthesize baby = _baby;
@synthesize focus = _focus;
@synthesize energy = _energy;
@synthesize support = _support;
@synthesize copingNum = _copingNum;
@synthesize dilation = _dilation;
@synthesize effacement = _effacement;
@synthesize hadBaby  = _hadBaby;
@synthesize contractionNum = _contractionNum;
@synthesize stateOfLabor = _stateOfLabor;
@synthesize chanceOfContraction = _chanceOfContraction;
@synthesize havingContraction = _havingContraction;
@synthesize contractionTimer = _contractionTimer;
@synthesize incrContraction = _incrContraction;

//randomly choose number between 1 and 10
-(int)getInitialCopingNum {
	int r = arc4random() %10;
	if (r == 0) {
		return 10;
	} else {
		return r;
	}
	
}

-(id)init {
	if(self = [super init]) {
		self.baby = [Baby new];
		self.focus = 255;
		self.energy = 255;
		self.support = 255;
		self.copingNum = [self getInitialCopingNum];
		self.dilation = 1;
		self.effacement = 1; //???
		self.hadBaby = NO;
		
		self.contractionNum = 0;
		self.stateOfLabor = ACTIVE;
		self.chanceOfContraction = 100;
		self.havingContraction = NO;
		self.incrContraction = YES;
	}
	return self;
}

-(void)startLabor {
	
}

-(void)changeContractionNumBy:(int)number greaterThan:(int)max {
	if (self.incrContraction) {
		if (self.contractionNum >= max) {
			self.incrContraction = NO;
			self.contractionNum -= number;
		}
		self.contractionNum += number; 
	} else {
		if (self.contractionNum <= 0) {
			//end contraction
			[self.contractionTimer invalidate];
			self.contractionTimer = nil;
			self.havingContraction = NO;
			self.contractionNum = 0;
			NSLog(@"contractionNum: %d", self.contractionNum);
			self.incrContraction = YES;
			//reevaluate lady's focus and energy, etc.?
		} else {
			self.contractionNum -= number;
		}
	}
}

-(int)getRandomBetween:(int)low and:(int)high {
	int diff = high - low;
	int rand = arc4random() %diff;
	return rand + low;
}

//selector for contractionTimer
-(void)incrementContractionNum:(NSTimer*)timer {
	if (self.stateOfLabor == EARLY) {
		NSLog(@"Contraction Strength %d", self.contractionNum);
		//use 100/15 = 6.6
		int low = 5; //6 - 1
		int high = 9; // 6 + 3
		int maxContractionStrength = 100;
		int num = [self getRandomBetween:low and:high];
		[self changeContractionNumBy:num greaterThan:maxContractionStrength];
		//increment contractionNum
		//effect focus, energy, support?
		
	} else if (self.stateOfLabor == ACTIVE) {
		NSLog(@"Contraction Strength %d", self.contractionNum);
	   //use 200/22.5 = 8.8
		int low = 8;
	   int high = 11;
	   int maxContractionStrength = 200;
	   int num = [self getRandomBetween:low and:high];
	   [self changeContractionNumBy:num greaterThan:maxContractionStrength];
	} else if (self.stateOfLabor == TRANSITION) {
	   //use 255/30 = 8.5
	   int low = 7;
	   int high = 11;
	   int maxContractionStrength = 255;
	   int num = [self getRandomBetween:low and:high];
	   [self changeContractionNumBy:num greaterThan:maxContractionStrength];
	} else if (self.stateOfLabor == PUSHING) {
	   //use 255/30 = 8.5
	   int low = 6;
	   int high = 11;
	   int maxContractionStrength = 255;
	   int num = [self getRandomBetween:low and:high];
	   [self changeContractionNumBy:num greaterThan:maxContractionStrength];
	} /*else if (self.stateOfLabor == BABYBORN) {
		<#statements#>
	}*/
}

-(void)startContraction {
	NSLog(@"start contraction");
	self.havingContraction = YES;
	self.contractionTimer = [NSTimer scheduledTimerWithTimeInterval:1 
									 target:self 
									 selector:@selector(incrementContractionNum:) 
									 userInfo:nil 
									 repeats:YES];
	
}

-(void)increaseChanceOfContraction {
	if (self.stateOfLabor == EARLY) {
		self.chanceOfContraction += 10; //determine how quickly this should occur
		
	} /*else if (self.stateOfLabor == ACTIVE) {
		<#statements#>
	} else if (self.stateOfLabor == TRANSITION) {
		<#statements#>
	} else if (self.stateOfLabor == PUSHING) {
		<#statements#>
	} else if (self.stateOfLabor == BABYBORN) {
		<#statements#>
	}*/
}

-(void)dealloc {
	[super dealloc];
	[_baby release];
	[_contractionTimer release];
}

@end

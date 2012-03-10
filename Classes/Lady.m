//
//  Lady.m
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Lady.h"

@implementation Lady

@synthesize focus = _focus;
@synthesize energy = _energy;
@synthesize support = _support;
@synthesize copingNum = _copingNum;
@synthesize dilation = _dilation;
@synthesize effacement = _effacement;
@synthesize hadBaby  = _hadBaby;

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
		self.focus = 255;
		self.energy = 255;
		self.support = 255;
		self.copingNum = [self getInitialCopingNum];
		self.dilation = 1;
		self.effacement = 1; //???
		self.hadBaby = NO;
	}
	return self;
}



@end

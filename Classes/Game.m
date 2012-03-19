//
//  Game.m
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Game.h"
#import "Lady.h"

@implementation Game

@synthesize lady = _lady;

-(id)init {
	if(self = [super init]) {
		self.lady = [Lady new];
	}
	return self;
}

-(int)getBabyHR {
	return self.lady.baby.heartRate;
}

-(bool)babyIsDistressed {
	return [[self.lady baby] inDistress];
}

-(int)getFocus {
	return self.lady.focus;
}

-(int)getEnergy {
	return self.lady.energy;
}

-(int)getSupport {
	return self.lady.support;
}

-(int)getCopingNum {
	return self.lady.copingNum;
}

-(int)getDilation {
	return self.lady.dilation;
}

-(int)getEffacement {
	return self.lady.effacement;
}

-(int)getContractionNum { //0 no contraction, 255 contraction peak
	return self.lady.contractionNum;
}
-(bool)hadBaby {
	return self.lady.hadBaby;
}

//-(void)perormAction:(*Action) action {
//
//}


-(void)dealloc {
	[_lady release];
	[super dealloc];
}

@end

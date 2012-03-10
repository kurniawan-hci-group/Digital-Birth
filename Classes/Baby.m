//
//  Baby.m
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Baby.h"


@implementation Baby

@synthesize heartRate = _heartRate;

//TODO
-(int)getNormalHR {
	//return random num btw 120 and 810
	return 130;
}

-(id)init {
	if (self = [super init]) {
		self.heartRate = [self getNormalHR];
	}
	return self;
}


-(bool)isDistressed {
	if (self.heartRate > 120 && self.heartRate < 180) {
		return NO;
	} else {
		return YES;
	}
}

@end

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

/*
int main(int argc, const char * argv[]) {
	NSLog(@"Hey There");
	
	return 0;
}*/

-(id)init {
	if(self = [super init]) {
		self.lady = [Lady new];
		[self.lady startLabor];
	}
	return self;
}

-(void)dealloc {
	[_lady release];
	[super dealloc];
}

@end

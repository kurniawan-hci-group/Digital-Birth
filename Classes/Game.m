//
//  Game.m
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Game.h"


@implementation Game

@synthesize lady = _lady;

-(void)dealloc {
	[_lady release];
}

@end

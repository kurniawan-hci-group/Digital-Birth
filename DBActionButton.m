//
//  DBActionButton.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DBActionButton.h"

@implementation DBActionButton

@synthesize name;
@synthesize onCooldown;

-(id)init
{
	if(self = [super init])
	{
		onCooldown = false;
	}
	return self;
}

@end

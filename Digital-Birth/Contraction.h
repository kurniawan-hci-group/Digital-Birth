//
//  Contraction.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contraction : NSObject
{
	int strength;
	int maxStrength;
	float elapsedDuration;
	float totalDuration;
	
	bool active;
	
	NSTimer* timer;
}

@property (readonly) int strength;
@property (readonly, getter = isActive) bool active;

-(id)initWithMax:(int)max andDuration:(float)duration;
-(void)start;

@end

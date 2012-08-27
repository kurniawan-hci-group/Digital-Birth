//
//  Baby.h
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
/*
 The Baby class represents the baby. There is just one baby, and it's owned by
 the Lady object (see Lady.h).
 
 The Baby has a heart rate and not much else.
 */

#import <Foundation/Foundation.h>


@interface Baby : NSObject
{
	int heartRate;
//	bool inDistress;
}

@property int heartRate;
//@property bool inDistress;

-(bool) inDistress;

@end

//
//  Baby.h
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

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

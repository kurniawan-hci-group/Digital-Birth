//
//  Baby.h
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Baby : NSObject {
	int _heartRate;
	bool _inDistress;
}

@property int heartRate;

-(void)inDistress;

@end

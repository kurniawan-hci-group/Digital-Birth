//
//  Lady.h
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Lady : NSObject {
	int _focus;
	int _energy;
	int _support;
	int _copingNum;
	int _dilation;
	int _effacement;
	bool _hadBaby;
	
}

@property int focus;
@property int energy;
@property int support;
@property int copingNum;
@property int dilation;
@property int effacement;
@property bool hadBaby;

@end

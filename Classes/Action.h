//
//  Action.h
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Action : NSObject {
	int _actionId;
	NSString *_actionName;
	NSString *_description;
	double _effectRate;
	double _successRate;
	NSString *_prosString;
	NSString *_consString;
	
}

@property int actionId;
@property (copy) NSString *actionName;
@property (copy) NSString *description;
@property double effectRate;
@property double successRate;
@property (copy) NSString *prosString;
@property (copy) NSString *consString;

 
@end

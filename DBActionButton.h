//
//  DBActionButton.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBActionButton : UIButton
{
	NSString* name;
	bool onCooldown;
}

@property (nonatomic, retain) NSString* name;
@property bool onCooldown;

@end

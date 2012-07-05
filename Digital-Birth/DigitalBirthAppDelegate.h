//
//  DigitalBirthAppDelegate.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@class RootViewController;

@interface DigitalBirthAppDelegate : UIResponder <UIApplicationDelegate>
{
	Game* _game;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) RootViewController *rootViewController;
@property (nonatomic, retain) Game* game;

@end

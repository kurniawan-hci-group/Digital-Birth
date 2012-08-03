//
//  DigitalBirthAppDelegate.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewController.h"
#import "MenuViewController.h"

void uncaughtExceptionHandler(NSException *exception);

@class GameViewController;
@class MenuViewController;

@interface DigitalBirthAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//@property (nonatomic, retain) GameViewController *gameViewController;
//@property (nonatomic, retain) Game* game;

@end

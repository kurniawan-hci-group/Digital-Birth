//
//  DigitalBirthAppDelegate.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 MainViewController is the main menu screen, and loads first.
 MainViewController presents GameViewController, which runs the game,
 and dismisses it when the game ends (i.e. the user either clicks 
 "End Game" from the "return from background" screen or clicks "Main Menu"
 in the game-end summary screen).
 */

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

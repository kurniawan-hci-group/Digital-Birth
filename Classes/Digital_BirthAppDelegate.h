//
//  Digital_BirthAppDelegate.h
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "MainGameViewController.h"
#import "ButtonsViewController.h"
#import "FHRViewController.h"
#import "DigitalBirthViewController.h"

@class DigitalBirthViewController;

@interface Digital_BirthAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
	UIImageView *background;
	UIImageView *womanView;
    IBOutlet UINavigationController *testViewController;
	DigitalBirthViewController *viewController;
	ButtonsViewController *buttonsController;
	MainGameViewController *mainController;
	FHRViewController *fhrController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *testViewController;
@property (nonatomic, retain) IBOutlet UIImageView *background;
@property (nonatomic, retain) DigitalBirthViewController *viewController;
@property (nonatomic, retain) ButtonsViewController *buttonsViewController;
@property (nonatomic, retain) FHRViewController *viewControllerFHR;
@property (nonatomic, retain) MainGameViewController *mainGameController;

@end


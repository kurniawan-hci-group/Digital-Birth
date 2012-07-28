//
//  DigitalBirthAppDelegate.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DigitalBirthAppDelegate.h"

@implementation DigitalBirthAppDelegate

@synthesize window;
@synthesize rootViewController;
@synthesize game;

-(void)dealloc
{
	[window release];
	[rootViewController release];
	[game release];
    [super dealloc];
}

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	game = [[Game alloc] init];
	
	self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
	self.window.backgroundColor = [UIColor whiteColor];
	
	rootViewController = [[RootViewController alloc] init];
	rootViewController.game = game;
	window.rootViewController = rootViewController;
	[rootViewController release];
	
    [self.window makeKeyAndVisible];
	
    return YES;
}

@end

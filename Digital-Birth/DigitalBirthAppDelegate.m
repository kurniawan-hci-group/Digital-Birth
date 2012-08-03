//
//  DigitalBirthAppDelegate.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DigitalBirthAppDelegate.h"
#import "Flurry.h"

void uncaughtExceptionHandler(NSException *exception)
{
	[Flurry logError:@"Uncaught" message:@"Crash!" exception:exception];
}

@implementation DigitalBirthAppDelegate

@synthesize window;
//@synthesize gameViewController;
//@synthesize game;

-(void)dealloc
{
	[window release];
//	[gameViewController release];
//	[game release];
    [super dealloc];
}

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
	[Flurry startSession:@"9PVJFKFSD4KYRFH4BW8M"];
	
	self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
	self.window.backgroundColor = [UIColor whiteColor];
	
//	GameViewController* gameViewController = [[GameViewController alloc] init];
//	window.rootViewController = gameViewController;
//	[gameViewController release];
	MenuViewController* menuViewController = [[MenuViewController alloc] init];
	window.rootViewController = menuViewController;
	[menuViewController release];
	
    [self.window makeKeyAndVisible];
	
    return YES;
}

@end

//
//  Digital_BirthAppDelegate.m
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Digital_BirthAppDelegate.h"

@implementation Digital_BirthAppDelegate

@synthesize window;
@synthesize testViewController;
@synthesize background;
@synthesize viewController;
@synthesize mainGameController;
@synthesize buttonsViewController;
@synthesize viewControllerFHR;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application{
	
	//Begin Zak's code snippet
	NSLog(@"Preparing to deploy screen");
	
	UIApplication *myApp = [UIApplication sharedApplication ];
	[myApp setStatusBarStyle: UIStatusBarStyleBlackTranslucent ];
	CGRect screenBounds = [ [ UIScreen mainScreen ] bounds ];
	
	
	self.window = [ [ [ UIWindow alloc] initWithFrame:screenBounds ] autorelease ];
	self.background = [ [ [ UIImageView alloc] initWithFrame:screenBounds ] autorelease ];
	//window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	window.backgroundColor = [UIColor whiteColor];
    //[self.window addSubview:[testViewController view]];
	[self.window makeKeyAndVisible];
	// End Zak's snippet
	
	//Code commented by Zak here. Uncomment to tinker <3
	DigitalBirthViewController *aViewController = [[DigitalBirthViewController alloc]
												   initWithNibName:@"DigitalBirth" 
												   bundle: [NSBundle mainBundle]];
	self.viewController = aViewController;
	[viewController release];
	
	[window addSubview:[viewController view]];
	//[window addSubview:[mainController view]];
	[window addSubview:[buttonsController view]];
	[window addSubview:[fhrController view]];
	[window center];
	[window makeKeyAndVisible];
	[window becomeFirstResponder];
	
	/*	womanView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 480, 320)];
	 womanView.image = [UIImage imageNamed:@"Mommy.png"];
	 [womanView setTransform:CGAffineTransformMakeRotation(M_PI/-2.0)];
	 womanView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	 womanView.contentMode = UIViewContentModeScaleAspectFill;
	 [window addSubview:womanView];
	 [window sendSubviewToBack:womanView];*/
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelay:1.0];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:window cache:YES];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(startAnimationDone:finished:context:)];
	[UIView commitAnimations];
	NSLog(@"SCREEN ENGAGED. FIRE ZEE MISSILES!");
}

-(void)startupAnimationDone: (NSString *)animationID finished:(NSNumber *)finished context: (void *)context {
	//	NSLog (@"start Anim");
	//	[womanView removeFromSuperview];
	//	[window sendSubviewToBack:womanView];
	//	womanView.alpha = 0.1;
	//	[womanView release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	//[testViewController release];
	[mainController release];
	[ButtonsViewController release];
	[FHRViewController release];
	[viewController release];
    [window release];
    [super dealloc];
}


@end

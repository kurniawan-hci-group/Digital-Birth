    //
//  ButtonsViewController.m
//  Digital-Birth
//
//  Created by Sri Kurniawan on 3/15/12.
//  Copyright 2012 University of California, Santa Cruz. All rights reserved.
//

#import "ButtonsViewController.h"


@implementation ButtonsViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
	
	if (orientation == UIInterfaceOrientationLandscapeRight)
	{ 
		CGAffineTransform transform = self.view.transform;
		
		// use the status bar frame to determine the center point of the window's content area.
		CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
		CGRect bounds = CGRectMake(0, 0, statusBarFrame.size.height, statusBarFrame.origin.x);
		CGPoint center = CGPointMake(bounds.size.height / 2.0, bounds.size.width / 2.0);
		// set the center point of the view to the center point of the window's content area.
		self.view.center = center;
		
		// Rotate the view 90 degrees around its new center point. 
		transform = CGAffineTransformRotate(transform, (M_PI / 2.0));
		self.view.transform = transform;
	}	
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[relax release];
	[lightTouchMassage release];
	[acupressure release];
	[heatPack release];
	[coldCloth release];
	[ragDoll release];
	[aromatherapy release];
	[music release];
	[visulaize release];
	
	[breathe release];
	[deepBreathing release];
	[countUpDown release];
	[yogaBreathing release];
	[rhythmicBreathing release];
	
	[beTogether release];
	[tv release];
	[movie release];
	[games release];
	[callFriends release];
	[walk release];
	[snuggle release];
	[kiss release];
	[sex release];
	
	[positions release];
	[slowDance release];
	[lean release];
	[lunge release];
	[birthBallStool release];
	[allFours release];
	[buttInAir release];
	[lieOnSide release];
	[toilet release];

	[help release];
	[askNurse release];
	[askDoula release];
	
    [super dealloc];
}


@end

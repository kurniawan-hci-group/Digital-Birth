    //
//  FHRViewController.m
//  Digital-Birth
//
//  Created by Sri Kurniawan on 3/27/12.
//  Copyright 2012 University of California, Santa Cruz. All rights reserved.
//

#import "FHRViewController.h"


@implementation FHRViewController

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
	UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
	
	if (orientation == UIInterfaceOrientationLandscapeLeft)
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
    [super dealloc];
}


@end

//
//  TestViewController.m
//  Digital-Birth
//
//  Created by User on 3/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TestViewController.h"

@implementation TestViewController

@synthesize game = _game;
@synthesize contractionTimer = _contractionTimer;

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


-(void)timerTicked:(NSTimer*)timer {
	NSLog(@"ticked");
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//can be deleted, just for testing
	CGRect frame = CGRectMake(10, 10, 300, 25);
	UILabel *helloLabel = [[UILabel alloc] initWithFrame:frame];
	helloLabel.text = @"HELLO THIS IS DOG";
	helloLabel.textColor = [UIColor grayColor];
	helloLabel.textAlignment = UITextAlignmentCenter;
	[self.view addSubview:helloLabel];
	[helloLabel release];
	
	
	self.game = [Game new]; //must keep
	NSLog(@"focus %d", [self.game getFocus]);
	NSLog(@"energy %d", [self.game getEnergy]);
	//self.contractionTimer = [NSTimer scheduledTimerWithTimeInterval:15 invocation:<#(NSInvocation *)invocation#> repeats:YES];
	self.contractionTimer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(timerTicked:) userInfo:nil repeats:YES];
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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

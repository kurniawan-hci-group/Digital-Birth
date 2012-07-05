    //
//  DigitalBirthViewController.m
//  Digital-Birth
//
//  Created by Sri Kurniawan on 3/13/12.
//  Copyright 2012 University of California, Santa Cruz. All rights reserved.
//

#import "DigitalBirthViewController.h"

@implementation DigitalBirthViewController

@synthesize statusLabel;

@synthesize label;
@synthesize buttons;
@synthesize FHR;  

-(IBAction) pullOutButtonView: (id)sender
{
	label.text = @"Button View is active";	
}

-(IBAction) pullOutFHRView: (id)sender
{
	label.text = @"FHR View is active";	
}

-(IBAction) buttonsTapped: (id)sender
{
	statusLabel.text = @"Button was tapped";
}

/*
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"DigitalBirthView.xib" bundle:nil];
    if (self)
    {
        // Custom initialization.
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
	CGRect rect = [UIScreen mainScreen].applicationFrame;
    self.view = [[UIView alloc] initWithFrame:rect];
	
	buttons	= [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[buttons addTarget:self action:@selector(buttonsTapped:) forControlEvents:UIControlEventTouchUpInside];
	[buttons setFrame:CGRectMake(50,50,100,24)];
	[self.view addSubview:buttons];
	
	CGRect labelRect = CGRectMake(0, 0, 200, 50);
	statusLabel = [[UILabel alloc] initWithFrame:labelRect];
	statusLabel.text = @"default status";
	[self.view addSubview:statusLabel];
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
	[statusLabel release];
	[label release];
	[buttons release];
	[FHR release];
    [super dealloc];
}


@end

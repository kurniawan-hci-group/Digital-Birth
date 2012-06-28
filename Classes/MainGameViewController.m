    //
//  MainGameViewController.m
//  Digital-Birth
//
//  Created by Sri Kurniawan on 3/28/12.
//  Copyright 2012 University of California, Santa Cruz. All rights reserved.
//

#import "MainGameViewController.h"

@implementation MainGameViewController

@synthesize buttonsViewController;
@synthesize viewControllerFHR;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        // Custom initialization.
    }
//	[self addSubView:];
//	[self addSubView:];
    return self;
}

-(void) pullUpButtons{
	CGRect buttonsFrame = self.view.frame;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	
	buttonsFrame.origin.y = 200;
	self.view.frame = buttonsFrame;
	//isOpen = YES;
	//self.alpha = 1;
	self.view.backgroundColor = [UIColor lightGrayColor];
//	[hideButton setImage:[UIImage imageNamed:@"hidecontroller.png"] forState: UIControlStateNormal];
//	hideButton.frame = CGRectMake(self.frame.size.width-38, 0, 38, 38);
//	[hideButton addTarget:self action:@selector(showOrHide) forControlEvents:UIControlEventTouchUpInside];
	
//	timecode.backgroundColor = [UIColor blackColor];
//	timecode.textColor = [UIColor lightGrayColor];
	
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	
	[UIView commitAnimations];
}

-(void) pullDownButtons{
	CGRect frame = self.view.frame;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	
	frame.origin.x = 320;//origin??
	self.view.frame = frame;
	//isOpen = NO;
	//self.alpha = .6;
	self.view.backgroundColor = NULL; 
//	[hideButton setImage:[UIImage imageNamed:@"showcontroller.png"] forState: UIControlStateNormal];
	
//	timecode.backgroundColor = [UIColor clearColor];
//	timecode.textColor = [UIColor lightGrayColor];
	
//	hideButton.frame = CGRectMake(self.frame.size.width-38, 0, 38, 38);
	
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
	[UIView commitAnimations];		
}

-(void) pullOutFHR{
	CGRect FHRframe = self.view.frame;;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.75];
	
	FHRframe.origin.x = 480;
	self.view.frame     = FHRframe;
	//isOpen = YES;
	//self.alpha = 1;
	//self.backgroundColor = [UIColor grayColor];
	//self.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"controller_background.png"]];
//	[hideButton setImage:[UIImage imageNamed:@"hidecontroller.png"] forState: UIControlStateNormal];
//	hideButton.frame = CGRectMake(self.frame.size.width-38, 0, 38, 38);
//	[hideButton addTarget:self action:@selector(showOrHide) forControlEvents:UIControlEventTouchUpInside];
	
//	timecode.backgroundColor = [UIColor blackColor];
//	timecode.textColor = [UIColor lightGrayColor];
	
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
	
	[UIView commitAnimations];	
}

-(void) pullInFHR{
	// Slide the view down off screen
	CGRect FHRframe = self.view.frame;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.75];
	
	FHRframe.origin.x = 0;
	self.view.frame = FHRframe;
	//isOpen = NO;
	//self.alpha = .6;
	self.view.backgroundColor = NULL;
	//[hideButton setImage:[UIImage imageNamed:@"showcontroller.png"] forState: UIControlStateNormal];
	
	//timecode.backgroundColor = [UIColor clearColor];
	//timecode.textColor = [UIColor lightGrayColor];
	
	//hideButton.frame = CGRectMake(self.frame.size.width-38, 0, 38, 38);
	
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
	[UIView commitAnimations];	
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
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

- (void)animationDidStop:(NSString*)animationID finished:(BOOL)finished context:(void *)context 
{
	// Release
	[self release];
}


- (void)dealloc {
    [super dealloc];
}


@end

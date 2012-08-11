//
//  MenuViewController.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "GameViewController.h"
#import "Constants.h"

@implementation MenuViewController

@synthesize gameSpeed;
@synthesize gameSpeedLabel;
@synthesize gameSpeedExplanationLabel;

@synthesize startingDilation;
@synthesize startingDilationLabel;

-(id)init
{
	if(self = [super init])
	{
		printf("Initializing menu controller.\n");
		gameSpeed = 1;
		startingDilation = ((double) arc4random() / ARC4RANDOM_MAX) * 3;
	}
	return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)dealloc
{
	[gameSpeedLabel release];
	[gameSpeedExplanationLabel release];
	[startingDilationLabel release];
	[super dealloc];
}

#pragma mark - Helper methods
-(void)displayGameSpeed
{
	NSString* gameSpeedDisplayString = [NSString stringWithFormat:@"%ix ", gameSpeed];
	gameSpeedLabel.text = gameSpeedDisplayString;
	if(gameSpeed == 1)
		gameSpeedExplanationLabel.hidden = NO;
	else
		gameSpeedExplanationLabel.hidden = YES;
}

-(void)displayStartingDilation
{
	NSString* startingDilationDisplayString = [NSString stringWithFormat:@"%i cm ", (int) startingDilation];
	startingDilationLabel.text = startingDilationDisplayString;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self displayGameSpeed];
	[self displayStartingDilation];
}

- (void)viewDidUnload
{
	[self setGameSpeedLabel:nil];
	[self setGameSpeedExplanationLabel:nil];
	[self setStartingDilationLabel:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

#pragma mark - Action methods
- (IBAction)newGameButtonPressed
{
	GameViewController* gameViewController = [[GameViewController alloc] init];
	gameViewController.delegate = self;
	gameViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	gameViewController.gameTimerTick = 1.0 / (float) gameSpeed;
	
	[self presentModalViewController:gameViewController animated:YES];
//	[self presentViewController:gameViewController animated:YES completion:nil];
}

- (IBAction)gameSpeedSliderChanged:(id)sender
{
	gameSpeed = [(UISlider*)sender value];
	[self displayGameSpeed];
}

- (IBAction)startingDilationSliderChanged:(id)sender
{
	startingDilation = [(UISlider*)sender value];
	[self displayStartingDilation];
}
@end

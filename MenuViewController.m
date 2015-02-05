//
//  MenuViewController.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "GameViewController.h"
#import "AboutViewController.h"
#import "Constants.h"

@implementation MenuViewController

@synthesize gameSpeed;
@synthesize gameSpeedLabel;
@synthesize gameSpeedExplanationLabel;

@synthesize startingDilation;
@synthesize startingDilationLabel;
@synthesize startingDilationEarlyLaborLabel;
@synthesize startingDilationActiveLaborLabel;
@synthesize startingDilationExplanationLabel;

@synthesize tooltipsToggleSwitch;

-(id)init
{
	if(self = [super init])
	{
		printf("Initializing menu controller.\n");
		gameSpeed = 1;
        startingDilation = 4;
//		startingDilation = ((double) arc4random() / ARC4RANDOM_MAX) * 3;
	}
	return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Helper methods

-(void)displayGameSpeed
{
	NSString* gameSpeedDisplayString = [NSString stringWithFormat:@"%ix ", gameSpeed];
	gameSpeedLabel.text = gameSpeedDisplayString;
	
	// With the 100x speedup (see the newGameButtonPressed: method), "real time is not really a thing...
//	if(gameSpeed == 1)
//		gameSpeedExplanationLabel.hidden = NO;
//	else
		gameSpeedExplanationLabel.hidden = YES;
}

-(void)displayStartingDilation
{
	NSString* startingDilationDisplayString = [NSString stringWithFormat:@"%i cm ", (int) startingDilation];
	startingDilationLabel.text = startingDilationDisplayString;
	
	if((int) startingDilation <= 3)
	{
		startingDilationEarlyLaborLabel.hidden = NO;
		startingDilationActiveLaborLabel.hidden = YES;
    }
	else
	{
		startingDilationEarlyLaborLabel.hidden = YES;
		startingDilationActiveLaborLabel.hidden = NO;
    }
	
	if(startingDilation > 3.0 && startingDilation < 5.0)
		startingDilationExplanationLabel.hidden = NO;
	else
		startingDilationExplanationLabel.hidden = YES;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self displayGameSpeed];
	[self displayStartingDilation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

#pragma mark - Action methods
- (IBAction)newGameButtonPressed
{
	NSDictionary* settings = @{
								@"startingDilation": @(startingDilation),
								@"showTooltips": @(tooltipsToggleSwitch.on),
								@"autoFadeTooltips": @(TRUE),
								@"autoFadeTooltipsDelay": @(3.0)
								};
	
	GameViewController* gameViewController = [[GameViewController alloc] init];
	gameViewController.delegate = self;
	gameViewController.settings = settings;
	gameViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	// The actual game speedup value we want is 100x the value reported by the slider;
	// this is so that we can have appropriate granularity (100x, 200x, or 300x).
	gameViewController.gameTimerTick = 1.0 / ((float) gameSpeed * 100);
	
	[self presentViewController:gameViewController animated:YES completion:nil];
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

- (IBAction)aboutDigitalBirthButtonPressed:(id)sender
{
	NSLog(@"Survey button pressed");
	
	AboutViewController* aboutViewController = [[AboutViewController alloc] init];
	aboutViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	
	[self presentViewController:aboutViewController animated:YES completion:nil];
}

@end

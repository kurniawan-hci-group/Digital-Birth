//
//  RootViewController.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "Constants.h"

@implementation RootViewController

@synthesize game;

@synthesize gameTimer;

@synthesize buttonsPanelExpanded;
@synthesize contractionsPanelExpanded;

@synthesize supportDisplay;
@synthesize hungerDisplay;
@synthesize tirednessDisplay;
@synthesize focusDisplayView;

@synthesize momView;
@synthesize momPicView;
@synthesize dilationDisplay;

@synthesize buttonsView;
@synthesize buttonsViewHandle;
@synthesize contractionsView;
@synthesize contractionsViewHandle;
@synthesize contractionsDisplay;

@synthesize relaxActionsButton;
@synthesize breatheActionsButton;
@synthesize beTogetherActionsButton;
@synthesize positionsActionsButton;
@synthesize verbalCareActionsButton;
@synthesize getHelpActionsButton;

#pragma mark - Memory Management
- (void)dealloc
{
	[game release];

	[supportDisplay release];
	[hungerDisplay release];
	[tirednessDisplay release];
	[focusDisplayView release];

	[momView release];
	[momPicView release];

	[dilationDisplay release];

	[buttonsView release];
	[buttonsViewHandle release];

	[relaxActionsButton release];
	[breatheActionsButton release];
	[beTogetherActionsButton release];
	[positionsActionsButton release];
	[verbalCareActionsButton release];
	[getHelpActionsButton release];

	[contractionsView release];
	[contractionsViewHandle release];
	
	[contractionsDisplay release];
	[super dealloc];
}

#pragma mark - Helper Methods
-(void) displaySupport
{
	[supportDisplay setProgress:(float) [game getSupport] / MAX_SUPPORT];
}

-(void) displayHunger
{
	NSString* hungerDisplayString = [NSString stringWithFormat:@"%i", [game getHunger]];
	self.hungerDisplay.text = hungerDisplayString;
}

-(void) displayTiredness
{
	NSString* tirednessDisplayString = [NSString stringWithFormat:@"%i", [game getTiredness]];
	self.tirednessDisplay.text = tirednessDisplayString;	
}

-(void) displayFocus
{
	switch(self.game.getFocus)
	{
		case 0:
			self.focusDisplayView.image = [UIImage imageNamed:@"focus_0.png"];
			break;
		case 1:
			self.focusDisplayView.image = [UIImage imageNamed:@"focus_1.png"];
			break;
		case 2:
			self.focusDisplayView.image = [UIImage imageNamed:@"focus_2.png"];
			break;
		case 3:
			self.focusDisplayView.image = [UIImage imageNamed:@"focus_2.png"];
			break;
		default:
			break;
	}
}

-(void) displayDilation
{
	NSString* dilationDisplayString = [NSString stringWithFormat:@"%i cm", [game getDilation]];
	self.dilationDisplay.text = dilationDisplayString;
}

-(void) displayContractionStrength
{
	NSString* contractionStrengthDisplayString = [NSString stringWithFormat:@"%i", [game getContractionStrength]];
	self.contractionsDisplay.text = contractionStrengthDisplayString;
}

-(void)toggleButtonsPanel:(BOOL) expand
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.15];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect buttonsFrame = buttonsView.frame;
	CGRect handleFrame = buttonsViewHandle.frame;
	CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
	
//	if ((buttonsFrame.origin.y == screenRect.size.width - buttonsFrame.size.height - statusBarFrame.size.width) && expand)
//	{
//        //don't expand an already expanded menu
//        return;
//    }
//	else if ((buttonsFrame.origin.y != screenRect.size.width - buttonsFrame.size.height - statusBarFrame.size.width) && !expand)
//	{
//        //don't shrink an already shrunk menu
//        return;
//    }
	
    if (expand)
	{
        buttonsFrame.origin.y = screenRect.size.width - buttonsFrame.size.height - statusBarFrame.size.width;
    }
	else
    {
        buttonsFrame.origin.y = screenRect.size.width - handleFrame.size.height - statusBarFrame.size.width;
    }
	
    [buttonsView setFrame:buttonsFrame];
    [UIView commitAnimations];
}

- (void)toggleContractionsPanel:(BOOL) expand
{
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.15];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect contractionsFrame = contractionsView.frame;
	CGRect handleFrame = contractionsViewHandle.frame;
	
	if (expand)
	{
        contractionsFrame.origin.x = 0;
    }
	else
    {
        contractionsFrame.origin.x = screenRect.size.height - handleFrame.size.width;
    }
	
    [contractionsView setFrame:contractionsFrame];
    [UIView commitAnimations];
}


#pragma mark - Game timer

- (IBAction)startGameTimer:sender
{
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(gameTimerTick:) userInfo:nil repeats:YES];
    self.gameTimer = timer;
}

-(void)gameTimerTick:(NSTimer*)gameTimer
{
	[self.game handleTimerTick];
	[self displaySupport];
	[self displayHunger];
	[self displayTiredness];
	[self displayFocus];
	[self displayDilation];
	[self displayContractionStrength];
}


#pragma mark - View lifecycle
- (void)viewDidLoad
{
	// ** Hack to make the view landscape properly. **
	// First rotate the screen:
	[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;
	// Then rotate the view and re-align it:
	CGAffineTransform landscapeTransform = CGAffineTransformMakeRotation(1.570796327); // pi/2, aka 90 degrees in radians
	[self.view setTransform:landscapeTransform];
	// ** End hack. **
	
	// Get and display support.
	[self displaySupport];
	
	// Get and display hunger.
	[self displayHunger];

	// Get and display tiredness.
	[self displayTiredness];
	
	// Get and display focus.
	[self displayFocus];
	
	// Display mom image.
	[self.momView addSubview:momPicView];
	[self.momView sendSubviewToBack:momPicView];
	
	// Get and display dilation.
	[self displayDilation];
	
	// Get frames of the screen and status bar
	// (for next two parts).
    CGRect screenRect = [[UIScreen mainScreen] bounds];
	CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
		
	// Add contractions monitor panel.
	CGRect contractionsPanelPosition = CGRectMake(screenRect.size.height - contractionsViewHandle.frame.size.width, (screenRect.size.width - contractionsView.frame.size.height - statusBarFrame.size.width - buttonsViewHandle.frame.size.height) / 2, contractionsView.frame.size.width, contractionsView.frame.size.height);
	[contractionsView setFrame:contractionsPanelPosition];
	[self.view addSubview:contractionsView];
	
	contractionsPanelExpanded = NO;
	
	// Add button panel.
	CGRect buttonsPanelPosition = CGRectMake(0, screenRect.size.width - buttonsViewHandle.frame.size.height - statusBarFrame.size.width, buttonsView.frame.size.width, buttonsView.frame.size.height);
	[buttonsView setFrame:buttonsPanelPosition];
	[self.view addSubview:buttonsView];
	
	buttonsPanelExpanded = NO;
	
	// Get and display contraction strength.
	[self displayContractionStrength];
	
	// Start the game timer.
	[self startGameTimer:self];
}

- (void)viewDidUnload
{
	[self setGetHelpActionsButton:nil];
	[self setVerbalCareActionsButton:nil];
	[self setPositionsActionsButton:nil];
	[self setBeTogetherActionsButton:nil];
	[self setBreatheActionsButton:nil];
	[self setRelaxActionsButton:nil];
	[self setButtonsView:nil];
	[self setSupportDisplay:nil];
	[self setMomView:nil];
	[self setMomPicView:nil];
	[self setDilationDisplay:nil];
	[self setButtonsViewHandle:nil];
	[self setFocusDisplayView:nil];
	[self setContractionsView:nil];
	[self setContractionsViewHandle:nil];
	[self setContractionsDisplay:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view to relieve memory usage
//	self.hungerDisplay = nil;
}

#pragma mark - Action Methods

- (IBAction)buttonsViewHandlePressed
{
	if(buttonsPanelExpanded)
	{
		[self toggleButtonsPanel:NO];
		buttonsPanelExpanded = NO;
	}
	else
	{
		[self toggleButtonsPanel:YES];
		buttonsPanelExpanded = YES;
	}
}

- (IBAction)contractionsViewHandlePressed
{
	if(contractionsPanelExpanded)
	{
		[self toggleContractionsPanel:NO];
		contractionsPanelExpanded = NO;
	}
	else
	{
		[self toggleContractionsPanel:YES];
		contractionsPanelExpanded = YES;
	}	
}

- (IBAction)relaxActionsButtonPressed:(id)sender
{
	
}

- (IBAction)breatheActionsButtonPressed:(id)sender
{
	
}

- (IBAction)beTogetherActionsButtonPressed:(id)sender
{
	
}

- (IBAction)positionsActionButtonPressed:(id)sender
{
	
}

- (IBAction)verbalCareActionsButtonPressed:(id)sender
{
	
}

- (IBAction)getHelpActionsButtonPressed:(id)sender
{
	
}
@end
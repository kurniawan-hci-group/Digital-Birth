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

@synthesize gameOverScreen;
@synthesize gameOverGradeDisplay;
@synthesize backgroundImageView;

@synthesize game;

@synthesize buttonsPanelExpanded;
@synthesize contractionsPanelExpanded;

@synthesize supportDisplay;
@synthesize energyDisplay;

@synthesize momPicView;
@synthesize dilationLabelPopupView;
@synthesize dilationDisplay;
@synthesize dilationDisplayButton;

@synthesize buttonsView;
@synthesize buttonsViewHandle;
@synthesize contractionsView;
@synthesize contractionsViewHandle;
@synthesize contractionsDisplay;
@synthesize contractionsGraphView;

@synthesize relaxActionsButton;
@synthesize breatheActionsButton;
@synthesize beTogetherActionsButton;
@synthesize positionsActionsButton;
@synthesize verbalCareActionsButton;
@synthesize getHelpActionsButton;

@synthesize relaxButtonsScrollView;
@synthesize relaxButtonsView;
@synthesize breatheButtonsScrollView;
@synthesize breatheButtonsView;
@synthesize beTogetherButtonsScrollView;
@synthesize beTogetherButtonsView;
@synthesize positionsButtonsScrollView;
@synthesize positionsButtonsView;
@synthesize verbalCareButtonsScrollView;
@synthesize verbalCareButtonsView;
@synthesize getHelpButtonsScrollView;
@synthesize getHelpButtonsView;

#pragma mark - Memory Management
- (void)dealloc
{
	[game release];

	[supportDisplay release];
	[energyDisplay release];

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
    [relaxButtonsScrollView release];
	[relaxButtonsView release];
	[breatheButtonsScrollView release];
	[breatheButtonsView release];
	[beTogetherButtonsScrollView release];
	[beTogetherButtonsView release];
	[positionsButtonsScrollView release];
	[positionsButtonsView release];
	[verbalCareButtonsScrollView release];
	[verbalCareButtonsView release];
	[getHelpButtonsScrollView release];
	[getHelpButtonsView release];
	[dilationDisplayButton release];
	[dilationLabelPopupView release];
	[contractionsGraphView release];
    [backgroundImageView release];
	[contractionsViewHandle release];
	[gameOverScreen release];
	[gameOverGradeDisplay release];
	[super dealloc];
}

#pragma mark - Helper Methods
-(void) displaySupport
{
	supportDisplay.targetNumber = [game getDesiredSupport] / MAX_SUPPORT;
	supportDisplay.windowWidth = [game getSupportWindow] / MAX_SUPPORT;
	supportDisplay.currentValue = [game getSupport] / MAX_SUPPORT;
}

-(void) displayCoping
{
	switch (game.getCoping)
	{
//		case <#constant#>:
//			<#statements#>
//			break;
//			
//		default:
//			break;
	}
}

-(void) displayEnergy
{
	[energyDisplay setProgress:(float) [game getEnergy] / MAX_ENERGY];
}

//-(void) displayFocus
//{
//	switch(game.getFocus)
//	{
//		case 0:
//			self.focusDisplayView.image = [UIImage imageNamed:@"focus_0.png"];
//			break;
//		case 1:
//			self.focusDisplayView.image = [UIImage imageNamed:@"focus_1.png"];
//			break;
//		case 2:
//			self.focusDisplayView.image = [UIImage imageNamed:@"focus_2.png"];
//			break;
//		case 3:
//			self.focusDisplayView.image = [UIImage imageNamed:@"focus_3.png"];
//			break;
//		default:
//			break;
//	}
//}
//
-(void) displayDilation
{
	NSString* dilationDisplayString = [NSString stringWithFormat:@"%i cm", [game getDilation]];
	self.dilationDisplay.text = dilationDisplayString;
	NSString* buttonImageFileName = [NSString stringWithFormat:@"dilation%i.png", [game getDilation]];
	[dilationDisplayButton setImage:[UIImage imageNamed:buttonImageFileName] forState:UIControlStateNormal];
}

-(void) displayPosition
{
	// Code to change the picture of the woman based on her position.
}

-(void) displayContractionStrength
{
	NSString* contractionStrengthDisplayString = [NSString stringWithFormat:@"%i", game.lady.contractionStrength];
	self.contractionsDisplay.text = contractionStrengthDisplayString;
	
	[self.contractionsGraphView drawDataPoint:game.lady.contractionStrength];
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
	
//	CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect contractionsFrame = contractionsView.frame;
	CGRect handleFrame = contractionsViewHandle.frame;
	
	if (expand)
	{
        contractionsFrame.origin.x = 0;
    }
	else
    {
        contractionsFrame.origin.x = handleFrame.size.width - contractionsFrame.size.width;
    }
	
    [contractionsView setFrame:contractionsFrame];
    [UIView commitAnimations];
}

- (void) hideAllButtonSubPanels
{
	relaxButtonsScrollView.hidden = YES;
	breatheButtonsScrollView.hidden = YES;
	beTogetherButtonsScrollView.hidden = YES;
	positionsButtonsScrollView.hidden = YES;
	verbalCareButtonsScrollView.hidden = YES;
	getHelpButtonsScrollView.hidden = YES;
}

- (void) toggleButtonSubPanel:(topLevelButton) button
{
	UIScrollView* thePanel;
	
	switch(button)
	{
		case relaxButton:
			thePanel = relaxButtonsScrollView;
			break;
		case breatheButton:
			thePanel = breatheButtonsScrollView;
			break;
		case beTogetherButton:
			thePanel = beTogetherButtonsScrollView;
			break;
		case positionsButton:
			thePanel = positionsButtonsScrollView;
			break;
		case verbalCareButton:
			thePanel = verbalCareButtonsScrollView;
			break;
		case getHelpButton:
			thePanel = getHelpButtonsScrollView;
			break;
		default:
			break;
	}

	if(!thePanel.hidden)
		thePanel.hidden = YES;
	else
	{
		[self hideAllButtonSubPanels];
		thePanel.hidden = NO;
	}
}

-(void) playSound: (NSString*)fName : (NSString*)ext
{
	NSURL* soundURL = [[NSBundle mainBundle] URLForResource:fName withExtension:ext];
	AudioServicesCreateSystemSoundID((CFURLRef) soundURL, &audioEffect);

	// Register a callback function, which will dispose of the system sound ID
	// when the sound finishes playing. This allows us to use the same SystemSoundID
	// variable for all the button sounds, without having to declare one variable
	// for each sound, while still preventing memory/sound ID leaks.
	AudioServicesAddSystemSoundCompletion(audioEffect, NULL, NULL, buttonSoundAudioCallback, NULL);

	AudioServicesPlayAlertSound(audioEffect);
//	[soundURL release];
}

void buttonSoundAudioCallback(SystemSoundID soundID, void *clientData)
{
	AudioServicesDisposeSystemSoundID(soundID);
}


#pragma mark - Display refresh timer

-(void)startDisplayTimer
{
	displayTimer = [NSTimer scheduledTimerWithTimeInterval:GAME_TIMER_TICK target:self selector:@selector(displayTimerTick:) userInfo:nil repeats:YES];
}

-(void)endGame
{
	[displayTimer invalidate];
	
	// Display game over screen.	
	char grade;
	switch (game.playerScore)
	{
		case 99:
			grade = 'A';
			break;
		case 89:
			grade = 'B';
			break;
		case 79:
			grade = 'C';
			break;
		case 69:
			grade = 'D';
			break;
		case 50:
			grade = 'F';
			break;
		default:
			break;
	}
	NSString* gradeDisplayString = [NSString stringWithFormat:@"Grade: %c", grade];
	gameOverGradeDisplay.text = gradeDisplayString;
	
	CGRect screenRect = [[UIScreen mainScreen] bounds];
	gameOverScreen.frame = CGRectMake((screenRect.size.height / 2) - (gameOverScreen.frame.size.width / 2), ((screenRect.size.width - 20 - buttonsViewHandle.frame.size.height) / 2) - (gameOverScreen.frame.size.height / 2), gameOverScreen.frame.size.width, gameOverScreen.frame.size.height);
	[self.view addSubview:gameOverScreen];	
}

-(void)displayTimerTick:(NSTimer *)timer
{
	if(game.gameStatus != IN_PROGRESS)
		[self endGame];
	
	[self displaySupport];
	[self displayEnergy];
	[self displayDilation];
	[self displayPosition];
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
	
	
	// Get and display status (support, energy, coping, dilation, position).
	[self displaySupport];
	[self displayCoping];
	[self displayEnergy];
	[self displayDilation];
	[self displayPosition];
	
	// Get frames of the screen and status bar
	// (for displaying the buttons panels and the contractions panel).
    CGRect screenRect = [[UIScreen mainScreen] bounds];
	CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
		
	// *** Add contractions monitor panel. ***
	CGRect contractionsPanelPosition = CGRectMake(contractionsViewHandle.frame.size.width - contractionsView.frame.size.width, (screenRect.size.width - contractionsView.frame.size.height - statusBarFrame.size.width - buttonsViewHandle.frame.size.height) / 2, contractionsView.frame.size.width, contractionsView.frame.size.height);
	[contractionsView setFrame:contractionsPanelPosition];
	[self.view addSubview:contractionsView];
	contractionsPanelExpanded = NO;
	
	// Add swipe gesture recognizers to contractions view handle.
	UISwipeGestureRecognizer* ctxSwipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(contractionsHandleSwipeRight:)];
	[ctxSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
	[contractionsViewHandle addGestureRecognizer:ctxSwipeRight];
	UISwipeGestureRecognizer* ctxSwipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(contractionsHandleSwipeLeft:)];
	[ctxSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
	[contractionsViewHandle addGestureRecognizer:ctxSwipeLeft];
	
	// Add the contractions graph itself (a subview), to the monitor panel.
	CGRect contractionsGraphPosition = CGRectMake(0, 0, contractionsGraphView.frame.size.width, contractionsGraphView.frame.size.height);
	[contractionsGraphView setFrame:contractionsGraphPosition];
	[self.contractionsView addSubview:contractionsGraphView];
	
	// Get and display contraction strength.
	[self displayContractionStrength];
	
	// *** Add button panel. ***
	CGRect buttonsPanelPosition = CGRectMake(0, screenRect.size.width - buttonsViewHandle.frame.size.height - statusBarFrame.size.width, buttonsView.frame.size.width, buttonsView.frame.size.height);
	[buttonsView setFrame:buttonsPanelPosition];
	[self.view addSubview:buttonsView];
	buttonsPanelExpanded = NO;
	
	// Add swipe gesture recognizers to button view handle.
	UISwipeGestureRecognizer* buttonSwipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(buttonHandleSwipeUp:)];
	[buttonSwipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
	[buttonsViewHandle addGestureRecognizer:buttonSwipeUp];
	UISwipeGestureRecognizer* buttonSwipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(buttonHandleSwipeDown:)];
	[buttonSwipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
	[buttonsViewHandle addGestureRecognizer:buttonSwipeDown];	
	
	// ** Add button sub-panels. **
	
	// Add relaxation buttons sub-panel.
	CGRect relaxButtonsScrollViewPosition = CGRectMake(0, screenRect.size.width - buttonsView.frame.size.height - relaxButtonsScrollView.frame.size.height - statusBarFrame.size.width, relaxButtonsScrollView.frame.size.width, relaxButtonsScrollView.frame.size.height);
	[relaxButtonsScrollView setFrame:relaxButtonsScrollViewPosition];
	[self.view addSubview:relaxButtonsScrollView];
	relaxButtonsScrollView.hidden = YES;
	[relaxButtonsScrollView addSubview:relaxButtonsView];
	relaxButtonsScrollView.contentSize = relaxButtonsView.frame.size;
	
	// Add breathing buttons sub-panel.
	CGRect breatheButtonsScrollViewPosition = CGRectMake(0, screenRect.size.width - buttonsView.frame.size.height - breatheButtonsScrollView.frame.size.height - statusBarFrame.size.width, breatheButtonsScrollView.frame.size.width, breatheButtonsScrollView.frame.size.height);
	[breatheButtonsScrollView setFrame:breatheButtonsScrollViewPosition];
	[self.view addSubview:breatheButtonsScrollView];
	breatheButtonsScrollView.hidden = YES;
	[breatheButtonsScrollView addSubview:breatheButtonsView];
	breatheButtonsScrollView.contentSize = breatheButtonsView.frame.size;
	
	// Add "be together" buttons sub-panel.
	CGRect beTogetherButtonsScrollViewPosition = CGRectMake(0, screenRect.size.width - buttonsView.frame.size.height - beTogetherButtonsScrollView.frame.size.height - statusBarFrame.size.width, beTogetherButtonsScrollView.frame.size.width, beTogetherButtonsScrollView.frame.size.height);
	[beTogetherButtonsScrollView setFrame:beTogetherButtonsScrollViewPosition];
	[self.view addSubview:beTogetherButtonsScrollView];
	beTogetherButtonsScrollView.hidden = YES;
	[beTogetherButtonsScrollView addSubview:beTogetherButtonsView];
	beTogetherButtonsScrollView.contentSize = beTogetherButtonsView.frame.size;
	
	// Add positions buttons sub-panel.
	CGRect positionsButtonsScrollViewPosition = CGRectMake(0, screenRect.size.width - buttonsView.frame.size.height - positionsButtonsScrollView.frame.size.height - statusBarFrame.size.width, positionsButtonsScrollView.frame.size.width, positionsButtonsScrollView.frame.size.height);
	[positionsButtonsScrollView setFrame:positionsButtonsScrollViewPosition];
	[self.view addSubview:positionsButtonsScrollView];
	positionsButtonsScrollView.hidden = YES;
	[positionsButtonsScrollView addSubview:positionsButtonsView];
	positionsButtonsScrollView.contentSize = positionsButtonsView.frame.size;
	
	// Add "verbal care" buttons sub-panel.
	CGRect verbalCareButtonsScrollViewPosition = CGRectMake(0, screenRect.size.width - buttonsView.frame.size.height - verbalCareButtonsScrollView.frame.size.height - statusBarFrame.size.width, verbalCareButtonsScrollView.frame.size.width, verbalCareButtonsScrollView.frame.size.height);
	[verbalCareButtonsScrollView setFrame:verbalCareButtonsScrollViewPosition];
	[self.view addSubview:verbalCareButtonsScrollView];
	verbalCareButtonsScrollView.hidden = YES;
	[verbalCareButtonsScrollView addSubview:verbalCareButtonsView];
	verbalCareButtonsScrollView.contentSize = verbalCareButtonsView.frame.size;
	
	// Add "get help" buttons sub-panel.
	CGRect getHelpButtonsScrollViewPosition = CGRectMake(0, screenRect.size.width - buttonsView.frame.size.height - getHelpButtonsScrollView.frame.size.height - statusBarFrame.size.width, getHelpButtonsScrollView.frame.size.width, getHelpButtonsScrollView.frame.size.height);
	[getHelpButtonsScrollView setFrame:getHelpButtonsScrollViewPosition];
	[self.view addSubview:getHelpButtonsScrollView];
	getHelpButtonsScrollView.hidden = YES;
	[getHelpButtonsScrollView addSubview:getHelpButtonsView];
	getHelpButtonsScrollView.contentSize = getHelpButtonsView.frame.size;
	
	// Possibly put this elsewhere, triggered from a "start game" button?

	// Start the display refresh timer.
	[self startDisplayTimer];
	// Start the game timer.	
	[self.game startGame];
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
	[self setMomPicView:nil];
	[self setDilationDisplay:nil];
	[self setButtonsViewHandle:nil];
	[self setContractionsView:nil];
	[self setContractionsViewHandle:nil];
	[self setContractionsDisplay:nil];
    [self setRelaxButtonsScrollView:nil];
	[self setRelaxButtonsView:nil];
	[self setBreatheButtonsScrollView:nil];
	[self setBreatheButtonsView:nil];
	[self setBeTogetherButtonsScrollView:nil];
	[self setBeTogetherButtonsView:nil];
	[self setPositionsButtonsScrollView:nil];
	[self setPositionsButtonsView:nil];
	[self setVerbalCareButtonsScrollView:nil];
	[self setVerbalCareButtonsView:nil];
	[self setGetHelpButtonsScrollView:nil];
	[self setGetHelpButtonsView:nil];	
	[self setDilationDisplayButton:nil];
	[self setDilationLabelPopupView:nil];
	[self setContractionsGraphView:nil];
    [self setBackgroundImageView:nil];
	[self setContractionsViewHandle:nil];
	[self setGameOverScreen:nil];
	[self setGameOverGradeDisplay:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view to relieve memory usage
}

#pragma mark - Action Methods

- (IBAction)quitButtonPressed
{	
	exit(0);
}

- (IBAction)buttonHandleSwipeUp:(UIGestureRecognizer*)sender
{
	[self toggleButtonsPanel:YES];
	buttonsPanelExpanded = YES;
}

- (IBAction)buttonHandleSwipeDown:(UIGestureRecognizer*)sender
{
	[self toggleButtonsPanel:NO];
	buttonsPanelExpanded = NO;
	[self hideAllButtonSubPanels];	
}

- (IBAction)contractionsHandleSwipeRight:(UIGestureRecognizer*)sender
{
	[self toggleContractionsPanel:YES];
	contractionsPanelExpanded = YES;	
}

- (IBAction)contractionsHandleSwipeLeft:(UIGestureRecognizer*)sender
{
	[self toggleContractionsPanel:NO];
	contractionsPanelExpanded = NO;
}

- (IBAction)relaxActionsButtonPressed:(id)sender
{
	[self toggleButtonSubPanel:relaxButton];
}

- (IBAction)breatheActionsButtonPressed:(id)sender
{
	[self toggleButtonSubPanel:breatheButton];
}

- (IBAction)beTogetherActionsButtonPressed:(id)sender
{
	[self toggleButtonSubPanel:beTogetherButton];
}

- (IBAction)positionsActionButtonPressed:(id)sender
{
	[self toggleButtonSubPanel:positionsButton];
}

- (IBAction)verbalCareActionsButtonPressed:(id)sender
{
	[self toggleButtonSubPanel:verbalCareButton];
}

- (IBAction)getHelpActionsButtonPressed:(id)sender
{
	[self toggleButtonSubPanel:getHelpButton];
}

- (IBAction)dilationDisplayButtonPressed:(id)sender
{
	dilationLabelPopupView.alpha = 1.0;
	
	[self performSelector:@selector(fadeOutDilationDisplay) withObject:nil afterDelay:2.0];
}

- (void)fadeOutDilationDisplay
{
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	
	dilationLabelPopupView.alpha = 0.0;
	
    [UIView commitAnimations];
}


#pragma mark - Button sub-panel actions

- (IBAction)lightTouchMassageButtonPressed
{
	[self.game performAction:@"lightTouchMassage"];	
}

- (IBAction)heatPackButtonTouched
{
	printf("test1\n");
	[self playSound:@"heatPack":@"aif"];
}

@end

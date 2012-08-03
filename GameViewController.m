//
//  GameViewController.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "Constants.h"

@implementation GameViewController
@synthesize quitView;
@synthesize quitViewHandle;

@synthesize delegate;

@synthesize game;

@synthesize gameOverScreen;
@synthesize gameOverGradeDisplay;
@synthesize backgroundImageView;

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
	[quitView release];
	[quitViewHandle release];
	[super dealloc];
}

#pragma mark - Object lifetime
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self)
//	{
//        printf("Initializing game controller with nib.\n");
//		game = [[Game alloc] init];
//    }
//    return self;
//}
//
-(id)init
{
	if(self = [super init])
	{
		printf("Initializing game controller.\n");
		game = [[Game alloc] init];
	}
	return self;
}

//-(id)initWithCoder:(NSCoder *)aDecoder
//{
//	if(self = [super initWithCoder:aDecoder])
//	{
//		printf("Initializing game controller with coder.\n");
//	}
//	return self;
//}
//
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
	[energyDisplay setEnergyLevel:(float) [game getEnergy] / MAX_ENERGY];
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

-(void)toggleButtonSubPanel:(UIScrollView*)panel expand:(BOOL)expand
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.10];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect panelFrame = panel.frame;
	
    if (expand)
	{
        panelFrame.origin.x = screenRect.size.height - panelFrame.size.width;
    }
	else
    {
        panelFrame.origin.x = screenRect.size.height;
    }
	
    [panel setFrame:panelFrame];
    [UIView commitAnimations];
}

-(void)toggleButtonsPanel:(BOOL) expand
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.15];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect buttonsFrame = buttonsView.frame;
	
    if (expand)
	{
        buttonsFrame.origin.x = 0;
    }
	else
    {
        buttonsFrame.origin.x = screenRect.size.height - buttonsViewHandle.frame.size.width;
		
//		[self toggleButtonSubPanel:relaxButtonsScrollView expand:NO];
//		[self toggleButtonSubPanel:breatheButtonsScrollView expand:NO];
//		[self toggleButtonSubPanel:beTogetherButtonsScrollView expand:NO];
//		[self toggleButtonSubPanel:positionsButtonsScrollView expand:NO];
//		[self toggleButtonSubPanel:verbalCareButtonsScrollView expand:NO];
//		[self toggleButtonSubPanel:getHelpButtonsScrollView expand:NO];
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

- (void)toggleQuitBox:(BOOL)expand
{
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.15];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	
	CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect quitFrame = quitView.frame;
	CGRect handleFrame = quitViewHandle.frame;
	
	if (expand)
	{
        quitFrame.origin.x = screenRect.size.height - quitFrame.size.width;
    }
	else
    {
        quitFrame.origin.x = screenRect.size.height - handleFrame.size.width;
    }
	
    [quitView setFrame:quitFrame];
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

// Accessors for gameTimerTick property.
-(void)setGameTimerTick:(float)tick
{
	GAME_TIMER_TICK = tick;
	CONTRACTION_TIMER_TICK = tick;
}
-(float)gameTimerTick
{
	return GAME_TIMER_TICK;
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
	gameOverScreen.frame = CGRectMake((screenRect.size.height / 2) - (gameOverScreen.frame.size.width / 2), (screenRect.size.width / 2) - (gameOverScreen.frame.size.height / 2) - 10, gameOverScreen.frame.size.width, gameOverScreen.frame.size.height);
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
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (void)viewDidLoad
{
	// ** Hack to make the view landscape properly. **
	// First rotate the screen:
//	[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;
	// Then rotate the view and re-align it:
//	CGAffineTransform landscapeTransform = CGAffineTransformMakeRotation(1.570796327); // pi/2, aka 90 degrees in radians
//	[self.view setTransform:landscapeTransform];
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
	CGRect contractionsPanelPosition = CGRectMake(contractionsViewHandle.frame.size.width - contractionsView.frame.size.width, (screenRect.size.width - contractionsView.frame.size.height - statusBarFrame.size.width) / 2, contractionsView.frame.size.width, contractionsView.frame.size.height);
	[contractionsView setFrame:contractionsPanelPosition];
	[self.view addSubview:contractionsView];
	contractionsPanelExpanded = NO;
	
	// Add swipe gesture recognizers to contractions view handle.
	UISwipeGestureRecognizer* ctxSwipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(contractionsHandleSlideOut:)];
	[ctxSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
	[contractionsViewHandle addGestureRecognizer:ctxSwipeRight];
	UISwipeGestureRecognizer* ctxSwipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(contractionsHandleSlideIn:)];
	[ctxSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
	[contractionsViewHandle addGestureRecognizer:ctxSwipeLeft];
	
	// Add the contractions graph itself (a subview), to the monitor panel.
	CGRect contractionsGraphPosition = CGRectMake(0, 0, contractionsGraphView.frame.size.width, contractionsGraphView.frame.size.height);
	[contractionsGraphView setFrame:contractionsGraphPosition];
	[self.contractionsView addSubview:contractionsGraphView];
	
	// Get and display contraction strength.
	[self displayContractionStrength];
	
	// *** Add quit box. ***
	CGRect quitBoxPosition = CGRectMake(screenRect.size.height - quitViewHandle.frame.size.width, 0, quitView.frame.size.width, quitView.frame.size.height);
	[quitView setFrame:quitBoxPosition];
	[self.view addSubview:quitView];
	quitBoxExpanded = NO;
	
	// Add swipe gesture recognizers to quit box handle.
	UISwipeGestureRecognizer* quitSwipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(quitHandleSlideOut:)];
	[quitSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
	[quitView addGestureRecognizer:quitSwipeLeft];
	UISwipeGestureRecognizer* quitSwipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(quitHandleSlideIn:)];
	[quitSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
	[quitView addGestureRecognizer:quitSwipeRight];
	
	// *** Add button panel. ***
	CGRect buttonsPanelPosition = CGRectMake(screenRect.size.height - buttonsViewHandle.frame.size.width, screenRect.size.width - buttonsViewHandle.frame.size.height - statusBarFrame.size.width, buttonsView.frame.size.width, buttonsView.frame.size.height);
	[buttonsView setFrame:buttonsPanelPosition];
	[self.view addSubview:buttonsView];
	buttonsPanelExpanded = NO;
	
	// Add swipe gesture recognizers to button view handle.
	UISwipeGestureRecognizer* buttonHandleSwipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(buttonHandleSlideOut:)];
	[buttonHandleSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
	[buttonsViewHandle addGestureRecognizer:buttonHandleSwipeLeft];
	UISwipeGestureRecognizer* buttonHandleSwipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(buttonHandleSlideIn:)];
	[buttonHandleSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
	[buttonsViewHandle addGestureRecognizer:buttonHandleSwipeRight];	
	
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
	
	dilationLabelPopupView.layer.cornerRadius = 8;
	dilationLabelPopupView.layer.masksToBounds = YES;
	
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
	[self setQuitView:nil];
	[self setQuitViewHandle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view to relieve memory usage
}

#pragma mark - Action Methods

- (IBAction)endGameToMainMenuButtonPressed
{	
	self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)quitButtonPressed
{
//	static bool really_quit = NO;
	self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//	if(really_quit)
		[self dismissModalViewControllerAnimated:YES];
//	else
//		really_quit = YES;		
}

- (IBAction)quitHandleSlideOut:(UIGestureRecognizer *)sender
{
	[self toggleQuitBox:YES];
	quitBoxExpanded = YES;
}

- (IBAction)quitHandleSlideIn:(UIGestureRecognizer *)sender
{
	[self toggleQuitBox:NO];
	quitBoxExpanded = NO;
}

- (IBAction)buttonHandleSlideOut:(UIGestureRecognizer *)sender
{
	[self toggleButtonsPanel:YES];
	buttonsPanelExpanded = YES;
}

- (IBAction)buttonHandleSlideIn:(UIGestureRecognizer *)sender
{
	[self toggleButtonsPanel:NO];
	buttonsPanelExpanded = NO;
	[self hideAllButtonSubPanels];	
}

- (IBAction)contractionsHandleSlideOut:(UIGestureRecognizer *)sender
{
	[self toggleContractionsPanel:YES];
	contractionsPanelExpanded = YES;	
}

- (IBAction)contractionsHandleSlideIn:(UIGestureRecognizer *)sender
{
	[self toggleContractionsPanel:NO];
	contractionsPanelExpanded = NO;
}

- (IBAction)relaxActionsButtonPressed:(id)sender
{
	[self toggleButtonSubPanel:relaxButton];
//	[self toggleButtonSubPanel:relaxButtonsScrollView expand:YES];
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

-(void)enableButtonNow:(UIButton*) button
{
	button.enabled = YES;
}

-(void)enableButton:(UIButton*) button afterCooldown:(NSTimeInterval) cooldown
{
	NSMethodSignature* sig = [self methodSignatureForSelector:@selector(enableButtonNow:)];
	NSInvocation* inv = [NSInvocation invocationWithMethodSignature:sig];
	[inv setSelector:@selector(enableButtonNow:)];
	[inv setTarget:self];
	[inv setArgument:&button atIndex:2];
	NSTimer* enableTimer;
	enableTimer = [NSTimer scheduledTimerWithTimeInterval:(cooldown * GAME_TIMER_TICK) invocation:inv repeats:NO];	
}

- (IBAction)lightTouchMassageButtonPressed:(id)sender
{
	if([game performAction:@"lightTouchMassage"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"lightTouchMassage"];
		[self enableButton:sender afterCooldown:cooldown];
	}
	else
	{
		// Play "not enough energy!" or whatever
	}
}

- (IBAction)heatPackButtonPressed:(id)sender
{
	if([game performAction:@"heatPack"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"heatPack"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)heatPackButtonTouched
{
	printf("test1\n");
	[self playSound:@"heatPack":@"aif"];
}

- (IBAction)coolClothButtonPressed:(id)sender
{
	if([game performAction:@"coolCloth"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"coolCloth"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)ragDollButtonPressed:(id)sender
{
	if([game performAction:@"ragDoll"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"ragDoll"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)aromatherapyButtonPressed:(id)sender
{
	if([game performAction:@"aromatherapy"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"aromatherapy"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)playMusicButtonPressed:(id)sender
{
	if([game performAction:@"playMusic"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"playMusic"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)visualizationButtonPressed:(id)sender
{
	if([game performAction:@"visualization"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"visualization"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)showerButtonPressed:(id)sender
{
	if([game performAction:@"shower"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"shower"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)tubButtonPressed:(id)sender
{
	if([game performAction:@"tub"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"tub"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}


- (IBAction)deepBreathingButtonPressed:(id)sender
{
	if([game performAction:@"deepBreathing"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"deepBreathing"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)countUpDownButtonPressed:(id)sender
{
	if([game performAction:@"countUpDown"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"countUpDown"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)rhythmicBreathingButtonPressed:(id)sender
{
	if([game performAction:@"rhythmicBreathing"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"rhythmicBreathing"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)TVButtonPressed:(id)sender
{
	if([game performAction:@"TV"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"TV"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)movieButtonPressed:(id)sender
{
	if([game performAction:@"movie"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"movie"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)gamesButtonPressed:(id)sender
{
	if([game performAction:@"games"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"games"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)callFriendsButtonPressed:(id)sender
{
	if([game performAction:@"callFriends"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"callFriends"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)snuggleButtonPressed:(id)sender
{
	if([game performAction:@"snuggle"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"snuggle"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)kissButtonPressed:(id)sender
{
	if([game performAction:@"kiss"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"kiss"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)sexButtonPressed:(id)sender
{
	if([game performAction:@"sex"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"sex"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)rubTummyButtonPressed:(id)sender
{
	if([game performAction:@"rubTummy"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"rubTummy"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)walkButtonPressed:(id)sender
{
	if([game performAction:@"walk"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"walk"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)standButtonPressed:(id)sender
{
	if([game performAction:@"stand"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"stand"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)slowDanceButtonPressed:(id)sender
{
	if([game performAction:@"slowDance"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"slowDance"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)leanOnWallButtonPressed:(id)sender
{
	if([game performAction:@"leanOnWall"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"leanOnWall"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)rockingChairButtonPressed:(id)sender
{
	if([game performAction:@"rockingChair"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"rockingChair"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)sitBackOnChairButtonPressed:(id)sender
{
	if([game performAction:@"sitBackOnChair"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"sitBackOnChair"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)sitOnBirthBallButtonPressed:(id)sender
{
	if([game performAction:@"sitOnBirthBall"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"sitOnBirthBall"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)lungeOnStairButtonPressed:(id)sender
{
	if([game performAction:@"lungeOnStair"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"lungeOnStair"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)kneelButtonpressed:(id)sender
{
	if([game performAction:@"kneel"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"kneel"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)squatButtonPressed:(id)sender
{
	if([game performAction:@"squat"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"squat"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)sitButtonPressed:(id)sender
{
	if([game performAction:@"sit"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"sit"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)lieOnSideButtonPressed:(id)sender
{
	if([game performAction:@"countUpDown"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"countUpDown"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)lieOnBackButtonPressed:(id)sender
{
	if([game performAction:@"lieOnBack"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"lieOnBack"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)allFoursButtonPressed:(id)sender
{
	if([game performAction:@"allFours"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"allFours"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)buttInAirButtonPressed:(id)sender
{
	if([game performAction:@"buttInAir"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"buttInAir"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)toiletButtonPressed:(id)sender
{
	if([game performAction:@"toilet"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"toilet"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)affirmationButtonPressed:(id)sender
{
	if([game performAction:@"affirmation"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"affirmation"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)encourageButtonPressed:(id)sender
{
	if([game performAction:@"encourage"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"encourage"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)complimentButtonPressed:(id)sender
{
	if([game performAction:@"compliment"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"compliment"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)saySomethingNiceButtonPressed:(id)sender
{
	if([game performAction:@"saySomethingNice"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"saySomethingNice"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)remindOfBabyButtonPressed:(id)sender
{
	if([game performAction:@"remindOfBaby"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"remindOfBaby"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)askNurseButtonPressed:(id)sender
{
	if([game performAction:@"askNurse"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"askNurse"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

- (IBAction)askDoulaButtonPressed:(id)sender
{
	if([game performAction:@"askDoula"])
	{
		((UIButton*) sender).enabled = NO;
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:@"askDoula"];
		[self enableButton:sender afterCooldown:cooldown];
	}
}

@end

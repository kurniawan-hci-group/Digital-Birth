//
//  GameViewController.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "Constants.h"
#import "SurveyViewController.h"

static NSDictionary* tooltipList; // Stores all tooltip specifications (tooltip text and positioning info) for all tooltips.

static NSDictionary* nurseHelpGrid; // Stores the grid of help text / audio IDs for each combination of factors.
static NSDictionary* nurseHelpContent; // Stores the help content (text only; audio is stored in individual audio files).

@interface GameViewController()
{
	NSMutableDictionary* tooltips; // Stores any currently spawned tooltips for all views. Keyed on view name.
}

@end

@implementation GameViewController
@synthesize quitView;

@synthesize delegate;
@synthesize settings;

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

@synthesize game;
@synthesize energyNumberLabel;

@synthesize gameOverScreen;
@synthesize gameSummaryView;
@synthesize seeBirthButton;

@synthesize nurseHelpView;
@synthesize nurseHelpTextView;
@synthesize nurseHelpImageView;

@synthesize birthView;

@synthesize backgroundImageView;

@synthesize buttonsPanelExpanded;
@synthesize contractionsPanelExpanded;

@synthesize copingDisplay;
@synthesize supportDisplay;
@synthesize supportDisplayTooltip;
@synthesize energyDisplay;
@synthesize sleepIndicatorView;

@synthesize momPicView;
@synthesize momPicGlowView;
@synthesize dilationLabelPopupView;
@synthesize dilationDisplay;
@synthesize dilationDisplayButton;

@synthesize energyNumberPopupView;

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

-(id)init
{
	if(self = [super init])
	{
		printf("Initializing game controller.\n");
		game = [[Game alloc] init];
		game.delegate = self;
		
		// Create dictionary to hold spawned tooltips (so as not to spawn a tooltip if it's already spawned).
		tooltips = [NSMutableDictionary dictionary];
		
		// Load tooltip specifications for all game elements.
		NSString* tooltipListPath = [[NSBundle mainBundle] pathForResource:@"Tooltips" ofType:@"plist"];
		tooltipList = [NSDictionary dictionaryWithContentsOfFile:tooltipListPath];
		if(tooltipList)
			printf("Tooltip list loaded successfully.\n");
		else
			printf("Could not load tooltip list!\n");
		
		// Load nurse help grid.
		NSString* nurseHelpGridPath = [[NSBundle mainBundle] pathForResource:@"NurseHelpGrid" ofType:@"plist"];
		nurseHelpGrid = [NSDictionary dictionaryWithContentsOfFile:nurseHelpGridPath];
		if(nurseHelpGrid)
			printf("Nurse help grid loaded successfully.\n");
		else
			printf("Could not load nurse help grid!");
		
//		NSLog(@"%@", nurseHelpGrid);
		
		// Load nurse help text content.
		NSString* nurseHelpContentPath = [[NSBundle mainBundle] pathForResource:@"NurseHelpContent" ofType:@"strings"];
		nurseHelpContent = [NSDictionary dictionaryWithContentsOfFile:nurseHelpContentPath];
		if(nurseHelpContent)
			printf("Nurse help content loaded successfully.\n");
		else
			printf("Could not load nurse help content!");
		
//		NSLog(@"%@", nurseHelpContent);

		// Load button cooldown images.
		NSMutableArray* cooldownImages = [[NSMutableArray alloc] init];
		int i = 0;
		while([[NSFileManager defaultManager] fileExistsAtPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"cooldown%d", i] ofType:@"png"]])
		{
			[cooldownImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"cooldown%d.png", i++]]];
		}
		
		NSLog(@"Loaded button cooldown images.");
		
		// Load "Z's" images for sleep indicator.
		NSMutableArray* sleepingImages = [[NSMutableArray alloc] init];
		int j = 0;
		while([[NSFileManager defaultManager] fileExistsAtPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"sleep%d", j] ofType:@"png"]])
		{
			[sleepingImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"sleep%d.png", j++]]];
		}
		sleepIndicatorView.animationImages = sleepingImages;
		
		NSLog(@"Loaded Z's cooldown images.");
		
		// Create action buttons.
		actionButtons = [[NSMutableDictionary alloc] init];
		for(NSString* actionName in [Game actionList])
		{
			DBActionButton* button = [[DBActionButton alloc] init];
			button.name = actionName;
			button.cooldownAnimationImages = cooldownImages;
			[button addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
			[button addTarget:self action:@selector(actionButtonTouched:) forControlEvents:UIControlEventTouchDown];
			actionButtons[actionName] = button;
		}
		
		NSLog(@"Created action buttons.");
		
		// Load position images.
		NSString* positionListPath = [[NSBundle mainBundle] pathForResource:@"Positions" ofType:@"plist"];
		positionList = [NSMutableDictionary dictionaryWithContentsOfFile:positionListPath];
		for(NSString* positionName in positionList)
		{
			NSLog(@"Loading image for position %@...", positionName);
			
			// Load the position image, if the image file exists.
			NSString* imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_position", positionName] ofType:@"png"];
			if([[NSFileManager defaultManager] fileExistsAtPath:imagePath])
			{
				UIImage* positionImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_position.png", positionName]];
				positionList[positionName][@"image"] = positionImage;
			}
			
			// Load this position's glow image, if the glow image file exists.
			NSString* imageGlowPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_position_glow", positionName] ofType:@"png"];
			if([[NSFileManager defaultManager] fileExistsAtPath:imageGlowPath])
			{
				UIImage* glowImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_position_glow.png", positionName]];
				positionList[positionName][@"glowAnimation"] = glowImage;
			}
			
			glowing = NO;
		}
		
		NSLog(@"Loaded position images.");
		
		// Add self as listener for notification of app returning to foreground,
		// to display the "End game or Resume game?" screen.
		if(&UIApplicationWillEnterForegroundNotification != nil)
		{
			[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnedFromBackground) name:UIApplicationWillEnterForegroundNotification object:nil];
		}
	}
	return self;
}

#pragma mark - Helper Methods
-(void)returnedFromBackground
{
	printf("returned from background!\n");
	
	if(game.gameStatus == IN_PROGRESS)
	{
		quitView.hidden = NO;
	}
	else
	{
		self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		[self dismissViewControllerAnimated:YES completion:nil];
	}
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
		
		// Flip the handle image, so the arrows face left.
		buttonsViewHandle.transform = CGAffineTransformMake(-1, 0, 0, 1, 0, 0);
    }
	else
    {
		// Place the buttons view just far enough off screen so that the visible part of the handle is visible, and the invisible part of the handle, and then 1 more pixel, to make it look pretty.
		buttonsFrame.origin.x = screenRect.size.height - (12 + buttonsViewHandle.frame.size.width + 1);

		// Un-flip the handle image, so the arrows face right.
		buttonsViewHandle.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
		
		// Hide whatever button sub-panel may be visible.
		[self hideAllButtonSubPanels];
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
    
    CGRect contractionsFrame = contractionsView.frame;
	CGRect handleFrame = contractionsViewHandle.frame;
	
	if (expand)
	{
        contractionsFrame.origin.x = 0;
		contractionsViewHandle.transform = CGAffineTransformMake(-1, 0, 0, 1, 0, 0);
    }
	else
    {
		// Slide the contractions monitor just far enough off screen so that the visible part of the handle is visible, and the invisible part of the handle, and then 1 more pixel, to make it look pretty.
        contractionsFrame.origin.x = (12 + handleFrame.size.width + 1) - contractionsFrame.size.width;
		contractionsViewHandle.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
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
	AudioServicesCreateSystemSoundID((__bridge CFURLRef) soundURL, &audioEffect);

	// Register a callback function, which will dispose of the system sound ID
	// when the sound finishes playing. This allows us to use the same SystemSoundID
	// variable for all the sounds, without having to declare one variable
	// for each sound, while still preventing memory/sound ID leaks.
	AudioServicesAddSystemSoundCompletion(audioEffect, NULL, NULL, buttonSoundAudioCallback, NULL);

	AudioServicesPlayAlertSound(audioEffect);
}

-(void)stopSound
{
	AudioServicesDisposeSystemSoundID(audioEffect);
}

void buttonSoundAudioCallback(SystemSoundID soundID, void *clientData)
{
	AudioServicesDisposeSystemSoundID(soundID);
}

-(void)setTooltipForView:(UIView*)view byViewName:(NSString*)name withTag:(NSString*)tag
{
	
}

-(void)showTooltipForView:(UIView*)view byViewName:(NSString*)name withTag:(NSString*)tag
{
	if(tooltips[name] != nil && [((DBTooltipView*)tooltips[name]).tag isEqualToString:tag])
	{
		[tooltips[name] show];
		if([settings[@"autoFadeTooltips"] boolValue] == YES)
			[self performSelector:@selector(fadeOutTooltip:) withObject:tooltips[name] afterDelay:[settings[@"autoFadeTooltipsDelay"] floatValue]];
	}
	else
	{
		NSLog(@"Creating tooltip for %@", name);
		
		NSMutableDictionary* tooltipSpec;
		
		// Determine which tooltip specification to use:
		// 1. If there's nothing at all for that view name, show no tooltip.
		// 2. If there's no specific tooltip spec for that tag under that name, use the default for that name.
		// 3. If it exists, use the specific tooltip for that tag under that name.
		if(tooltipList[name] == nil || (tooltipList[name][tag] == nil && tooltipList[name][@"default"] == nil))
		{
			NSLog(@"Using global default spec for this tooltip.");
			tooltipSpec = [tooltipList[@"default"] mutableCopy];
			tooltipSpec[@"text"] = name;
		}
		else if (tooltipList[name][tag] == nil)
		{
			NSLog(@"Using this view's default spec for this tooltip.");
			tooltipSpec = [tooltipList[name][@"default"] mutableCopy];
		}
		else
		{
			NSLog(@"Using spec for this view and tag.");
			tooltipSpec = [tooltipList[name][tag] mutableCopy];
		}
		
		// Get the tooltip spec fields from the spec.
		CGPoint position;
		if(tooltipSpec[@"position"] == nil)
		{
			CGPoint viewFrameOrigin = [view convertPoint:view.bounds.origin toView:self.view];
			position = viewFrameOrigin;			
		}
		else
		{
			position.x = [tooltipSpec[@"position"][@"x"] floatValue];
			position.y = [tooltipSpec[@"position"][@"y"] floatValue];
		}
		NSInteger direction = [tooltipSpec[@"direction"] integerValue];
		CGFloat offset = [tooltipSpec[@"offset"] floatValue];
		NSString* text = tooltipSpec[@"text"];
		
		// Create and add the tooltip.
		tooltips[name] = [self spawnTooltipAtPosition:position direction:direction offset:offset withText:text andTag:tag];
		[self.view addSubview:tooltips[name]];
		
		// Show the tooltip.
		[tooltips[name] show];
		if([settings[@"autoFadeTooltips"] boolValue] == YES)
			[self performSelector:@selector(fadeOutTooltip:) withObject:tooltips[name] afterDelay:[settings[@"autoFadeTooltipsDelay"] floatValue]];
	}
	
	NSLog(@"Showing tooltip for %@", name);
}

-(DBTooltipView*) spawnTooltipAtPosition:(CGPoint)position direction:(NSInteger)direction offset:(CGFloat)offset withText:(NSString*)text andTag:(NSString*)tag
{
	// Create tooltip view.
	DBTooltipView* tooltip = [[DBTooltipView alloc] init];

	// Configure tooltip.
	tooltip.text = text;
	tooltip.tag = tag;
	
	// Configure tooltip position.
	CGRect frame = tooltip.frame;
	frame.origin = position;
	
	// Square root of 2 to get axial (x,y) distances for 45-degree directions.
	CGFloat diag_factor = sqrtf(2.0);
	
	// Move origin in the appropriate direction (0 = 12:00, 1 = 1:30, ..., 7 = 10:30)
	// (or in other words, 0 = N, 1 = NE, ..., 7 = NW) by the offset.
	switch (direction)
	{
		case 0:
			frame.origin.y -= offset;
			break;
			
		case 1:
			frame.origin.x += offset / diag_factor;
			frame.origin.y -= offset / diag_factor;
			break;
			
		case 2:
			frame.origin.x += offset;
			break;
			
		case 3:
			frame.origin.x += offset / diag_factor;
			frame.origin.y += offset / diag_factor;
			break;
			
		case 4:
			frame.origin.y += offset;
			break;
			
		case 5:
			frame.origin.x -= offset / diag_factor;
			frame.origin.y += offset / diag_factor;
			break;
			
		case 6:
			frame.origin.x -= offset;
			break;
			
		case 7:
			frame.origin.x -= offset / diag_factor;
			frame.origin.y -= offset / diag_factor;
			break;
			
		default:
			break;
	}
	
	// Set modified frame.
	tooltip.frame = frame;

	return tooltip;
}

-(NSString*)stringifyLaborStage:(laborStageType)stage
{
	switch (stage)
	{
		case EARLY:
			return @"EARLY";
			break;
			
		case ACTIVE:
			return @"ACTIVE";
			break;
			
		case LATE_ACTIVE:
			return @"LATE_ACTIVE";
			break;
			
		case TRANSITION:
			return @"TRANSITION";
			break;
			
		case PUSHING:
			return @"PUSHING";
			break;
			
		case BABYBORN:
			return @"BABYBORN";
			break;
			
		default:
			break;
	}
}

-(void)showNurseHelpWindow
{
	// Check for conditions: labor stage, coping, support, energy, position.
	
	// Get the string describing the current labor stage.
	NSString* laborStage = laborStageString(game.getLaborStage);
	
	// Coping indicates which of 6 intervals it is (0, 1-2, 3-4, 5-6, 7-8, 9-10).
	NSString* coping = [NSString stringWithFormat:@"%d", (game.getCoping + 1) / 2];

	// Support can be too low, too high, or just right..
	NSString* supportLevel;
	if(game.getSupport < game.getDesiredSupport - game.getSupportWindow)
		supportLevel = @"TOO_LOW";
	else if(game.getSupport > game.getDesiredSupport + game.getSupportWindow)
		supportLevel = @"TOO_HIGH";
	else
		supportLevel = @"JUST_RIGHT";
	
	// Energy can be asleep, low, or normal.
	NSString* energyLevel;
	if(game.isSleeping == YES)
		energyLevel = @"ASLEEP";
	else if(game.getEnergy <= 0.15)
		energyLevel = @"LOW";
	else
		energyLevel = @"NORMAL";
	
	// Get the current position. -- CURRENTLY UNUSED --
	NSString* position = game.getPosition;
	
	NSLog(@"%@ %@ %@ %@", laborStage, coping, supportLevel, energyLevel);
	
	// Get the available help content indices for the current combinations of factors.
	NSArray* availableHelpContentIndices = nurseHelpGrid[laborStage][coping][supportLevel][energyLevel];
	
	NSLog(@"%d help content indices available", availableHelpContentIndices.count);
	
	// Randomly determine which help string to use.
	NSString* helpStringIndex = availableHelpContentIndices[arc4random() % availableHelpContentIndices.count];
	
	// Load the text for that help string index.
	nurseHelpTextView.text = nurseHelpContent[helpStringIndex];
	
	// Get the audio file name for that help string index.
	NSString* helpAudioClipFileName = [NSString stringWithFormat:@"nurseHelp%@", helpStringIndex];
	NSLog(@"%@", helpAudioClipFileName);
	
	// Show the help window.
	nurseHelpView.hidden = NO;
	
	// Play the audio file for that help string index.
	[self playSound:helpAudioClipFileName:@"aif"];
}

#pragma mark - Display refresh timer

-(void) displaySupport
{
	supportDisplay.targetNumber = [game getDesiredSupport] / MAX_SUPPORT;
	supportDisplay.windowWidth = [game getSupportWindow] / MAX_SUPPORT;
	supportDisplay.currentValue = [game getSupport] / MAX_SUPPORT;
}

-(void) displayCoping
{
	// Unhide the thought bubble with the coping scale image.
	[copingDisplay show];
	
	// Change the coping scale image based on coping value.
	NSString* copingImageName = [NSString stringWithFormat:@"coping%i.png", game.getCoping];
	[copingDisplay setImage:[UIImage imageNamed:copingImageName]];
	
	// Reposition the thought bubble appropriately relative to the woman's current position.
	CGRect copingFrame = copingDisplay.frame;
	copingFrame.origin = CGPointMake([positionList[game.getPosition][@"copingXPos"] floatValue], [positionList[game.getPosition][@"copingYPos"] floatValue]);
	copingDisplay.frame = copingFrame;
	
	// Flip the thought bubble horizontally or vertically, if necessary.
	copingDisplay.flipHorizontal = [positionList[game.getPosition][@"copingFlipHorizontal"] boolValue];
	copingDisplay.flipVertical = [positionList[game.getPosition][@"copingFlipVertical"] boolValue];
}

-(void)pulseCoping
{
	[copingDisplay pulse:10];
}

-(void) displayEnergy
{
	[energyDisplay setEnergyLevel:(float) [game getEnergy] / MAX_ENERGY];
	
	if(game.isSleeping)
	{
		CGRect sleepIndicatorViewFrame = sleepIndicatorView.frame;
		sleepIndicatorViewFrame.origin = CGPointMake([positionList[game.getPosition][@"ZxPos"] floatValue], [positionList[game.getPosition][@"ZyPos"] floatValue]);
		sleepIndicatorView.frame = sleepIndicatorViewFrame;

		sleepIndicatorView.hidden = NO;
	}
	else
	{
		sleepIndicatorView.hidden = YES;
	}
}

-(void) displayDilation
{
	NSString* dilationDisplayString = [NSString stringWithFormat:@"%i cm", [game getDilation]];
	self.dilationDisplay.text = dilationDisplayString;
	NSString* buttonImageFileName = [NSString stringWithFormat:@"dilation%i.png", [game getDilation]];
	[dilationDisplayButton setImage:[UIImage imageNamed:buttonImageFileName] forState:UIControlStateNormal];
}

-(void) displayPosition
{
	// Change the picture of the woman based on her position.
	momPicView.image = positionList[game.getPosition][@"image"];
	
	// If we're currently having a contraction, display the glow.
	if(glowing)
	{
		momPicGlowView.image = positionList[game.getPosition][@"glowAnimation"];
		momPicGlowView.hidden = NO;
		[UIView animateWithDuration:1.0 delay:0.0 options:(UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse) animations:^{
			CGFloat glowIntensity = game.getContractionStrength / MAX_POSSIBLE_CONTRACTION_STRENGTH;
			momPicGlowView.alpha = 0.5 + 0.5 * glowIntensity;
		} completion:nil];
	}
	else
	{
		momPicGlowView.hidden = YES;
	}

	// Reposition the woman appropriately. -- NO LONGER NECESSARY --
//	CGRect momViewFrame = momPicView.frame;
//	momViewFrame.size = momPicView.image.size;
//	momViewFrame.origin = CGPointMake([positionList[game.getPosition][@"xPos"] floatValue], [positionList[game.getPosition][@"yPos"] floatValue]);
//	momPicView.frame = momViewFrame;
	
	// Reposition the dilation display.
//	CGRect dilationFrame = dilationDisplayButton.frame;
//	dilationFrame.origin = CGPointMake([positionList[game.getPosition][@"dilationXPos"] floatValue], [positionList [game.getPosition][@"dilationYPos"] floatValue]);
//	dilationDisplayButton.frame = dilationFrame;
//	CGRect dilationPopupFrame = dilationLabelPopupView.frame;
//	dilationPopupFrame.origin = CGPointMake(dilationFrame.origin.x - 70, dilationFrame.origin.y + 9);
//	dilationLabelPopupView.frame = dilationPopupFrame;
	
	// *** SPECIAL CASES ***
	if([game.getPosition isEqualToString:@"lieOnSide"])
		backgroundImageView.image = [UIImage imageNamed:@"background_bed_down.png"];
//	else if([game.getPosition isEqualToString:@"lieOnBack"])
	else
		backgroundImageView.image = [UIImage imageNamed:@"background_bed_up.png"];	
}

-(void) displayContractionStrength
{
	NSString* contractionStrengthDisplayString = [NSString stringWithFormat:@"%i", game.getContractionStrength];
	self.contractionsDisplay.text = contractionStrengthDisplayString;
	
	[self.contractionsGraphView drawDataPoint:game.getContractionStrength];
}

-(void)startDisplayTimer
{
	displayTimer = [NSTimer scheduledTimerWithTimeInterval:GAME_TIMER_TICK target:self selector:@selector(displayTimerTick:) userInfo:nil repeats:YES];
}

-(void)endGame
{
	[displayTimer invalidate];
	
	// Generate game stats and summary info.
	NSMutableDictionary* gameSummary;
	char grade;
	NSString* ladyReaction;
	switch (game.playerScore)
	{
		case 99:
			grade = 'A';
			ladyReaction = @"You were great support. Thank you!";
			break;
		case 89:
			grade = 'B';
			ladyReaction = @"Overall, you were helpful.";
			break;
		case 79:
			grade = 'C';
			ladyReaction = @"Pay more attention to me.";
			break;
		case 69:
			grade = 'D';
			ladyReaction = @"Were you trying to make me mad? Because it worked.";
			break;
		case 50:
		default:
			grade = 'F';
			ladyReaction = @"You don't know me at all.";
			break;
	}
	gameSummary = [[NSMutableDictionary alloc] init];
	gameSummary[@"Grade"] = [NSString stringWithFormat:@"%c", grade];
	gameSummary[@"Reaction"] = ladyReaction;
	NSString* stageDuration;
	stageDuration = stringForTimeInterval(delegate.gameSpeed * game.getLaborDuration);
	gameSummary[@"laborDuration"] = stageDuration;
	if(game.hadBaby)
	{
		stageDuration = stringForTimeInterval(delegate.gameSpeed * ([(game.getLaborStats)[@"activeLaborStartTime"] timeIntervalSinceDate:(game.getLaborStats)[@"earlyLaborStartTime"]]));
		gameSummary[@"earlyLaborDuration"] = stageDuration;
		stageDuration = stringForTimeInterval(delegate.gameSpeed * ([(game.getLaborStats)[@"transitionStartTime"] timeIntervalSinceDate: (game.getLaborStats)[@"activeLaborStartTime"]]));
		gameSummary[@"activeLaborDuration"] = stageDuration;
		stageDuration = stringForTimeInterval(delegate.gameSpeed * ([(game.getLaborStats)[@"pushingStartTime"] timeIntervalSinceDate: (game.getLaborStats)[@"transitionStartTime"]]));
		gameSummary[@"transitionDuration"] = stageDuration;
		stageDuration = stringForTimeInterval(delegate.gameSpeed * ([(game.getLaborStats)[@"hadBabyTime"] timeIntervalSinceDate: (game.getLaborStats)[@"pushingStartTime"]]));
		gameSummary[@"pushingDuration"] = stageDuration;
	}
	gameSummary[@"hadBaby"] = @(game.hadBaby);
	gameSummaryView.gameSummary = gameSummary;
	
	// If we had a baby, unhide the "see birth" button.
	// FEATURE NOT YET IMPLEMENTED
//	if(game.hadBaby || !game.hadBaby)
//		seeBirthButton.hidden = NO;
	
	// Display game over screen.	
	[gameSummaryView display];	
	gameOverScreen.frame = self.view.bounds;
	[self.view addSubview:gameOverScreen];	
}

-(void)displayTimerTick:(NSTimer*)timer
{
	if(game.gameStatus != IN_PROGRESS)
		[self endGame];
	
	[self displaySupport];
	[self displayEnergy];
//	[self displayCoping];
	[self displayDilation];
//	[self displayPosition];
	[self displayContractionStrength];
	
	for(NSString* actionName in actionButtons)
	{
		if(![game canPerformAction:actionName])
			((DBActionButton*)actionButtons[actionName]).enabled = NO;
		else if (((DBActionButton*)actionButtons[actionName]).onCooldown == NO)
			((DBActionButton*)actionButtons[actionName]).enabled = YES;
	}
}

#pragma mark - View lifecycle
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (void)viewDidLoad
{
	// Configure coping display.
	copingDisplay.autoFadeOut = YES;
	copingDisplay.fadeOutDelay = 2.0;
	copingDisplay.fadeOutDuration = 1.0;
	copingDisplay.visibleAlpha = 0.75;
	
	// Get and display status (support, energy, coping, dilation, position).
	[self displaySupport];
	[supportDisplay clearTrail];
	[self displayCoping];
	[self displayEnergy];
	[self displayDilation];
	[self displayPosition];
	
	// Get frames of the screen and status bar
	// (for displaying the buttons panels and the contractions panel).
    CGRect screenRect = [[UIScreen mainScreen] bounds];
	CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
		
	// *** Add contractions monitor panel. ***
	// Place the contractions monitor just far enough off screen so that the visible part of the handle is visible, and the invisible part of the handle, and then 1 more pixel, to make it look pretty.
	CGRect contractionsPanelPosition = CGRectMake((12 + contractionsViewHandle.frame.size.width + 1) - contractionsView.frame.size.width, (screenRect.size.width - contractionsView.frame.size.height - statusBarFrame.size.width) / 2, contractionsView.frame.size.width, contractionsView.frame.size.height);
	[contractionsView setFrame:contractionsPanelPosition];
//	[self.view addSubview:contractionsView]; // Simply uncomment this line to put the contraction monitor back in!
	contractionsPanelExpanded = NO;
	
	// Add swipe gesture recognizers to contractions view handle.
    // Nah, let's use pan gestures! - Zak
//	UIPanGestureRecognizer* ctxPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(contractionsHandlePan:)];
//    [contractionsView addGestureRecognizer:ctxPan];
	// Why not use both...? - Sandy
	UISwipeGestureRecognizer* ctxSwipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(contractionsHandleSlideOut:)];
	[ctxSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
	[contractionsView addGestureRecognizer:ctxSwipeRight];
	UISwipeGestureRecognizer* ctxSwipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(contractionsHandleSlideIn:)];
	[ctxSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
	[contractionsView addGestureRecognizer:ctxSwipeLeft];
	
	// Add the contractions graph itself (a subview), to the monitor panel.
	CGRect contractionsGraphPosition = CGRectMake(0, 0, contractionsGraphView.frame.size.width, contractionsGraphView.frame.size.height);
	[contractionsGraphView setFrame:contractionsGraphPosition];
	[self.contractionsView addSubview:contractionsGraphView];
	
	// Get and display contraction strength.
	[self displayContractionStrength];
	
	// *** Add "restart/resume?" box. ***
	quitView.frame = CGRectMake((screenRect.size.height / 2) - (quitView.frame.size.width / 2), (screenRect.size.width / 2) - (quitView.frame.size.height / 2) - 10, quitView.frame.size.width, quitView.frame.size.height);
	[self.view addSubview:quitView];
	
	// *** Add the "help from nurse" box. ***
	nurseHelpView.frame = CGRectMake(14, 68, nurseHelpView.frame.size.width, nurseHelpView.frame.size.height);
	[self.view addSubview:nurseHelpView];
	
	// *** Add button panel. ***
	// Place the buttons view just far enough off screen so that the visible part of the handle is visible, and the invisible part of the handle, and then 1 more pixel, to make it look pretty.
	CGRect buttonsPanelPosition = CGRectMake(screenRect.size.height - (12 + buttonsViewHandle.frame.size.width + 1), screenRect.size.width - statusBarFrame.size.width - 80, buttonsView.frame.size.width, buttonsView.frame.size.height);
	[buttonsView setFrame:buttonsPanelPosition];
	[self.view addSubview:buttonsView];
	buttonsPanelExpanded = NO;
	
	// Add swipe gesture recognizers to button view handle.
    // Nah, let's use pan gestures! - Zak
//	UIPanGestureRecognizer* buttonHandlePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(buttonHandlePan:)];
//	[buttonsView addGestureRecognizer:buttonHandlePan];
	// Why not use both...? - Sandy
	UISwipeGestureRecognizer* buttonHandleSwipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(buttonHandleSlideOut:)];
	[buttonHandleSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
	[buttonsView addGestureRecognizer:buttonHandleSwipeLeft];
	UISwipeGestureRecognizer* buttonHandleSwipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(buttonHandleSlideIn:)];
	[buttonHandleSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
	[buttonsView addGestureRecognizer:buttonHandleSwipeRight];
	
	// ** Add button sub-panels. **
	
	// Add relaxation buttons sub-panel.
	CGRect relaxButtonsScrollViewPosition = CGRectMake(0, screenRect.size.width - buttonsView.frame.size.height - relaxButtonsScrollView.frame.size.height - statusBarFrame.size.width, relaxButtonsScrollView.frame.size.width, relaxButtonsScrollView.frame.size.height);
	[relaxButtonsScrollView setFrame:relaxButtonsScrollViewPosition];
	[self.view addSubview:relaxButtonsScrollView];
	relaxButtonsScrollView.hidden = YES;
	[relaxButtonsScrollView addSubview:relaxButtonsView];
//	relaxButtonsScrollView.contentSize = relaxButtonsView.frame.size;
	
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
	
	// Add buttons on sub-panels.
	NSMutableDictionary* buttonGroups = [[NSMutableDictionary alloc] initWithCapacity:6];
	for(NSString* actionName in actionButtons)
	{
		NSString* buttonCategory = [Game actionList][actionName][@"category"];

		// If there's not already a button group for this category, make one, initializing it with the button.
		// If there is, add the button to said group.
		if(!buttonGroups[buttonCategory])
			buttonGroups[buttonCategory] = [NSMutableArray arrayWithObject:actionButtons[actionName]];
		else
			[(NSMutableArray*)buttonGroups[buttonCategory] addObject:actionButtons[actionName]];
		
		// Load and set button sounds.
		[(DBActionButton*)actionButtons[actionName] setTooltipSound:actionName];
		
		// Load and set button images, for normal and disabled state.
		// Normal image is ACTION_NAME.png; disabled image is ACTION_NAME_disabled.png.
 		NSString* imageName = [NSString stringWithFormat:@"%s.png", [[Game actionList][actionName][@"name"] UTF8String]];
		[(DBActionButton*)actionButtons[actionName] setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
		//NSString* imageName_disabled = [NSString stringWithFormat:@"%s_disabled.png", [[Game actionList][actionName][@"name"] UTF8String]];
		//[(DBActionButton*)[actionButtons objectForKey:actionName] setBackgroundImage:[UIImage imageNamed:imageName_disabled] forState:UIControlStateDisabled];
		
//		printf("action name: %s; image name: %s; button category: %s\n", [actionName UTF8String], [imageName UTF8String], [buttonCategory UTF8String]);
		//printf("action name: %s; image name: %s; disabled image name: %s, button category: %s\n", [actionName UTF8String], [imageName UTF8String], [imageName_disabled UTF8String], [buttonCategory UTF8String]);
		
		UIView* theButtonPanel;
		if([buttonCategory isEqualToString:@"relax"])
		{
			theButtonPanel = relaxButtonsView;
		}
		else if([buttonCategory isEqualToString:@"breathe"])
		{
			theButtonPanel = breatheButtonsView;
		}
		else if([buttonCategory isEqualToString:@"beTogether"])
		{
			theButtonPanel = beTogetherButtonsView;
		}
		else if([buttonCategory isEqualToString:@"position"])
		{
			theButtonPanel = positionsButtonsView;
		}
		else if([buttonCategory isEqualToString:@"verbalCare"])
		{
			theButtonPanel = verbalCareButtonsView;
		}
		else if([buttonCategory isEqualToString:@"help"])
		{
			theButtonPanel = getHelpButtonsView;
		}
		
		CGRect buttonFrame = CGRectMake(ACTION_BUTTON_SPACING + (ACTION_BUTTON_SPACING + ACTION_BUTTON_SIZE) * ([(NSMutableArray*)buttonGroups[buttonCategory] count] - 1), ACTION_BUTTON_SPACING, ACTION_BUTTON_SIZE, ACTION_BUTTON_SIZE);
		((DBActionButton*)actionButtons[actionName]).frame = buttonFrame;
		[theButtonPanel addSubview:actionButtons[actionName]];
		
	}
	
	// Set sizes of button sub-panel views according to number of buttons.
	CGRect buttonsViewFrame;
	
	buttonsViewFrame = CGRectMake(relaxButtonsView.frame.origin.x, relaxButtonsView.frame.origin.y, ACTION_BUTTON_SPACING + (ACTION_BUTTON_SPACING + ACTION_BUTTON_SIZE) * [(NSMutableArray*)buttonGroups[@"relax"] count], relaxButtonsView.frame.size.height);
	relaxButtonsView.frame = buttonsViewFrame;
	relaxButtonsScrollView.contentSize = relaxButtonsView.frame.size;
	
	buttonsViewFrame = CGRectMake(breatheButtonsView.frame.origin.x, breatheButtonsView.frame.origin.y, ACTION_BUTTON_SPACING + (ACTION_BUTTON_SPACING + ACTION_BUTTON_SIZE) * [(NSMutableArray*)buttonGroups[@"breathe"] count], breatheButtonsView.frame.size.height);
	breatheButtonsView.frame = buttonsViewFrame;
	breatheButtonsScrollView.contentSize = breatheButtonsView.frame.size;
	
	buttonsViewFrame = CGRectMake(beTogetherButtonsView.frame.origin.x, beTogetherButtonsView.frame.origin.y, ACTION_BUTTON_SPACING + (ACTION_BUTTON_SPACING + ACTION_BUTTON_SIZE) * [(NSMutableArray*)buttonGroups[@"beTogether"] count], beTogetherButtonsView.frame.size.height);
	beTogetherButtonsView.frame = buttonsViewFrame;
	beTogetherButtonsScrollView.contentSize = beTogetherButtonsView.frame.size;
	
	buttonsViewFrame = CGRectMake(positionsButtonsView.frame.origin.x, positionsButtonsView.frame.origin.y, ACTION_BUTTON_SPACING + (ACTION_BUTTON_SPACING + ACTION_BUTTON_SIZE) * [(NSMutableArray*)buttonGroups[@"position"] count], positionsButtonsView.frame.size.height);
	positionsButtonsView.frame = buttonsViewFrame;
	positionsButtonsScrollView.contentSize = positionsButtonsView.frame.size;
	
	buttonsViewFrame = CGRectMake(verbalCareButtonsView.frame.origin.x, verbalCareButtonsView.frame.origin.y, ACTION_BUTTON_SPACING + (ACTION_BUTTON_SPACING + ACTION_BUTTON_SIZE) * [(NSMutableArray*)buttonGroups[@"verbalCare"] count], verbalCareButtonsView.frame.size.height);
	verbalCareButtonsView.frame = buttonsViewFrame;
	verbalCareButtonsScrollView.contentSize = verbalCareButtonsView.frame.size;
	
	buttonsViewFrame = CGRectMake(getHelpButtonsView.frame.origin.x, getHelpButtonsView.frame.origin.y, ACTION_BUTTON_SPACING + (ACTION_BUTTON_SPACING + ACTION_BUTTON_SIZE) * [(NSMutableArray*)buttonGroups[@"help"] count], getHelpButtonsView.frame.size.height);
	getHelpButtonsView.frame = buttonsViewFrame;
	getHelpButtonsScrollView.contentSize = getHelpButtonsView.frame.size;
	
	dilationLabelPopupView.layer.cornerRadius = 8;
	dilationLabelPopupView.layer.masksToBounds = YES;
	
	supportDisplayTooltip.layer.cornerRadius = 6;
	supportDisplayTooltip.layer.masksToBounds = YES;
	
	// Add tap gesture recognizer to support display (to pop up tooltip).
	UITapGestureRecognizer* supportDisplayTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(supportDisplayPressed)];
	[supportDisplay addGestureRecognizer:supportDisplayTapped];
	
	// Add swipe gesture recognizers to mom view (to rub tummy).
	UISwipeGestureRecognizer* momSwipedRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(momTummyRub:)];
	[momSwipedRight setDirection:UISwipeGestureRecognizerDirectionRight];
	[momPicView addGestureRecognizer:momSwipedRight];
	UISwipeGestureRecognizer* momSwipedLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(momTummyRub:)];
	[momSwipedLeft setDirection:UISwipeGestureRecognizerDirectionRight];
	[momPicView addGestureRecognizer:momSwipedLeft];
	
	// Add tap gesture recognizer to mom view (to bring up thought bubble with coping display).
	UITapGestureRecognizer* momTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCopingDisplay)];
	[momPicView addGestureRecognizer:momTapped];
	
	// Start the display refresh timer.
	[self startDisplayTimer];
	
	// Set certain variables to values specified in main menu.
	[game setStartingDilation:[settings[@"startingDilation"] floatValue]];
	
	// Start the game timer.	
	[self.game startGame];
	
//	[self endGame];
}

#pragma mark - Action Methods

- (IBAction)endGameToMainMenuButtonPressed
{	
	self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)seeBirthButtonPressed
{
	birthView.frame = self.view.bounds;
	[self.view addSubview:birthView];
	[birthView startBirth];
}

- (IBAction)surveyButtonPressed
{
	NSLog(@"Survey button pressed");
	
	SurveyViewController* surveyViewController = [[SurveyViewController alloc] init];
	surveyViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	
	[self presentViewController:surveyViewController animated:YES completion:nil];
}

- (IBAction)resumeButtonPressed
{
	quitView.hidden = YES;
}

- (IBAction)quitButtonPressed
{
	self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)nurseHelpCloseButtonPressed
{
	[self stopSound];
	nurseHelpView.hidden = YES;
}

//- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
//{
//    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
//        UIView *piece = gestureRecognizer.view;
//        CGPoint locationInView = [gestureRecognizer locationInView:piece];
//        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
//        
//        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
//        piece.center = locationInSuperview;
//    }
//}
//
- (IBAction)buttonHandlePan:(UIPanGestureRecognizer *)sender
{
	UIView *selectedView = [sender view];
    //[self adjustAnchorPointForGestureRecognizer:sender];
    
    if ([sender state] == UIGestureRecognizerStateBegan || [sender state] == UIGestureRecognizerStateChanged) {
        CGPoint translation = [sender translationInView:[selectedView superview]];
        if(selectedView.frame.origin.x > -1 && selectedView.frame.origin.x < 474)
        {
            [selectedView setCenter:CGPointMake([selectedView center].x + translation.x, [selectedView center].y)];
            [sender setTranslation:CGPointZero inView:[selectedView superview]];
        }
    }
    if ([sender state] == UIGestureRecognizerStateEnded)
    {
        if(selectedView.frame.origin.x > 45 && buttonsPanelExpanded)
        {
            buttonsPanelExpanded = NO;
            [self toggleButtonsPanel:NO];
        }
        if(selectedView.frame.origin.x < 438 && !buttonsPanelExpanded)
        {
            buttonsPanelExpanded = YES;
            [self toggleButtonsPanel:YES];
        }
        
        if(selectedView.frame.origin.x < 0)
        {
            [selectedView setCenter:CGPointMake(240, [selectedView center].y)];
        }
        if(selectedView.frame.origin.x > 470)
        {
            [selectedView setCenter:CGPointMake(708, [selectedView center].y)];
        }
    }
    printf("%f\n", selectedView.frame.origin.x);

}

- (IBAction)contractionsHandlePan:(UIPanGestureRecognizer *)sender
{
    UIView *selectedView = [sender view];
    //[self adjustAnchorPointForGestureRecognizer:sender];
    if ([sender state] == UIGestureRecognizerStateBegan || [sender state] == UIGestureRecognizerStateChanged)
    {
        printf("%f", selectedView.frame.origin.x);
        CGPoint translation = [sender translationInView:[selectedView superview]];
        if(selectedView.frame.origin.x > -450 && selectedView.frame.origin.x < 1)
        {
            [selectedView setCenter:CGPointMake([selectedView center].x + translation.x, [selectedView center].y)];
            [sender setTranslation:CGPointZero inView:[selectedView superview]];
        }
    }
    if ([sender state] == UIGestureRecognizerStateEnded)
    {
        if(selectedView.frame.origin.x > -410 && !contractionsPanelExpanded)
        {
            contractionsPanelExpanded = YES;
            [self toggleContractionsPanel:YES];
        }
        if(selectedView.frame.origin.x < -45 && contractionsPanelExpanded)
        {
            contractionsPanelExpanded = NO;
            [self toggleContractionsPanel:NO];
        }
        
        if(selectedView.frame.origin.x < -445)
        {
            [selectedView setCenter:CGPointMake(-445, [selectedView center].y)];
        }
        if(selectedView.frame.origin.x > 0)
        {
            [selectedView setCenter:CGPointMake(240, [selectedView center].y)];
        }
    }
	
}

- (IBAction)buttonHandleSlideOut:(UIGestureRecognizer*)sender
{
	[self toggleButtonsPanel:YES];
	buttonsPanelExpanded = YES;
}

- (IBAction)buttonHandleSlideIn:(UIGestureRecognizer*)sender
{
	[self toggleButtonsPanel:NO];
	buttonsPanelExpanded = NO;
}

- (IBAction)contractionsHandleSlideOut:(UIGestureRecognizer*)sender
{
	[self toggleContractionsPanel:YES];
	contractionsPanelExpanded = YES;
}

- (IBAction)contractionsHandleSlideIn:(UIGestureRecognizer*)sender
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

//- (IBAction)getHelpActionsButtonPressed:(id)sender
//{
//	[self toggleButtonSubPanel:getHelpButton];
//}

- (IBAction)getHelpButtonPressed:(id)sender
{
	NSLog(@"Help button pressed.");
	
	// If we're currently displaying a help window, do nothing.
	if(nurseHelpView.hidden == NO)
		return;
	
	// Otherwise, display a help window.
	[self showNurseHelpWindow];
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

- (IBAction)energyNumberButtonPressed:(id)sender
{
	energyNumberPopupView.alpha = 1.0;
	
	[self performSelector:@selector(fadeOutEnergyNumber) withObject:nil afterDelay:2.0];
}

- (void)fadeOutEnergyNumber
{
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	
	energyNumberPopupView.alpha = 0.0;
	
    [UIView commitAnimations];
}

-(IBAction)supportDisplayPressed
{
	supportDisplayTooltip.alpha = 1.0;
	
	[self performSelector:@selector(fadeOutTooltip:) withObject:supportDisplayTooltip afterDelay:2.0];
}

-(void)fadeOutTooltip:(UIView*)tooltip
{
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	
	tooltip.alpha = 0.0;
	
    [UIView commitAnimations];
}

-(IBAction)momTummyRub:(UIGestureRecognizer *)sender
{
	[self actionButtonPressed:actionButtons[@"rubTummy"]];
}

-(IBAction)showCopingDisplay
{
	[copingDisplay show];
}

#pragma mark - Button sub-panel actions

-(void)enableButtonNow:(DBActionButton*) button
{
	button.onCooldown = NO;
	if([game canPerformAction:button.name])
		button.enabled = YES;
}

-(void)enableButton:(DBActionButton*) button afterCooldown:(NSTimeInterval) cooldown
{
	NSMethodSignature* sig = [self methodSignatureForSelector:@selector(enableButtonNow:)];
	NSInvocation* inv = [NSInvocation invocationWithMethodSignature:sig];
	[inv setSelector:@selector(enableButtonNow:)];
	[inv setTarget:self];
	__unsafe_unretained DBActionButton* tempButton = button;
	[inv setArgument:&tempButton atIndex:2];
	NSTimer* enableTimer;
	enableTimer = [NSTimer scheduledTimerWithTimeInterval:(cooldown * GAME_TIMER_TICK) invocation:inv repeats:NO];	
}

-(void)actionButtonPressed:(DBActionButton*)button
{
	printf("%s button pressed\n", [button.name UTF8String]);
	
	if([game performAction:button.name])
	{
		button.enabled = NO;
		button.onCooldown = YES;
		[button setCooldown:([game getCooldown:button.name] * GAME_TIMER_TICK)];
		
		// Re-enable the button after the cooldown elapses.
		NSTimeInterval cooldown = [game getCooldown:button.name];
		[self enableButton:button afterCooldown:cooldown];
	}
}

-(void)actionButtonTouched:(DBActionButton*)button
{
	[button playTooltipSound];
	
	if([settings[@"showTooltips"] boolValue] == YES)
		[self showTooltipForView:button byViewName:[NSString stringWithFormat:@"%@Button", button.name]  withTag:@"default"];
}

#pragma mark - Delegate methods

-(void)contractionStarted
{
	if(glowing == NO)
	{
		glowing = YES;
//		momPicView.animationImages = [[positionList objectForKey:game.getPosition] objectForKey:@"glowAnimation"];
//		momPicView.animationDuration = 1.0;
//		momPicView.animationRepeatCount = 1;
//		[momPicView startAnimating];
		[self displayPosition];
	}	
}

-(void)contractionEnded
{
	if(glowing == YES)
	{
		glowing = NO;
		[self displayPosition];
	}
}

@end

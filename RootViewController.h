//
//  RootViewController.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Game.h"
#import "ContractionsGraphView.h"
#import "DBSlidingWindowView.h"

typedef enum
{
	relaxButton,
	breatheButton,
	beTogetherButton,
	positionsButton,
	verbalCareButton,
	getHelpButton
} topLevelButton;

#pragma mark - RootViewController class declaration

@interface RootViewController : UIViewController
{
	Game* game;
	
	bool buttonsPanelExpanded;
	bool contractionsPanelExpanded;
	
	NSTimer* displayTimer;
	SystemSoundID audioEffect;
}

@property (retain, nonatomic) IBOutlet UIView *gameOverScreen;
@property (retain, nonatomic) IBOutlet UILabel *gameOverGradeDisplay;
- (IBAction)quitButtonPressed;

// Background image.
@property (retain, nonatomic) IBOutlet UIImageView *backgroundImageView;

// Display areas for four of the displayed stats.
@property (retain, nonatomic) IBOutlet DBSlidingWindowView *supportDisplay;
@property (nonatomic, retain) IBOutlet UIProgressView *energyDisplay;

// The display area showing the mother.
@property (retain, nonatomic) IBOutlet UIImageView *momPicView;
@property (retain, nonatomic) IBOutlet UIView *dilationLabelPopupView;
@property (retain, nonatomic) IBOutlet UILabel *dilationDisplay;
@property (retain, nonatomic) IBOutlet UIButton *dilationDisplayButton;
- (IBAction)dilationDisplayButtonPressed:(id)sender;
- (void)fadeOutDilationDisplay;

#pragma mark - Contraction monitor

@property (retain, nonatomic) IBOutlet UIView *contractionsView;
@property (retain, nonatomic) IBOutlet UILabel *contractionsDisplay;
@property (retain, nonatomic) IBOutlet ContractionsGraphView *contractionsGraphView;

@property (retain, nonatomic) IBOutlet UIImageView *contractionsViewHandle;
- (IBAction)contractionsHandleSwipeRight:(UIGestureRecognizer*)sender;
- (IBAction)contractionsHandleSwipeLeft:(UIGestureRecognizer*)sender;

- (void)toggleContractionsPanel:(BOOL) expand;
@property bool contractionsPanelExpanded;

#pragma mark - Button panels

// The primary button panel.
@property (retain, nonatomic) IBOutlet UIView *buttonsView;

@property (retain, nonatomic) IBOutlet UIImageView *buttonsViewHandle;
- (IBAction)buttonHandleSwipeUp:(UIGestureRecognizer*)sender;
- (IBAction)buttonHandleSwipeDown:(UIGestureRecognizer*)sender;

- (void)toggleButtonsPanel:(BOOL) expand;
@property bool buttonsPanelExpanded;

// Buttons on the primary button panel.
@property (retain, nonatomic) IBOutlet UIButton *relaxActionsButton;
@property (retain, nonatomic) IBOutlet UIButton *breatheActionsButton;
@property (retain, nonatomic) IBOutlet UIButton *beTogetherActionsButton;
@property (retain, nonatomic) IBOutlet UIButton *positionsActionsButton;
@property (retain, nonatomic) IBOutlet UIButton *verbalCareActionsButton;
@property (retain, nonatomic) IBOutlet UIButton *getHelpActionsButton;

// Buttons on the sub-panels.

// Buttons on the relaxation sub-panel.

// Scroll views holding the button sub-panels for each category of action, 
// and the button sub-panels themselves.
@property (retain, nonatomic) IBOutlet UIScrollView *relaxButtonsScrollView;
@property (retain, nonatomic) IBOutlet UIView *relaxButtonsView;
@property (retain, nonatomic) IBOutlet UIScrollView *breatheButtonsScrollView;
@property (retain, nonatomic) IBOutlet UIView *breatheButtonsView;
@property (retain, nonatomic) IBOutlet UIScrollView *beTogetherButtonsScrollView;
@property (retain, nonatomic) IBOutlet UIView *beTogetherButtonsView;
@property (retain, nonatomic) IBOutlet UIScrollView *positionsButtonsScrollView;
@property (retain, nonatomic) IBOutlet UIView *positionsButtonsView;
@property (retain, nonatomic) IBOutlet UIScrollView *verbalCareButtonsScrollView;
@property (retain, nonatomic) IBOutlet UIView *verbalCareButtonsView;
@property (retain, nonatomic) IBOutlet UIScrollView *getHelpButtonsScrollView;
@property (retain, nonatomic) IBOutlet UIView *getHelpButtonsView;

// Actions for buttons on the main panel.
- (IBAction)relaxActionsButtonPressed:(id)sender;
- (IBAction)breatheActionsButtonPressed:(id)sender;
- (IBAction)beTogetherActionsButtonPressed:(id)sender;
- (IBAction)positionsActionButtonPressed:(id)sender;
- (IBAction)verbalCareActionsButtonPressed:(id)sender;
- (IBAction)getHelpActionsButtonPressed:(id)sender;

// Actions for buttons on the sub-panels.

// Actions for buttons on the relaxation sub-panel.
- (IBAction)lightTouchMassageButtonPressed:(id)sender;
- (IBAction)acupressureButtonPressed:(id)sender;
- (IBAction)heatPackButtonPressed:(id)sender;
- (IBAction)coldClothButtonPressed:(id)sender;
- (IBAction)ragDollButtonPressed:(id)sender;
- (IBAction)aromatherapyButtonPressed:(id)sender;
- (IBAction)playMusicButtonPressed:(id)sender;
- (IBAction)visualizationButtonPressed:(id)sender;

- (IBAction)heatPackButtonTouched;

- (void) toggleButtonSubPanel:(topLevelButton) button;
- (void) hideAllButtonSubPanels;

void buttonSoundAudioCallback(SystemSoundID soundID, void *clientData);
-(void) playSound: (NSString *)fName: (NSString *)ext;

@property (nonatomic, retain) Game* game;

-(void)startDisplayTimer;
-(void)displayTimerTick:(NSTimer*)timer;

@end

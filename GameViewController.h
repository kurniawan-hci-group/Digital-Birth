//
//  GameViewController.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 GameViewController contains all the views which make up the game UI.
 It also owns a Game object (see Game.h for details).
 */

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>
#import "Game.h"
#import "ContractionsGraphView.h"
#import "DBSlidingWindowView.h"
#import "DBEnergyView.h"
#import "DBCopingDisplay.h"
#import "DBActionButton.h"
#import "DBGameSummaryView.h"
#import "DBTooltipView.h"
#import "DBBirthView.h"

#define ACTION_BUTTON_SIZE		56
#define ACTION_BUTTON_SPACING	 6

typedef enum
{
	relaxButton,
	breatheButton,
	beTogetherButton,
	positionsButton,
	verbalCareButton,
	getHelpButton
} topLevelButton;

#pragma mark - GameViewController class declaration

@protocol GameViewDelegate <NSObject>

@property (readonly) int gameSpeed;

@end

@interface GameViewController : UIViewController <GameDelegate>
{
	id <GameViewDelegate> __weak delegate;
	
	Game* game;
	
	bool glowing;
	
	bool buttonsPanelExpanded;
	bool contractionsPanelExpanded;
	
	NSMutableDictionary* actionButtons;
	NSMutableDictionary* positionList;
	
	NSTimer* displayTimer;
	SystemSoundID audioEffect;
}

@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) NSDictionary* settings;
@property (nonatomic) float gameTimerTick;

@property (strong, nonatomic) IBOutlet UIView *gameOverScreen;
@property (strong, nonatomic) IBOutlet DBGameSummaryView *gameSummaryView;
@property (strong, nonatomic) IBOutlet UIButton *seeBirthButton;
- (IBAction)endGameToMainMenuButtonPressed;
- (IBAction)surveyButtonPressed;
- (IBAction)seeBirthButtonPressed;

@property (strong, nonatomic) IBOutlet UIView *quitView;
- (IBAction)resumeButtonPressed;
- (IBAction)quitButtonPressed;

@property (strong, nonatomic) IBOutlet UIView* nurseHelpView;
@property (strong, nonatomic) IBOutlet UITextView* nurseHelpTextView;
@property (strong, nonatomic) IBOutlet UIImageView* nurseHelpImageView;
-(IBAction)nurseHelpCloseButtonPressed;

@property (strong, nonatomic) IBOutlet DBBirthView* birthView;

// Background image.
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;

#pragma mark - Displayed stats

@property (strong, nonatomic) IBOutlet DBCopingDisplay *copingDisplay;
@property (strong, nonatomic) IBOutlet DBSlidingWindowView *supportDisplay;
@property (strong, nonatomic) IBOutlet UILabel *supportDisplayTooltip;
@property (nonatomic, strong) IBOutlet DBEnergyView *energyDisplay;
@property (strong, nonatomic) IBOutlet UIImageView *sleepIndicatorView;
@property (strong, nonatomic) IBOutlet UILabel *energyNumberLabel;
@property (strong, nonatomic) IBOutlet UIButton *energyNumberButton;
@property (strong, nonatomic) IBOutlet UIView *energyNumberPopupView;

- (IBAction)energyNumberButtonPressed:(id)sender;
- (void)fadeOutEnergyNumber;


// The display area showing the mother.
@property (strong, nonatomic) IBOutlet UIImageView *momPicView;
@property (strong, nonatomic) IBOutlet UIImageView *momPicGlowView;
- (IBAction)momTummyRub:(UIGestureRecognizer*)sender;
@property (strong, nonatomic) IBOutlet UIView *dilationLabelPopupView;
@property (strong, nonatomic) IBOutlet UILabel *dilationDisplay;
@property (strong, nonatomic) IBOutlet UIButton *dilationDisplayButton;
- (IBAction)dilationDisplayButtonPressed:(id)sender;
- (void)fadeOutDilationDisplay;

#pragma mark - Contraction monitor

@property (strong, nonatomic) IBOutlet UIView *contractionsView;
@property (strong, nonatomic) IBOutlet UILabel *contractionsDisplay;
@property (strong, nonatomic) IBOutlet ContractionsGraphView *contractionsGraphView;

// For sliding the contractions monitor in and out:
@property (retain, nonatomic) IBOutlet UIImageView *contractionsViewHandle;
- (IBAction)contractionsHandlePan:(UIPanGestureRecognizer*)sender;
- (IBAction)contractionsHandleSlideOut:(UIGestureRecognizer*)sender;
- (IBAction)contractionsHandleSlideIn:(UIGestureRecognizer*)sender;

- (void)toggleContractionsPanel:(BOOL) expand;
@property bool contractionsPanelExpanded;

#pragma mark - Button panels

// The primary button panel.
@property (strong, nonatomic) IBOutlet UIView *buttonsView;

// For sliding the buttons panel in and out:
@property (nonatomic, strong) IBOutlet UIImageView *buttonsViewHandle;
- (IBAction)buttonHandlePan:(UIGestureRecognizer*)sender;
- (IBAction)buttonHandleSlideOut:(UIGestureRecognizer*)sender;
- (IBAction)buttonHandleSlideIn:(UIGestureRecognizer*)sender;

- (void)toggleButtonsPanel:(BOOL) expand;
@property bool buttonsPanelExpanded;

// Buttons on the primary button panel.
@property (strong, nonatomic) IBOutlet UIButton *relaxActionsButton;
@property (strong, nonatomic) IBOutlet UIButton *breatheActionsButton;
@property (strong, nonatomic) IBOutlet UIButton *beTogetherActionsButton;
@property (strong, nonatomic) IBOutlet UIButton *positionsActionsButton;
@property (strong, nonatomic) IBOutlet UIButton *verbalCareActionsButton;
@property (strong, nonatomic) IBOutlet UIButton *getHelpActionsButton;

// Scroll views holding the button sub-panels for each category of action, 
// and the button sub-panels themselves.
@property (strong, nonatomic) IBOutlet UIScrollView *relaxButtonsScrollView;
@property (strong, nonatomic) IBOutlet UIView *relaxButtonsView;
@property (strong, nonatomic) IBOutlet UIScrollView *breatheButtonsScrollView;
@property (strong, nonatomic) IBOutlet UIView *breatheButtonsView;
@property (strong, nonatomic) IBOutlet UIScrollView *beTogetherButtonsScrollView;
@property (strong, nonatomic) IBOutlet UIView *beTogetherButtonsView;
@property (strong, nonatomic) IBOutlet UIScrollView *positionsButtonsScrollView;
@property (strong, nonatomic) IBOutlet UIView *positionsButtonsView;
@property (strong, nonatomic) IBOutlet UIScrollView *verbalCareButtonsScrollView;
@property (strong, nonatomic) IBOutlet UIView *verbalCareButtonsView;
@property (strong, nonatomic) IBOutlet UIScrollView *getHelpButtonsScrollView;
@property (strong, nonatomic) IBOutlet UIView *getHelpButtonsView;

// Actions for buttons on the main panel.
- (IBAction)relaxActionsButtonPressed:(id)sender;
- (IBAction)breatheActionsButtonPressed:(id)sender;
- (IBAction)beTogetherActionsButtonPressed:(id)sender;
- (IBAction)positionsActionButtonPressed:(id)sender;
- (IBAction)verbalCareActionsButtonPressed:(id)sender;
//- (IBAction)getHelpActionsButtonPressed:(id)sender;
- (IBAction)getHelpButtonPressed:(id)sender;

#pragma mark - Sub-panel button actions
-(void)actionButtonPressed:(DBActionButton*)button;
-(void)actionButtonTouched:(DBActionButton*)button;

- (void) toggleButtonSubPanel:(topLevelButton) button;
- (void) hideAllButtonSubPanels;

void buttonSoundAudioCallback(SystemSoundID soundID, void *clientData);

@property (nonatomic, strong) Game* game;

-(void)startDisplayTimer;
-(void)displayTimerTick:(NSTimer*)timer;

-(void)contractionStarted;
-(void)contractionEnded;
-(void)displayPosition;
-(void)pulseCoping;

@end

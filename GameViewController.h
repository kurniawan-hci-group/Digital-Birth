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
#import "DBActionButton.h"
#import "DBGameSummaryView.h"

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
	id <GameViewDelegate> delegate;
	
	Game* game;
	
	bool glowing;
	
	bool buttonsPanelExpanded;
	bool contractionsPanelExpanded;
	
	NSMutableDictionary* actionButtons;
	NSMutableDictionary* positionList;
	
	NSTimer* displayTimer;
	SystemSoundID audioEffect;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) NSDictionary* settings;
@property (nonatomic) float gameTimerTick;

@property (retain, nonatomic) IBOutlet UIView *gameOverScreen;
@property (retain, nonatomic) IBOutlet DBGameSummaryView *gameSummaryView;
- (IBAction)endGameToMainMenuButtonPressed;

@property (retain, nonatomic) IBOutlet UIView *quitView;
- (IBAction)resumeButtonPressed;
- (IBAction)quitButtonPressed;

// Background image.
@property (retain, nonatomic) IBOutlet UIImageView *backgroundImageView;

#pragma mark - Displayed stats

@property (retain, nonatomic) IBOutlet UIImageView *copingDisplay;

@property (retain, nonatomic) IBOutlet DBSlidingWindowView *supportDisplay;
@property (retain, nonatomic) IBOutlet UILabel *supportDisplayTooltip;
@property (nonatomic, retain) IBOutlet DBEnergyView *energyDisplay;
@property (retain, nonatomic) IBOutlet UIImageView *sleepIndicatorView;
@property (retain, nonatomic) IBOutlet UILabel *energyNumberLabel;
@property (retain, nonatomic) IBOutlet UIButton *energyNumberButton;
@property (retain, nonatomic) IBOutlet UIView *energyNumberPopupView;

- (IBAction)energyNumberButtonPressed:(id)sender;
- (void)fadeOutEnergyNumber;


// The display area showing the mother.
@property (retain, nonatomic) IBOutlet UIImageView *momPicView;
- (IBAction)momTummyRub:(UIGestureRecognizer*)sender;
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
- (IBAction)contractionsHandleSlideOut:(UIGestureRecognizer*)sender;
- (IBAction)contractionsHandleSlideIn:(UIGestureRecognizer*)sender;

- (void)toggleContractionsPanel:(BOOL) expand;
@property bool contractionsPanelExpanded;

#pragma mark - Button panels

// The primary button panel.
@property (retain, nonatomic) IBOutlet UIView *buttonsView;

@property (retain, nonatomic) IBOutlet UIImageView *buttonsViewHandle;
- (IBAction)buttonHandleSlideOut:(UIGestureRecognizer*)sender;
- (IBAction)buttonHandleSlideIn:(UIGestureRecognizer*)sender;

- (void)toggleButtonsPanel:(BOOL) expand;
@property bool buttonsPanelExpanded;

// Buttons on the primary button panel.
@property (retain, nonatomic) IBOutlet UIButton *relaxActionsButton;
@property (retain, nonatomic) IBOutlet UIButton *breatheActionsButton;
@property (retain, nonatomic) IBOutlet UIButton *beTogetherActionsButton;
@property (retain, nonatomic) IBOutlet UIButton *positionsActionsButton;
@property (retain, nonatomic) IBOutlet UIButton *verbalCareActionsButton;
@property (retain, nonatomic) IBOutlet UIButton *getHelpActionsButton;

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

#pragma mark - Sub-panel button actions
-(void)actionButtonPressed:(DBActionButton*)button;
-(void)actionButtonTouched:(DBActionButton*)button;

- (void) toggleButtonSubPanel:(topLevelButton) button;
- (void) hideAllButtonSubPanels;

void buttonSoundAudioCallback(SystemSoundID soundID, void *clientData);
-(void) playSound: (NSString *)fName: (NSString *)ext;

@property (nonatomic, retain) Game* game;

-(void)startDisplayTimer;
-(void)displayTimerTick:(NSTimer*)timer;

-(void)contractionStarted;
-(void)contractionEnded;
-(void)displayPosition;

@end

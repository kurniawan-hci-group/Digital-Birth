//
//  GameViewController.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>
#import "Game.h"
#import "ContractionsGraphView.h"
#import "DBSlidingWindowView.h"
#import "DBEnergyView.h"

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



@end

@interface GameViewController : UIViewController
{
	id <GameViewDelegate> delegate;
	
	Game* game;
	
	bool buttonsPanelExpanded;
	bool contractionsPanelExpanded;
	bool quitBoxExpanded;
	
	NSTimer* displayTimer;
	SystemSoundID audioEffect;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic) float gameTimerTick;

@property (retain, nonatomic) IBOutlet UIView *gameOverScreen;
@property (retain, nonatomic) IBOutlet UILabel *gameOverGradeDisplay;
- (IBAction)endGameToMainMenuButtonPressed;

@property (retain, nonatomic) IBOutlet UIView *quitView;
@property (retain, nonatomic) IBOutlet UIImageView *quitViewHandle;
- (IBAction)quitHandleSlideOut:(UIGestureRecognizer*)sender;
- (IBAction)quitHandleSlideIn:(UIGestureRecognizer*)sender;
- (IBAction)quitButtonPressed;

// Background image.
@property (retain, nonatomic) IBOutlet UIImageView *backgroundImageView;

#pragma mark - Displayed stats

@property (retain, nonatomic) IBOutlet DBSlidingWindowView *supportDisplay;
@property (nonatomic, retain) IBOutlet DBEnergyView *energyDisplay;

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
// Relaxation sub-panel.
- (IBAction)lightTouchMassageButtonPressed:(id)sender;
- (IBAction)heatPackButtonPressed:(id)sender;
- (IBAction)heatPackButtonTouched;
- (IBAction)coolClothButtonPressed:(id)sender;
- (IBAction)ragDollButtonPressed:(id)sender;
- (IBAction)aromatherapyButtonPressed:(id)sender;
- (IBAction)playMusicButtonPressed:(id)sender;
- (IBAction)visualizationButtonPressed:(id)sender;
- (IBAction)showerButtonPressed:(id)sender;
- (IBAction)tubButtonPressed:(id)sender;

// Breathing sub-panel.
- (IBAction)deepBreathingButtonPressed:(id)sender;
- (IBAction)countUpDownButtonPressed:(id)sender;
- (IBAction)rhythmicBreathingButtonPressed:(id)sender;

// Be together sub-panel.
- (IBAction)TVButtonPressed:(id)sender;
- (IBAction)movieButtonPressed:(id)sender;
- (IBAction)gamesButtonPressed:(id)sender;
- (IBAction)callFriendsButtonPressed:(id)sender;
- (IBAction)snuggleButtonPressed:(id)sender;
- (IBAction)kissButtonPressed:(id)sender;
- (IBAction)sexButtonPressed:(id)sender;
- (IBAction)rubTummyButtonPressed:(id)sender;

// Positions sub-panel.
- (IBAction)walkButtonPressed:(id)sender;
- (IBAction)standButtonPressed:(id)sender;
- (IBAction)slowDanceButtonPressed:(id)sender;
- (IBAction)leanOnWallButtonPressed:(id)sender;
- (IBAction)rockingChairButtonPressed:(id)sender;
- (IBAction)sitBackOnChairButtonPressed:(id)sender;
- (IBAction)sitOnBirthBallButtonPressed:(id)sender;
- (IBAction)lungeOnStairButtonPressed:(id)sender;
- (IBAction)kneelButtonpressed:(id)sender;
- (IBAction)squatButtonPressed:(id)sender;
- (IBAction)sitButtonPressed:(id)sender;
- (IBAction)lieOnSideButtonPressed:(id)sender;
- (IBAction)lieOnBackButtonPressed:(id)sender;
- (IBAction)allFoursButtonPressed:(id)sender;
- (IBAction)buttInAirButtonPressed:(id)sender;
- (IBAction)toiletButtonPressed:(id)sender;

// Verbal care sub-panel.
- (IBAction)affirmationButtonPressed:(id)sender;
- (IBAction)encourageButtonPressed:(id)sender;
- (IBAction)complimentButtonPressed:(id)sender;
- (IBAction)saySomethingNiceButtonPressed:(id)sender;
- (IBAction)remindOfBabyButtonPressed:(id)sender;

// Help sub-panel.
- (IBAction)askNurseButtonPressed:(id)sender;
- (IBAction)askDoulaButtonPressed:(id)sender;

- (void) toggleButtonSubPanel:(topLevelButton) button;
- (void) hideAllButtonSubPanels;

void buttonSoundAudioCallback(SystemSoundID soundID, void *clientData);
-(void) playSound: (NSString *)fName: (NSString *)ext;

@property (nonatomic, retain) Game* game;

-(void)startDisplayTimer;
-(void)displayTimerTick:(NSTimer*)timer;

@end

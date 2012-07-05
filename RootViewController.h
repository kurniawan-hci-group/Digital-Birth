//
//  RootViewController.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface RootViewController : UIViewController
{
	Game* game;
	
	bool buttonsPanelExpanded;
	bool contractionsPanelExpanded;
	
	NSTimer* gameTimer;
}

@property (retain, nonatomic) IBOutlet UIProgressView *supportDisplay;
@property (nonatomic, retain) IBOutlet UILabel *hungerDisplay;
@property (nonatomic, retain) IBOutlet UILabel *tirednessDisplay;
@property (retain, nonatomic) IBOutlet UIImageView *focusDisplayView;

@property (retain, nonatomic) IBOutlet UIView *momView;
@property (retain, nonatomic) IBOutlet UIImageView *momPicView;
@property (retain, nonatomic) IBOutlet UILabel *dilationDisplay;

@property (retain, nonatomic) IBOutlet UIView *buttonsView;
@property (retain, nonatomic) IBOutlet UIButton *buttonsViewHandle;

@property (retain, nonatomic) IBOutlet UIView *contractionsView;
@property (retain, nonatomic) IBOutlet UIButton *contractionsViewHandle;
@property (retain, nonatomic) IBOutlet UILabel *contractionsDisplay;

@property (retain, nonatomic) IBOutlet UIButton *relaxActionsButton;
@property (retain, nonatomic) IBOutlet UIButton *breatheActionsButton;
@property (retain, nonatomic) IBOutlet UIButton *beTogetherActionsButton;
@property (retain, nonatomic) IBOutlet UIButton *positionsActionsButton;
@property (retain, nonatomic) IBOutlet UIButton *verbalCareActionsButton;
@property (retain, nonatomic) IBOutlet UIButton *getHelpActionsButton;

- (IBAction)buttonsViewHandlePressed;
- (void)toggleButtonsPanel:(BOOL) expand;

- (IBAction)contractionsViewHandlePressed;
- (void)toggleContractionsPanel:(BOOL) expand;

- (IBAction)relaxActionsButtonPressed:(id)sender;
- (IBAction)breatheActionsButtonPressed:(id)sender;
- (IBAction)beTogetherActionsButtonPressed:(id)sender;
- (IBAction)positionsActionButtonPressed:(id)sender;
- (IBAction)verbalCareActionsButtonPressed:(id)sender;
- (IBAction)getHelpActionsButtonPressed:(id)sender;

@property (nonatomic, retain) Game* game;

-(void)gameTimerTick:(NSTimer*)gameTimer;
@property (nonatomic, retain) NSTimer* gameTimer;
- (IBAction)startGameTimer:sender;

@property bool buttonsPanelExpanded;
@property bool contractionsPanelExpanded;

@end

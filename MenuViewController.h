//
//  MenuViewController.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 MenuViewController contains sliders for game speed and initial dilation.
 It instantiates a GameViewController when the user presses the "Start Game"
 button, passing it the game speed and initial dilation.
 */

#import <UIKit/UIKit.h>
#import "GameViewController.h"

@interface MenuViewController : UIViewController <GameViewDelegate>

- (IBAction)newGameButtonPressed;
- (IBAction)gameSpeedSliderChanged:(id)sender;
- (IBAction)startingDilationSliderChanged:(id)sender;

@property (readonly) int gameSpeed;
@property (retain, nonatomic) IBOutlet UILabel *gameSpeedLabel;
@property (retain, nonatomic) IBOutlet UILabel *gameSpeedExplanationLabel;

@property (readonly) float startingDilation;
@property (retain, nonatomic) IBOutlet UILabel *startingDilationLabel;

@end
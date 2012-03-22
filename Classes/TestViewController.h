//
//  TestViewController.h
//  Digital-Birth
//
//  Created by User on 3/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"


@interface TestViewController : UIViewController {
	Game *_game;
	NSTimer *_contractionTimer;
}

@property (nonatomic, retain) Game *game;
@property (nonatomic, retain) NSTimer *contractionTimer;

@end

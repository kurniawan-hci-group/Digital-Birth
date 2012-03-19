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
}

@property (retain) Game *game;

@end

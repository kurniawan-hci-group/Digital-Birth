//
//  MainGameViewController.h
//  Digital-Birth
//
//  Created by Sri Kurniawan on 3/28/12.
//  Copyright 2012 University of California, Santa Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "ButtonsViewController.h"
#include "FHRViewController.h"

@interface MainGameViewController : UIViewController {
	ButtonsViewController *buttonsViewController;
	FHRViewController *viewControllerFHR;
}

- (void)startupAnimationDone:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
- (void)pullUpButtons;
- (void)pullDownButtons;
- (void)pullOutFHR;
- (void)pullInFHR;

@property (nonatomic, retain) ButtonsViewController *buttonsViewController;
@property (nonatomic, retain) FHRViewController *viewControllerFHR;

@end

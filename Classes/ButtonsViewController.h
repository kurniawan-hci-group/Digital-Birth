//
//  ButtonsViewController.h
//  Digital-Birth
//
//  Created by Sri Kurniawan on 3/15/12.
//  Copyright 2012 University of California, Santa Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ButtonsViewController : UIViewController {
	UIButton *relax;

	UIButton *lightTouchMassage;
	UIButton *acupressure;
	UIButton *heatPack;
	UIButton *coldCloth;
	UIButton *ragDoll;
	UIButton *aromatherapy;
	UIButton *music;
	UIButton *visulaize;
	
	UIButton *breathe;
	
    UIButton *deepBreathing;
	UIButton *countUpDown;
	UIButton *yogaBreathing;
	UIButton *rhythmicBreathing;
	
	UIButton *beTogether;
	
	UIButton *tv;
	UIButton *movie;
	UIButton *games;
	UIButton *callFriends;
	UIButton *walk;
	UIButton *snuggle;
	UIButton *kiss;
	UIButton *sex;
	
	UIButton *positions;
	
	UIButton *slowDance;
	UIButton *lean;
	UIButton *lunge;
	UIButton *birthBallStool;
	UIButton *allFours;
	UIButton *buttInAir;
	UIButton *lieOnSide;
	UIButton *toilet;
	
	UIButton *help;
	
	UIButton *askNurse;
	UIButton *askDoula;
	

UIViewController *buttonViewController;  
}

@property (nonatomic, retain) UIButton *relax;
@property (nonatomic, retain) UIButton *lightTouchMassage;
@property (nonatomic, retain) UIButton *acupressure;
@property (nonatomic, retain) UIButton *heatPack;
@property (nonatomic, retain) UIButton *coldCloth;
@property (nonatomic, retain) UIButton *ragDoll;
@property (nonatomic, retain) UIButton *aromatherapy;
@property (nonatomic, retain) UIButton *music;
@property (nonatomic, retain) UIButton *visualize;
@property (nonatomic, retain) UIButton *breathe;
@property (nonatomic, retain) UIButton *countUpDown;
@property (nonatomic, retain) UIButton *yogaBreathing;
@property (nonatomic, retain) UIButton *rhythmicBreathing;
@property (nonatomic, retain) UIButton *beTogether;
@property (nonatomic, retain) UIButton *tv;
@property (nonatomic, retain) UIButton *movie;
@property (nonatomic, retain) UIButton *games;
@property (nonatomic, retain) UIButton *callFriends;
@property (nonatomic, retain) UIButton *walk;
@property (nonatomic, retain) UIButton *snuggle;
@property (nonatomic, retain) UIButton *kiss;
@property (nonatomic, retain) UIButton *sex;
@property (nonatomic, retain) UIButton *positions;
@property (nonatomic, retain) UIButton *slowDance;
@property (nonatomic, retain) UIButton *lean;
@property (nonatomic, retain) UIButton *lunge;
@property (nonatomic, retain) UIButton *birthBallStool;
@property (nonatomic, retain) UIButton *buttInAir;
@property (nonatomic, retain) UIButton *lieOnSide;
@property (nonatomic, retain) UIButton *toiler;
@property (nonatomic, retain) UIButton *help;
@property (nonatomic, retain) UIButton *askNurse;
@property (nonatomic, retain) UIButton *askDoula;

-(void)showController;
-(void)hideController;
-(void)showRelaxButtons;
-(void)showBreatheButtons;
-(void)showBeTogetherButtons;
-(void)showPositionButtons;
-(void)showHelpButtons;

@end

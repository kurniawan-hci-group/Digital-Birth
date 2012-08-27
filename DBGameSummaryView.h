//
//  DBGameSummaryView.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 DBGameSummaryView is a custom view that displays some stats.
 It takes an NSDictionary of game stats and displays some or all of them 
 (depending on the value of the "hadBaby" element in the dict).
 
 DBGameSummaryView does not support user interaction.
 
 In Digital Birth, a DBGameSummaryView is a subview of game-end screen.
 */

#import <UIKit/UIKit.h>

@interface DBGameSummaryView : UIView

@property (nonatomic, retain) NSDictionary* gameSummary;

-(void)display;

@end

//
//  DBActionButton.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 DBActionButton is a custom control, a subclass of UIButton.
 It extends UIButton to add a non-displayed object name, cooldown display
 functionality, and a "tooltip sound".
 
 In Digital Birth, DBActionButtons are used for all of the action buttons.
 */

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface DBActionButton : UIButton
{
	SystemSoundID tooltipSound;
	NSArray* cooldownAnimationImages;
	
	UIImageView* cooldownImageView;
	
	NSString* name;
	bool onCooldown;
}

@property (nonatomic, retain) NSArray* cooldownAnimationImages;
@property (nonatomic, retain) NSString* name;
@property bool onCooldown;

-(void)playTooltipSound;
-(void)setCooldown:(CGFloat)cooldown;

-(void)setTooltipSound:(NSString*)soundName;
-(void)setTooltipSound:(NSString*)soundName withExtension:(NSString*)ext;

@end

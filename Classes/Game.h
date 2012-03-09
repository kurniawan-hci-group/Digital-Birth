//
//  Game.h
//  Digital-Birth
//
//  Created by User on 3/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Game : NSObject {
	Lady *_lady;
}

-(int)getBabyHR;
-(bool)babyIsDistressed;

-(int)getFocus;
-(int)getEnergy;
-(int)getSupport; 
-(int)getCopingNum; 
-(int)getDilation;
-(int)getEffacement; //want to use effacement?

//Deal with actions
-(bool)havingContraction;
-(bool)isDead; //replace with isHavingCSection?

-(void)giveEpidural;
-(void)turnOffLights;
-(void)confineToBed;


//A few ways of modeling actions

//list every action
-(void)giveBackrub;
-(void)giveIceChips;
-(void)playMusic;
-(void)sayMantra; //etc.

//categorize options
-(void)performFocusingAction;
-(void)performEnergizingAction;
-(void)performSupportiveAction;
//OR
-(void)performMassage;
-(void)haveRest;
-(void)provideDistraction;
-(void)provideFocus;
-(void)provideNaturalPainRelief;
-(void)provideDrugPainRelief;




@end

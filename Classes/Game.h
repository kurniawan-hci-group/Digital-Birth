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
-(int)getContractionNum; //0 no contraction, 255 contraction peak
-(bool)hadBaby;
-(void)perormAction:(*Action) action;





@end

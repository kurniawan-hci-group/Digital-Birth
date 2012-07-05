//
//  DigitalBirthViewController.h
//  Digital-Birth
//
//  Created by Sri Kurniawan on 3/13/12.
//  Copyright 2012 University of California, Santa Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DigitalBirthViewController : UIViewController
{
	UILabel *label;
	UILabel *statusLabel;
	UIButton *buttons;
	UIButton *FHR;
}

@property (nonatomic, retain) IBOutlet UILabel* statusLabel;

@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UIButton *buttons;
@property (nonatomic, retain) IBOutlet UIButton *FHR;

-(IBAction) pullOutButtonView: (id) sender;
-(IBAction) pullOutFHRView: (id) sender;
-(IBAction) buttonsTapped: (id)sender;

@end

//
//  DBGameSummaryView.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DBGameSummaryView.h"
#import "Functions.h"

@implementation DBGameSummaryView

@synthesize gameSummary;

-(id)initWithCoder:(NSCoder*)aCoder
{
	if(self = [super initWithCoder:aCoder])
	{
		// Initialization code here.
    }
    return self;
}

-(void)display
{
	UILabel* fieldLabel;
	UILabel* fieldContents;
	
	// Place "Grade: " label.
	fieldLabel = [[UILabel alloc] init];
	fieldLabel.text = @"Grade: ";
	fieldLabel.frame = CGRectMake(10, 5, 0, 0);
	[fieldLabel sizeToFit];
	[self addSubview:fieldLabel];
	
	// Place grade.
	fieldContents = [[UILabel alloc] init];
	fieldContents.text = [gameSummary objectForKey:@"Grade"];
	fieldContents.frame = CGRectMake(10 + fieldLabel.frame.size.width, 5, 0, 0);
	[fieldContents sizeToFit];
	[self addSubview:fieldContents];
	
	// Place reaction.
	fieldContents = [[UILabel alloc] init];
	fieldContents.text = [NSString stringWithFormat:@"\"%s\"", [[gameSummary objectForKey:@"Reaction"] UTF8String]];
	fieldContents.frame = CGRectMake(100, 5, 0, 0);
	[fieldContents sizeToFit];
	[self addSubview:fieldContents];
	
	// Place total labor duration.
	fieldLabel = [[UILabel alloc] init];
	fieldLabel.text = @"Total labor duration: ";
	fieldLabel.frame = CGRectMake(10, 30, 0, 0);
	[fieldLabel sizeToFit];
	[self addSubview:fieldLabel];
	
	fieldContents = [[UILabel alloc] init];
	fieldContents.text = [gameSummary objectForKey:@"laborDuration"];
	fieldContents.frame = CGRectMake(180, 30, 0, 0);
	[fieldContents sizeToFit];
	[self addSubview:fieldContents];

	// If we had the baby, place duration stats for each stage.
	if([[gameSummary objectForKey:@"hadBaby"] boolValue])
	{
		fieldLabel = [[UILabel alloc] init];
		fieldLabel.text = @"Early labor duration: ";
		fieldLabel.frame = CGRectMake(10, 55, 0, 0);
		[fieldLabel sizeToFit];
		[self addSubview:fieldLabel];
		
		fieldContents = [[UILabel alloc] init];
		fieldContents.text = [gameSummary objectForKey:@"earlyLaborDuration"];
		fieldContents.frame = CGRectMake(180, 55, 0, 0);
		[fieldContents sizeToFit];
		[self addSubview:fieldContents];
		
		fieldLabel = [[UILabel alloc] init];
		fieldLabel.text = @"Active labor duration: ";
		fieldLabel.frame = CGRectMake(10, 80, 0, 0);
		[fieldLabel sizeToFit];
		[self addSubview:fieldLabel];
		
		fieldContents = [[UILabel alloc] init];
		fieldContents.text = [gameSummary objectForKey:@"activeLaborDuration"];
		fieldContents.frame = CGRectMake(180, 80, 0, 0);
		[fieldContents sizeToFit];
		[self addSubview:fieldContents];
		
		fieldLabel = [[UILabel alloc] init];
		fieldLabel.text = @"Transition duration: ";
		fieldLabel.frame = CGRectMake(10, 115, 0, 0);
		[fieldLabel sizeToFit];
		[self addSubview:fieldLabel];
		
		fieldContents = [[UILabel alloc] init];
		fieldContents.text = [gameSummary objectForKey:@"transitionDuration"];
		fieldContents.frame = CGRectMake(180, 115, 0, 0);
		[fieldContents sizeToFit];
		[self addSubview:fieldContents];
		
		fieldLabel = [[UILabel alloc] init];
		fieldLabel.text = @"Pushing duration: ";
		fieldLabel.frame = CGRectMake(10, 140, 0, 0);
		[fieldLabel sizeToFit];
		[self addSubview:fieldLabel];
		
		fieldContents = [[UILabel alloc] init];
		fieldContents.text = [gameSummary objectForKey:@"pushingDuration"];
		fieldContents.frame = CGRectMake(180, 140, 0, 0);
		[fieldContents sizeToFit];
		[self addSubview:fieldContents];
	}
}

-(void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Draw a black rectangle around the edges.
	CGColorRef black = [UIColor blackColor].CGColor;
	CGContextSetFillColorWithColor(context, black);
	CGContextSetLineWidth(context, 1.0);
	CGContextStrokeRect(context, rectFor1PxStroke(self.bounds));
}

@end

//
//  DBActionButton.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DBActionButton.h"
#import "Functions.h"

@implementation DBActionButton

@synthesize name;
@synthesize cooldownAnimationImages;

-(bool)onCooldown
{
	return onCooldown;
}

-(void)setOnCooldown:(bool)val
{
	onCooldown = val;
	if(!onCooldown)
		self.imageView.animationImages = nil;
}

-(id)init
{
	if(self = [super init])
	{
		onCooldown = NO;
		
		cooldownImageView = [[UIImageView alloc] init];
		cooldownImageView.alpha = 0.3;
		[self addSubview:cooldownImageView];
	}
	return self;
}

-(void)dealloc
{
	AudioServicesDisposeSystemSoundID(tooltipSound);
}

//-(void)drawRect:(CGRect)rect
//{
//	[super drawRect:rect];
//	
//	printf("drawing rect OMG OMG OMG!!!!\n");
//
//	CGContextRef context = UIGraphicsGetCurrentContext();
//	
//	// Draw a black rectangle around the edges.
//	CGColorRef black = [UIColor blackColor].CGColor;
//	CGContextSetFillColorWithColor(context, black);
//	CGContextSetLineWidth(context, 1.0);
//	CGContextStrokeRect(context, rectFor1PxStroke(self.bounds));
//}
//
#pragma mark - Public methods

-(void)setCooldown:(CGFloat)cooldown
{
	onCooldown = YES;
	
	[cooldownImageView setFrame:self.bounds];
	cooldownImageView.animationImages = cooldownAnimationImages;
	cooldownImageView.animationDuration = cooldown;
	cooldownImageView.animationRepeatCount = 1;
	[cooldownImageView startAnimating];
}

-(void)setTooltipSound:(NSString*)soundName
{
	NSURL* soundURL = [[NSBundle mainBundle] URLForResource:soundName withExtension:@"aif"];
	AudioServicesCreateSystemSoundID((__bridge CFURLRef) soundURL, &tooltipSound);
}

-(void)setTooltipSound:(NSString*)soundName withExtension:(NSString*)ext
{
	NSURL* soundURL = [[NSBundle mainBundle] URLForResource:soundName withExtension:ext];
	AudioServicesCreateSystemSoundID((__bridge CFURLRef) soundURL, &tooltipSound);
}

-(void)playTooltipSound
{
	AudioServicesPlayAlertSound(tooltipSound);	
}

@end

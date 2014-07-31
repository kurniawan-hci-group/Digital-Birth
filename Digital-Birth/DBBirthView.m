//
//  DBBirthView.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 3/23/14.
//
//

#import "DBBirthView.h"
#import <MediaPlayer/MPMoviePlayerController.h>

@interface DBBirthView ()

@property UIImageView* birthAnimationPartOne;
@property UIImageView* birthAnimationPartTwo;
@property UIImageView* birthAnimationPartThree;

@property MPMoviePlayerController* theMoviePlayer;

@end

@implementation DBBirthView

@synthesize birthAnimationPartOne;
@synthesize birthAnimationPartTwo;
@synthesize birthAnimationPartThree;

@synthesize theMoviePlayer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self)
	{
		NSMutableArray* birthPartOneFrames = [[NSMutableArray alloc] init];
		int i = 0;
		while([[NSFileManager defaultManager] fileExistsAtPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"cooldown%d", i] ofType:@"png"]])
		{
			[birthPartOneFrames addObject:[UIImage imageNamed:[NSString stringWithFormat:@"cooldown%d.png", i++]]];
		}
		
		NSMutableArray* birthPartTwoFrames = [[NSMutableArray alloc] init];
		i = 0;
		while([[NSFileManager defaultManager] fileExistsAtPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"cooldown%d", i] ofType:@"png"]])
		{
			[birthPartTwoFrames addObject:[UIImage imageNamed:[NSString stringWithFormat:@"cooldown%d.png", i++]]];
		}
		
		NSMutableArray* birthPartThreeFrames = [[NSMutableArray alloc] init];
		i = 0;
		while([[NSFileManager defaultManager] fileExistsAtPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"cooldown%d", i] ofType:@"png"]])
		{
			[birthPartThreeFrames addObject:[UIImage imageNamed:[NSString stringWithFormat:@"cooldown%d.png", i++]]];
		}
		
		NSLog(@"Loaded button cooldown images.");
		birthAnimationPartOne = [[UIImageView alloc] initWithFrame:self.bounds];
		birthAnimationPartTwo = [[UIImageView alloc] initWithFrame:self.bounds];
		birthAnimationPartTwo = [[UIImageView alloc] initWithFrame:self.bounds];
		
		birthAnimationPartOne.animationImages = birthPartThreeFrames;
		birthAnimationPartOne.animationImages = birthPartTwoFrames;
		birthAnimationPartOne.animationImages = birthPartOneFrames;
//		[self addSubview:birthAnimationPartThree];
//		[self addSubview:birthAnimationPartTwo];
//		[self addSubview:birthAnimationPartOne];
		
		// Initialize movie player.
		
		NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"birth_scene_1" ofType:@"mp4"];
		NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
		
		theMoviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
		theMoviePlayer.controlStyle = MPMovieControlStyleNone;
		[theMoviePlayer.view setFrame:self.bounds];
		[self addSubview:theMoviePlayer.view];
		[theMoviePlayer play];
		
		// Create "Back to Main menu" button.
		
		UIButton* mainMenuButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[mainMenuButton setTitle:@"Back to Main Menu" forState:UIControlStateNormal];
		mainMenuButton.frame = CGRectMake(404, 250, 144, 30);
		[mainMenuButton addTarget:self action:@selector(mainMenuButtonPressed) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:mainMenuButton];
	}
	return self;
}

-(void)startBirth
{
//	[birthAnimationPartOne startAnimating];
	[theMoviePlayer play];
}

-(void)mainMenuButtonPressed
{
	[self removeFromSuperview];
//	[birthAnimationPartOne stopAnimating];
	[theMoviePlayer stop];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

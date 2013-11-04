//
//  DBCopingDisplay.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 10/26/13.
//
//

#import "DBCopingDisplay.h"

@interface DBCopingDisplay ()
{
	UIImageView* imageView;
	
	UIImageView* backgroundImageView;
	CGAffineTransform backgroundImageHorizontalTransform;
	CGAffineTransform backgroundImageVerticalTransform;
	
	NSInteger pulseTicksRemaining;
}

@end

@implementation DBCopingDisplay

#pragma mark - properties & accessors

-(UIImage*)image
{
	return imageView.image;
}

-(void)setImage:(UIImage*)newImage
{
	imageView.image = newImage;
}

-(UIImage*)backgroundImage
{
	return backgroundImageView.image;
}

-(void)setBackgroundImage:(UIImage*)newBackgroundImage
{
	backgroundImageView.image = newBackgroundImage;
}

@synthesize flipHorizontal;
-(void)setFlipHorizontal:(bool)flip
{
	// Set the horizontal flip transform appropriately
	backgroundImageHorizontalTransform = flip ? CGAffineTransformMake(-1, 0, 0, 1, 0, 0) : CGAffineTransformIdentity;

	// Set the image view's transform by combining the horizontal and vertical transforms.
	backgroundImageView.transform = CGAffineTransformConcat(backgroundImageHorizontalTransform, backgroundImageVerticalTransform);
	
	flipHorizontal = flip;
	
	// Adjust coping scale image position within thought bubble, appropriately for new flip settings.
	[self positionCopingScaleImage];
}

@synthesize flipVertical;
-(void)setFlipVertical:(bool)flip
{
	// Set the vertical flip transform appropriately
	backgroundImageVerticalTransform = flip ? CGAffineTransformMake(1, 0, 0, -1, 0, 0 ) : CGAffineTransformIdentity;
	
	// Set the image view's transform by combining the horizontal and vertical transforms.
	backgroundImageView.transform = CGAffineTransformConcat(backgroundImageHorizontalTransform, backgroundImageVerticalTransform);
	
	flipVertical = flip;
	
	// Adjust coping scale image position within thought bubble, appropriately for new flip settings.
	[self positionCopingScaleImage];
}

#pragma mark - initializers

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self)
	{
		self.backgroundColor = [UIColor clearColor];

		backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
		[backgroundImageView setImage:[UIImage imageNamed:@"thought_bubble.png"]];
		[self addSubview:backgroundImageView];
		
		imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 33, 33)];
		[self addSubview:imageView];
		
		self.flipHorizontal = NO;
		self.flipVertical = NO;
		
		self.visibleAlpha = 0.5;
		self.autoFadeOut = NO;
		self.fadeOutDelay = 2.0;
		self.fadeOutDuration = 1.0;

//		[self setOpaque:NO];
//		[imageView setOpaque:NO];
	}
	return self;
}

#pragma mark - display methods

-(void)show
{
	self.alpha = _visibleAlpha;
	
	if(_autoFadeOut)
		[self performSelector:@selector(fadeOut) withObject:nil afterDelay:_fadeOutDelay];
}

//-(void)showForDuration:(NSTimeInterval)duration
//{
//	self.alpha = _visibleAlpha;
//	
//	[self performSelector:@selector(fadeOut) withObject:nil afterDelay:duration];
//	
//}
//
-(void)hide
{
	self.alpha = 0.0;
}

-(void)fadeOut
{
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_fadeOutDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	
	self.alpha = 0.0;
	
    [UIView commitAnimations];
}

-(void)fadeOutWithDuration:(NSTimeInterval)duration
{
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	
	self.alpha = 0.0;
	
    [UIView commitAnimations];
}

-(void)pulse:(NSInteger)times
{
	NSTimer* pulseTickTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(pulseTick:) userInfo:nil repeats:YES];
	pulseTicksRemaining = times;
	[[NSRunLoop currentRunLoop] addTimer:pulseTickTimer forMode:NSDefaultRunLoopMode];
}

-(void)pulseTick:(NSTimer*)timer
{
	pulseTicksRemaining--;
	
	[self show];
	[self fadeOutWithDuration:1.5];
	
	if(pulseTicksRemaining == 0)
		[timer invalidate];
}

#pragma mark - helper methods

-(void)positionCopingScaleImage
{
	NSLog(@"Adjusting coping scale image position...");
	printf("flip H: %d; flip V: %d\n", flipHorizontal, flipVertical);
	
	if(!flipHorizontal && !flipVertical)
		imageView.frame = CGRectMake(14, 6, 33, 33);

	else if(flipHorizontal && !flipVertical)
		imageView.frame = CGRectMake(12, 6, 33, 33);

	else if (!flipHorizontal && flipVertical)
		imageView.frame = CGRectMake(14, 15, 33, 33);

	else // if (flipHorizontal && flipVertical)
		imageView.frame = CGRectMake(12, 15, 33, 33);
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

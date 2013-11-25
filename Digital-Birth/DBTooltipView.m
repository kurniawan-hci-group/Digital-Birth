//
//  DBTooltipView.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 10/26/13.
//
//

#import "DBTooltipView.h"

@interface DBTooltipView ()

@property (nonatomic, strong) UIButton* closeButton;
@property (nonatomic, strong) UILabel* textLabel;

@end

@implementation DBTooltipView

@synthesize tag;

#pragma mark - properties & accessors

-(NSString*)text
{
	return textLabel.text;
}
-(void)setText:(NSString *)text
{
	textLabel.text = text;
	[textLabel sizeToFit];
	
	NSLog(@"Text label frame is now %@", NSStringFromCGRect(textLabel.frame));

	closeButton.frame = CGRectMake(textLabel.frame.size.width, 0, 20, 20);
	[self sizeToFit];
	
	NSLog(@"Self frame is now %@", NSStringFromCGRect(self.frame));
}

@synthesize closeButton;
@synthesize textLabel;

#pragma mark - initializers

-(void)initialize
{
	NSLog(@"Initializing DBTooltipView...");
	
	self.backgroundColor = [UIColor whiteColor];
	
	// Create and add text label.
	textLabel = [[UILabel alloc] init];
	[self addSubview:textLabel];

	// Create and add close button.
	closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[closeButton setTitle:@"x" forState:UIControlStateNormal];
	[closeButton addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:closeButton];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
        [self initialize];
    }
    return self;
}

#pragma mark - UI helper methods

-(CGSize)sizeThatFits:(CGSize)size
{
	return CGSizeMake(textLabel.frame.size.width + closeButton.frame.size.width, MAX(textLabel.frame.size.height, closeButton.frame.size.height));
}

#pragma mark - methods

-(void)closeButtonPressed:(UIButton*)sender
{
	NSLog(@"Close button pressed on tooltip \"%@\"", self.text);
	[self hide];
}

-(void)show
{
	self.hidden = NO;
	self.alpha = 1.0;
}

-(void)hide
{
	self.hidden = YES;
	self.alpha = 0.0;
}

@end

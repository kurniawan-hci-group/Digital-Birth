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
}

@synthesize closeButton;
@synthesize textLabel;

#pragma mark - initializers

-(void)initialize
{
	// Create and add close button.
	closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	closeButton.frame = CGRectMake(self.frame.size.width - 20, 0, 20, 20);
	[self addSubview:closeButton];
	
	// Create and add text label.
	textLabel = [[UILabel alloc] init];
	textLabel.frame = CGRectMake(0, 0, self.frame.size.width - 20, 20);
	[self addSubview:textLabel];
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

#pragma mark - methods

-(void)show
{
	
}

-(void)hide
{
	
}

@end

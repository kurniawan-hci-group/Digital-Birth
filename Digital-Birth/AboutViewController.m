//
//  AboutViewController.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 2/4/14.
//
//

#import "AboutViewController.h"

@interface AboutViewController ()
{
	BOOL devCreditsShown;
}

@property BOOL devCreditsShown;

- (IBAction)mainMenuButtonPressed:(id)sender;
- (IBAction)developerCreditsButtonPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *developerCreditsButton;
@property (strong, nonatomic) IBOutlet UITextView *devCreditsTextView;

@end

@implementation AboutViewController

-(BOOL)devCreditsShown
{
	return devCreditsShown;
}

-(void)setDevCreditsShown:(BOOL)show
{
	if(show)
	{
		devCreditsTextView.hidden = NO;
		[developerCreditsButton setTitle:@"Hide Developer Credits" forState:UIControlStateNormal];
	}
	else
	{
		devCreditsTextView.hidden = YES;
		[developerCreditsButton setTitle:@"Show Developer Credits" forState:UIControlStateNormal];
	}
	
	devCreditsShown = show;
}

@synthesize developerCreditsButton;
@synthesize devCreditsTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
	{
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	devCreditsShown = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mainMenuButtonPressed:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)developerCreditsButtonPressed:(id)sender
{
	self.devCreditsShown = !self.devCreditsShown;
}
@end

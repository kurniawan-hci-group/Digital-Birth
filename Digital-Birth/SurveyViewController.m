//
//  SurveyViewController.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 12/23/13.
//
//

#import "SurveyViewController.h"

@interface SurveyViewController ()
{
	NSDictionary* surveyInfo;
}

- (IBAction)sendEmailButtonPressed:(id)sender;
- (IBAction)doSurveyNowButtonPressed:(id)sender;
- (IBAction)backToGame:(id)sender;
- (IBAction)okayButtonPressed:(id)sender;

@property IBOutlet UIWebView* webView;
@property (strong, nonatomic) IBOutlet UIButton *backToGameButton;
@property (strong, nonatomic) IBOutlet UIView *emailErrorView;

@end

@implementation SurveyViewController

@synthesize webView;
@synthesize backToGameButton;
@synthesize emailErrorView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
	{
		if(&UIApplicationWillEnterForegroundNotification != nil)
		{
			[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToGame:) name:UIApplicationWillEnterForegroundNotification object:nil];
		}
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	// Load survey info.
	NSString* surveyInfoPath = [[NSBundle mainBundle] pathForResource:@"Survey" ofType:@"plist"];
	surveyInfo = [NSDictionary dictionaryWithContentsOfFile:surveyInfoPath];
	if(surveyInfo)
		printf("Survey info loaded successfully.\n");
	else
		printf("Could not load survey info!\n");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendEmailButtonPressed:(id)sender
{
	if ([MFMailComposeViewController canSendMail])
	{
		MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
		controller.mailComposeDelegate = self;
		[controller setSubject:surveyInfo[@"emailSubject"]];
		NSString* emailBody = [NSString stringWithFormat:@"%@%@", surveyInfo[@"emailBody"], surveyInfo[@"surveyURL"]];
		[controller setMessageBody:emailBody isHTML:NO];
		if (controller)
			[self presentViewController:controller animated:YES completion:nil];
	}
	else
	{
		NSLog(@"We can't send mail for some reason");
		
		emailErrorView.hidden = NO;
	}
}

- (IBAction)doSurveyNowButtonPressed:(id)sender
{
//	webView.frame = self.view.bounds;
//	webView.scalesPageToFit = YES;
//	
//	[self.view addSubview:webView];
//	
//	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:surveyInfo[@"surveyURL"]]]];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:surveyInfo[@"surveyURL"]]];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
	if (result == MFMailComposeResultSent)
	{
		NSLog(@"Reminder email sent.");
	}
	else
	{
		NSLog(@"Reminder email NOT sent.");
	}
	
	[self dismissViewControllerAnimated:YES completion:^{
		backToGameButton.hidden = NO;
	} ];
}

-(IBAction)backToGame:(id)sender
{
	NSLog(@"Returning to game...");
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)okayButtonPressed:(id)sender
{
	emailErrorView.hidden = YES;
}

@end

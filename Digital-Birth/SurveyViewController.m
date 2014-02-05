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

@end

@implementation SurveyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
	} else {
		// Handle the error
	}
}

- (IBAction)doSurveyNowButtonPressed:(id)sender
{
	
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
	
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end

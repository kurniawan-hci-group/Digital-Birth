//
//  AboutViewController.m
//  Digital-Birth
//
//  Created by Sandy Achmiz on 2/4/14.
//
//

#import "AboutViewController.h"

@interface AboutViewController ()

- (IBAction)mainMenuButtonPressed:(id)sender;

@end

@implementation AboutViewController

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
@end

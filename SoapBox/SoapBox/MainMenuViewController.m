//
//  MainMenuViewController.m
//  SoapBox
//
//  Created by Jackson on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "MainMenuViewController.h"
#import "AddNewIssueViewController.h"
#import "SettingsViewController.h"
#import "AboutSoapViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController
@synthesize myIssues, friendsIssues, settings, about, logo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)openContainer {
    
    [self.masterContainer openContainer];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeContainer)];
    [self.view addGestureRecognizer:tap];
    
}

-(void)closeContainer {
    
    [self.masterContainer closeContainer];
    
}

-(void)showIssueController {
    
    AddNewIssueViewController *addIssue = [[AddNewIssueViewController alloc] init];
    UINavigationController *addIssueNav = [[UINavigationController alloc] initWithRootViewController:addIssue];
    
    [self presentViewController:addIssueNav animated:YES completion:^{
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  
  self.title = @"HELLO";
  
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(openContainer)];
  [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    NSFontAttributeName: [UIFont fontWithName:@"SecretCode" size:30.0f]}];
  
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(openContainer)];
  [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"AvenirNext-Regular" size:20.0], NSFontAttributeName,nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showIssueController)];
  [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"AvenirNext-Regular" size:30.0], NSFontAttributeName,nil] forState:UIControlStateNormal];
  
  // building title for the nav bar
  UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
  title.backgroundColor = [UIColor clearColor];
  title.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
  title.textAlignment = NSTextAlignmentCenter;
  title.textColor = [UIColor whiteColor];
  title.text = @"SoapBox";
  [title setFont:[UIFont fontWithName:@"SecretCode" size:13]];
  [self.navigationItem setTitleView:title];
  
  // Sets up the frames of the 4 buttons and the logo.
  // borders of buttons
  if( !IS_IPHONE_5 ){
    NSLog(@"Youre running an iPhone 4/4s");
    [myIssues setFrame:CGRectMake(0.0, DEVICEHEIGHT-200, DEVICEWIDTH/2, 100)];
    [friendsIssues setFrame:CGRectMake(DEVICEWIDTH/2, DEVICEHEIGHT-200, DEVICEWIDTH/2, 100)];
    [settings setFrame:CGRectMake(0.0, DEVICEHEIGHT-100, DEVICEWIDTH/2, 100)];
    [about setFrame:CGRectMake(DEVICEWIDTH/2, DEVICEHEIGHT-100, DEVICEWIDTH/2, 100)];
  }
  [myIssues.layer setBorderWidth:1], [myIssues.layer setBorderColor:[UIColor blackColor].CGColor];
  [friendsIssues.layer setBorderWidth:1], [friendsIssues.layer setBorderColor:[UIColor blackColor].CGColor];
  [settings.layer setBorderWidth:1], [settings.layer setBorderColor:[UIColor blackColor].CGColor];
  [about.layer setBorderWidth:1], [about.layer setBorderColor:[UIColor blackColor].CGColor];
  
  // logo shit
  [logo.layer setCornerRadius:20];
  [logo.layer setBorderWidth:1];
  [logo.layer setBorderColor:[UIColor darkGrayColor].CGColor];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)myIssues:(id)sender {
    IssueListViewController *issueController = [[IssueListViewController alloc] initWithNibName:@"IssueListViewController" bundle:[NSBundle mainBundle]];
    issueController.title = @"My Issues";
    [self.navigationController pushViewController:issueController animated:YES];
}
- (IBAction)friendsIssues:(id)sender {
    IssueListViewController *issueController = [[IssueListViewController alloc] initWithNibName:@"IssueListViewController" bundle:[NSBundle mainBundle]];
    Issue *issue = [[Issue alloc] init];
    issue.title = @"Test Issue";
    issue.description = @"This is a test description for the issue. I think it is long enough beginning.. right.. now!!";
    issueController.issues = @[issue];
    issueController.title = @"Friend's Issues";
    [self.navigationController pushViewController:issueController animated:YES];

}
- (IBAction)about:(id)sender {
    NSLog(@"\n\n\nWHYYYY\n\n");
    AboutSoapViewController *aVC = [[AboutSoapViewController alloc] init];
    [self.navigationController pushViewController:aVC animated:YES];
}
- (IBAction)settings:(id)sender {
    SettingsViewController *sVC = [[SettingsViewController alloc] init];
    [self.navigationController pushViewController:sVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  
//    [self.view setHidden:NO];
    if (self.masterContainer.containerIsOpen) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}
- (void) viewWillDisappear:(BOOL)animated{
  self.title = @"";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.title = @"SoapBox";

}


@end

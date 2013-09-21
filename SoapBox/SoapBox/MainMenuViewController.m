//
//  MainMenuViewController.m
//  SoapBox
//
//  Created by Jackson on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "MainMenuViewController.h"
#import "AddNewIssueViewController.h"

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
  
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Drop" style:UIBarButtonItemStylePlain target:self action:@selector(openContainer)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showIssueController)];
  
  // building title for the nav bar
  UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
  title.backgroundColor = [UIColor clearColor];
  title.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
  title.textAlignment = NSTextAlignmentCenter;
  title.textColor = [UIColor whiteColor];
  title.text = @"SoapBox";
  [title setFont:[UIFont fontWithName:@"SecretCode" size:13]];
  [self.navigationItem setTitleView:title];
  self.title = @"SOAPBOX BLAH BLAH";
  
  // Sets up the frames of the 4 buttons and the logo.
  // borders of buttons
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
  
}
- (IBAction)settings:(id)sender {
  
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
//  [self.view setHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


@end

//
//  MainMenuViewController.m
//  SoapBox
//
//  Created by Jackson on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "MainMenuViewController.h"
#import "AddIssueViewController.h"

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
    
    AddIssueViewController *addIssue = [[AddIssueViewController alloc] init];
    UINavigationController *addIssueNav = [[UINavigationController alloc] initWithRootViewController:addIssue];
    
    [self presentViewController:addIssueNav animated:YES completion:^{
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Drop" style:UIBarButtonItemStylePlain target:self action:@selector(openContainer)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(showIssueController)];
  
  // Sets up the frames of the 4 buttons and the logo.
  // borders of buttons
  [myIssues.layer setBorderWidth:1], [myIssues.layer setBorderColor:[UIColor blackColor].CGColor];
  [friendsIssues.layer setBorderWidth:1], [friendsIssues.layer setBorderColor:[UIColor blackColor].CGColor];
  [settings.layer setBorderWidth:1], [settings.layer setBorderColor:[UIColor blackColor].CGColor];
  [about.layer setBorderWidth:1], [about.layer setBorderColor:[UIColor blackColor].CGColor];
  
  // logo shit
  [logo.layer setCornerRadius:20];
  [logo.layer setBorderWidth:1];
  [logo.layer setBorderColor:[UIColor blackColor].CGColor];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)myIssues:(id)sender {
  
}
- (IBAction)friendsIssues:(id)sender {
  
}
- (IBAction)about:(id)sender {
  
}
- (IBAction)settings:(id)sender {
  
}


@end

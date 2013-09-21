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
@synthesize myIssues, friendsIssues, about, settings, logo;

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
<<<<<<< HEAD
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Hi" style:UIBarButtonItemStylePlain target:self action:@selector(openContainer)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(showIssueController)];
    
    // Sets up the frames of the 4 buttons and the logo.
    [myIssues setFrame:CGRectMake(5, [self view].frame.size.height/2, ([self view].frame.size.width/2)-10, ([self view].frame.size.height/4)-10)];
    [friendsIssues setFrame:CGRectMake(([self view].frame.size.width/2)+5, [self view].frame.size.height/2, ([self view].frame.size.width/2)-10, ([self view].frame.size.height/4)-10)];
    [settings setFrame:CGRectMake(5, [self view].frame.size.height*3/4, ([self view].frame.size.width/2)-10, ([self view].frame.size.height/4)-10)];
    [about setFrame:CGRectMake([self view].frame.size.width/2, [self view].frame.size.height*3/4, ([self view].frame.size.width/2)-10, ([self view].frame.size.height/4)-10)];
    [logo setFrame:CGRectMake([self view].frame.size.width/2, [self view].frame.size.height/3, 2*[self view].frame.size.width/3, [self view].frame.size.height/4)];
    
    [myIssues.layer setBorderWidth:1];
    [friendsIssues.layer setBorderWidth:1];
    [settings.layer setBorderWidth:1];
    [about.layer setBorderWidth:1];
    
    [myIssues.layer setBorderColor:[UIColor colorWithRed:192 green:192 blue:192 alpha:1].CGColor];
    [friendsIssues.layer setBorderColor:[UIColor colorWithRed:192 green:192 blue:192 alpha:1].CGColor];
    [settings.layer setBorderColor:[UIColor colorWithRed:192 green:192 blue:192 alpha:1].CGColor];
    [about.layer setBorderColor:[UIColor colorWithRed:192 green:192 blue:192 alpha:1].CGColor];
=======

  
  // Sets up the frames of the 4 buttons and the logo.
  [myIssues setFrame:CGRectMake(5, [self view].frame.size.height/2, ([self view].frame.size.width/2)-10, ([self view].frame.size.height/4)-10)];
  [friendsIssues setFrame:CGRectMake(([self view].frame.size.width/2)+5, [self view].frame.size.height/2, ([self view].frame.size.width/2)-10, ([self view].frame.size.height/4)-10)];
  [settings setFrame:CGRectMake(5, [self view].frame.size.height*3/4, ([self view].frame.size.width/2)-10, ([self view].frame.size.height/4)-10)];
  [about setFrame:CGRectMake([self view].frame.size.width/2, [self view].frame.size.height*3/4, ([self view].frame.size.width/2)-10, ([self view].frame.size.height/4)-10)];
  [logo setFrame:CGRectMake([self view].frame.size.width/2, [self view].frame.size.height/3, 2*[self view].frame.size.width/3, [self view].frame.size.height/4)];
  
  [myIssues.layer setBorderWidth:1];
  [friendsIssues.layer setBorderWidth:1];
  [settings.layer setBorderWidth:1];
  [about.layer setBorderWidth:1];

  [myIssues.layer setBorderColor:[UIColor colorWithRed:192 green:192 blue:192 alpha:1].CGColor];
  [friendsIssues.layer setBorderColor:[UIColor colorWithRed:192 green:192 blue:192 alpha:1].CGColor];
  [settings.layer setBorderColor:[UIColor colorWithRed:192 green:192 blue:192 alpha:1].CGColor];
  [about.layer setBorderColor:[UIColor colorWithRed:192 green:192 blue:192 alpha:1].CGColor];
  
  [logo setBackgroundColor:[UIColor blackColor]];
>>>>>>> 411c4ffccfdb56a00affb973e4a3a8fe1c036e99
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

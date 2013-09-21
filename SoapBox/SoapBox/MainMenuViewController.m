//
//  MainMenuViewController.m
//  SoapBox
//
//  Created by Jackson on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "MainMenuViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

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
	// Do any additional setup after loading the view.

  
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

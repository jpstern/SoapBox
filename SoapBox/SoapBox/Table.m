//
//  Table.m
//  SoapBox
//
//  Created by Jackson on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "Table.h"

@interface Table () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation Table

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
  [myIssues setFrame:CGRectMake(0, [self view].frame.size.height/2, [self view].frame.size.width/2, [self view].frame.size.height/4)];
  [friendsIssues setFrame:CGRectMake([self view].frame.size.width/2, [self view].frame.size.height/2, [self view].frame.size.width/2, [self view].frame.size.height/4)];
  [settings setFrame:CGRectMake(0, [self view].frame.size.height*3/4, [self view].frame.size.width/2, [self view].frame.size.height/4)];
  [about setFrame:CGRectMake([self view].frame.size.width/2, [self view].frame.size.height*3/4, [self view].frame.size.width/2, [self view].frame.size.height/4)];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

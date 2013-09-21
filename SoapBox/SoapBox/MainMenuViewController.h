//
//  MainMenuViewController.h
//  SoapBox
//
//  Created by Jackson on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IssueListViewController.h"
#import "Issue.h"

@interface MainMenuViewController : UIViewController{
  IBOutlet UIButton *myIssues;
  IBOutlet UIButton *friendsIssues;
  IBOutlet UIButton *about;
  IBOutlet UIButton *settings;
    BOOL returnFromPush;
}


@property (nonatomic, strong) IBOutlet UIButton *myIssues;
@property (nonatomic, strong) IBOutlet UIButton *friendsIssues;
@property (nonatomic, strong) IBOutlet UIButton *about;
@property (nonatomic, strong) IBOutlet UIButton *settings;
@property (nonatomic, strong) IBOutlet UIImageView *logo;

- (IBAction)myIssues:(id)sender;
- (IBAction)friendsIssues:(id)sender;
- (IBAction)about:(id)sender;
- (IBAction)settings:(id)sender;


@end

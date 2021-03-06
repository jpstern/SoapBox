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
#import "Constant.h"

@interface MainMenuViewController : UIViewController

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

//
//  IssueListViewController.h
//  SoapBox
//
//  Created by Charley Hutchison on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Issue.h"
#import "IssueViewController.h"

@interface IssueListViewController : UITableViewController

@property (nonatomic, strong) NSArray *issues;

@end

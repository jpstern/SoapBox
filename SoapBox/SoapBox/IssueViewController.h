//
//  IssueViewController.h
//  SoapBox
//
//  Created by Charley Hutchison on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Issue.h"
#import <MapKit/MapKit.h>

@interface IssueViewController : UIViewController

@property (nonatomic, strong) Issue *issue;
@property (weak, nonatomic) IBOutlet UILabel *issueTitle;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *description;
@property (weak, nonatomic) IBOutlet UIImageView *mapImage;

@end

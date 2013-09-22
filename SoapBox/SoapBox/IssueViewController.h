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
#import "AddEmailViewController.h"
#import <Social/Social.h>

@interface IssueViewController : UIViewController <AddEmailDelegate>

@property (nonatomic, strong) Issue *issue;
@property (weak, nonatomic) IBOutlet UILabel *issueTitle;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *description;
@property (weak, nonatomic) IBOutlet UIImageView *mapImage;
@property (weak, nonatomic) IBOutlet UIButton *tweeter;
@property (weak, nonatomic) IBOutlet UIButton *facebooker;
@property (weak, nonatomic) IBOutlet UIButton *email;

- (IBAction)tweet:(UIButton *)sender;
- (IBAction)fbook:(UIButton *)sender;
- (IBAction)addEmail:(UIButton *)sender;

@end

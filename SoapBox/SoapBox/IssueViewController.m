//
//  IssueViewController.m
//  SoapBox
//
//  Created by Charley Hutchison on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "IssueViewController.h"

@interface IssueViewController ()

@end

@implementation IssueViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    }

- (void)finishedWithEmail:(NSString *)email body:(NSString *)body{
    /*
    [self dismissViewControllerAnimated:YES completion:nil];
    NSArray *addresses = [email componentsSeparatedByString:@","];
    
    [PFCloud callFunctionInBackground:@"email" withParameters:@{@"address": [NSJSONSerialization dataWithJSONObject:addresses options:nil error:nil], @"subject": @"Hello World", @"text": body} block:^(id object, NSError *error) {
    NSLog(@"Body: %@, %@, %@", body, addresses, email);
    [PFCloud callFunctionInBackground:@"email" withParameters:@{@"to": addresses, @"subject": @"Hello World", @"message": body} block:^(id object, NSError *error) {
        NSLog(@"Object %@, Error, %@", object, error);
    }];
    }
     */
}

- (void)canceled {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addEmail:(UIButton *)sender {
    AddEmailViewController *emailController = [[AddEmailViewController alloc] initWithNibName:@"AddEmailViewController" bundle:nil];
    emailController.delegate = self;
    [self presentViewController:emailController animated:YES completion:^{
        NSLog(@"SHowing Email View");
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"View did load");
    self.issueTitle.text = self.issue.title;
    self.description.text = self.issue.description;
    self.image.image = self.issue.image;
    MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc] init];
    options.size = self.mapImage.frame.size;
    options.region = MKCoordinateRegionMake(self.issue.location, MKCoordinateSpanMake(0.001, 0.001));
    MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc] initWithOptions:options];
    [snapshotter startWithCompletionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
        NSLog(@"Snapshot finished");
        self.mapImage.image = snapshot.image;
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

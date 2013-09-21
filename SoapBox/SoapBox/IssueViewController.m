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

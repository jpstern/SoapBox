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

@synthesize tweeter, facebooker, email, mapImage, image;

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

- (IBAction)tweet:(UIButton *)sender{
  if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
  {
    SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    NSString *tweet = [NSString stringWithFormat:@"%@ - %@... #SoapBox", self.issueTitle.text, self.description.text];
    [tweetSheet setInitialText:tweet];
    [self presentViewController:tweetSheet animated:YES completion:nil];
  }
  else {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Sorry"
                              message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup."
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];
  }
}

- (IBAction)fbook:(UIButton *)sender{
  if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
//    var parameters = new NSDictionary ();
//    var request = SLRequest.Create (SLServiceKind.Facebook, SLRequestMethod.Get, new NSUrl ("https://graph.facebook.com/283148898401104"), parameters);
//    request.PerformRequest ((data, response, error) => {
//      if (response.StatusCode == 200) {
//        InvokeOnMainThread (() => {
//          resultsTextView.Text = data.ToString ();
//        });
//      } else {
//        InvokeOnMainThread (() => {
//          resultsTextView.Text = "Error: " + response.StatusCode.ToString ();
//        });
//      }
//    });
  }
  else {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Sorry"
                              message:@"You can't post to Facebook right now, make sure your device has an internet connection and you have at least one Facebook account setup."
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];
  }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"View did load");
    self.issueTitle.text = self.issue.title;
    self.description.text = self.issue.description;
    image.image = self.issue.image;
    MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc] init];
    options.size = self.mapImage.frame.size;
    options.region = MKCoordinateRegionMake(self.issue.location, MKCoordinateSpanMake(0.001, 0.001));
    MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc] initWithOptions:options];
    [snapshotter startWithCompletionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
        NSLog(@"Snapshot finished");
        mapImage.image = snapshot.image;
    }];
    // Do any additional setup after loading the view from its nib.
  [mapImage setBackgroundColor:[UIColor clearColor]];
  [mapImage.layer setMasksToBounds:YES];
  [mapImage.layer setBorderWidth:3];
  [mapImage.layer setBorderColor:[UIColor whiteColor].CGColor];
  [mapImage.layer setCornerRadius:15];
  
  [image setBackgroundColor:[UIColor clearColor]];
  [image.layer setMasksToBounds:YES];
  [image.layer setBorderWidth:3];
  [image.layer setBorderColor:[UIColor whiteColor].CGColor];
  [image.layer setCornerRadius:15];
  
  [tweeter.layer setBorderWidth:3];
  [tweeter.layer setBorderColor:[UIColor whiteColor].CGColor];
  [tweeter.layer setCornerRadius:10];
  [tweeter setBackgroundColor:[UIColor colorWithRed:0 green:205.0/255 blue:250.0/255 alpha:1]];
  
  [facebooker.layer setBorderWidth:3];
  [facebooker.layer setBorderColor:[UIColor whiteColor].CGColor];
  [facebooker.layer setCornerRadius:10];
  [facebooker setBackgroundColor:[UIColor colorWithRed:0 green:85.0/255 blue:153.0/255 alpha:1]];
  
  [email.layer setBorderWidth:3];
  [email.layer setBorderColor:[UIColor whiteColor].CGColor];
  [email.layer setCornerRadius:10];
  [email setBackgroundColor:[UIColor colorWithRed:6.0/255 green:21.0/255 blue:130.0/255 alpha:1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  AboutSoapViewController.m
//  SoapBox
//
//  Created by Gregoire on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "AboutSoapViewController.h"

@interface AboutSoapViewController ()

@end

@implementation AboutSoapViewController

@synthesize label, aboutText;

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
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:NO];
    [self.view setBackgroundColor:GRAY2];
    [aboutText setBackgroundColor:GRAY1];
    [aboutText setTextColor:[UIColor whiteColor]];
    [aboutText setText:@"Long ago when people wanted to be heard, they would stand on a SoapBox and holler. We believe our SoapBox gives the modern user a step up when it comes to being heard and hearing others. We aggregate data about issues taking into account proximity, friends, whats trending, and advanced machine learning to let our user know whats important."];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

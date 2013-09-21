//
//  ViewController.m
//  SoapBox
//
//  Created by Josh Stern on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

/*
 
 - (void)logoutButtonTouchHandler:(id)sender  {
 [PFUser logOut]; // Log out
 
 // Return to login page
 [self.navigationController popToRootViewControllerAnimated:YES];
 }
 
 */

- (IBAction)login:(id)sender  {
    // The permissions requested from the user
    // look below for more
    /* https://developers.facebook.com/docs/reference/login/#permissions */
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        //[_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
           
            //push it real good
            
        } else {
            NSLog(@"User with facebook logged in!");
            
            
            //puch it real good
            
            NSLog(@"made it here");
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

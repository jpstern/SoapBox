//
//  ViewController.m
//  SoapBox
//
//  Created by Josh Stern on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "ViewController.h"
#import "MapViewController.h"

@interface ViewController ()

@end



@implementation ViewController

@synthesize loginBtn, titleLabel, soapBoxPic;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.view setBackgroundColor:GRAY1];
    
    titleLabel = [[UILabel alloc] init];
    [self.titleLabel setFrame:CGRectMake(0, 40, 320, 100)];
    [self.titleLabel setText:@"SoapBox"];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.titleLabel setFont:[UIFont fontWithName:@"AvenirNextCondensed-Regular" size:50]];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setFrame:CGRectMake(50, 360, 220, 60)];
    [self.loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn setTitle:@"Login with Facebook" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn.layer setCornerRadius:30];
    [self.loginBtn setBackgroundColor:GRAY2];
    [self.loginBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.loginBtn.layer setBorderWidth:3];
    
    soapBoxPic = [[UIImageView alloc] initWithFrame:CGRectMake(80, 160, 160, 160)];
    soapBoxPic.image = [UIImage imageNamed:@"soapbox.png"];
    
    
    [self.view addSubview:loginBtn];
    [self.view addSubview:titleLabel];
    [self.view addSubview:soapBoxPic];
    
    if ([PFUser currentUser] && // Check if a user is cached
        [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) // Check if user is linked to Facebook
    {
        NSLog(@"DOUBLE CHECKS");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}



- (void)login:(id)sender  {
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
        } else { //user
            [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    
                    
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
                    [formatter setNumberStyle:NSNumberFormatterNoStyle];
                    NSNumber *fbIdNumber = [formatter numberFromString:[result objectForKey:@"id"]];
                    [[PFUser currentUser] setObject:[result objectForKey:@"id"] forKey:@"fbIdString"];
                    [[PFUser currentUser] setObject:fbIdNumber forKey:@"facebookID"];
        
                    [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if(succeeded){
                            NSLog(@"successful save!!");
                        }
                        else{
                            NSLog(@"%@", [error localizedDescription]);
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                            message:@"Something went wrong"
                                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                        }
                    }];
                    
                }
            }];
        }
        
        if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
           
            //push it real good
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!"
                                                            message:@"Touch \"SoapBox\" to begin..."
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [self dismissViewControllerAnimated:YES  completion:nil];
            
        } else {
            NSLog(@"User with facebook logged in!");
            
            
            //puch it real good
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!"
                                                            message:@"Touch \"SoapBox\" to begin..."
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [self dismissViewControllerAnimated:YES  completion:nil];
            
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

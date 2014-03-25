//
//  ViewController.m
//  SoapBox
//
//  Created by Josh Stern on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "ViewController.h"
#import "MapViewController.h"
#import "MBProgressHUD.h"

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
    [self.navigationController setNavigationBarHidden:YES];
    
    titleLabel = [[UILabel alloc] init];
    [self.titleLabel setFrame:CGRectMake(0, 40, 320, 100)];
    [self.titleLabel setText:@"SoapBox"];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.titleLabel setFont:[UIFont fontWithName:@"AvenirNextCondensed-Regular" size:50]];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setFrame:CGRectMake(50, DEVICEHEIGHT*4/5, 220, 60)];
    [self.loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn setTitle:@"Login with Facebook" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn.layer setCornerRadius:25];
    [self.loginBtn setBackgroundColor:GRAY2];
    [self.loginBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.loginBtn.layer setBorderWidth:3];
    
    soapBoxPic = [[UIImageView alloc] initWithFrame:CGRectMake(60, DEVICEHEIGHT/2-100, 200, 200)];
    soapBoxPic.image = [UIImage imageNamed:@"soapbox.png"];
    
    
    [self.view addSubview:loginBtn];
    [self.view addSubview:titleLabel];
    [self.view addSubview:soapBoxPic];
    
    if ([PFUser currentUser] && // Check if a user is cached
        [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) // Check if user is linked to Facebook
    {
        NSLog(@"DOUBLE CHECKS");
        [self.navigationController pushViewController:[[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil] animated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)login:(id)sender  {
    // The permissions requested from the user
    // look below for more
    /* https://developers.facebook.com/docs/reference/login/#permissions */
    NSArray *permissionsArray = @[ @"user_relationships", @"user_location"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else { //user
            
            if (user.isNew) {
                NSLog(@"User with facebook signed up and logged in!");
                
                [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                    if (!error) {
                        
                        NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
                        [formatter setNumberStyle:NSNumberFormatterNoStyle];
                        NSNumber *fbIdNumber = [formatter numberFromString:[result objectForKey:@"id"]];
                        [[PFUser currentUser] setObject:[result objectForKey:@"id"] forKey:@"fbIdString"];
                        [[PFUser currentUser] setObject:fbIdNumber forKey:@"facebookID"];
                        
                        if(user.isNew){
                            [[PFUser currentUser] setObject:[NSArray array] forKey:@"agreesWith"];
                        }
                        
                        [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            if(succeeded){
                                NSLog(@"\n\n\nsuccessful save!!\n\n\n");
                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                //push it real good
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!"
                                                                                message:@"Touch \"SoapBox\" to begin..."
                                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                [alert show];
                                [self.navigationController pushViewController:[[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil] animated:YES];
                                
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
                    else{//error
                        NSLog(@"\n\n%@\n\n", [error localizedDescription]);
                    }
                }];
                
                
            }
            else {
                NSLog(@"User with facebook logged in!");
                
                
                //puch it real good
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!"
                                                                message:@"Touch \"SoapBox\" to begin..."
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [self.navigationController pushViewController:[[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil] animated:YES];
                
                NSLog(@"made it here");
            }
            
        }
    }];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

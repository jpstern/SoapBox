//
//  MapViewController.m
//  SoapBox
//
//  Created by Gregoire on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "MapViewController.h"
#import "ViewController.h"
#include "IssueAnnotation.h"
#include "CustomCell.h"
#import "AnimatedOverlay.h"


@interface MapViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation MapViewController

@synthesize mapView = _mapView;
@synthesize currentDist;
@synthesize filters, filterMeTimbers, filterSheet, filterView;
@synthesize issueList, data, fbData, issueView;
@synthesize refreshView, menuView;
@synthesize fbFriendsWithApp;

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
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Do any additional setup after loading the view from its nib.

    if (!([PFUser currentUser] && // Check if a user is cached
          [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]])) // Check if user is linked to Facebook
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    
    }
    
    [self refresh];
    
    if (!FBSession.activeSession.isOpen) {
        // if the session is closed, then we open it here, and establish a handler for state changes
        [FBSession openActiveSessionWithReadPermissions:nil
                                           allowLoginUI:YES
                                      completionHandler:^(FBSession *session,
                                                          FBSessionState state,
                                                          NSError *error) {
                                          if (error) {
                                              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:error.localizedDescription
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                              [alertView show];
                                          } else if (session.isOpen) {
                                              //run your user info request here
                                              NSLog(@"\n\nSESSION IS OPEN\n\n");
                                              //get the FB DATA

                                          }
                                    }];
    }
    
    [self fbDataLoader];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBarTintColor:GRAY2];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    //[self.navigationController.navigationBar.layer setBorderWidth:6.0];// Just to make sure its working
    //[self.navigationController.navigationBar.layer setBorderColor:GRAY1.CGColor];
    
    // left bar button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(menuTouched)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:20.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    //right bar button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showIssueController)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:30.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    // building title for the nav bar
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200, 50)];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.text = @"SoapBox";
    [title setFont:[UIFont fontWithName:@"AvenirNextCondensed-Regular" size:25]];
    [self.navigationItem setTitleView:title];

    
    
    //init the views
    filters = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    [filters setBackgroundColor:GRAY2];
    filters.tag = 1;
    
    filterSheet = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    filterSheet.backgroundColor = GRAY1;
    filterSheet.alpha = 0.7;
    filterSheet.tag = 1;
    
    filterView = [[FilterView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    issueView = [[IssueView alloc] initWithFrame:CGRectMake(0, 0, 320, DEVICEHEIGHT-60)];
    refreshView = [[RefreshView alloc] initWithFrame:CGRectMake(0, 105, 320, 45)];
    menuView = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, 320, DEVICEHEIGHT-60)];
    
    [menuView.logout addTarget:self action:@selector(logoutHandler) forControlEvents:UIControlEventTouchUpInside];
    menuView.tag = 0;
    
    [refreshView.no addTarget:self action:@selector(refreshResponderNo) forControlEvents:UIControlEventTouchUpInside];
    [refreshView.yes addTarget:self action:@selector(refreshResponderYes) forControlEvents:UIControlEventTouchUpInside];
    
    [filterView.sortingControl addTarget:self action:@selector(changeMadeToFilterView) forControlEvents:UIControlEventValueChanged];
    [filterView.fbSwitch addTarget:self action:@selector(changeMadeToFilterView) forControlEvents:UIControlEventTouchUpInside];
    
    //issue view buttons
    issueView.delegate = self;
    [issueView.backToList addTarget:self action:@selector(tableTopper) forControlEvents:UIControlEventTouchUpInside];
    [issueView.twitter addTarget:self action:@selector(twitterPost) forControlEvents:UIControlEventTouchUpInside];
    [issueView.facebook addTarget:self action:@selector(fbPost) forControlEvents:UIControlEventTouchUpInside];
    [issueView.email addTarget:self action:@selector(sendEmail) forControlEvents:UIControlEventTouchUpInside];
    [issueView.more addTarget:self action:@selector(moreBtnTouched) forControlEvents:UIControlEventTouchUpInside];
    [issueView.backToMap addTarget:self action:@selector(mapBtnTouched) forControlEvents:UIControlEventTouchUpInside];
    [issueView.agree addTarget:self action:@selector(agree) forControlEvents:UIControlEventTouchUpInside];
    
    filterMeTimbers = [UIButton buttonWithType:UIButtonTypeCustom];
    [filterMeTimbers setFrame:CGRectMake(60, 0, 200, 50)];
    [filterMeTimbers addTarget:self action:@selector(bringEmOut) forControlEvents:UIControlEventTouchUpInside];
    [filterMeTimbers setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:filterSheet];
    [self.view addSubview:filters];
    
    [self.navigationController.navigationBar addSubview:filterMeTimbers];
    
    
    issueList = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 320, DEVICEHEIGHT-160) style:UITableViewStylePlain];
    [issueList setBackgroundColor:[UIColor clearColor]];
    [issueList setDelegate:self];
    [issueList setDataSource:self];
    
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [[LocationGetter sharedInstance] locationManager].location.coordinate.latitude;
    zoomLocation.longitude = [[LocationGetter sharedInstance] locationManager].location.coordinate.longitude;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 5*METERS_PER_MILE,5*METERS_PER_MILE);
    
    [_mapView setRegion:viewRegion animated:YES];
    
}

-(void)fbDataLoader{
    
    NSString *query = @"SELECT uid, name, pic_square, mutual_friend_count, is_app_user FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) AND is_app_user ORDER BY mutual_friend_count";
    NSDictionary *queryParam = @{ @"q": query };
    [FBRequestConnection startWithGraphPath:@"/fql" parameters:queryParam HTTPMethod:@"GET" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        
        if (!error) {
            // result will contain an array with your user's friends in the "data" key
            NSLog(@"\n\nSuccesful FB Data save\n\n");
            
            fbData = [result objectForKey:@"data"];
            NSMutableArray *friendIds = [NSMutableArray arrayWithCapacity:fbData.count];
            // Create a list of friends' Facebook IDs
            
            for (NSDictionary *friendObject in fbData) {
                [friendIds addObject:[friendObject objectForKey:@"uid"]];
            }
            fbFriendsWithApp = [friendIds copy];
        }
        else if([error.userInfo[FBErrorParsedJSONResponseKey][@"body"][@"error"][@"type"] isEqualToString:@"OAuthException"]){
            NSLog(@"The facebook session was invalidated %@", error.description);
            [self logout];
        }
        else{
            NSLog(@"Some other error: %@", error);
        }
        
    }];
}

-(void)logoutHandler{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are you sure"
                                                    message:@"you want to logout?"
                                                   delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
    
}

-(void)logout{
    [PFUser logOut];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/********************************************** ALERT VIEW DELEGATE ************************************************************ */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"YES"])
    {
        [self logout];
    }
    else if([title isEqualToString:@"NO"])
    {
        return;
    }
    
}


/********************************************** ANIMATIONS ************************************************************ */


-(void)mapBtnTouched{
    
    [self positionMapAtCenter:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    filters.tag = 1;
    [issueView showMore:NO];
    [UIView animateWithDuration:0.4
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [filterSheet setFrame:CGRectMake(0, 0, 320, 0)];
                         [issueView removeFromSuperview];
                         [filters setFrame:CGRectMake(0, 0, 320, 0)];
                         
                     }
                     completion:^(BOOL finished) {
                         //add comments section
                         [issueView resetShareButtons];
                     }];
    
}

-(void)moreBtnTouched{
    
    
    if (issueView.more.tag == 1) {
        issueView.more.tag = 0;
        [UIView animateWithDuration:0.4
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [filterSheet setFrame:CGRectMake(0, 0, 320, DEVICEHEIGHT)];
                             [issueView.more setTitle:@"less ^" forState:UIControlStateNormal];
                             [issueView setFrame:CGRectMake(0, 20, 320, DEVICEHEIGHT-20)];
                             [issueView.more setFrame:CGRectMake(0, DEVICEHEIGHT-40, 320, 20)];
                             [issueView.description setFont:[UIFont fontWithName:@"AvenirNextCondensed-Regular" size:24]];
                             [issueView.description setFrame:CGRectMake(10, 120, 310, 160)];
                         }
                         completion:^(BOOL finished) {
                             [issueView showMore:YES];
                         }];
    }
    else if(issueView.more.tag == 0){
        issueView.more.tag = 1;
        [issueView showMore:NO];
        [UIView animateWithDuration:0.4
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [issueView.more setTitle:@"more v" forState:UIControlStateNormal];
                             [filterSheet setFrame:CGRectMake(0, 0, 320, 230)];
                             [issueView setFrame:CGRectMake(0, 20, 320, 230)];
                             [issueView.more setFrame:CGRectMake(0, 210, 320, 20)];
                             [issueView.description setFont:[UIFont fontWithName:@"AvenirNextCondensed-Regular" size:14]];
                             [issueView.description setFrame:CGRectMake(10, 120, 310, 80)];
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    }
    
}

-(void)menuTouched{
    
    
    if(menuView.tag == 0){
        menuView.tag = 1;
        filters.tag = 3;
        [menuView setAlpha:0];
        [self.view addSubview:menuView];
        [UIView animateWithDuration:0.4f
                              delay:0.0f
                            options: UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [menuView setAlpha:1];
                         }
                         completion:nil];
        
    }
    else if(menuView.tag == 1) {
        menuView.tag = 0;
        if(issueList.tag != 1){
            filters.tag = 0;
        }
        else{
            filters.tag = 1;
        }
        [UIView animateWithDuration:0.4f
                              delay:0.0f
                            options: UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [menuView setAlpha:0];
                             
                         }
                         completion:^(BOOL finished) {
                             [menuView removeFromSuperview];
                         }];
    }
    
    
}


-(void) tableTopper{
    if(issueList.tag == 0){
        
        [self removeAnimatedOverlay];
        
        [self positionMapAtCenter:NO];
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
        issueList.tag = 1;
        filters.tag = 3;
        if([self.view.subviews containsObject:refreshView]){
            [refreshView removeFromSuperview];
            [UIView animateWithDuration:0.2f
                                  delay:0.0f
                                options: UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                                 [issueList setFrame:CGRectMake(0, 100, 320, DEVICEHEIGHT-160)];
                             }
                             completion:nil];
        }
        
        
        //HERE!!!!!
        [issueView.more setTitle:@"more v" forState:UIControlStateNormal];
        [issueView.more setFrame:CGRectMake(0, 210, 320, 20)];
        issueView.more.tag = 1;
        [filterSheet setAlpha:0.7];
        [filterView removeFromSuperview];
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options: UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [issueList setAlpha:0];
                             [filters setFrame:CGRectMake(0, 0, 320, 60)];
                             [filterSheet setFrame:CGRectMake(0, 0, 320, 230)];
                             [filterView setAlpha:0];
                         }
                         completion:^(BOOL finished) {
                             [filterView removeFromSuperview];
                             [issueList removeFromSuperview];
                             [issueView setAlpha:0];
                             [issueView setFrame:CGRectMake(0, 20, 320, 230)];
                             [self.view addSubview:issueView];
                             [UIView animateWithDuration:0.4f
                                                   delay:0.0f
                                                 options: UIViewAnimationOptionBeginFromCurrentState
                                              animations:^{
                                                  [issueView setAlpha:1];
                                                  [issueView animateShareButtons];
                                              }
                                              completion:^(BOOL finished) {
                                                  //[self addAnimatedOverlayToIssueAnnotationWithCircle:animatedOverlay.circle];
                                              }];
                         }];
        
    }
    else if(issueList.tag == 1) {
        
        [self positionMapAtCenter:YES];
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        issueList.tag = 0;
        filters.tag = 0;
        [issueView resetShareButtons];
        [issueView showMore:NO];
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options: UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [issueView setAlpha:0];
                             [filters setFrame:CGRectMake(0, 0, 320, 100)];
                             [filterSheet setFrame:CGRectMake(0, 0, 320, DEVICEHEIGHT-60)];
                         }
                         completion:^(BOOL finished) {
                             [issueView resetShareButtons];
                             [issueView removeFromSuperview];
                             
                             if([filterView filterValuesDifferent]){
                                 [refreshView setAlpha:0];
                                 [self.view addSubview:refreshView];
                                 [issueList setFrame:CGRectMake(0, 150, 320, DEVICEHEIGHT-160)];
                             }
                             else{
                                 [issueList setFrame:CGRectMake(0, 100, 320, DEVICEHEIGHT-160)];
                             }
                             [issueList setAlpha:0];
                             [self.view addSubview:issueList];
                             [filterView setAlpha:0];
                             [self.view addSubview:filterView];
                             [UIView animateWithDuration:0.3f
                                                   delay:0.0f
                                                 options: UIViewAnimationOptionBeginFromCurrentState
                                              animations:^{
                                                  [issueList setAlpha:1];
                                                  [filterView setAlpha:1];
                                                  if([filterView filterValuesDifferent]){
                                                      [refreshView setAlpha:1];
                                                  }
                                              }
                                              completion:nil];
                         }];
    }
}


-(void)whipItOut{
    
    if(filterSheet.tag == 0){
        filterSheet.tag = 1;
        
        [UIView animateWithDuration:0.4f
                              delay:0.0f
                            options: UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [filterSheet setFrame:CGRectMake(0.0f, 0.0f, 320.0f, 0.0f)];
                             [filterSheet setAlpha:0.0];
                         }
                         completion:nil];
        
    }
    else if(filterSheet.tag == 1) {
        filterSheet.tag = 0;
        [UIView animateWithDuration:0.6f
                              delay:0.0f
                            options: UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [filterSheet setFrame:CGRectMake(0.0f, 0.0f, 320.0f, DEVICEHEIGHT-60)];
                             [filterSheet setAlpha:0.7];
                             
                         }
                         completion:nil];
    }
    
}

static NSDate *lastFired;

-(void)bringEmOut{
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    if([date timeIntervalSinceDate:lastFired] <= 0.6){
        return;
    }
    
    lastFired = [NSDate dateWithTimeIntervalSinceNow:0];
    
    if(filters.tag == 0){
        filters.tag = 1;
        
        [UIView animateWithDuration:0.2f
                              delay:0.0f
                            options: UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             filterSheet.tag =0;
                             [self whipItOut];
                             [filterView removeFromSuperview];
                             [filters setFrame:CGRectMake(0.0f, 00.0f, 320.0f, 00.0f)];
                             [issueList setAlpha:0];
                             [issueList removeFromSuperview];
                             if ([self.view.subviews containsObject:refreshView]) {
                                 [refreshView removeFromSuperview];
                             }
                         }
                         completion:nil];
        if([filterView chagesMade]){
            NSLog(@"\n\nCHANGES MADE\n\n");
            [self refresh];
        }
        
    }
    else if(filters.tag == 1) {
        filters.tag = 0;
        filterView.changed = false;
        [filterView setVals];
        [UIView animateWithDuration:0.25f
                              delay:0.0f
                            options: UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             [filters setFrame:CGRectMake(0.0f, 0.0f, 320.0f, 100.0f)];
                             filterSheet.tag = 1;
                             [self whipItOut];
                         }
                         completion:^(BOOL finished) {
                             [filterView setAlpha:0];
                             [self.view addSubview:filterView];
                             [issueList setAlpha:0];
                             [self.view addSubview:issueList];
                             [issueList setFrame:CGRectMake(0, 100, 320, DEVICEHEIGHT-160)];
                             [UIView animateWithDuration:0.4f
                                                   delay:0.0f
                                                 options: UIViewAnimationOptionAllowUserInteraction
                                              animations:^{
                                                  [filterView setAlpha:1];
                                                  [issueList setAlpha:1];
                                              }
                                              completion:^(BOOL finished) {
                                              }];
                         }];
        
    }
    
}


-(void)changeMadeToFilterView{
    
    if(![filterView filterValuesDifferent]){
        [self refreshResponderNo];
        return;
    }
    
    [issueList scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options: UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [issueList setFrame:CGRectMake(0, 150, 320, DEVICEHEIGHT-160)];
                         [refreshView setAlpha:1];
                     }
                     completion:^(BOOL finished) {
                         [refreshView setAlpha:0];
                         [self.view addSubview:refreshView];
                         [UIView animateWithDuration:0.3f
                                               delay:0.0f
                                             options: UIViewAnimationOptionBeginFromCurrentState
                                          animations:^{
                                              [refreshView setAlpha:1];
                                          }
                                          completion:nil];
                     }];
    
}

-(void)refreshResponderNo{
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options: UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [refreshView setAlpha:0];
                     }
                     completion:^(BOOL finished) {
                         [refreshView removeFromSuperview];
                         [UIView animateWithDuration:0.2f
                                               delay:0.0f
                                             options: UIViewAnimationOptionBeginFromCurrentState
                                          animations:^{
                                              [issueList setFrame:CGRectMake(0, 100, 320, DEVICEHEIGHT-160)];
                                              [filterView.fbSwitch setOn:filterView.fbSwitchIsOn animated:YES];
                                              [filterView.sortingControl setSelectedSegmentIndex:filterView.segmentVal];
                                          }
                                          completion:nil];
                     }];
}

-(void)refreshResponderYes{
    [self removeAnimatedOverlay];
    [self refresh];
    [filterView chagesMade];
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options: UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [refreshView setAlpha:0];
                         [issueList setAlpha:0];
                     }
                     completion:^(BOOL finished) {
                         [issueList removeFromSuperview];
                         [refreshView removeFromSuperview];
                         [UIView animateWithDuration:0.2f
                                               delay:0.0f
                                             options: UIViewAnimationOptionBeginFromCurrentState
                                          animations:^{
                                              [issueList setFrame:CGRectMake(0, 100, 320, DEVICEHEIGHT-160)];
                                              
                                          }
                                          completion:^(BOOL finished) {
                                              [issueList setAlpha:1];
                                              [self.view addSubview:issueList];
                                          }];
                     }];
    
}


-(void)showIssueController {
    
    AddNewIssueViewController *addIssue = [[AddNewIssueViewController alloc] init];
    addIssue.issueAddDelegate = self;
    UINavigationController *addIssueNav = [[UINavigationController alloc] initWithRootViewController:addIssue];
    [self presentViewController:addIssueNav animated:YES completion:nil];
}

-(void) addingNewIssue{
    [self refresh];
}

/********************************************** REFRESHERS ************************************************************ */


-(void) refreshMap{
    [self removeAllAnnotations];
    [self removeAnimatedOverlay];
    for(Issue *issue in self.data){
        IssueAnnotation *tmpAnnotation = [[IssueAnnotation alloc] initWithIssue:issue];
        
        //circles
        MKCircle *circle = [MKCircle circleWithCenterCoordinate:issue.location radius:RADIUS_SCALAR*[issue.metric doubleValue]];
        tmpAnnotation.circle = circle;
        tmpAnnotation.circle.title = [NSString stringWithFormat:@"%f", [issue.metric doubleValue]];
        [self.mapView addOverlay:tmpAnnotation.circle];
        [self.mapView addAnnotation:tmpAnnotation];
    }
}

-(void) refreshTableView{
    
    [self.issueList reloadData];
    [issueList scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    
}

static NSString *recentlyFlaggedId = @"nada";

-(void)refresh{
    NSLog(@"\n\nrefrehing\n\n");
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Do something...
        [self refreshBody];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
    
}




-(void)refreshBody{
    //throw in an animation
    
    CGFloat kilometers = currentDist/1000;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Issue"];
    [query setLimit:50];
    [query whereKey:@"flagged" equalTo:[NSNumber numberWithBool:FALSE]];
    [query whereKey:@"objectId" notEqualTo:recentlyFlaggedId];

    //for no flagged Id;
    
    if(filterView.fbSwitch.isOn){
        [query whereKey:@"userFacebookID" containedIn:fbFriendsWithApp];
    }
    
    if(filterView.sortingControl.selectedSegmentIndex == 2){
        [query orderByDescending:@"Alchemy"];
    }
    else if(filterView.sortingControl.selectedSegmentIndex == 1){
        [query orderByDescending:@"createdAt"];
    }
    else if (filterView.sortingControl.selectedSegmentIndex == 0){
        [query whereKey:@"Location"
           nearGeoPoint:[PFGeoPoint geoPointWithLatitude:[[LocationGetter sharedInstance] getLatitude]
                                               longitude:[[LocationGetter sharedInstance]getLongitude]]
       withinKilometers:kilometers];
    }
    NSMutableArray *array = [NSMutableArray array];
    
    NSArray *objects = [query findObjects];
    for (PFObject *object in objects) {
        
        Issue *tmpIssue = [[Issue alloc] initWithPFObject:object];
        [array addObject:tmpIssue];
    }
    self.data = array;
    [self refreshMap];
    [self refreshTableView];
    recentlyFlaggedId = @"nada";
}

/**********************************************MAP VIEW DELEGATE STUFF************************************************************ */


//animated overlay to be passed around... static instance
static AnimatedOverlay *animatedOverlay;

-(void)addAnimatedOverlayToIssueAnnotationWithCircle:(MKCircle *)circle{
    
    MKMapRect mapRect = [circle boundingMapRect];
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(mapRect);
    
    CGRect rect = [_mapView  convertRegion:region toRectToView:_mapView];
    
    if(!animatedOverlay){
        animatedOverlay = [[AnimatedOverlay alloc] initWithFrame:rect];
    }
    else{
        [animatedOverlay setFrame:rect];
    }
    animatedOverlay.circle = circle;
    [_mapView addSubview:animatedOverlay];
    [animatedOverlay startAnimating];
}

-(void)removeAnimatedOverlay{
    if(animatedOverlay){
        [animatedOverlay stopAnimating];
        [animatedOverlay removeFromSuperview];
    }
}


-(void) selectAnotation{
    
    [self removeAnimatedOverlay];
    
    for(NSObject <MKAnnotation> *n in _mapView.annotations){
        //NSLog(@"issue parse id is %@ vs %@",issueView.issue.parseId , ((IssueAnnotation *)n).issue.parseId);
        if([issueView.issue.parseId isEqualToString:((IssueAnnotation *)n).issue.parseId]){
            
            if([_mapView.selectedAnnotations containsObject:n] ){
                [_mapView deselectAnnotation:n animated:NO];
            }
            [_mapView selectAnnotation:n animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^
                           {
                               
                           });
        }
    }
}

-(void)positionMapAtCenter:(BOOL)center{
    
    CLLocationCoordinate2D track = issueView.issue.location;
    if(!center){
        track.latitude += _mapView.region.span.latitudeDelta*0.213;
    }
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(track, currentDist,currentDist);
    
    [self.mapView setRegion:region animated:TRUE];
    [self.mapView regionThatFits:region];
    
}


-(void) viewWillAppear:(BOOL)animated{
    
    [[LocationGetter sharedInstance] startUpdates];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [[LocationGetter sharedInstance] locationManager].location.coordinate.latitude;
    zoomLocation.longitude = [[LocationGetter sharedInstance] locationManager].location.coordinate.longitude;
    
    NSLog(@"Longitude and latitude are %f and %f", zoomLocation.latitude, zoomLocation.longitude);
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, currentDist,currentDist);
    
    [_mapView setRegion:viewRegion animated:YES];

}


-(void) removeAllAnnotations{
    for (id<MKAnnotation> n in _mapView.annotations) {
        if([n isKindOfClass:[MKUserLocation class]]){
            continue;
        }
        [_mapView removeOverlay:((IssueAnnotation *)n).circle];
        [_mapView removeAnnotation:n];
    }
}


- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKCircle class]]) {
        MKCircleRenderer *circleView = [[MKCircleRenderer alloc] initWithCircle:(MKCircle*)overlay];
        
        double metric = [overlay.title doubleValue];
        
        CGFloat insideAlpha = 0.2;
        CGFloat rimAlpha = 0.7;
        
        if(metric >= RED){
            circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:insideAlpha];
            circleView.strokeColor = [[UIColor redColor] colorWithAlphaComponent:rimAlpha];
        }
        else if(metric >= ORANGE){
            circleView.fillColor = [[UIColor orangeColor] colorWithAlphaComponent:insideAlpha];
            circleView.strokeColor = [[UIColor orangeColor] colorWithAlphaComponent:rimAlpha];
        }
        else if(metric >= YELLOW){
            circleView.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:insideAlpha];
            circleView.strokeColor = [[UIColor yellowColor] colorWithAlphaComponent:rimAlpha];
        }
        else if (metric >= GREEN){
            circleView.fillColor = [[UIColor greenColor] colorWithAlphaComponent:insideAlpha];
            circleView.strokeColor = [[UIColor greenColor] colorWithAlphaComponent:rimAlpha];
        }
        else if (metric >= BLUE){
            circleView.fillColor = [[UIColor blueColor] colorWithAlphaComponent:insideAlpha];
            circleView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:rimAlpha];
        }
        else{
            circleView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:insideAlpha];
            circleView.strokeColor = [[UIColor cyanColor] colorWithAlphaComponent:rimAlpha];
        }
        
        circleView.lineWidth = 1;
        return circleView;
    }
    return NULL;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }
    
    static NSString *identifier = @"itemPin";
    MKAnnotationView *annotationView = (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = NO;
        
        UIImage *pin = [UIImage imageNamed:@"circle_small.png"];
        annotationView.image = pin;
        
    } else {
        annotationView.annotation = annotation;
    }

    return annotationView;
    
}

-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    
    [self removeAnimatedOverlay];
    
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    MKMapRect mRect = _mapView.visibleMapRect;
    MKMapPoint eastMapPoint = MKMapPointMake(MKMapRectGetMinX(mRect), MKMapRectGetMidY(mRect));
    MKMapPoint westMapPoint = MKMapPointMake(MKMapRectGetMaxX(mRect), MKMapRectGetMidY(mRect));
    
    self.currentDist = MKMetersBetweenMapPoints(eastMapPoint, westMapPoint);
    //NSLog(@"cuurent dist is %f", currentDist);
    
    
    [self addAnimatedOverlayToIssueAnnotationWithCircle:animatedOverlay.circle];
}


-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    //custom annotationview
    
    if([view.annotation isKindOfClass:[MKUserLocation class]]){
        return;
    }
    
    [self removeAnimatedOverlay];
    
    [issueView setNewIssue:((IssueAnnotation *)view.annotation).issue];
    animatedOverlay.circle = ((IssueAnnotation *)view.annotation).circle;
    
    //animate here
    issueList.tag = 0;
    [self tableTopper];
    
}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    
    [self removeAnimatedOverlay];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"calloutAccessoryControlTapped");
    
    if([view.annotation isMemberOfClass:[MKUserLocation class]])return;
    
    //
    
}





/**********************************************TABLE VIEW DELEGATE STUFF************************************************************ */

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CellIdentifier";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        [cell.image.layer setBorderWidth:2];
        [cell.image.layer setCornerRadius:5];
        [cell.image.layer setBorderColor:[UIColor whiteColor].CGColor];
        [cell.image.layer setMasksToBounds:YES];
    }
    
    if(!data || [data count] < 1){
        return cell;
    }
    
    NSInteger index = [indexPath indexAtPosition:[indexPath length]-1];
    
    Issue *tmpIssue = [data objectAtIndex:index];
    
    cell.issue = tmpIssue;
    
    double metric = [tmpIssue.metric doubleValue];
    
    if(metric >= RED){
        [cell.trend setBackgroundColor:[UIColor redColor]];
    }
    else if(metric >= ORANGE){
        [cell.trend setBackgroundColor:[UIColor orangeColor]];
    }
    else if(metric >= YELLOW){
        [cell.trend setBackgroundColor:[UIColor yellowColor]];
    }
    else if(metric >= GREEN){
        [cell.trend setBackgroundColor:[UIColor greenColor]];
    }
    else if(metric >= BLUE){
        [cell.trend setBackgroundColor:[UIColor blueColor]];
    }
    else{
        [cell.trend setBackgroundColor:[UIColor cyanColor]];
    }
    
    cell.image.image = tmpIssue.image;
    
    if(!tmpIssue.image){
        cell.image.image = [UIImage imageNamed:@"soapbox.png"];
    }
    
    // Configure the cell...
    
    NSArray *agreesForUser = [[PFUser currentUser] objectForKey:@"agreesWith"];
    if([agreesForUser containsObject:tmpIssue.parseId]){
        [cell.trend setText:@"+1"];
        [cell.trend setTextAlignment:NSTextAlignmentCenter];
        [cell.trend setTextColor:GRAY1];
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.title setText:tmpIssue.title];
    [cell.title setTextColor:[UIColor whiteColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [data count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}


// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = (CustomCell *)[issueList cellForRowAtIndexPath:indexPath];
    [issueView setNewIssue:cell.issue];
    
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options: UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [cell setBackgroundColor:[UIColor whiteColor]];
                         [cell setAlpha:0.7];
                     }
                     completion:^(BOOL finished) {
                         [cell setBackgroundColor:[UIColor clearColor]];
                         [cell setAlpha:1];
                         [self selectAnotation];
                     }];
    
}



/**********************************************MEMORY WARNING STUFF************************************************************ */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/********************************************** FB / TWEET / EMAIL ************************************************************ */


-(void) twitterPost{
    NSLog(@"So you want to tweet...");
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        NSLog(@"Well now you can start!");
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        // Sets the completion handler.  Note that we don't know which thread the
        // block will be called on, so we need to ensure that any UI updates occur
        // on the main queue
        tweetSheet.completionHandler = ^(SLComposeViewControllerResult result) {
            switch(result) {
                    //  This means the user cancelled without sending the Tweet
                case SLComposeViewControllerResultCancelled:
                    break;
                    //  This means the user hit 'Send'
                case SLComposeViewControllerResultDone:
                    [self updateIssueMetric:issueView.issue withVal:3];
                    break;
            }
            
            //  dismiss the Tweet Sheet
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:NO completion:^{
                    NSLog(@"Tweet Sheet has been dismissed.");
                }];
            });
        };
        
        NSString *tweet = [NSString stringWithFormat:@"%@ - %@... #SoapBox", issueView.issueTitle.text, issueView.description.text];
        [tweetSheet setInitialText:tweet];
        [self presentViewController:tweetSheet animated:YES completion:^{
            NSLog(@"GOGOGO!");
        }];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"Log into Twitter via Settings->Twitter to post."
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

-(void) fbPost{
    NSLog(@"So you want to post...");
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        NSLog(@"Well now you can start!");
        SLComposeViewController *shareSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        // Sets the completion handler.  Note that we don't know which thread the
        // block will be called on, so we need to ensure that any UI updates occur
        // on the main queue
        shareSheet.completionHandler = ^(SLComposeViewControllerResult result) {
            switch(result) {
                    //  This means the user cancelled without sending the Tweet
                case SLComposeViewControllerResultCancelled:
                    break;
                    //  This means the user hit 'Send'
                case SLComposeViewControllerResultDone:
                    [self updateIssueMetric:issueView.issue withVal:3];
                    break;
            }
            
            //  dismiss the Tweet Sheet
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:NO completion:^{
                    NSLog(@"FB share Sheet has been dismissed.");
                }];
            });
        };
        
        NSString *post = [NSString stringWithFormat:@"%@ - %@... #SoapBox\n\n%s", issueView.issueTitle.text, issueView.description.text, APP_LINK];
        [shareSheet setInitialText: post];
        [self presentViewController:shareSheet animated:YES completion:^{
            NSLog(@"GOGOGO!");
        }];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"Log into Facebook via Settings->Facebook to post."
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

-(void)sendEmailAfterFlagged{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        [mailViewController setToRecipients:[NSArray arrayWithObjects:@"jhurray@umich.edu", nil]];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:@"Issue has been flagged!"];
        mailViewController.navigationBar.barStyle = UIBarStyleBlack;
        mailViewController.navigationItem.rightBarButtonItem.style = UIBarButtonItemStylePlain;
        [mailViewController setMessageBody:[NSString stringWithFormat:@"IssueId = %@\n\nPlease detail below why you believe this issue is innapropriate.\n\n", issueView.issue.parseId] isHTML:NO];
        [self presentViewController:mailViewController animated:YES completion:^{
            NSLog(@"GOGOGO!");
        }];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"Cant Send Email Right Now."
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}


- (void)sendEmail{
    NSLog(@"So you want to email...");
    if ([MFMailComposeViewController canSendMail])
    {
        NSLog(@"Well now you can start!");
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        [mailViewController setTitle:@"Share!"];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:@"Join in the issue!"];
        mailViewController.navigationBar.barStyle = UIBarStyleBlack;
        mailViewController.navigationItem.rightBarButtonItem.style = UIBarButtonItemStylePlain;
        [mailViewController setMessageBody:[NSString stringWithFormat:@"I would like you to join my issue, %@, on SoapBox.\n\n%s", issueView.issue.title, APP_LINK] isHTML:NO];
        [self presentViewController:mailViewController animated:YES completion:^{
            NSLog(@"GOGOGO!");
        }];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"Cant Send Email Right Now."
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}


- (void)finishedWithEmail:(NSString *)email body:(NSString *)body {
    
    
}


-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    if(result == MFMailComposeResultCancelled){
        return;
    }
    if ([controller.title isEqualToString:@"Share!"]) {
        [self updateIssueMetric:issueView.issue withVal:3];
    }
    else{
        //give time for an issue to be flagged
        [issueView flaggingEmailSentWithIssueId:issueView.issue.parseId];
        [self mapBtnTouched];
        recentlyFlaggedId = issueView.issue.parseId;
        [self removeAnimatedOverlay];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5*NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // Do something...
            [self refresh];
            
        });
    }

}

- (void)canceled{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)agree{
    
    
    if(issueView.agree.tag == 1){
        return;
    }

    NSMutableArray *agreesForUser = [NSMutableArray arrayWithArray:[[PFUser currentUser] objectForKey:@"agreesWith"]];
    [agreesForUser addObject:issueView.issue.parseId];
    [[PFUser currentUser] setObject:agreesForUser forKey:@"agreesWith"];
    [[PFUser currentUser] saveInBackground];
    
    [issueView.agree setBackgroundColor:[UIColor greenColor]];
    [issueView.agree setTitleColor:GRAY1 forState:UIControlStateNormal];
    [self updateIssueMetric:issueView.issue withVal:1];
    issueView.agree.tag =1;
}

-(void)updateIssueMetric:(Issue *)tmpIssue withVal:(int)val{
    
    
    tmpIssue.metric = [NSNumber numberWithInt:[tmpIssue.metric intValue] + val];
    PFObject *issueToUpdate = [PFObject objectWithoutDataWithClassName:@"Issue" objectId:(tmpIssue.parseId)];
    [issueToUpdate setObject:tmpIssue.metric forKey:@"Alchemy"];
    [issueToUpdate saveInBackgroundWithBlock:^(BOOL success,NSError *error ){
        if(!success){
            NSLog(@"\n\n%@\n\n", [error localizedDescription]);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Something went wrong"
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            NSLog(@"\n\nUPDATE SUCCESFUL on %@ with id %@\n", tmpIssue.title, tmpIssue.parseId);
            [self refresh];
            dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, 0.2*NSEC_PER_SEC);
            dispatch_after(delay, dispatch_get_main_queue(), ^(void){
                [self selectAnotation];
                [animatedOverlay startAnimating];
            });
        }
    }];
    
}



@end
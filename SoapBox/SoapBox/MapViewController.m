//
//  MapViewController.m
//  SoapBox
//
//  Created by Gregoire on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "MapViewController.h"
#import "AddNewIssueViewController.h"
#import "ViewController.h"
#import "IssueViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize mapView = _mapView;
@synthesize currentDist;
@synthesize filterLabel, filters, filterMeTimbers;
@synthesize nowButton,closeButton,hotButton,friendsButton;

-(void) removeAllAnnotations{
    for (id<MKAnnotation> n in _mapView.annotations) {
        [_mapView removeAnnotation:n];
    }
}

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
    
    //init the views
    filters = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    filters.backgroundColor = GRAY2;
    filters.tag = 1;
    filterMeTimbers = [UIButton buttonWithType:UIButtonTypeCustom];
    [filterMeTimbers setFrame:CGRectMake(60, 0, 200, 50)];
    [filterMeTimbers addTarget:self action:@selector(bringEmOut) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:filters];
    [self.view addSubview:filterLabel];
    
    [self.masterContainer.parentController.navigationBar addSubview:filterMeTimbers];
    
    //make filter buttons
    nowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    hotButton = [UIButton buttonWithType:UIButtonTypeCustom];
    friendsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //set targets
    [nowButton addTarget:self action:@selector(refreshNow) forControlEvents:UIControlEventTouchUpInside];
    [hotButton addTarget:self action:@selector(refreshHot) forControlEvents:UIControlEventTouchUpInside];
    [friendsButton addTarget:self action:@selector(refreshFriend) forControlEvents:UIControlEventTouchUpInside];
    [closeButton addTarget:self action:@selector(refreshClose) forControlEvents:UIControlEventTouchUpInside];
    //set frames
    [nowButton setFrame:CGRectMake(0, 0, 80, 0)];
    [hotButton setFrame:CGRectMake(80, 0, 80, 0)];
    [friendsButton setFrame:CGRectMake(160, 0, 80, 0)];
    [closeButton setFrame:CGRectMake(240, 0, 80, 0)];
    
    
    [self.navigationController setNavigationBarHidden:YES];
    if (!([PFUser currentUser] && // Check if a user is cached
        [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]])) // Check if user is linked to Facebook
    {
        ViewController *loginVC = [[ViewController alloc] init];
        UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        
        [self presentViewController:loginNav animated:YES completion:^{
            
        }];
        
        [self refresh];
      }

  [self setTitle:@"SoapBox"];
  [[[self navigationController] navigationItem] setTitle:@"SoapBox"];
  NSLog(@"%@",[[[self navigationController] navigationBar] titleTextAttributes]);
  
    /* once we need it
     
     UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
     UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(loadAddScreen:)];
     self.navigationItem.rightBarButtonItem = refreshButton;
     self.navigationItem.leftBarButtonItem = addButton;
     
     */
}


-(void)bringEmOut{
    NSLog(@"\n\n\nFILTER ME TIMBERS!!!\n\n\n");
    if(filters.tag == 0){
        filters.tag = 1;
        [UIView animateWithDuration:0.2f
                              delay:0.0f
                            options: UIViewAutoresizingFlexibleBottomMargin
                         animations:^{
                             //[ setFrame:CGRectMake(0.0f, 00.0f, 320.0f, 00.0f)];
                         }
                         completion:nil];
    }
    else if(filters.tag == 1) {
        filters.tag = 0;
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options: UIViewAutoresizingFlexibleBottomMargin
                         animations:^{
                             [filters setFrame:CGRectMake(0.0f, 0.0f, 320.0f, 80.0f)];
                         }
                         completion:nil];
    }

}

-(void)refresh{
    NSLog(@"\n\nrefrehing\n\n");
    
    [self removeAllAnnotations];
    
    //throw in an animation
    
    CGFloat kilometers = currentDist/1000;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Issue"];
    [query setLimit:100];
    [query whereKey:@"Location"
       nearGeoPoint:[PFGeoPoint geoPointWithLatitude:[[LocationGetter sharedInstance] getLatitude]
                                           longitude:[[LocationGetter sharedInstance]getLongitude]]
   withinKilometers:kilometers];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"OBJECTS SIZE IS %i", [objects count]);
            for (PFObject *object in objects) {
                
                PFGeoPoint *tmp = [object objectForKey:@"Location"];
                //NSLog(@"object %@ is now at %f , %f\n\n", [object objectForKey:@"title"], tmp.latitude, tmp.longitude);
                MKPointAnnotation *tmpAnnotation = [[MKPointAnnotation alloc]init];
                tmpAnnotation.coordinate = CLLocationCoordinate2DMake(tmp.latitude, tmp.longitude);
                tmpAnnotation.title = [object objectForKey:@"Title"];
                tmpAnnotation.subtitle = [object objectForKey:@"Description"];
                [self.mapView addAnnotation:tmpAnnotation];
            }
        }
    }];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    MKMapRect mRect = _mapView.visibleMapRect;
    MKMapPoint eastMapPoint = MKMapPointMake(MKMapRectGetMinX(mRect), MKMapRectGetMidY(mRect));
    MKMapPoint westMapPoint = MKMapPointMake(MKMapRectGetMaxX(mRect), MKMapRectGetMidY(mRect));
    
    self.currentDist = MKMetersBetweenMapPoints(eastMapPoint, westMapPoint);
    NSLog(@"cuurent dist is %f", currentDist);
}

-(void) viewWillAppear:(BOOL)animated{
    
    [[LocationGetter sharedInstance] startUpdates];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [[LocationGetter sharedInstance] locationManager].location.coordinate.latitude;
    zoomLocation.longitude = [[LocationGetter sharedInstance] locationManager].location.coordinate.longitude;
    
    NSLog(@"Longitude and latitude are %f and %f", zoomLocation.latitude, zoomLocation.longitude);
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, METERS_PER_MILE, METERS_PER_MILE);
    
    [_mapView setRegion:viewRegion animated:YES];
    
    //refresh
    [self refresh];
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    
    //NSLog(@"\n\nin here\n\n");
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    static NSString *identifier = @"itemPin";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.pinColor = MKPinAnnotationColorRed;
        
        
        //set up switch for this
        
        UIImage *pin = [UIImage imageNamed:@"pin_blue_small.png"];
        annotationView.image = pin;
    } else {
        annotationView.annotation = annotation;
    }
    
    return annotationView;
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"calloutAccessoryControlTapped");
    
    if([view.annotation isMemberOfClass:[MKUserLocation class]])return;
    
    IssueViewController *iVC = [[IssueViewController alloc]initWithNibName:@"IssueViewController" bundle:nil];
    [self.masterContainer.parentController pushViewController:iVC animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

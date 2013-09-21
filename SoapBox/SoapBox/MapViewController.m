//
//  MapViewController.m
//  SoapBox
//
//  Created by Gregoire on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "MapViewController.h"
#import "AddIssueViewController.h"

#define METERS_PER_MILE 1609.344

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize mapView = _mapView;
@synthesize currentDist;

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
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(loadAddScreen:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    /* once we need it
     
     UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
     UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(loadAddScreen:)];
     self.navigationItem.rightBarButtonItem = refreshButton;
     self.navigationItem.leftBarButtonItem = addButton;
     
     */
}

-(IBAction)loadAddScreen:(id)sender{
    AddIssueViewController *aiVC = [[AddIssueViewController alloc] initWithNibName:@"AddIssueViewController" bundle:nil];
    UINavigationController *tmpNC = [[UINavigationController alloc] initWithRootViewController:aiVC];
    [self presentViewController:tmpNC animated:YES completion:nil];
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
    //[self refresh];
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
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

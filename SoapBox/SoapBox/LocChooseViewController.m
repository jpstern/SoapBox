//
//  LocChooseViewController.m
//  SoapBox
//
//  Created by Gregoire on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "LocChooseViewController.h"

@interface LocChooseViewController ()

@end

@implementation LocChooseViewController

@synthesize mapView2 = _mapView2;
@synthesize coord = _coord;
@synthesize mapImage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"inintilizing" );
        mapImage = NULL;
        _coord = CLLocationCoordinate2DMake([[LocationGetter sharedInstance] getLatitude],  [[LocationGetter sharedInstance] getLongitude]);
    }
    return self;
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [_mapView2 setDelegate:self];
    
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Drag and Drop";
    
    UIButton *checkBtn = [[UIButton alloc] initWithFrame:BARBUTTONFRAME];
    UIImage *check = [UIImage imageNamed:@"check@2x.png"];
    [checkBtn setImage:check forState:UIControlStateNormal];
    [checkBtn addTarget:self action:@selector(success) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *checkBarButton = [[UIBarButtonItem alloc] initWithCustomView:checkBtn];
    self.navigationItem.rightBarButtonItem = checkBarButton;
    
    UIButton *crossBtn = [[UIButton alloc] initWithFrame:BARBUTTONFRAME];
    UIImage *cross = [UIImage imageNamed:@"cross@2x.png"];
    [crossBtn setImage:cross forState:UIControlStateNormal];
    [crossBtn addTarget:self action:@selector(cancelMove) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *crossBarBtn = [[UIBarButtonItem alloc]initWithCustomView:crossBtn];
    self.navigationItem.leftBarButtonItem = crossBarBtn;
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    static NSString *identifier = @"draganddrop";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [_mapView2 dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.animatesDrop = YES;
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.draggable = YES;
        //annotationView.pinColor = MKPinAnnotationColorPurple;
        UIImage *pin = [UIImage imageNamed:@"pin_blue_small.png"];
        annotationView.image = pin;
    } else {
        annotationView.annotation = annotation;
    }
    
    return annotationView;
    
}

//**** FOR PIN DRAG ****
- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)annotationView
didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding)
    {
        CLLocationCoordinate2D droppedAt = annotationView.annotation.coordinate;
        NSLog(@"Pin dropped at %f,%f", droppedAt.latitude, droppedAt.longitude);
        _coord = CLLocationCoordinate2DMake(droppedAt.latitude, droppedAt.longitude);
    }
}


-(void) viewDidAppear:(BOOL)animated{
    [_mapView2 removeAnnotations:_mapView2.annotations];
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.title = @"DRAG AND DROP";
    point.subtitle = @"touch down and hold";
    point.coordinate = CLLocationCoordinate2DMake((CLLocationDegrees)[[LocationGetter sharedInstance] getLatitude], (CLLocationDegrees)[[LocationGetter sharedInstance] getLongitude]);
    [self.mapView2 addAnnotation:point];
    NSLog(@"lat and long are %f, %f", point.coordinate.latitude, point.coordinate.longitude);
    _coord = CLLocationCoordinate2DMake(point.coordinate.latitude, point.coordinate.longitude);
    [_mapView2 selectAnnotation:point animated:YES];
    NSLog(@"view did appear" );
    NSLog(@"annotations count is %lu\n\n", (unsigned long)[_mapView2.annotations count]);
}

-(void) viewWillAppear:(BOOL)animated{
    
    
    [[LocationGetter sharedInstance] startUpdates];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [[LocationGetter sharedInstance] locationManager].location.coordinate.latitude;
    zoomLocation.longitude = [[LocationGetter sharedInstance] locationManager].location.coordinate.longitude;
    
    NSLog(@"Longitude and latitude are %f and %f", zoomLocation.latitude, zoomLocation.longitude);
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, .6*METERS_PER_MILE, .6*METERS_PER_MILE);
    
    [_mapView2 setRegion:viewRegion animated:YES];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"YES"])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if([title isEqualToString:@"NO"])
    {
        return;
    }
    
}

- (void)success{
    
    MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc] init];
    options.region = MKCoordinateRegionMake(self.coord, MKCoordinateSpanMake(0.01, 0.01));
    MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc] initWithOptions:options];
    [snapshotter startWithCompletionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
        NSLog(@"Snapshot finished");
        self.mapImage = snapshot.image;
    }];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are you sure"
                                                    message:@"you want to change the location of this item?"
                                                   delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [alert show];
    
}

- (void)cancelMove{
    [self dismissViewControllerAnimated:YES completion:nil];
    _coord = CLLocationCoordinate2DMake([[LocationGetter sharedInstance] getLatitude], [[LocationGetter sharedInstance]getLongitude]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

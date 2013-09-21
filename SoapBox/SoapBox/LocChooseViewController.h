//
//  LocChooseViewController.h
//  SoapBox
//
//  Created by Gregoire on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LocChooseViewController : UIViewController <MKMapViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView2;
//@property (nonatomic, strong) MKPointAnnotation *point;
@property (nonatomic) CLLocationCoordinate2D coord;

@end

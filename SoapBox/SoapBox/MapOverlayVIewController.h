//
//  MapOverlayVIewController.h
//  SoapBox
//
//  Created by Charley Hutchison on 9/22/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MapOverlayVIewController : MKOverlayRenderer

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context;

@property (strong, nonatomic) UIColor* fillColor;

@end

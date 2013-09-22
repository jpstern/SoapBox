//
//  MapOverlayVIewController.m
//  SoapBox
//
//  Created by Charley Hutchison on 9/22/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "MapOverlayVIewController.h"

@implementation MapOverlayVIewController

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context {
    CGContextBeginPath(context);
    CGContextSetLineWidth(context,5);
    CGContextStrokeEllipseInRect(context, CGRectMake(mapRect.origin.x, mapRect.origin.y, mapRect.size.height, mapRect.size.width));

}

@end

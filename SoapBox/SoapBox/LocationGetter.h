//
//  LocationGetter.h
//  CurbList
//
//  Created by Gregoire on 6/14/13.
//  Copyright (c) 2013 BirwinApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationGetterDelegate <NSObject>

- (void) newLocation:(CLLocation *)location;

@end



@interface LocationGetter : NSObject <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property(nonatomic , retain) id delegate;

+(id) sharedInstance;

- (void)startUpdates;
-(double) getLatitude;
-(double) getLongitude;
-(CLLocationCoordinate2D) getCoord;


@end

//
//  Issue.m
//  SoapBox
//
//  Created by Charley Hutchison on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "Issue.h"

@implementation Issue

-(id)initWithPFObject:(PFObject *)object{
    
    if(self = [super init]){
        
        PFGeoPoint *tmp = [object objectForKey:@"Location"];
        self.location = CLLocationCoordinate2DMake(tmp.latitude, tmp.longitude);
        self.title = [object objectForKey:@"Title"];
        self.description = [object objectForKey:@"Description"];
        self.metric = [object objectForKey:@"Alchemy"];
        PFFile *file = [object valueForKey:@"Image"];
        self.image = [UIImage imageWithData:file.getData];
        self.parseId = [object objectId];
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        self.createdAt = [dateFormatter stringFromDate:[object createdAt]];
        
        CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:self.location.latitude longitude:self.location.longitude];
        [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            for (CLPlacemark * placemark in placemarks) {
                NSString * addressName = [placemark name];
                NSString * city = [placemark locality]; // locality means "city"
                NSString * administrativeArea = [placemark administrativeArea]; // which is "state" in the U.S.A.
                self.address = [NSString stringWithFormat:@"%@\n%@, %@", addressName, city, administrativeArea];
            }
        }];
        
    }
    return self;
}

@end

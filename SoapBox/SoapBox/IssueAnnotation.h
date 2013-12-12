//
//  IssueAnnotation.h
//  SoapBox
//
//  Created by Gregoire on 11/6/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Issue.h"

@interface IssueAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readwrite, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, strong) Issue *issue;
@property (nonatomic, strong) MKCircle *circle;

-(id)initWithIssue: (Issue *)issue;

@end

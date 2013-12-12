//
//  IssueAnnotation.m
//  SoapBox
//
//  Created by Gregoire on 11/6/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "IssueAnnotation.h"

@implementation IssueAnnotation

-(id)initWithIssue: (Issue *)issueForInit
{
    if ((self = [super init]))
    {
        self.issue = issueForInit;
        self.coordinate = issueForInit.location;
        self.title = issueForInit.title;
        self.subtitle = issueForInit.description;
        //self.circle = [MKCircle circleWithCenterCoordinate:issueForInit.location radius:[issueForInit.metric doubleValue]];
    }
    return self;
}

@end

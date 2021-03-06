//
//  Issue.h
//  SoapBox
//
//  Created by Charley Hutchison on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Issue : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) UIImage *image;
@property (nonatomic) CLLocationCoordinate2D location;
@property (nonatomic) CGFloat *metric;

@end

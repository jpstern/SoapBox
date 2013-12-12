//
//  AnimatedOverlay.h
//  SoapBox
//
//  Created by Gregoire on 12/1/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

@interface AnimatedOverlay : UIImageView

@property (nonatomic,strong) MKCircle* circle;
-(void)startAnimating;
-(void) stopAnimating;

@end

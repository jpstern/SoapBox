//
//  MapViewController.h
//  SoapBox
//
//  Created by Gregoire on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController<MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property double currentDist;
@property (nonatomic, strong)  UIView *filters;
@property (nonatomic, strong)  UILabel *filterLabel;
@property (nonatomic, strong) UIView *hotView;
@property (nonatomic, strong) UIView *closeView;
@property (nonatomic, strong) UIView *friendsView;
@property (nonatomic, strong) UIView *nowView;
@property (nonatomic, strong) IBOutlet UIButton *filterMeTimbers;
@property (nonatomic,strong) IBOutlet UIButton *hotButton;
@property (nonatomic,strong) IBOutlet UIButton *closeButton;
@property (nonatomic,strong) IBOutlet UIButton *friendsButton;
@property (nonatomic,strong) IBOutlet UIButton *nowButton;

-(void) removeAllAnnotations;
- (void)refreshClose;
- (void) refreshFriend;


@end

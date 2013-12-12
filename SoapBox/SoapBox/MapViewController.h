//
//  MapViewController.h
//  SoapBox
//
//  Created by Gregoire on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import "FilterView.h"
#import "IssueView.h"
#import "RefreshView.h"
#import "MenuView.h"
#import "MBProgressHUD.h"

@interface MapViewController : UIViewController<MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource, AddEmailDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property double currentDist;
@property (nonatomic, strong)  UIView *filters;
@property (nonatomic, strong) IBOutlet UIButton *filterMeTimbers;
@property (nonatomic, strong) FilterView *filterView;
@property (nonatomic,strong) IssueView *issueView;
@property (nonatomic, strong) RefreshView *refreshView;
@property (nonatomic, strong) MenuView *menuView;


@property (nonatomic, strong) UIView *filterSheet;

@property (nonatomic,strong) UITableView *issueList;

@property (nonatomic,strong) NSArray *data;
@property (nonatomic, strong) NSArray *fbData;
@property (nonatomic,strong) NSArray *fbFriendsWithApp;

-(void) removeAllAnnotations;



@end

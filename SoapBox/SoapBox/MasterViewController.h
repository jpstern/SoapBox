//
//  MasterViewController.h
//  SoapBox
//
//  Created by Josh Stern on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIView *parentView;
@property (nonatomic, strong) IBOutlet UIView *childView;

@property (nonatomic, strong) UINavigationController *parentController;
@property (nonatomic, strong) UINavigationController *childController;

@property (nonatomic, strong) UITapGestureRecognizer *parentTapGesture;
@property (nonatomic, strong) UITapGestureRecognizer *childTapGesture;

@property (nonatomic) BOOL containerIsOpen;

-(void)openContainer;
-(void)closeContainer;

@end

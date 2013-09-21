//
//  UIViewController+MasterContainer.h
//  SoapBox
//
//  Created by Josh Stern on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MasterViewController;

@interface UIViewController (MasterContainer)

@property (nonatomic, weak, readonly) MasterViewController *masterContainer;

@end

//
//  UIViewController+MasterContainer.m
//  SoapBox
//
//  Created by Josh Stern on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "UIViewController+MasterContainer.h"

#import "MasterViewController.h"

@implementation UIViewController (MasterContainer)

-(MasterViewController *)masterContainer {
    
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[MasterViewController class]]) {
            return (MasterViewController *)iter;
        } else if (iter.parentViewController && iter.parentViewController != iter) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;

    
}

@end

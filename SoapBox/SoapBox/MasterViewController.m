//
//  MasterViewController.m
//  SoapBox
//
//  Created by Josh Stern on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "MasterViewController.h"


@interface MasterViewController ()

@end

@implementation MasterViewController
@synthesize parentView, childView;

@synthesize parentController = _parentController;
@synthesize childController = _childController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  
  
  
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
      
    [self updateParentView];
    [self updateChildView];
  
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateParentView
{
    _parentController.view.frame = parentView.bounds;
    [parentView addSubview:_parentController.view];
}

-(void)setParentController:(UINavigationController *)parentController {
    
    _parentController = parentController;
    
    // handle view controller hierarchy
    [self addChildViewController:_parentController];
    [parentController didMoveToParentViewController:self];
    
    if ([self isViewLoaded]) {
        [self updateParentView];
    }
}

- (void)updateChildView
{
    _childController.view.frame = CGRectMake(0, _parentController.view.frame.origin.y, 320, _parentController.view.frame.size.height - parentView.frame.origin.y);// childView.bounds;
    [childView addSubview:_childController.view];
    
}

-(void)setChildController:(UINavigationController *)childController {
    
    _childController = childController;
    
    // handle view controller hierarchy
    [self addChildViewController:_childController];
    [childController didMoveToParentViewController:self];
    
    if([self isViewLoaded]) {
        [self updateChildView];
    }
}

-(void)openContainer {

    self.parentTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeContainer)];
    [self.parentView addGestureRecognizer:self.parentTapGesture];
    [self.childView addGestureRecognizer:self.parentTapGesture];
    
    [self.parentController setNavigationBarHidden:YES animated:YES];
    
    [UIView animateWithDuration:0.20 animations:^{
    
        CGRect rect = self.childView.frame;
        
        if (IS_IPHONE_5) {
        rect.origin.y = self.view.frame.size.height - 60;
        }
        else {
            rect.origin.y = self.view.frame.size.height;
        }
        self.childView.frame = rect;
        
    } completion:^(BOOL finished) {
        
        self.containerIsOpen = YES;
    }];

}

-(void)closeContainer {
    [self.parentView removeGestureRecognizer:self.parentTapGesture];
    [self.childView removeGestureRecognizer:self.parentTapGesture];
    
    [self.parentController setNavigationBarHidden:NO animated:YES];
    
    [UIView animateWithDuration:0.20 animations:^{
        
        CGRect rect = self.childView.frame;
        
        rect.origin.y = 60;
        
        self.childView.frame = rect;
        
    } completion:^(BOOL finished) {
        
        self.containerIsOpen = NO;
      
      [self.parentController popToRootViewControllerAnimated:NO];
    }];
    
}

@end

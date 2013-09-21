//
//  DummyTableViewController.m
//  SoapBox
//
//  Created by Josh Stern on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "DummyTableViewController.h"
#import "DummyViewController.h"

@interface DummyTableViewController ()

@end

@implementation DummyTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)openContainer {
    
    [self.masterContainer openContainer];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeContainer)];
    [self.view addGestureRecognizer:tap];
 
}

-(void)closeContainer {
    
    [self.masterContainer closeContainer];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Hi" style:UIBarButtonItemStylePlain target:self action:@selector(openContainer)];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 50, 200, 30);
    [button addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"HELLO" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    if (self.masterContainer.containerIsOpen) {

        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    else {
        
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)push:(id)sender {
    
    DummyViewController *dummy = [[DummyViewController alloc] init];
    
    [self.navigationController pushViewController:dummy animated:YES];
}

@end

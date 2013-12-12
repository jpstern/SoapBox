//
//  ViewController.h
//  SoapBox
//
//  Created by Josh Stern on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIImageView *soapBoxPic;

- (void)login:(id)sender;

@end

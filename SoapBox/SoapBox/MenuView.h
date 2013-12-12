//
//  MenuView.h
//  SoapBox
//
//  Created by Gregoire on 11/27/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuView : UIView

@property (nonatomic,strong) UISegmentedControl *menuControl;
@property (nonatomic, strong) UIButton *logout;
@property (nonatomic,strong) UITextView *about;

@end

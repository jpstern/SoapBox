//
//  FilterView.h
//  SoapBox
//
//  Created by Gregoire on 11/25/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterView : UIView

@property (nonatomic, strong) UISwitch *fbSwitch;
@property (nonatomic, strong) UISegmentedControl *sortingControl;
@property (nonatomic, strong) UILabel *fbText;
@property (nonatomic, strong) UILabel *segmentText;

@property (nonatomic) int  fbSwitchIsOn;
@property (nonatomic) int  segmentVal;

@property (nonatomic) BOOL changed;

-(BOOL)chagesMade;
-(void)setVals;
-(BOOL)filterValuesDifferent;

@end

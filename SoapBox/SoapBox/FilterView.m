//
//  FilterView.m
//  SoapBox
//
//  Created by Gregoire on 11/25/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "FilterView.h"

@implementation FilterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.changed = false;
        
        CGFloat fbDepth = 30;
        CGFloat fbYOffset = 10;
        self.fbSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(260, fbYOffset, 60, fbDepth)];
        self.fbText = [[UILabel alloc] initWithFrame:CGRectMake(5, fbYOffset, 260, fbDepth)];
        [self.fbText setText:@"Show Only Facebook Friends"];
        [self.fbText setFont:[UIFont fontWithName:@"AvenirNextCondensed-Regular" size:25]];
        [self.fbText setTextColor:[UIColor whiteColor]];
        
        CGFloat segmentDepth = 40;
        CGFloat segmentYOffset = 50;
        NSArray *titleArray = [NSArray arrayWithObjects:@"Closest", @"Newest", @"Hottest", nil];
        self.sortingControl = [[UISegmentedControl alloc] initWithItems:titleArray];
        [self.sortingControl setBackgroundColor:[UIColor clearColor]];
        [self.sortingControl setTintColor:[UIColor whiteColor]];
        [self.sortingControl setFrame:CGRectMake(100, segmentYOffset, 210, segmentDepth)];
        self.segmentText = [[UILabel alloc] initWithFrame:CGRectMake(5, segmentYOffset, 95, segmentDepth)];
        [self.segmentText setText:@"Sort By..."];
        [self.segmentText setFont:[UIFont fontWithName:@"AvenirNextCondensed-Regular" size:25]];
        [self.segmentText setTextColor:[UIColor whiteColor]];
        [self.sortingControl setSelectedSegmentIndex:0];
        
        [self addSubview:self.fbSwitch];
        [self addSubview:self.sortingControl];
        [self addSubview:self.fbText];
        [self addSubview:self.segmentText];
    }
    return self;
}

-(BOOL)filterValuesDifferent{
    if(self.fbSwitch.isOn == self.fbSwitchIsOn){
        if(self.segmentVal == self.sortingControl.selectedSegmentIndex){
            return false;
        }
    }
    return true;
}

-(void)setVals{
    self.fbSwitchIsOn = self.fbSwitch.isOn;
    self.segmentVal = self.sortingControl.selectedSegmentIndex;
}

-(BOOL)chagesMade{
    
    if(self.fbSwitch.isOn != self.fbSwitchIsOn){
        [self setVals];
        return true;
    }
    if(self.sortingControl.selectedSegmentIndex != self.segmentVal){
        [self setVals];
        return true;
    }
    
    return false;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

//
//  MenuView.m
//  SoapBox
//
//  Created by Gregoire on 11/27/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:GRAY2];
        // Initialization code
        NSArray *segmentNames = [NSArray arrayWithObjects:@"About SoapBox", @"Logout", nil];
        self.menuControl = [[UISegmentedControl alloc] initWithItems:segmentNames];
        [self.menuControl setBackgroundColor:[UIColor clearColor]];
        [self.menuControl setFrame:CGRectMake(20, 40, 280, 60)];
        [self.menuControl setTintColor:[UIColor whiteColor]];
        [self.menuControl setSelectedSegmentIndex:0];
        [self.menuControl addTarget:self action:@selector(segmentChanged) forControlEvents:UIControlEventValueChanged];
        
        self.logout = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.logout setFrame:CGRectMake(80, 160, 160, 100)];
        [self.logout setBackgroundColor:[UIColor clearColor]];
        [self.logout setTitle:@"Logout" forState:UIControlStateNormal];
        [self.logout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.logout.layer setBorderColor:[UIColor whiteColor].CGColor];
        [self.logout.layer setBorderWidth:3];
        [self.logout.layer setCornerRadius:50];
        [self.logout addTarget:self action:@selector(unHighlightLogout) forControlEvents:UIControlEventTouchUpOutside];
        [self.logout addTarget:self action:@selector(highlightLogout) forControlEvents:UIControlEventTouchDown];
        [self.logout addTarget:self action:@selector(unHighlightLogout) forControlEvents:UIControlEventTouchUpInside];
        
        self.about = [[UITextView alloc] initWithFrame:CGRectMake(20, 120, 300, 280)];
        [self.about setBackgroundColor:[UIColor clearColor]];
        [self.about setTextColor:[UIColor whiteColor]];
        [self.about setText:@"Long ago when people wanted to be heard, they would stand on a SoapBox and holler. We believe our SoapBox gives the modern user a step up when it comes to being heard and hearing others. We aggregate data about issues taking into account proximity, friends, whats trending, and advanced machine learning (using the Alchemy API) to let our user know whats important."];
        [self.about setFont:[UIFont fontWithName:@"AvenirNextCondensed-Regular" size:18]];
        [self.about setScrollEnabled:false];
    
        [self addSubview:self.about];
        //[self addSubview:self.logout];
        [self addSubview:self.menuControl];

    }
    return self;
}



-(void)segmentChanged{
    
    if(self.menuControl.selectedSegmentIndex == 0){
        
        [UIView animateWithDuration:0.2f
                              delay:0.0f
                            options: UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [self.logout setAlpha:0];
                         }
                         completion:^(BOOL finished) {
                             [self.logout removeFromSuperview];
                             [self.about setAlpha:0];
                             [self addSubview:self.about];
                             [UIView animateWithDuration:0.2f
                                                   delay:0.0f
                                                 options: UIViewAnimationOptionBeginFromCurrentState
                                              animations:^{
                                                  [self.about setAlpha:1];
                                              }
                                              completion:nil];
                         }];
    }
    else if(self.menuControl.selectedSegmentIndex == 1){
        
        [UIView animateWithDuration:0.2f
                              delay:0.0f
                            options: UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [self.about setAlpha:0];
                         }
                         completion:^(BOOL finished) {
                             [self.about removeFromSuperview];
                             [self.logout setAlpha:0];
                             [self addSubview:self.logout];
                             [UIView animateWithDuration:0.2f
                                                   delay:0.0f
                                                 options: UIViewAnimationOptionBeginFromCurrentState
                                              animations:^{
                                                  [self.logout setAlpha:1];
                                              }
                                              completion:nil];
                         }];
    }
    
}

-(void)highlightLogout{
    [self.logout setBackgroundColor:[UIColor whiteColor]];
    
}

-(void)unHighlightLogout{
    [self.logout setBackgroundColor:[UIColor clearColor]];
    
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

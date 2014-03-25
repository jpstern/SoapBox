//
//  RefreshView.m
//  SoapBox
//
//  Created by Gregoire on 11/27/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "RefreshView.h"

@implementation RefreshView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.prompt = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 130, 45)];
        [self.prompt setText:@"Refresh Results?"];
        [self.prompt setTextColor:[UIColor whiteColor]];
        [self.prompt setBackgroundColor:[UIColor clearColor]];
        [self.prompt setFont:[UIFont fontWithName:@"AvenirNextCondensed-Regular" size:22]];
        
        self.yes = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.yes setFrame:CGRectMake(170, 0, 45, 45)];
        [self.yes setBackgroundColor:[UIColor clearColor]];
        [self.yes setTitle:@"Yes" forState:UIControlStateNormal];
        [self.yes setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.yes setBackgroundColor:[UIColor clearColor]];
        [self.yes setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.yes.layer setBorderWidth:1];
        [self.yes.layer setBorderColor:[UIColor whiteColor].CGColor];
        [self.yes.layer setCornerRadius:45/2];
        [self.yes addTarget:self action:@selector(highlightYes) forControlEvents:UIControlEventTouchDown];
        [self.yes addTarget:self action:@selector(unHighlightYes) forControlEvents:UIControlEventTouchUpInside];
        [self.yes addTarget:self action:@selector(unHighlightYes) forControlEvents:UIControlEventTouchUpOutside];
        
        self.no = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.no setFrame:CGRectMake(245, 0, 45, 45)];
        [self.no setBackgroundColor:[UIColor clearColor]];
        [self.no setTitle:@"No" forState:UIControlStateNormal];
        [self.no setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.no.layer setBorderWidth:1];
        [self.no.layer setBorderColor:[UIColor whiteColor].CGColor];
        [self.no.layer setCornerRadius:45/2];
        [self.no addTarget:self action:@selector(highlightNo) forControlEvents:UIControlEventTouchDown];
        [self.no addTarget:self action:@selector(unHighlightNo) forControlEvents:UIControlEventTouchUpInside];
        [self.no addTarget:self action:@selector(unHighlightNo) forControlEvents:UIControlEventTouchUpOutside];
        
        [self addSubview:self.prompt];
        [self addSubview:self.yes];
        [self addSubview:self.no];
        
    }
    return self;
}

-(void)highlightNo{
    [self.no setBackgroundColor:[UIColor whiteColor]];
    
}
-(void)highlightYes{
    [self.yes setBackgroundColor:[UIColor whiteColor]];
    
}
-(void)unHighlightNo{
    [self.no setBackgroundColor:[UIColor clearColor]];
    
}
-(void)unHighlightYes{
    [self.yes setBackgroundColor:[UIColor clearColor]];
    
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

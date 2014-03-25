//
//  IssueView.m
//  SoapBox
//
//  Created by Gregoire on 11/26/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "IssueView.h"
#import "ImageColorChanger.h"

@implementation IssueView

@synthesize flag;

CGFloat btnDiameter = 320/5;
CGFloat btnYCoord = 45;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        UIColor *twitterColor = [UIColor colorWithRed:0 green:205.0/255 blue:250.0/255 alpha:1];
        UIColor *fbColor = [UIColor colorWithRed:0 green:85.0/255 blue:153.0/255 alpha:1];
        UIColor *emailColor = [UIColor colorWithRed:6.0/255 green:21.0/255 blue:130.0/255 alpha:1];
        
        // Initialization code
        self.issueTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [self.issueTitle setText:self.issue.title];
        [self.issueTitle setTextColor:[UIColor whiteColor]];
        [self.issueTitle setBackgroundColor:[UIColor clearColor]];
        [self.issueTitle setFont:[UIFont fontWithName:@"AvenirNextCondensed-Regular" size:22]];
        [self.issueTitle setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.issueTitle];
        
        self.description = [[UITextView alloc] initWithFrame:CGRectMake(10, 120, 310, 80)];
        [self.description setText:self.issue.description];
        
        [self.description setTextAlignment:NSTextAlignmentLeft];
        [self.description setTextColor:[UIColor whiteColor]];
        self.description.editable = NO;
        self.description.scrollEnabled = NO;
        [self.description setBackgroundColor:[UIColor clearColor]];
        [self.description setFont:[UIFont fontWithName:@"AvenirNextCondensed-Regular" size:14]];
        [self addSubview:self.description];
        
        
        self.address = [[UITextView alloc] initWithFrame:CGRectMake(10, 290, 310, 80)];
        [self.address setText:self.issue.address];
        
        [self.address setTextAlignment:NSTextAlignmentLeft];
        [self.address setTextColor:[UIColor whiteColor]];
        self.address.editable = NO;
        self.address.scrollEnabled = NO;
        [self.address setBackgroundColor:[UIColor clearColor]];
        [self.address setFont:[UIFont fontWithName:@"AvenirNextCondensed-Regular" size:20]];
        //[self addSubview:self.address];
        
        self.createdAt = [[UILabel alloc] initWithFrame:CGRectMake(10, 390, 310, 50)];
        [self.createdAt setText:[NSString stringWithFormat:@"Created on: %@", self.issue.createdAt]];
        [self.createdAt setTextColor:[UIColor whiteColor]];
        [self.createdAt setBackgroundColor:[UIColor clearColor]];
        [self.createdAt setFont:[UIFont fontWithName:@"AvenirNextCondensed-Regular" size:26]];
        [self.createdAt setTextAlignment:NSTextAlignmentLeft];
        //[self addSubview:self.createdAt];
        
        self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, DEVICEHEIGHT-20)];
        self.image.image = self.issue.image;
        [self.image setBackgroundColor:GRAY2];
        
        self.back2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.back2 setFrame:CGRectMake(260, 10, 50, 50)];
        [self.back2 setBackgroundColor:GRAY1];
        [self.back2 setTitle:@"back" forState:UIControlStateNormal];
        [self.back2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.back2 addTarget:self action:@selector(back2TouchHandler) forControlEvents:UIControlEventTouchUpInside];
        [self.back2.layer setBorderWidth:1.5];
        [self.back2.layer setBorderColor:[UIColor whiteColor].CGColor];
        [self.back2.layer setCornerRadius:25];
        
        self.backToList = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backToList setFrame:CGRectMake(DEVICEWIDTH-40, 0, 40, 40)];
        [self.backToList setBackgroundColor:[UIColor clearColor]];
        [self.backToList setTitle:@"list" forState:UIControlStateNormal];
        [self.backToList setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.backToList];

        
        self.backToMap = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backToMap setFrame:CGRectMake(0, 0, 40, 40)];
        [self.backToMap setBackgroundColor:[UIColor clearColor]];
        [self.backToMap setTitle:@"map" forState:UIControlStateNormal];
        [self.backToMap setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.backToMap];
        
        
        
        self.seePic = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.seePic setFrame:CGRectMake(320, btnYCoord, btnDiameter, btnDiameter)];
        [self.seePic setBackgroundColor:GRAY1];
        [self.seePic setTitle:@"pic" forState:UIControlStateNormal];
        [self.seePic setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.seePic.layer setCornerRadius:btnDiameter/2];
        [self.seePic addTarget:self action:@selector(presentPicture) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.seePic];
        
        self.more = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.more setFrame:CGRectMake(0, 210, 320, 20)];
        [self.more setBackgroundColor:GRAY1];
        [self.more setAlpha:0.8];
        [self.more setTitle:@"more v" forState:UIControlStateNormal];
        [self.more setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.more setTag:1];
        [self addSubview:self.more];
        
        self.twitter = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.twitter setFrame:CGRectMake(320, btnYCoord, btnDiameter, btnDiameter)];
        [self.twitter setBackgroundColor:twitterColor];
        [self.twitter setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.twitter.layer setCornerRadius:btnDiameter/2];
        [self.twitter setBackgroundImage:[UIImage imageNamed:@"twitpic.png"] forState:UIControlStateNormal];
        [self addSubview:self.twitter];
        
        
        self.facebook = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.facebook setFrame:CGRectMake(320, btnYCoord, btnDiameter, btnDiameter)];
        [self.facebook setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.facebook setBackgroundColor:fbColor];
        [self.facebook.layer setCornerRadius:btnDiameter/2];
        [self.facebook setBackgroundImage:[UIImage imageNamed:@"fbbutton.png"] forState:UIControlStateNormal];
        [self addSubview:self.facebook];
        
        self.email = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.email setFrame:CGRectMake(320, btnYCoord, btnDiameter, btnDiameter)];
        [self.email setBackgroundColor:emailColor];
        [self.email setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.email.layer setCornerRadius:btnDiameter/2];
        [self.email setBackgroundImage:[UIImage imageNamed:@"email.png"] forState:UIControlStateNormal];
        [self addSubview:self.email];
        
        self.agree = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.agree setFrame:CGRectMake(320, btnYCoord, btnDiameter, btnDiameter)];
        [self.agree setBackgroundColor:GRAY1];
        [self.agree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.agree.layer setCornerRadius:btnDiameter/2];
        [self.agree setTitle:@"+1" forState:UIControlStateNormal];
        [self addSubview:self.agree];
        
        flag = [UIButton buttonWithType:UIButtonTypeCustom];
        [flag setBackgroundColor:[UIColor redColor]];
        [flag setFrame:CGRectMake(0, DEVICEHEIGHT-90, DEVICEWIDTH,30)];
        [flag setTitle:@"Flag as inappropriate" forState:UIControlStateNormal];
        [flag setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [flag addTarget:self action:@selector(pictureFlaggedAsInappropriate) forControlEvents:UIControlEventTouchUpInside];
        [flag setAlpha:0];
        
    }
    return self;
}

-(void) pictureFlaggedAsInappropriate{
    
    NSLog(@"Start flagging process");
    [self.delegate sendEmailAfterFlagged];
    //[self back2TouchHandler];
    //if I deem that picture isnt innapropriate I will unflag the Issue
}

-(void)flaggingEmailSentWithIssueId:(NSString *)issueId{
    PFObject *issueToUpdate = [PFObject objectWithoutDataWithClassName:@"Issue" objectId:(issueId)];
    [issueToUpdate setObject:[NSNumber numberWithBool:TRUE] forKey:@"flagged"];
    [issueToUpdate saveInBackgroundWithBlock:^(BOOL success,NSError *error ){
        if(!success){
            NSLog(@"\n\n%@\n\n", [error localizedDescription]);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Something went wrong. Try again."
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            //anything after email is sent
        }
    }];
}


-(void) showMore:(BOOL)more{
    
    if(more){
        [self.address setAlpha:0];
        [self.createdAt setAlpha:0];
        [self addSubview:self.createdAt];
        [self addSubview:self.address];
        [self addSubview:flag];
        [UIView animateWithDuration:0.2
                              delay:0.0f
                            options: UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [self.flag setAlpha:0.7];
                             [self.address setAlpha:1];
                             [self.createdAt setAlpha:1];
                             [self.description setFrame:CGRectMake(10, 120, 310, 160)];
                         }
                         completion:^(BOOL finished) {
                             
                         }];
        
    }
    else{
        
        [UIView animateWithDuration:0.2
                              delay:0.0f
                            options: UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             [self.address setAlpha:0];
                             [self.flag setAlpha:0.0];
                             [self.createdAt setAlpha:0];
                             [self.description setFrame:CGRectMake(10, 120, 310, 80)];
                             [self.description setFont:[UIFont fontWithName:@"AvenirNextCondensed-Regular" size:14]];
                         }
                         completion:^(BOOL finished) {
                             [self.address removeFromSuperview];
                             [self.createdAt removeFromSuperview];
                             [self.flag removeFromSuperview];
                         }];
        
    }
}

-(void)presentPicture{
    
    UILabel *noPhoto = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 320, 150)];
    [noPhoto setText:@"Loading..."];
    [noPhoto setTextColor:[UIColor whiteColor]];
    [noPhoto setFont:[UIFont fontWithName:@"AvenirNextCondensed-Regular" size:40]];
    [noPhoto setTextAlignment:NSTextAlignmentCenter];
    
    [self.image setAlpha:0];
    [self.back2 setAlpha:0];
    [noPhoto setAlpha:0];
    [self addSubview:self.image];
    //[self addSubview:flag];
    [self addSubview:self.back2];
    [self.image setUserInteractionEnabled:YES];
    [self.image addSubview:noPhoto];
    if(!self.issue.image){
        [noPhoto setText:@"No Photo"];
    }
    
    if(!self.image.image && self.issue.image){
        PFQuery *picQuery = [PFQuery queryWithClassName:@"FullSizeImage"];
        [picQuery whereKey:@"issueId" equalTo:self.issue.parseId];
        [picQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if(error || objects.count == 0){
                [noPhoto setFont:[UIFont fontWithName:@"AvenirNextCondensed-Regular" size:30]];
                [noPhoto setText:@"Something went wrong..."];
            }
            else{
                PFFile *imageFile = [[objects objectAtIndex:0] objectForKey:@"Image"];
                [noPhoto removeFromSuperview];
                [self.image setImage:[UIImage imageWithData:imageFile.getData]];
                //[self animateAfterPicLoad];
            }
        }];
    }
    [self.back2 setAlpha:1];
    if(!self.image.image){
        [noPhoto setAlpha:1];
    }
    [self.image setAlpha:1];
    
}

-(void)animateAfterPicLoad{
    
    [UIView animateWithDuration:0.2
                          delay:0.0f
                        options: UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

-(void)back2TouchHandler{
    

    for(id label in self.image.subviews){
        [label removeFromSuperview];
    }
        [UIView animateWithDuration:0.2f
                              delay:0.0f
                            options: UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [self.image setAlpha:0];
                             [self.back2 setAlpha:0];
                         }
                         completion:^(BOOL finished) {
                             [self.back2 removeFromSuperview];
                             [self.image removeFromSuperview];
                         }];
}

-(void)setNewIssue:(Issue *)issue{
    
    self.issue = issue;
    self.image.image = nil;
    self.issueTitle.text = issue.title;
    self.description.text = issue.description;
    self.address.text = issue.address;
    self.createdAt.text = [NSString stringWithFormat:@"Created on: %@", self.issue.createdAt];
    NSMutableArray *agreesForUser = [[PFUser currentUser] objectForKey:@"agreesWith"];
    if([agreesForUser containsObject:issue.parseId]){
        [self.agree setBackgroundColor:[UIColor greenColor]];
        [self.agree setTitleColor:GRAY1 forState:UIControlStateNormal];
        self.agree.tag = 1;
    }
    else{
        [self.agree setBackgroundColor:GRAY1];
        [self.agree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.agree.tag = 0;
    }
    
}

-(void)animateShareButtons{
    
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options: UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                    [self.twitter setFrame:CGRectMake(0, btnYCoord , btnDiameter, btnDiameter)];
                         
                     }
                     completion:nil];
    [UIView animateWithDuration:0.2f
                          delay:0.075f
                        options: UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.facebook setFrame:CGRectMake(64, btnYCoord, btnDiameter, btnDiameter)];
                         
                     }
                     completion:nil];
    [UIView animateWithDuration:0.2f
                          delay:0.15f
                        options: UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.email setFrame:CGRectMake(64*2, btnYCoord, btnDiameter, btnDiameter)];
                         
                     }
                     completion:nil];

    [UIView animateWithDuration:0.2f
                          delay:0.225f
                        options: UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.seePic setFrame:CGRectMake(64*3, btnYCoord, btnDiameter, btnDiameter)];
                         
                     }
                     completion:nil];
    [UIView animateWithDuration:0.2f
                          delay:0.3f
                        options: UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.agree setFrame:CGRectMake(64*4, btnYCoord, btnDiameter, btnDiameter)];
                         
                     }
                     completion:nil];
    
}

-(void)resetShareButtons{
    
    [self.facebook setFrame:CGRectMake(320, btnYCoord, btnDiameter, btnDiameter)];
    [self.email setFrame:CGRectMake(320, btnYCoord, btnDiameter, btnDiameter)];
    [self.twitter setFrame:CGRectMake(320, btnYCoord, btnDiameter, btnDiameter)];
    [self.seePic setFrame:CGRectMake(320, btnYCoord, btnDiameter, btnDiameter)];
    [self.agree setFrame:CGRectMake(320, btnYCoord, btnDiameter, btnDiameter)];
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

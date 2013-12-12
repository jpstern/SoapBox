//
//  IssueView.h
//  SoapBox
//
//  Created by Gregoire on 11/26/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Issue.h"
#import <MapKit/MapKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface IssueView : UIView 

@property (nonatomic, strong) Issue *issue;
@property (strong, nonatomic)  UILabel *issueTitle;
@property (strong, nonatomic)  UIImageView *image;
@property (strong, nonatomic)  UITextView *description;
@property (nonatomic, strong) UITextView *address;
@property (nonatomic, strong) UILabel *createdAt;
@property (strong, nonatomic)  UIButton *twitter;
@property (strong, nonatomic)  UIButton *facebook;
@property (strong, nonatomic)  UIButton *email;
@property (strong, nonatomic)  UIButton *agree;
@property (strong, nonatomic)  UIButton *more;
@property (strong, nonatomic) UIButton *seePic;
@property (strong, nonatomic) UIButton *backToList;
@property (strong, nonatomic) UIButton *backToMap;
@property (strong, nonatomic) UIButton *back2;

-(void)setNewIssue:(Issue *) issue ;

-(void)animateShareButtons;
-(void) showMore:(BOOL)more;
-(void)resetShareButtons;


@end

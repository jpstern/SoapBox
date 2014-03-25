//
//  AddNewIssueViewController.h
//  SoapBox
//
//  Created by Gregoire on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//
#import "LocChooseViewController.h"
#import <UIKit/UIKit.h>

@class AddNewIssueViewController;
@protocol NewIssueDelegate <NSObject>

-(void)addingNewIssue;

@end

@interface AddNewIssueViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    dispatch_queue_t backgroundQueue;
}

@property (nonatomic, weak) id <NewIssueDelegate> issueAddDelegate;
@property (strong, nonatomic) UITextView *titleTextView;
@property (strong, nonatomic) UITextView *descriptionTextView;
@property (strong, nonatomic) UILabel *titleCounter;
@property (strong, nonatomic) UILabel *descriptionCounter;
@property (strong, nonatomic) UIScrollView *tagScrollView;
@property (strong, nonatomic) UIButton *addPhotoBtn;
@property (strong, nonatomic) UIButton *addTagBtn;
@property (strong, nonatomic) UIButton *addLocBtn;
@property (strong, nonatomic) LocChooseViewController *lcVC;

@end
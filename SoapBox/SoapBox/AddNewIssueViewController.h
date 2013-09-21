//
//  AddNewIssueViewController.h
//  SoapBox
//
//  Created by Gregoire on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "LocChooseViewController.h"
#import <UIKit/UIKit.h>

@interface AddNewIssueViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImageView *pictureImageView;
@property (strong, nonatomic) UITextView *titleTextView;
@property (strong, nonatomic) UITextView *descriptionTextView;
@property (strong, nonatomic) UILabel *titleCounter;
@property (strong, nonatomic) UILabel *descriptionCounter;
@property (strong, nonatomic) UIScrollView *tagScrollView;
@property (strong, nonatomic) UIButton *addPhotoBtn;
@property (strong, nonatomic) UIButton *addTagBtn;
@property (strong, nonatomic) UIButton *addLocBtn;
@property (strong, nonatomic) NSMutableArray *tileArray;
@property (strong, nonatomic) LocChooseViewController *lcVC;
@property (nonatomic) BOOL tagsVisible;

@end
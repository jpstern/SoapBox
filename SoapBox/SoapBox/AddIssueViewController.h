//
//  AddIssueViewController.h
//  SoapBox
//
//  Created by Charley Hutchison on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddIssueViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic) UIImage *image;

@end

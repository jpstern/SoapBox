//
//  AddEmailViewController.h
//  SoapBox
//
//  Created by Charley Hutchison on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddEmailDelegate <NSObject>

@required - (void)finishedWithEmail:(NSString *)email body:(NSString *)body;
@required - (void)canceled;

@end

@interface AddEmailViewController : UIViewController

@property id <AddEmailDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

//
//  AddIssueViewController.m
//  SoapBox
//
//  Created by Charley Hutchison on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "AddIssueViewController.h"

@interface AddIssueViewController ()

@end


@implementation AddIssueViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.delegate = self;
    self.textView.delegate = self;
}

- (IBAction)takePhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:^{
        NSLog(@"Presented Picker");
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSLog(@"range");
    if ([textView.text length] > 140) {
        textView.text = [textView.text substringToIndex:139];
        return NO;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"range");
    if ([textField.text length] > 30) {
        textField.text = [textField.text substringToIndex:29];
        return NO;
    }
    return YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"info: %@", info);
    self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Dismissing View controller");
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Dismissing View COntroller");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

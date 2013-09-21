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

-(void)closeIssue {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)saveIssue:(UIButton *)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.descriptionTextField.delegate = self;
    self.titleTextField.delegate = self;
    self.titleTextField.tag = 1;
    self.descriptionTextField.tag = 2;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(closeIssue)];
}

- (IBAction)takePhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:^{
        NSLog(@"Presented Picker");
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"range");
    NSLog(@"String: %@", string);
    if ([[NSCharacterSet whitespaceAndNewlineCharacterSet] characterIsMember:[string characterAtIndex:0]]) {
        NSLog(@"Newline");
        [textField resignFirstResponder];
    }
    CGFloat maxLength = 30;
    if(textField.tag == 2){
        maxLength = 140;
    }
    
    if ([textField.text length] > maxLength) {
        textField.text = [textField.text substringToIndex:maxLength-1];
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

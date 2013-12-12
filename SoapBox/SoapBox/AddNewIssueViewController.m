//
//  AddNewIssueViewController.m
//  SoapBox
//
//  Created by Gregoire on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "AddNewIssueViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <dispatch/dispatch.h>

@interface AddNewIssueViewController ()

@end

#define KEYBOARDHEIGHT 216

@implementation AddNewIssueViewController
@synthesize pictureImageView, titleTextView, descriptionTextView;
@synthesize titleCounter, descriptionCounter;
@synthesize tagScrollView;
@synthesize tagsVisible;
@synthesize addPhotoBtn, addLocBtn, addTagBtn;
@synthesize tileArray;
@synthesize lcVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    if(self.lcVC.mapImage){
        [self.addLocBtn setBackgroundImage:lcVC.mapImage forState:UIControlStateNormal];
    }
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    return YES;
}

-(UIImage *)changeColorTo:(UIColor *)color fromImage:(UIImage *)image{
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    
    return flippedImage;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    float space = self.view.bounds.size.height - KEYBOARDHEIGHT;
    NSLog(@"%f", space);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
    
    lcVC = [[LocChooseViewController alloc] initWithNibName:@"LocChooseViewController" bundle:nil];
    tileArray = [[NSMutableArray alloc] init];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],                                                                   NSFontAttributeName: [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:25.0f]}];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [self.navigationItem setTitle:@"What's Your Issue?"];
    
    CGFloat offset = 55;
    CGFloat versionOffset = 0;
    CGFloat fontOffset = 0;
    if(IS_IPHONE_5){
        versionOffset += 30;
        fontOffset += 5;
    }
    titleTextView = [[UITextView alloc] initWithFrame:CGRectMake(70, 20+offset, 230, 60)];
    [titleTextView setReturnKeyType:UIReturnKeyDone];
    titleTextView.delegate = self;
    titleTextView.tag = 1;
    titleTextView.textColor = [UIColor lightGrayColor];
    titleTextView.text = @"Title...";
    [titleTextView setFont:[UIFont boldSystemFontOfSize:17.0+fontOffset]];
    
    descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(70, 90+offset, 230, 120+versionOffset)];
    [descriptionTextView setReturnKeyType:UIReturnKeyDone];
    descriptionTextView.delegate = self;
    descriptionTextView.tag = 2;
    descriptionTextView.textColor = [UIColor lightGrayColor];
    descriptionTextView.text = @"Description...";
    [descriptionTextView setFont:[UIFont systemFontOfSize:15.0+fontOffset]];
    
    titleCounter = [[UILabel alloc] initWithFrame:CGRectMake(20, 20+offset, 30, 60)];
    titleCounter.text = @"25";
    descriptionCounter = [[UILabel alloc] initWithFrame:CGRectMake(20, 90+offset, 30, 60)];
    descriptionCounter.text = @"100";
    
    UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(60, 20+offset, 4, DEVICEHEIGHT-300)];
    divider.backgroundColor = [UIColor blackColor];
    
    tagScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, DEVICEHEIGHT-244+offset, DEVICEWIDTH, DEVICEHEIGHT-244)];
    tagScrollView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTouched:)];
    [self.view addGestureRecognizer:tap];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"screen height %f", DEVICEHEIGHT);
    
    UIColor *secondaryColor = [UIColor lightGrayColor];
    UIView *buttonBackground = [[UIView alloc] initWithFrame:CGRectMake(0, DEVICEHEIGHT-260+offset, DEVICEWIDTH, 244)];
    buttonBackground.backgroundColor = secondaryColor;
    [self.view addSubview:buttonBackground];
    
    
    
    addPhotoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, DEVICEHEIGHT-260+offset, 160, 210)];
    addPhotoBtn.backgroundColor = secondaryColor;
    [addPhotoBtn addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [addPhotoBtn setTitle:@"Take a photo" forState:UIControlStateNormal];
    [addPhotoBtn setBackgroundColor:[UIColor lightGrayColor]];
    [addPhotoBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];

    
    
    addLocBtn = [[UIButton alloc] initWithFrame:CGRectMake(160, DEVICEHEIGHT-260+offset, 160, 210)];
    addLocBtn.backgroundColor = secondaryColor;
    [addLocBtn addTarget:self action:@selector(changeLocation) forControlEvents:UIControlEventTouchUpInside];
    [addLocBtn setTitle:@"Set the pin" forState:UIControlStateNormal];
    [addLocBtn setBackgroundColor:[UIColor grayColor]];
    [addLocBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    //ADD ALL THE IMAGES
    
    [self.view addSubview:tagScrollView];
    [self.view addSubview:titleTextView];
    [self.view addSubview:descriptionTextView];
    [self.view addSubview:titleCounter];
    [self.view addSubview:descriptionCounter];
    [self.view addSubview:divider];
    [self.view addSubview:tagScrollView];
    [self.view addSubview:addPhotoBtn];
    [self.view addSubview:addTagBtn];
    [self.view addSubview:addLocBtn];
    
    
    //changed to the check
    
    UIButton *addItem = [[UIButton alloc] initWithFrame:BARBUTTONFRAME];
    UIImage *check = [UIImage imageNamed:@"check@2x.png"];
    [addItem setImage:check forState:UIControlStateNormal];
    [addItem addTarget:self action:@selector(createItem) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *deny = [[UIButton alloc] initWithFrame:BARBUTTONFRAME];
    UIImage *cross = [UIImage imageNamed:@"cross@2x.png"];
    [deny setImage:cross forState:UIControlStateNormal];
    [deny addTarget:self action:@selector(cancelAdd) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barCross = [[UIBarButtonItem alloc] initWithCustomView:deny];
    self.navigationItem.leftBarButtonItem = barCross;
    
    UIBarButtonItem *accept = [[UIBarButtonItem alloc] initWithCustomView:addItem];
    self.navigationItem.rightBarButtonItem = accept;
    
    //[self generateTiles];
    
    tagsVisible = false;
    
    
    
}

-(void)changeLocation{
    
    UINavigationController *tmpNC = [[UINavigationController alloc] initWithRootViewController:lcVC];
    [self presentViewController:tmpNC animated:YES completion:nil];
}

- (void)cancelAdd{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createItem
{

    NSLog(@"\n\n\n titelview.text = |%i| \n\n\n", titleTextView.text == nil);
    //hacky fix lets find a better way
    if(titleTextView.text.length < 2 || [titleTextView.text isEqualToString:@"Title..."]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"You need a title with more than 2 characters"
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    //everythings good
    backgroundQueue = dispatch_queue_create("upload dispatch queue", NULL);
    dispatch_async(backgroundQueue, ^{
        PFObject *issue = [PFObject objectWithClassName:@"Issue"];
        NSData *data = UIImageJPEGRepresentation(addPhotoBtn.imageView.image, 0.05f);
        PFFile *imageFile = [PFFile fileWithName:@"image.png" data:data];
        [imageFile save];
        [issue setObject:imageFile forKey:@"Image"];
        
        PFGeoPoint *location = [PFGeoPoint geoPointWithLatitude:lcVC.coord.latitude longitude:lcVC.coord.longitude];
        [issue setObject:location forKey:@"Location"];
        [issue setObject:titleTextView.text forKey:@"Title"];
        [issue setObject:[[PFUser currentUser] objectForKey:@"facebookID"] forKey:@"userFacebookID"];
        [issue setObject:descriptionTextView.text forKey:@"Description"];
        [issue saveInBackgroundWithBlock:^(BOOL success, NSError *error) {
            if (success) {
                [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];

                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                NSLog(@"\n\n%@\n\n", [error localizedDescription]);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Something went wrong"
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];

    });
    
    
}

- (void)dealloc {
    
}

- (void)takePhoto
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing = true;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(UIColor*) inverseColor: (UIColor *)color
{
    CGFloat r,g,b,a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    return [UIColor colorWithRed:1.-r green:1.-g blue:1.-b alpha:a];
}




- (IBAction)chooseTag:(UIButton*)sender
{
    if(sender.backgroundColor == [UIColor whiteColor]){
        [sender setBackgroundColor:[UIColor greenColor]];
    }
    else{
        [sender setBackgroundColor:[UIColor whiteColor]];
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"got picture");
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    [addPhotoBtn setImage:image forState:UIControlStateNormal];
}


- (IBAction)backgroundTouched:(id)sender
{
    NSLog(@"dsfasd");
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) textViewDidEndEditing:(UITextView *)textView{
    if (textView.tag == 1) {
        if([textView.text isEqualToString:@""]){
            textView.text = @"Title...";
            textView.textColor = [UIColor lightGrayColor];
        }
    } else {
        if([textView.text isEqualToString:@""]){
            textView.text = @"Description...";
            textView.textColor = [UIColor lightGrayColor];
        }
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView.tag == 1) {
        if([textView.text isEqualToString:@"Title..."]){
            textView.text = @"";
            textView.textColor = [UIColor blackColor];
        }
    } else {
        if([textView.text isEqualToString:@"Description..."]){
            textView.text = @"";
            textView.textColor = [UIColor blackColor];
        }
    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    
    if (textView.tag == 1) {
        if (textView.text.length <= 25) {
            unsigned long length = textView.text.length;
            if([text isEqualToString:@""] ){
                if(textView.text.length == 0 ){
                  return false;
                }
                if(textView.text.length == 25){
                    titleCounter.text = [NSString stringWithFormat:@"%i",1];
                    return true;
                }
                length-=2;
            }
            if(textView.text.length == 25){
                return false;
            }
            titleCounter.text = [NSString stringWithFormat:@"%lu", 25 - length-1];
            return true;
        }
        else {
            return false;
        }
    }
    else {
        if (textView.text.length <= 100) {
            int length = textView.text.length;
            if([text isEqualToString:@""] ){
                if(textView.text.length == 0 ){
                    return false;
                }
                if(textView.text.length == 100){
                    descriptionCounter.text = [NSString stringWithFormat:@"%i",1];
                    return true;
                }
                length-=2;
            }
            if(textView.text.length == 100){
                return false;
            }
            descriptionCounter.text = [NSString stringWithFormat:@"%d", 100 - length -1];
            return true;
        } else {
            return false;
        }
    }
}

@end

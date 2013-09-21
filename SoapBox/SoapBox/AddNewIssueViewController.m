//
//  AddNewIssueViewController.m
//  SoapBox
//
//  Created by Gregoire on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "AddNewIssueViewController.h"
#import <QuartzCore/QuartzCore.h>

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

- (void)viewWillAppear:(BOOL)animated
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
    
    self.navigationItem.title = @"What's Your Issue?";
    
    CGFloat offset = 55;
    titleTextView = [[UITextView alloc] initWithFrame:CGRectMake(70, 20+offset, 230, 60)];
    [titleTextView setReturnKeyType:UIReturnKeyDone];
    titleTextView.delegate = self;
    titleTextView.tag = 1;
    titleTextView.textColor = [UIColor lightGrayColor];
    titleTextView.text = @"Title...";
    [titleTextView setFont:[UIFont boldSystemFontOfSize:22.0]];
    
    descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(70, 90+offset, 230, 150)];
    [descriptionTextView setReturnKeyType:UIReturnKeyDone];
    descriptionTextView.delegate = self;
    descriptionTextView.tag = 2;
    descriptionTextView.textColor = [UIColor lightGrayColor];
    descriptionTextView.text = @"Description...";
    [descriptionTextView setFont:[UIFont systemFontOfSize:20.0]];
    
    titleCounter = [[UILabel alloc] initWithFrame:CGRectMake(20, 20+offset, 30, 60)];
    titleCounter.text = @"30";
    descriptionCounter = [[UILabel alloc] initWithFrame:CGRectMake(20, 90+offset, 30, 60)];
    descriptionCounter.text = @"130";
    
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
    
    
    
    addPhotoBtn = [[UIButton alloc] initWithFrame:CGRectMake(25, DEVICEHEIGHT-229+offset, 150, 150)];
    addPhotoBtn.backgroundColor = secondaryColor;
    [addPhotoBtn addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    UIImage *photoImage = [self changeColorTo:[UIColor darkGrayColor] fromImage:[UIImage imageNamed:@"camera-white.png"]];
    [addPhotoBtn setBackgroundImage:[UIImage imageNamed:@"camera-white.png"] forState:UIControlStateHighlighted];
    [addPhotoBtn setBackgroundImage:photoImage forState:UIControlStateNormal];
    
    
    addLocBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, DEVICEHEIGHT-244+offset, 120, 100)];
    addLocBtn.backgroundColor = secondaryColor;
    [addLocBtn addTarget:self action:@selector(changeLocation) forControlEvents:UIControlEventTouchUpInside];
    UIImage *locImage = [self changeColorTo:[UIColor darkGrayColor]  fromImage:[UIImage imageNamed:@"pin-black.png.png"]];
    [addLocBtn setBackgroundImage:[UIImage imageNamed:@"pin-black.png"] forState:UIControlStateHighlighted];
    [addLocBtn setBackgroundImage:locImage forState:UIControlStateNormal];
    
    addTagBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, DEVICEHEIGHT-144+offset, 120, 100)];
    addTagBtn.backgroundColor = secondaryColor;
    [addTagBtn addTarget:self action:@selector(displayTags:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *tagPhoto = [self changeColorTo:[UIColor darkGrayColor] fromImage:[UIImage imageNamed:@"tag-flat.png"]];
    [addTagBtn setBackgroundImage:[UIImage imageNamed:@"tag-flat.png"] forState:UIControlStateHighlighted];
    [addTagBtn setBackgroundImage:tagPhoto forState:UIControlStateNormal];
    
    //[addTagBtn setTitle:@"Add\ntag" forState:UIControlStateNormal];
    //[addLocBtn setTitle:@"Current\nLocation" forState:UIControlStateNormal];
    //[addPhotoBtn setTitle:@"Take a pic" forState:UIControlStateNormal];
    
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
    //why do both of these create item????
    
    UIButton *addItem = [[UIButton alloc] initWithFrame:BARBUTTONFRAME];
    UIImage *check = [UIImage imageNamed:@"check@2x.png"];
    [addItem setImage:check forState:UIControlStateNormal];
    [addItem addTarget:self action:@selector(createItem) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *deny = [[UIButton alloc] initWithFrame:BARBUTTONFRAME];
    UIImage *cross = [UIImage imageNamed:@"cross@2x.png"];
    [deny setImage:cross forState:UIControlStateNormal];
    [deny addTarget:self action:@selector(cancelAdd) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barCross = [[UIBarButtonItem alloc] initWithCustomView:deny];
    self.navigationItem.rightBarButtonItem = barCross;
    
    UIBarButtonItem *accept = [[UIBarButtonItem alloc] initWithCustomView:addItem];
    self.navigationItem.leftBarButtonItem = accept;
    
    [self generateTiles];
    
    tagsVisible = false;
    
    
    
}

-(void)changeLocation{
    
    UINavigationController *tmpNC = [[UINavigationController alloc] initWithRootViewController:lcVC];
    [self presentViewController:tmpNC animated:YES completion:nil];
}

- (void)cancelAdd{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createItem
{
    NSLog(@"\n\n\n titelview.text = |%i| \n\n\n", titleTextView.text == nil);
    if (!addPhotoBtn.imageView.image) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"You need a picture."
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    //hacky fix lets find a better way
    if(titleTextView.text.length < 2 || [titleTextView.text isEqualToString:@"Title..."]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"You need a title with more than 2 characters"
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    //everythings good
    PFObject *issue = [PFObject objectWithClassName:@"Issue"];
    NSData *data = UIImageJPEGRepresentation(addPhotoBtn.imageView.image, 0.05f);
    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:data];
    [imageFile save];
    [issue setObject:imageFile forKey:@"Image"];
    
    PFGeoPoint *location = [PFGeoPoint geoPointWithLatitude:lcVC.coord.latitude longitude:lcVC.coord.longitude];
    [issue setObject:location forKey:@"Location"];
    [issue setObject:[PFUser currentUser] forKey:@"User"];
    [issue setObject:titleTextView.text forKey:@"Title"];
    [issue setObject:descriptionTextView.text forKey:@"Description"];
    [issue saveInBackgroundWithBlock:^(BOOL success, NSError *error) {
        if (success) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSLog(@"%@", [error localizedDescription]);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Something went wrong"
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    
    
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


- (void)generateTiles
{
    /*
    int i = 0;
    int j = 0;
    for (NSString *key in [Category categories]) {
        
        UIButton *tile = [[UIButton alloc] initWithFrame:CGRectMake(j*80, i*77 + 9, 80, 77)];
        [tile addTarget:self action:@selector(chooseTag:) forControlEvents:UIControlEventTouchUpInside];
        tile.alpha = 0;
        Category *value = [[Category categories] objectForKey:key];
        tile.backgroundColor = value.color;
        [tile setTitle:value.name forState:UIControlStateNormal];
        [tile setTitleColor:[self inverseColor:value.color] forState:UIControlStateNormal];
        [tile.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [tagScrollView addSubview:tile];
        [tileArray addObject:tile];
        j++;
        if(j%4 ==0){
            j = 0;
            i++;
        }
    }
     */
}


- (IBAction)chooseTag:(UIButton*)sender
{
    //addTagBtn.backgroundColor = sender.backgroundColor;
    UIImage *img = [self changeColorTo:sender.backgroundColor fromImage:[UIImage imageNamed:@"tag-flat.png"]];
    [addTagBtn setBackgroundImage:img forState:UIControlStateNormal];
    [self displayTags:nil];
}

- (void)showOrHideTiles:(BOOL)show
{
    srand(time(NULL));
    int i = 0;
    NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:tileArray];
    while (tmpArray.count > 0) {
        int index = rand() % tmpArray.count;
        UIView *tmp = [tmpArray objectAtIndex:index];
        [tmpArray removeObject:tmp];
        i++;
        [UIView animateWithDuration:0.5 delay:0.005 + 0.05*i options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            tmp.alpha = show;
        }completion:nil];
        
    }
}

- (IBAction)displayTags:(id)sender
{
    NSLog(@"dsfsd");
    if (tagsVisible) {
        [UIView animateWithDuration:0.005 delay:1.5 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            tagScrollView.center = CGPointMake(tagScrollView.center.x, tagScrollView.center.y+tagScrollView.frame.size.height);
        } completion:nil];
        tagsVisible = false;
        [self showOrHideTiles:false];
    } else {
        [UIView animateWithDuration:0.005 delay:0.005 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            tagScrollView.center = CGPointMake(tagScrollView.center.x, tagScrollView.center.y-tagScrollView.frame.size.height);
        } completion:nil];
        tagsVisible = true;
        [self showOrHideTiles:true];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"got picture");
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [addPhotoBtn setImage:image forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
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
            textView.textColor = [UIColor blackColor];
        }
    } else {
        if([textView.text isEqualToString:@""]){
            textView.text = @"Description...";
            textView.textColor = [UIColor blackColor];
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
        if (textView.text.length < 30) {
            titleCounter.text = [NSString stringWithFormat:@"%i", 30 - textView.text.length];
            return true;
        } else {
            return false;
        }
    } else {
        if (textView.text.length < 130) {
            descriptionCounter.text = [NSString stringWithFormat:@"%i", 130 - textView.text.length];
            return true;
        } else {
            return false;
        }
    }
}

@end

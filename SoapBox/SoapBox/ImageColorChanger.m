//
//  ImageColorChanger.m
//  SoapBox
//
//  Created by Gregoire on 12/3/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "ImageColorChanger.h"

@implementation ImageColorChanger


-(id) init{
    
    if(self = [super init]){
        //add init code here
    }
    
    return self;
}


-(void) changeImage:(UIImage *)image toColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    self.image = flippedImage;
}

@end

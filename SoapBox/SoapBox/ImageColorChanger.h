//
//  ImageColorChanger.h
//  SoapBox
//
//  Created by Gregoire on 12/3/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageColorChanger : NSObject

@property (nonatomic, strong) UIImage *image;

-(void) changeImage:(UIImage *)image toColor:(UIColor *)color;

@end

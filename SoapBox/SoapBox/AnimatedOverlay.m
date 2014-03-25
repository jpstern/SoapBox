//
//  AnimatedOverlay.m
//  SoapBox
//
//  Created by Gregoire on 12/1/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "AnimatedOverlay.h"

#define MAX_RATIO 1.7
#define MIN_RATIO 0.01
#define STEP_RATIO 0.05

#define ANIMATION_DURATION 3

//repeat forever
#define ANIMATION_REPEAT HUGE_VALF

@implementation AnimatedOverlay

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) startAnimating{
    //create the image
    self.image = [UIImage imageNamed:@"circle.png"];
    
    UIColor *colorForAnimation;
    double metric = [self.circle.title doubleValue];
    
    if(metric >= RED){
        colorForAnimation = [UIColor redColor];
    }
    else if(metric >= ORANGE){
        colorForAnimation = [UIColor orangeColor];
    }
    else if(metric >= YELLOW){
        colorForAnimation = [UIColor yellowColor];
    }
    else if (metric >= GREEN){
        colorForAnimation = [UIColor greenColor];
    }
    else if (metric >= BLUE){
        colorForAnimation = [UIColor blueColor];
    }
    else{
        colorForAnimation = [UIColor cyanColor];
    }
    
    //image color change
    
    CGRect rect = CGRectMake(0, 0, self.image.size.width, self.image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, self.image.CGImage);
    CGContextSetFillColorWithColor(context, [colorForAnimation CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    self.image = flippedImage;
    
    
    //opacity animation setup
    CABasicAnimation *opacityAnimation;
    
    opacityAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = ANIMATION_DURATION;
    opacityAnimation.repeatCount = ANIMATION_REPEAT;
    //theAnimation.autoreverses=YES;
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0.85];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.15];
    
    //resize animation setup
    CABasicAnimation *transformAnimation;
    
    transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    transformAnimation.duration = ANIMATION_DURATION;
    transformAnimation.repeatCount = ANIMATION_REPEAT;
    //transformAnimation.autoreverses=YES;
    transformAnimation.fromValue = [NSNumber numberWithFloat:MIN_RATIO];
    transformAnimation.toValue = [NSNumber numberWithFloat:MAX_RATIO];
    
    
    //group the two animation
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    group.repeatCount = ANIMATION_REPEAT;
    [group setAnimations:[NSArray arrayWithObjects:opacityAnimation, transformAnimation, nil]];
    group.duration = ANIMATION_DURATION;
    
    //apply the grouped animaton
    [self.layer addAnimation:group forKey:@"groupAnimation"];
}

-(void)stopAnimating{
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

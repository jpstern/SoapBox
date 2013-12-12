//
//  CustomCell.m
//  SoapBox
//
//  Created by Jackson on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize title, trend, accessoryView, image;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initalize];
    }
    return self;
}


-(void)awakeFromNib {
    [super awakeFromNib];
    [self initalize];
}

-(void) initalize {
    [self.trend.layer setCornerRadius:self.trend.frame.size.width/2];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

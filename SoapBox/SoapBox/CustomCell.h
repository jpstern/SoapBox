//
//  CustomCell.h
//  SoapBox
//
//  Created by Jackson on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Issue.h"

@interface CustomCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *image;
@property (nonatomic, strong) IBOutlet UILabel *trend;
@property (nonatomic, strong) IBOutlet UILabel *title;
@property (nonatomic, strong) Issue *issue;

@end

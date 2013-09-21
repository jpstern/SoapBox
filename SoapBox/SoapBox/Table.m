//
//  Table.m
//  SoapBox
//
//  Created by Jackson on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "Table.h"

@interface Table () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation Table

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  
  [mainMenu setFrame:CGRectMake(0, 0, [self view].frame.size.width, [self view].frame.size.height)];
  [mainMenu setBackgroundColor: [UIColor clearColor] ];
  menuItems = [[NSArray alloc] initWithObjects:@"Your Issues", @"Friends Issues", @"Settings", @"About", nil];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//----------------------------------------------------------------
//          UITableView Datasource and Delegate methods
//________________________________________________________________
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  // Return the number of rows in the section.
  return [menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  // Configure the cell in each row
  
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell;
  
  cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  // Configure the cell... setting the text of our cell's label
  cell.textLabel.text = [menuItems objectAtIndex:indexPath.row];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
}

@end

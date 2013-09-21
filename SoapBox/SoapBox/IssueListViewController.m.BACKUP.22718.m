//
//  IssueListViewController.m
//  SoapBox
//
//  Created by Charley Hutchison on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "IssueListViewController.h"

@interface IssueListViewController ()

@end

@implementation IssueListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
  [self.navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
  [[self tableView] setBackgroundColor:[UIColor colorWithRed:31.0/255 green:31.0/255 blue:31.0/255 alpha:1.0]];
  [[self tableView] setSeparatorColor:[UIColor blackColor]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.issues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
      NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
      cell = [nib objectAtIndex:0];
    }
    Issue *issue = [self.issues objectAtIndex:indexPath.row];
<<<<<<< HEAD
    //cell.textLabel.text = issue.title;
    
=======
  
  // title of the issue.
  [cell.title setText: issue.title];
  [cell.title setTextColor:[UIColor yellowColor]];

  // description of the issue.
  [cell.description setTextColor:[UIColor yellowColor]];
  [cell.description setText: issue.description];
  if ([[cell.description text] length] > 50) {
    NSRange range = [[cell.description text] rangeOfComposedCharacterSequencesForRange:(NSRange){0, 50}];
    [cell.description setText: [[cell.description text] substringWithRange:range]];
    [cell.description setText: [[cell.description text] stringByAppendingString:@" …"]];
  }
  
  // friend who supports the issue (if "friends issues" was selected)
  [cell.fromFriend setTextColor:[UIColor yellowColor]];
  [cell.fromFriend setText:@"Friend's Name"];
  
  [cell.trend setBackgroundColor:[UIColor darkGrayColor]];
  [cell setBackgroundColor:[UIColor clearColor]];
>>>>>>> 7f0cbb1843d7a76acb52e0c8a212640ec630da2e
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self.title isEqualToString:@"My Issues"]) {
    PFQuery *query = [[PFQuery alloc] initWithClassName:@"Issue"];
    [query whereKey:@"User" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"Objects: %@, Error: %@", objects, error);
        NSMutableArray *array = [NSMutableArray array];
        for (PFObject *object in objects) {
            Issue *newIssue = [[Issue alloc] init];
            PFGeoPoint *geoPoint = [object valueForKey:@"Location"];
            newIssue.location = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
            newIssue.title = [object valueForKey:@"Title"];
            newIssue.description = [object valueForKey:@"Description"];
            newIssue.image = [object valueForKey:@"Image"];
            NSLog(@"Issue: %@", newIssue);
            [array addObject:newIssue];
        }
        self.issues = array;
        [self.tableView reloadData];
    }];
    }
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    IssueViewController *detailViewController = [[IssueViewController alloc] initWithNibName:@"IssueViewController" bundle:nil];

    // Pass the selected object to the new view controller.
    detailViewController.issue = [self.issues objectAtIndex:indexPath.row];
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 

@end

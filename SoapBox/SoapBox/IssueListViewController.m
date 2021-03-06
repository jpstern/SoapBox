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
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:20.0], NSFontAttributeName,nil] forState:UIControlStateNormal];
  [[self tableView] setBackgroundColor:[UIColor colorWithRed:31.0/255 green:31.0/255 blue:31.0/255 alpha:1.0]];
  [[self tableView] setSeparatorColor:[UIColor blackColor]];
  
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
          NSNumber *number = [object valueForKey:@"Alchemy"];
          newIssue.metric =  [number intValue];
        newIssue.description = [object valueForKey:@"Description"];
        PFFile *file = [object valueForKey:@"Image"];
          newIssue.image = [UIImage imageWithData:file.getData];
        NSLog(@"Issue: %@", newIssue);
        [array addObject:newIssue];
      }
      self.issues = array;
      [self.tableView reloadData];
    }];
  }
  else if ([self.title isEqualToString:@"Friend's Issues"]) {
      NSString *query = @"SELECT uid, name, pic_square, mutual_friend_count, is_app_user FROM user WHERE uid IN "
      @"(SELECT uid2 FROM friend WHERE uid1 = me()) ORDER BY mutual_friend_count";
      NSDictionary *queryParam = @{ @"q": query };
      [FBRequestConnection startWithGraphPath:@"/fql" parameters:queryParam HTTPMethod:@"GET" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
          NSLog(@"Results: %@, %@", result, [result class]);
          NSArray *array = (NSArray *)result[@"data"];
          NSLog(@"%@", [[array objectAtIndex:0] class]);
          NSMutableArray *uidArray = [NSMutableArray array];
          for (FBGraphObject *object in array) {
              [uidArray addObject:object[@"uid"]];
          }
          PFQuery *dbQuery = [[PFQuery alloc] initWithClassName:@"Issue"];
          [dbQuery whereKey:@"authData" containedIn:uidArray];
          [dbQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
              NSLog(@"Objects: %@", objects);
              NSMutableArray *newArray = [NSMutableArray array];
              for (PFObject *object in objects) {
                  Issue *newIssue = [[Issue alloc] init];
                  PFGeoPoint *geoPoint = [object valueForKey:@"Location"];
                  newIssue.location = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
                  newIssue.title = [object valueForKey:@"Title"];
                  newIssue.metric = [(NSNumber *)[object valueForKey:@"Alchemy"] intValue];
                  newIssue.description = [object valueForKey:@"Description"];
                  PFFile *file = [object valueForKey:@"Image"];
                  newIssue.image = [UIImage imageWithData:file.getData];
                  NSLog(@"Issue: %@", newIssue);
                  [newArray addObject:newIssue];
              }
              self.issues = newArray;
              [self.tableView reloadData];

          }];
      }];
  }
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
      [cell.image.layer setBorderWidth:2];
      [cell.image.layer setCornerRadius:5];
      [cell.image.layer setBorderColor:[UIColor whiteColor].CGColor];
      [cell.image.layer setMasksToBounds:YES];
    }
    Issue *issue = [self.issues objectAtIndex:indexPath.row];
  
  // title of the issue.
  [cell.title setText: issue.title];
  [cell.title setTextColor:[UIColor yellowColor]];
    
   //set color trend
    if(issue.metric >= RED){
        [cell.trend setBackgroundColor:[UIColor redColor]];
    }
    else if(issue.metric >= ORANGE){
        [cell.trend setBackgroundColor:[UIColor orangeColor]];
    }
    else if(issue.metric >=YELLOW){
        [cell.trend setBackgroundColor:[UIColor yellowColor]];
    }
    else if(issue.metric >= GREEN){
        [cell.trend setBackgroundColor:[UIColor greenColor]];
    }
    else{
        [cell.trend setBackgroundColor:[UIColor blueColor]];
    }

  // description of the issue.
  [cell.description setTextColor:[UIColor yellowColor]];
  [cell.description setText: issue.description];
  if ([[cell.description text] length] > 50) {
    NSRange range = [[cell.description text] rangeOfComposedCharacterSequencesForRange:(NSRange){0, 50}];
    [cell.description setText: [[cell.description text] substringWithRange:range]];
    [cell.description setText: [[cell.description text] stringByAppendingString:@" …"]];
  }
  
  // image from the issue
  [[cell image] setImage:issue.image];
  
  // friend who supports the issue (if "friends issues" was selected)
  [cell.fromFriend setTextColor:[UIColor yellowColor]];
  [cell.fromFriend setText:@"Friend's Name"];
  
  [cell.trend setBackgroundColor:[UIColor darkGrayColor]];
  [cell setBackgroundColor:[UIColor clearColor]];
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


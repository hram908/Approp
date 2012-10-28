//
//  AppropDetailViewController.m
//  Approp
//
//  Created by Dianna Mertz on 10/20/12.
//  Copyright (c) 2012 Dianna Mertz. All rights reserved.
//

#import "AppropReferenceController.h"
#import "AppropViewController.h"
#import "AppropAppDelegate.h"

@interface AppropReferenceController()
@end

@implementation AppropReferenceController

@synthesize paintingsArray;
@synthesize tableView = _tableView;


-(void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview
    [super didReceiveMemoryWarning];
    
}

// Method to load the paintings array from the plist
- (void)loadPaintings {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"paintings" ofType:@"plist"];
    self.paintingsArray = [NSArray arrayWithContentsOfFile:path];
    [self.tableView reloadData];
}


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    }
    return self;
}

- (void)viewDidLoad
{
    // Load the data from the plist
    
    [self loadPaintings];
    

    [super viewDidLoad];
}

// Method for the toolbar button
-(IBAction) usebackButton: (id) sender {
    [self dismissModalViewControllerAnimated:YES];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
   
}


#pragma mark - Table view data source

// Increase the height of each cell a bit more than the default
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 68;
}

// Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

// Call the paintings.plist count to allocate the number of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"number of rows = %d", self.paintingsArray.count);
    
    return self.paintingsArray.count;
    
}

// Describe the cell and populate table
- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)
indexPath {
    // Cell
    NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:nil];
        cell.textLabel.textColor = [UIColor colorWithRed:0.6f green:0.7f blue:0.8f alpha:1.0f];
    }
    // Call the info from the paintings.plist and distribute to cells
    NSDictionary *paintingsInfo = [self.paintingsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [paintingsInfo objectForKey:@"name"];
    cell.detailTextLabel.text = [paintingsInfo objectForKey:@"link"];
    UIImage *image = [UIImage imageNamed:[paintingsInfo objectForKey:@"image"]];
    cell.imageView.image = image;
    
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
 
 
 #pragma mark - Table view delegate
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Navigation logic may go here. Create and push another view controller.
 }
 
 -(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowsAtIndexPath:(NSIndexPath *)indexPath
 {
 return UITableViewCellEditingStyleDelete;
 }
 */



@end

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

@implementation AppropReferenceController

// Method to load the paintings array from the plist
- (void)loadPaintings {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"paintings" ofType:@"plist"];
    self.paintingsArray = [NSArray arrayWithContentsOfFile:path];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    // Load the data from the plist
    [self loadPaintings];
    [super viewDidLoad];
}

#pragma mark - Table view data source

// Call the paintings.plist count to allocate the number of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //NSLog(@"number of rows = %d", self.paintingsArray.count);
    
    return self.paintingsArray.count;
}

// Describe the cell and populate table
- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)
indexPath {
    // Cell
    NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:cellIdentifier];
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

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"Accessory Section #%i Row #%i", indexPath.section, indexPath.row);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0 && indexPath.row==0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://en.wikipedia.org/wiki/File:Caravaggio_-_Fanciullo_con_canestro_di_frutta.jpg"]];
    }
        else if(indexPath.section==0 && indexPath.row==1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://en.wikipedia.org/wiki/File:Lucas_Cranach_the_Elder-Adam_and_Eve_1533.jpg"]];
        }
        else if(indexPath.section==0 && indexPath.row==2) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://en.wikipedia.org/wiki/File:Hans_Holbein_the_Younger_-_The_Ambassadors_-_Google_Art_Project.jpg"]];
        
        }
        else if(indexPath.section==0 && indexPath.row==3) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://en.wikipedia.org/wiki/File:%C3%89douard_Manet_-_Le_D%C3%A9jeuner_sur_l%27herbe.jpg"]];
            
        }
        else if(indexPath.section==0 && indexPath.row==4) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://en.wikipedia.org/wiki/File:Creaci%C3%B3n_de_Ad%C3%A1n.jpg"]];
            
        }
}

@end

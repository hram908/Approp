//
//  AppropRefController.m
//  Approp
//
//  Created by Dianna Mertz on 11/2/12.
//  Copyright (c) 2012 Dianna Mertz. All rights reserved.
//

#import "AppropRefController.h"


@interface AppropRefController ()

@end

@implementation AppropRefController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return self.paintingsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Cell
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
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

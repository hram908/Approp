//
//  AppropDetailViewController.h
//  Approp
//
//  Created by Dianna Mertz on 10/20/12.
//  Copyright (c) 2012 Dianna Mertz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "AppropViewController.h"

@interface AppropReferenceController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSArray *paintingsArray;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end

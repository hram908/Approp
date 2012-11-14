//
//  AppropMasterViewController.h
//  Approp
//
//  Created by Dianna Mertz on 10/20/12.
//  Copyright (c) 2012 Dianna Mertz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface AppropViewController : UIViewController <UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,UIPopoverControllerDelegate, UIActionSheetDelegate, UITableViewDelegate>
{
    BOOL newMedia;
}

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIPopoverController *popover;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) UIActionSheet *shareSheet;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *canvasButton;
@property (nonatomic, strong) UIBarButtonItem *cameraButton;
@property (nonatomic, strong) UIBarButtonItem *cameraRollButton;
@property (nonatomic, strong) UIBarButtonItem *shareButton;

- (IBAction)useCamera:(id)sender;
- (IBAction)useCameraRoll:(id)sender;
- (IBAction)useCanvasButton:(id)sender;
- (IBAction)useShareButton:(id)sender;

@end

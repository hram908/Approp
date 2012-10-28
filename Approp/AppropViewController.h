//
//  AppropMasterViewController.h
//  Approp
//
//  Created by Dianna Mertz on 10/20/12.
//  Copyright (c) 2012 Dianna Mertz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@class AppropReferenceController;

@interface AppropViewController : UIViewController <UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,UIPopoverControllerDelegate, UIActionSheetDelegate, UITableViewDelegate>
{
    BOOL newMedia;
}

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIPopoverController *popoverController;
//@property (nonatomic, strong) IBOutlet UIToolbar *toolbar;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) UIActionSheet *shareSheet;
@property (nonatomic, strong) UIBarButtonItem *canvasButton;
@property (nonatomic, strong) UIBarButtonItem *cameraButton;
@property (nonatomic, strong) UIBarButtonItem *cameraRollButton;
@property (nonatomic, strong) UIBarButtonItem *shareButton;
@property (nonatomic, strong) UIBarButtonItem *referenceButton;



- (IBAction)useCamera:(id)sender;
- (IBAction)useCameraRoll:(id)sender;
- (IBAction)useCanvasButton:(id)sender;
- (IBAction)useShareButton:(id)sender;
- (IBAction)useReferenceButton:(id)sender;

@end

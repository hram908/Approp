//
//  AppropMasterViewController.m
//  Approp
//
//  Created by Dianna Mertz on 10/20/12.
//  Copyright (c) 2012 Dianna Mertz. All rights reserved.
//

#import "AppropViewController.h"
#import "SHK.h"
#import "SHKActionSheet.h"
#import "SHKFacebook.h"
#import "SHKItem.h"
#import "AppropAppDelegate.h"

@interface AppropViewController()
@end

@implementation AppropViewController


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


- (void)viewDidLoad
{   
    [super viewDidLoad];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.imageView.image)
    {
        // Use a block here so that the image doesn't hiccup
        __block UIImage *image = self.imageView.image;
        dispatch_async(dispatch_queue_create("com.doubledi", NULL),^(void) {
            
            NSData *imageData = UIImagePNGRepresentation(image);
            [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"imageData"];
        }
        );
    
    }
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *imageData = [defaults objectForKey:@"imageData"];
    if(imageData && !self.imageView.image)
    {
        self.imageView.image = [UIImage imageWithData:imageData];
    }
    [super viewDidAppear:animated];
    
}

#pragma mark - Canvas Button

- (IBAction) useCamera: (id)sender{
    if([UIImagePickerController isSourceTypeAvailable:
        UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (NSString *) kUTTypeImage,
                                  nil];
        imagePicker.allowsEditing = NO;
        [self presentModalViewController:imagePicker
                                animated:YES];
        newMedia = YES;
    }
}


-(IBAction)useCameraRoll:(id)sender {
    
    // For iPad
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if ([self.popover isPopoverVisible]) {
            [self.popover dismissPopoverAnimated:YES];
        } else {
            if ([UIImagePickerController isSourceTypeAvailable:
                 UIImagePickerControllerSourceTypeSavedPhotosAlbum])
            {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePicker.mediaTypes = [NSArray arrayWithObjects: (NSString *) kUTTypeImage, nil];
                imagePicker.allowsEditing = NO;
                self.popover = [[UIPopoverController alloc]
                                          initWithContentViewController:imagePicker];
                _popover.delegate = self;
                [self.popover presentPopoverFromBarButtonItem:self.canvasButton permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                //[self.popover presentPopoverFromRect:CGRectMake(20,200,300,300) inView:self.view  permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES ];
                newMedia = NO;
            }
        }
    } else {
    
        // For iPhone
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.mediaTypes = [NSArray arrayWithObjects: (NSString *) kUTTypeImage, nil];
            imagePicker.allowsEditing = NO;
            [self presentModalViewController:imagePicker animated:YES];
            newMedia = NO;
        }
    }
}


// Method for calling the canvas button action sheet
-(IBAction) useCanvasButton:(id)sender {
    if (self.actionSheet) {
        [self.actionSheet dismissWithClickedButtonIndex:-1 animated:YES];
        self.actionSheet = nil;
        return;
    }
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"Canvas" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", nil];
    self.actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [self.actionSheet showFromBarButtonItem:sender animated:YES];
}

// Method for making the selection in the canvas button action sheet
- (void)actionSheet:(UIActionSheet *)actSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *choice = [self.actionSheet buttonTitleAtIndex:buttonIndex];
    if( [choice isEqualToString:@"Camera"] ){
        [self useCamera:self.canvasButton];
    } else if( [choice isEqualToString:@"Photo Library"] ){
        [self useCameraRoll:self.canvasButton];
    }
}

// Dismiss canvas button action sheet
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    self.actionSheet = nil;
}

// Choose and Load the image from the library
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // For iPad
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.view.window != nil) {
        [self.popover dismissPopoverAnimated:true];
        }
    }
    [picker dismissModalViewControllerAnimated:YES];
    picker = nil;
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    // Keep aspect ration in tact between iPhone and iPad
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        // Assume the image is in portrait mode
        UIImage * PortraitImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        // But if not portrait mode, turn to landscape
        if (PortraitImage.size.width > PortraitImage.size.height) {
            UIImage * LandscapeImage =
            [[UIImage alloc] initWithCGImage: PortraitImage.CGImage
                                       scale: 1.0
                                 orientation: UIImageOrientationRight];
            self.imageView.image = LandscapeImage;
            if (newMedia)
                UIImageWriteToSavedPhotosAlbum(LandscapeImage,
                                               self,
                                               @selector(image:finishedSavingWithError:contextInfo:),
                                               nil);
        }
        else {
            self.imageView.image = PortraitImage;
        }
        if (newMedia)
            UIImageWriteToSavedPhotosAlbum(PortraitImage,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
}

// Method for a problem saving
-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Save failed"
                              message: @"Failed to save image"\
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}


#pragma mark - Share Button

// Method for share button action sheet
-(IBAction) useShareButton: (id) sender {
	SHKItem *item = [SHKItem image:_imageView.image title:@"Appropriator"];
	SHKActionSheet *sharedSheet = [SHKActionSheet actionSheetForItem:item];
	[SHK setRootViewController:self];
    sharedSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [sharedSheet showFromBarButtonItem:sender animated:YES];
}


#pragma mark: overandout

- (void)viewDidUnload {
    self.imageView = nil;
    self.popover = nil;
}


@end

//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by Rahim Sonawalla on 4/26/14.
//  Copyright (c) 2014 Hi Rahim. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation BNRDetailViewController

- (IBAction)takePicture:(id)sender
{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'Source type must be UIImagePickerControllerSourceTypeCamera'
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        
        UIImage *crossLine = [UIImage imageNamed:@"cross"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:crossLine];
        
        // if being lazy and not willing to find a cross png
//        CGFloat width = imagePicker.cameraOverlayView.bounds.size.width;
//        CGFloat height = imagePicker.cameraOverlayView.bounds.size.height;
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
//        label.text = @"+";
//
//        UIView *crossView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, width, height)];
//        [label setCenter:crossView.center];
//        [crossView addSubview:label];
        
        
        [imagePicker.cameraOverlayView addSubview:imageView];
        imageView.center = imagePicker.cameraOverlayView.center;
        
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;

    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    
    self.imageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BNRItem *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    static NSDateFormatter *dateFormatter = nil;
    
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
    NSString *itemKey = self.item.itemKey;
    
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:itemKey];
    
    self.imageView.image = imageToDisplay;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}


- (IBAction)deleteItemPhoto:(UIBarButtonItem *)sender
{
    NSString *key = self.item.itemKey;
    [[BNRImageStore sharedStore] deleteImageForKey:key];
    
    self.imageView.image = nil;
}
@end

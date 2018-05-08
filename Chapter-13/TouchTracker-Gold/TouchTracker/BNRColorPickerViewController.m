//
//  BNRColorPickerViewController.m
//  TouchTracker
//
//  Created by Xue Yu on 5/7/18.
//  Copyright © 2018 XueYu. All rights reserved.
//

// use this here
// https://stackoverflow.com/a/32523136/3608824
#import "BNRColorPickerViewController.h"


@interface BNRColorPickerViewController ()

@property (nonatomic, strong) NSArray *colors;
@property (weak, nonatomic) IBOutlet UIView *selectedColorView;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end


@implementation BNRColorPickerViewController

- (NSArray *)colors
{
    if (!_colors) {
        _colors = @[@0x000000, @0xfe0000, @0xff7900, @0xffb900, @0xffde00, @0xfcff00,@0xd2ff00, @0x05c000, @0x00c0a7, @0x0600ff, @0x6700bf, @0x9500c0, @0xbf0199, @0xffffff ];
    }
    return _colors;
}

- (IBAction)sliderChanged:(id)sender
{
    int index = (int) self.slider.value;
    int rgbValue = (int)self.colors[index];
    self.selectedColorView.backgroundColor = [self UIColorFromHex:rgbValue];
}

- (UIColor *) UIColorFromHex:(int)rgbValue
{
    CGFloat red =  (CGFloat)((rgbValue & 0xFF0000) >> 16) / 0xFF;
    CGFloat green = (CGFloat)((rgbValue & 0x00FF00) >> 8) / 0xFF;
    CGFloat blue =  (CGFloat)(rgbValue & 0x0000FF) / 0xFF;
    CGFloat alpha = (CGFloat)1.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
}

- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)done:(id)sender
{
    NSLog(@"%@", self.selectedColorView.backgroundColor);
    [self.delegate changeLineColor:self.selectedColorView.backgroundColor];
    [self dismissViewControllerAnimated:true completion:nil];
}






@end

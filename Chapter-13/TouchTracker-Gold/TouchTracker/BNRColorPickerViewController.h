//
//  BNRColorPickerViewController.h
//  TouchTracker
//
//  Created by Xue Yu on 5/7/18.
//  Copyright © 2018 XueYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorPickerDelegate <NSObject>
- (void) changeLineColor:(UIColor *)color;
@end


@interface BNRColorPickerViewController : UIViewController

@property (nonatomic, weak) id<ColorPickerDelegate> delegate;

@end



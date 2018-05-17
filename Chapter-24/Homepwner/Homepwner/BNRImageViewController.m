//
//  BNRImageViewController.m
//  Homepwner
//
//  Created by Xue Yu on 5/13/18.
//  Copyright © 2018 Hi Rahim. All rights reserved.
//

#import "BNRImageViewController.h"

@interface BNRImageViewController ()

@end

@implementation BNRImageViewController

- (void)loadView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.view = imageView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIImageView *imageView = (UIImageView *)self.view;
    imageView.image = self.image;
}

@end

//
//  BNRImageViewController.m
//  Homepwner
//
//  Created by Xue Yu on 5/13/18.
//  Copyright © 2018 Hi Rahim. All rights reserved.
//

#import "BNRImageViewController.h"

@interface BNRImageViewController () <UIScrollViewDelegate>

@property (strong,nonatomic) UIImageView *imageView;

@end

@implementation BNRImageViewController

- (void)loadView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 600, 600)];

    self.imageView = [[UIImageView alloc] initWithImage:self.image];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [scrollView addSubview:self.imageView];
    scrollView.delegate = self;
    
    scrollView.maximumZoomScale = 2.0;
    scrollView.minimumZoomScale = 0.1;
    
    scrollView.contentSize = self.imageView.bounds.size;
    NSLog(@"size of scrollView is %@",NSStringFromCGSize(scrollView.contentSize));
    
    float initZoom = MIN(600.0 / self.imageView.bounds.size.width,
                         600.0 / self.imageView.bounds.size.height);
    NSLog(@"%f", initZoom);
    scrollView.zoomScale = initZoom;
    self.imageView.center = scrollView.center;
      
    
    self.view = scrollView;
}

- (void)viewWillAppear:(BOOL)animated
{

}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    self.imageView.center = scrollView.center;
}
@end

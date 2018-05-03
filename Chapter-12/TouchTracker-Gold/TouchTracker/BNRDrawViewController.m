//
//  ViewController.m
//  TouchTracker
//
//  Created by Xue Yu on 5/2/18.
//  Copyright © 2018 XueYu. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@interface BNRDrawViewController ()

@end

@implementation BNRDrawViewController

- (void)loadView
{
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}


@end

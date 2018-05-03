//
//  BNRCircle.m
//  TouchTracker
//
//  Created by Xue Yu on 5/2/18.
//  Copyright © 2018 XueYu. All rights reserved.
//

#import "BNRCircle.h"

@implementation BNRCircle

- (CGRect) rect
{
    int x = (int)(self.diag1.x < self.diag2.x ? self.diag1.x : self.diag2.x);
    int y = (int)(self.diag1.y < self.diag2.y ? self.diag1.y : self.diag2.y);
    
    int width = (int)(fabs(self.diag1.x - self.diag2.x));
    int height = (int)(fabs(self.diag1.y - self.diag2.y));

    return CGRectMake(x, y, width, height);
}

@end

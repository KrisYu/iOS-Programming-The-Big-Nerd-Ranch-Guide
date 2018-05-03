//
//  BNRLine.m
//  TouchTracker
//
//  Created by Xue Yu on 5/2/18.
//  Copyright © 2018 XueYu. All rights reserved.
//

#import "BNRLine.h"

@implementation BNRLine

- (double) radian
{
    return atan2(self.end.y - self.begin.y, self.end.x - self.begin.x);
}

@end

//
//  BNRDrawLine.m
//  TouchTracker
//
//  Created by Xue Yu on 5/2/18.
//  Copyright © 2018 XueYu. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView()

@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, strong) NSMutableArray *finishedLines;

@end


@implementation BNRDrawView


- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
    }
    
    return self;
}

- (void) strokeLine: (BNRLine *)line
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

- (void) drawRect:(CGRect)rect
{
    for (BNRLine *line in self.finishedLines) {
        if (line.radian >= 0) {
            [[UIColor blackColor] set];
        } else {
            [[UIColor whiteColor] set];
        }
        [self strokeLine:line];
    }
    
    [[UIColor redColor] set];
    for (NSValue *key in self.linesInProgress) {
        [self strokeLine:self.linesInProgress[key]];
    }
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView:self];
        
        BNRLine *line = [[BNRLine alloc] init];
        line.begin = location;
        line.end = location;
        
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        self.linesInProgress[key] = line;
    }

    [self setNeedsDisplay];
}


-(void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *touch in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        BNRLine *line = self.linesInProgress[key];
        
        line.end = [touch locationInView:self];
    }

    [self setNeedsDisplay];
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    

    for (UITouch *touch in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        BNRLine *line = self.linesInProgress[key];
        NSLog(@"%f",line.radian);
        
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
    }

    
    [self setNeedsDisplay];
}

- (void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *touch in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        [self.linesInProgress removeObjectForKey:key];
    }
}

@end

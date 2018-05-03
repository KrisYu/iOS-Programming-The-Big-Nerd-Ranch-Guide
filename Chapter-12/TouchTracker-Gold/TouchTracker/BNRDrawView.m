//
//  BNRDrawLine.m
//  TouchTracker
//
//  Created by Xue Yu on 5/2/18.
//  Copyright © 2018 XueYu. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"
#import "BNRCircle.h"

@interface BNRDrawView()


@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
// no need to use dictionary, since 2 touches draw circle.
@property (nonatomic, strong) BNRCircle *currentCircle;
@property (nonatomic, strong) NSMutableArray *finishedLines;
@property (nonatomic, strong) NSMutableArray *finishedCircles;

@end


@implementation BNRDrawView


- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.finishedCircles = [[NSMutableArray alloc] init];
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

- (void) strokeCircle:(BNRCircle *)circle
{
    UIBezierPath *bp = [UIBezierPath bezierPathWithOvalInRect: circle.rect];
    
    bp.lineWidth = 5;
    bp.lineCapStyle = kCGLineCapRound;
    
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
    
    [[UIColor whiteColor] set];
    for (BNRCircle *circle in self.finishedCircles) {
        [self strokeCircle:circle];
    }
    
    [[UIColor redColor] set];
    for (NSValue *key in self.linesInProgress) {
        [self strokeLine:self.linesInProgress[key]];
    }
    
    if (self.currentCircle) {
        [self strokeCircle:self.currentCircle];
    }

    
    
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSLog(@"%d", touches.count);
    
    if (touches.count != 2) {
        for (UITouch *touch in touches) {
            CGPoint location = [touch locationInView:self];
            
            BNRLine *line = [[BNRLine alloc] init];
            line.begin = location;
            line.end = location;
            
            NSValue *key = [NSValue valueWithNonretainedObject:touch];
            self.linesInProgress[key] = line;
        }
    } else {
        
        NSLog(@"trying to draw circle");
        NSArray *circleTouches =  touches.allObjects;
        UITouch *touch1 = [circleTouches firstObject];
        UITouch *touch2 = [circleTouches lastObject];
        
        CGPoint touch1Loc = [touch1 locationInView:self];
        CGPoint touch2Loc = [touch2 locationInView:self];
        
 
        BNRCircle *circle = [[BNRCircle alloc] init];
        circle.diag1 = touch1Loc;
        circle.diag2 = touch2Loc;
        
//        NSLog(@"%@", circle.diag1);
//        NSLog(@"%@", circle.diag2);
//
//
        self.currentCircle = circle;

    }

    [self setNeedsDisplay];
}


-(void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    if (touches.count != 2 ) {
        for (UITouch *touch in touches) {
            NSValue *key = [NSValue valueWithNonretainedObject:touch];
            BNRLine *line = self.linesInProgress[key];
            
            line.end = [touch locationInView:self];
        }
    } else {
        NSArray *circleTouches =  touches.allObjects;
        UITouch *touch1 = [circleTouches firstObject];
        UITouch *touch2 = [circleTouches lastObject];
        
        CGPoint diag1 = [touch1 locationInView:self];
        CGPoint diag2 = [touch2 locationInView:self];
        
        
        
        self.currentCircle.diag1 = diag1;
        self.currentCircle.diag2 = diag2;

    }


    [self setNeedsDisplay];
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
//    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    if (touches.count != 2 ) {
        for (UITouch *touch in touches) {
            NSValue *key = [NSValue valueWithNonretainedObject:touch];
            BNRLine *line = self.linesInProgress[key];
            
            [self.finishedLines addObject:line];
            [self.linesInProgress removeObjectForKey:key];
        }
    } else {
        
        if (self.currentCircle) {
            [self.finishedCircles addObject:self.currentCircle];
            self.currentCircle = nil;
        }

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
    self.currentCircle = nil;

}

@end

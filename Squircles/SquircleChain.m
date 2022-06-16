//
//  SquircleChain.m
//  Squircles
//
//  Created by Sara Sparks on 6/15/22.
//

#import "SquircleChain.h"
#import "Cocoa/Cocoa.h"
#define RAD_TO_DEG (180.0/M_PI)

@implementation SquircleChain {
    NSMutableArray* segments;
    NSPoint pivot;
    CGFloat angle;
    CGFloat radius;
    bool clockwise;
}

+ (SquircleChain*)chainWithStartingPivot:(NSPoint)pivot radius:(CGFloat)radius {
    SquircleChain* chain = [SquircleChain new];
    chain->segments = [NSMutableArray array];
    chain->pivot = pivot;
    chain->angle = (CGFloat)rand() / RAND_MAX;
    chain->radius = radius;
    chain->clockwise = rand() & 1;
    return chain;
}

- (void)addSegmentOfLength:(CGFloat)length {
    CGFloat endAngle = angle + (clockwise ? -1 : 1) * (length / radius);
    NSBezierPath* segment = [NSBezierPath new];
    [segment appendBezierPathWithArcWithCenter:pivot radius:radius startAngle:angle*RAD_TO_DEG endAngle:endAngle*RAD_TO_DEG clockwise:clockwise];
    [segments addObject:segment];
    angle = endAngle;
}

- (void)turn {
    CGFloat x = pivot.x + cos(angle);
    CGFloat y = pivot.y + sin(angle);
    CGFloat oldRadius = radius;
    radius = 16.0 + 112.0 * ((CGFloat)rand() / RAND_MAX);
    clockwise = !clockwise;
    CGFloat newPivotAngle = angle;
    pivot.x = x + (radius + oldRadius) * cos(newPivotAngle);
    pivot.y = y + (radius + oldRadius) * sin(newPivotAngle);
    angle += M_PI;
    if (angle >= 2*M_PI) angle -= 2*M_PI;
}

- (void)clear {
    [segments removeAllObjects];
}

- (void)drawWithVisiblePivot:(bool)drawPivot {
    CGFloat hue = 0.0;
    for (NSBezierPath* segment in segments) {
        [[NSColor colorWithDeviceHue:hue saturation:1.0 brightness:1.0 alpha:1.0] setStroke];
        [segment stroke];
        hue += 0.05;
        if (hue >= 1.0) hue -= 1.0;
    }
    
    if (drawPivot) {
        if (clockwise)
            [[NSColor redColor] setFill];
        else
            [[NSColor greenColor] setFill];
        
        NSBezierPath* marker = [NSBezierPath new];
        [marker appendBezierPathWithArcWithCenter:pivot radius:4.0 startAngle:0 endAngle:360.0];
        [marker fill];
    }
}

- (NSString*)debugText {
    return [NSString stringWithFormat:@"Pivot: (%.1f, %.1f), R = %.1f, A = %.4f", pivot.x, pivot.y, radius, angle];
}

@end

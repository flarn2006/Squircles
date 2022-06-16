//
//  SquircleChain.m
//  Squircles
//
//  Created by Sara Sparks on 6/15/22.
//

#import "SquircleChain.h"
#import "Cocoa/Cocoa.h"

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
    [segment appendBezierPathWithArcWithCenter:pivot radius:radius startAngle:angle endAngle:endAngle clockwise:clockwise];
    [segments addObject:segment];
    angle = endAngle;
}

- (void)turn {
    CGFloat x = pivot.x + cos(angle);
    CGFloat y = pivot.y + sin(angle);
    radius = 16.0 + 112.0 * ((CGFloat)rand() / RAND_MAX);
    clockwise = !clockwise;
    CGFloat newPivotAngle = angle + (clockwise ? 1 : -1) * M_PI_2;
    pivot.x = x + radius * cos(newPivotAngle);
    pivot.y = y + radius * sin(newPivotAngle);
    angle += M_PI;
    if (angle >= 2*M_PI) angle -= 2*M_PI;
}

- (void)stroke {
    CGFloat hue = 0.0;
    for (NSBezierPath* segment in segments) {
        [[NSColor colorWithDeviceHue:hue saturation:1.0 brightness:1.0 alpha:1.0] setStroke];
        [segment stroke];
        hue += 0.05;
        if (hue >= 1.0) hue -= 1.0;
    }
}

- (NSString*)debugText {
    return [NSString stringWithFormat:@"Pivot: (%.1f, %.1f), R = %.1f, A = %.4f", pivot.x, pivot.y, radius, angle];
}

@end

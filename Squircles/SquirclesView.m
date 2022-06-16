//
//  SquirclesView.m
//  Squircles
//
//  Created by Sara Sparks on 6/15/22.
//

#import "SquirclesView.h"
#import "SquircleChain.h"
#import "Foundation/Foundation.h"

@implementation SquirclesView {
    SquircleChain* chain;
    int segmentsUntilTurn;
}

- (void)turn {
    [chain turn];
    segmentsUntilTurn = rand() & 255;
}

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/60.0];
    }
    
    NSPoint center;
    center.x = frame.origin.x + frame.size.width / 2;
    center.y = frame.origin.y + frame.size.height / 2;
    chain = [SquircleChain chainWithStartingPivot:center radius:50.0];
    [self turn];
    
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
    [chain drawWithVisiblePivot:NO];
}

- (void)animateOneFrame
{
    [chain addSegmentOfLength:8.0];
    if (--segmentsUntilTurn == 0)
        [self turn];
    [self setNeedsDisplay:YES];
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end

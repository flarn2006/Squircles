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
    SquircleChain* otherChain;
    int segmentsUntilTurn;
}

- (void)newChain {
    otherChain = chain;
    
    NSPoint center;
    center.x = [self frame].origin.x + [self frame].size.width / 2;
    center.y = [self frame].origin.y + [self frame].size.height / 2;
    chain = [SquircleChain chainWithStartingPivot:center radius:50.0];
    [self turn];
}

- (void)turn {
    [chain turn];
    segmentsUntilTurn = 3 + rand() % (int)[chain currentRadius]/2;
}

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/60.0];
    }
    chain = nil;
    [self newChain];
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
    if (otherChain != nil)
        [otherChain drawWithVisiblePivot:NO];
    [chain drawWithVisiblePivot:NO];
}

- (void)animateOneFrame
{
    if (!NSPointInRect([chain currentPivot], [self frame]))
        [self newChain];
    [chain addSegmentOfLength:8.0];
    if (--segmentsUntilTurn == 0)
        [self turn];
    
    if (otherChain != nil)
        [otherChain fade];
    
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

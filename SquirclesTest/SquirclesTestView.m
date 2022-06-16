//
//  SquirclesTestView.m
//  SquirclesTest
//
//  Created by Sara Sparks on 6/15/22.
//

#import "SquirclesTestView.h"
#import "SquircleChain.h"

@implementation SquirclesTestView {
    SquircleChain* chain;
}

@synthesize segmentLength;

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSegmentLength:10.0];
    NSPoint center;
    center.x = [self frame].origin.x + [self frame].size.width / 2;
    center.y = [self frame].origin.y + [self frame].size.height / 2;
    chain = [SquircleChain chainWithStartingPivot:center radius:64.0];
}

- (IBAction)addSegment:(id)sender {
    [self willChangeValueForKey:@"debugText"];
    [chain addSegmentOfLength: [self segmentLength]];
    [self didChangeValueForKey:@"debugText"];
    [self setNeedsDisplay:YES];
}

- (IBAction)turn:(id)sender {
    [self willChangeValueForKey:@"debugText"];
    [chain turn];
    [self didChangeValueForKey:@"debugText"];
    [self setNeedsDisplay:YES];
}

- (NSString*)debugText {
    return [chain debugText];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    [chain drawWithVisiblePivot:YES];
}

@end

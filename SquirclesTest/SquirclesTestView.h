//
//  SquirclesTestView.h
//  SquirclesTest
//
//  Created by Sara Sparks on 6/15/22.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface SquirclesTestView : NSView

@property CGFloat segmentLength;

- (void)awakeFromNib;
- (IBAction)addSegment:(id)sender;
- (IBAction)turn:(id)sender;
- (NSString*)debugText;

@end

NS_ASSUME_NONNULL_END

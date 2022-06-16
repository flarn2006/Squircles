//
//  SquircleChain.h
//  Squircles
//
//  Created by Sara Sparks on 6/15/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SquircleChain : NSObject

+ (SquircleChain*)chainWithStartingPivot:(NSPoint)pivot radius:(CGFloat)radius;

- (void)addSegmentOfLength:(CGFloat)length;
- (void)turn;
- (void)stroke;

- (NSString*)debugText;

@end

NS_ASSUME_NONNULL_END

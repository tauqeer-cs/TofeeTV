//
//  NSString+Measurements.h
//  Bidvoorons
//
//  Created by Eric Kuck on 8/29/14.
//  Copyright (c) 2014 Eric Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Measurements)

- (CGSize)sizeWithFont:(UIFont *)font forMaxWidth:(CGFloat)maxWidth;

@end

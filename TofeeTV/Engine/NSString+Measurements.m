//
//  NSString+Measurements.m
//  Bidvoorons
//
//  Created by Eric Kuck on 8/29/14.
//  Copyright (c) 2014 Eric Kuck. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NSString+Measurements.h"

@implementation NSString (Measurements)

- (CGSize)sizeWithFont:(UIFont *)font forMaxWidth:(CGFloat)maxWidth
{
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithString:[self mutableCopy]];
    [textStorage addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [textStorage length])];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(maxWidth, MAXFLOAT)];
    textContainer.lineFragmentPadding = 0;
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    return [layoutManager usedRectForTextContainer:textContainer].size;
}

@end

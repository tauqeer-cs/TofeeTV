//
//  UIColor+HexSupport.m
//  Bidvoorons
//
//  Created by Eric Kuck on 8/28/14.
//  Copyright (c) 2014 Eric Kuck. All rights reserved.
//

#import "UIColor+HexSupport.h"

@implementation UIColor (HexSupport)

+ (UIColor *)colorWithHex:(NSString *)hex
{
    hex = [hex stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if (hex.length == 3) {
        hex = [NSString stringWithFormat:@"0%@0%@0%@",
               [hex substringWithRange:NSMakeRange(0, 1)],
               [hex substringWithRange:NSMakeRange(1, 1)],
               [hex substringWithRange:NSMakeRange(2, 1)]];
    }
    
    if (hex.length == 6) {
        hex = [@"ff" stringByAppendingString:hex];
    }
    
    unsigned int intValue;
    [[NSScanner scannerWithString:hex] scanHexInt:&intValue];//CGFloat alpha = ((intValue >> 24) & 0xFF) / 255.0f;
    CGFloat red = ((intValue >> 16) & 0xFF) / 255.0f;
    CGFloat green = ((intValue >> 8) & 0xFF) / 255.0f;
    CGFloat blue = ((intValue >> 0) & 0xFF) / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

+ (UIColor *)colorWithHex:(NSString *)hex Alpha:(float)alpha
{
    hex = [hex stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if (hex.length == 3) {
        hex = [NSString stringWithFormat:@"0%@0%@0%@",
               [hex substringWithRange:NSMakeRange(0, 1)],
               [hex substringWithRange:NSMakeRange(1, 1)],
               [hex substringWithRange:NSMakeRange(2, 1)]];
    }
    
    if (hex.length == 6) {
        hex = [@"ff" stringByAppendingString:hex];
    }
    
    unsigned int intValue;
    [[NSScanner scannerWithString:hex] scanHexInt:&intValue];//CGFloat alpha = ((intValue >> 24) & 0xFF) / 255.0f;
    CGFloat red = ((intValue >> 16) & 0xFF) / 255.0f;
    CGFloat green = ((intValue >> 8) & 0xFF) / 255.0f;
    CGFloat blue = ((intValue >> 0) & 0xFF) / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end

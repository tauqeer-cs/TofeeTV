//
//  UIColor+HexSupport.h
//  Bidvoorons
//
//  Created by Eric Kuck on 8/28/14.
//  Copyright (c) 2014 Eric Kuck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexSupport)

+ (UIColor *)colorWithHex:(NSString *)hex;
+ (UIColor *)colorWithHex:(NSString *)hex Alpha:(float)alpha;
@end

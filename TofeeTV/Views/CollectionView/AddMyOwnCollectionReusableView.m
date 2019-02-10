//
//  AddMyOwnCollectionReusableView.m
//  GiftList
//
//  Created by Shehzad Bilal on 11/5/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import "AddMyOwnCollectionReusableView.h"
#import "Config.h"

@implementation AddMyOwnCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"Add your own +" attributes:@{
                                                                                                                                   NSFontAttributeName: [UIFont fontWithName:@"Raleway-Bold" size:13.0f],
                                                                                                                                   NSForegroundColorAttributeName: [UIColor colorWithWhite:1.0f alpha:1.0f]
                                                                                                                                   }];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Raleway-SemiBold" size: 15.0f] range:NSMakeRange(13, 1)];
    [self.btnAddOwn setAttributedTitle:attributedString forState:UIControlStateNormal];
    
    [self.btnAddOwn setBackgroundColor:DefaultGreen];
    
    self.btnAddOwn.layer.cornerRadius = 15;
    
    
}

@end

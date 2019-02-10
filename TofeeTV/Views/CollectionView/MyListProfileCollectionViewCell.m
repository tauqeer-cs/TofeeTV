//
//  MyListProfileCollectionViewCell.m
//  GiftList
//
//  Created by Shehzad Bilal on 10/11/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import "MyListProfileCollectionViewCell.h"

@implementation MyListProfileCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
 
    self.lblName.textColor = [UIColor colorWithRed:59.0/255.0 green:59.0/255.0 blue:59.0/255.0 alpha:1.0];
    self.lblName.font = [UIFont fontWithName:FontRegular size:26];
    
    
    
    
}

@end

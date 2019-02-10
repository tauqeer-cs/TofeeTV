//
//  CategoryCollectionViewCell.m
//  GiftList
//
//  Created by Shehzad Bilal on 10/1/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import "CategoryCollectionViewCell.h"
#import "Config.h"

@implementation CategoryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = ShadedLightGray;
    self.lblName.font = [UIFont fontWithName:FontRegular size:15];
    
 
}

@end

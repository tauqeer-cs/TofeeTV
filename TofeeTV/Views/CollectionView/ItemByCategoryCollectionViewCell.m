//
//  ItemByCategoryCollectionViewCell.m
//  GiftList
//
//  Created by Shehzad Bilal on 10/8/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import "ItemByCategoryCollectionViewCell.h"
#import "Config.h"

@implementation ItemByCategoryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = [UIColor whiteColor];
    self.lblItemName.font = [UIFont fontWithName:FontRegular size:15];
    self.lblItemBrand.font = [UIFont fontWithName:FontRegular size:14];
    
    
}

@end

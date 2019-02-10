//
//  BransListingCollectionViewCell.m
//  GiftList
//
//  Created by Shehzad Bilal on 10/1/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import "BransListingCollectionViewCell.h"
#import "Config.h"


@implementation BransListingCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = ShadedLightGray;
    self.lblName.font = [UIFont fontWithName:FontRegular size:15];
    
    
    
}

- (IBAction)hearthButtonTapped:(UIButton *)sender {

    sender.selected = !sender.selected;
    
}
@end

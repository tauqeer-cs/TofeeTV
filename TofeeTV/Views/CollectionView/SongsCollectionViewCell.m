//
//  SongsCollectionViewCell.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 06/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "SongsCollectionViewCell.h"

@implementation SongsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.lblTitle.font = [UIFont fontWithName:FontRegular size:20.0];
    self.lblTitle.textColor = DefaultYellowColor2;
    
}

@end

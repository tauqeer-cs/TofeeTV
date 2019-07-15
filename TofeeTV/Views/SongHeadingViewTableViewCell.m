//
//  SongHeadingViewTableViewCell.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 04/07/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "SongHeadingViewTableViewCell.h"

@implementation SongHeadingViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    if (IS_IPad) {
        self.trailing.constant = 200;
        self.leading.constant = 200;
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  SongHeadingViewTableViewCell.h
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 04/07/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SongHeadingViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leading;

@end

NS_ASSUME_NONNULL_END

//
//  MyListItemImageCollectionViewCell.h
//  GiftList
//
//  Created by Shehzad Bilal on 10/11/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyListItemImageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@property (nonatomic) BOOL noItemCell;
@property (weak, nonatomic) IBOutlet UIImageView *plusCollection;

@end

NS_ASSUME_NONNULL_END

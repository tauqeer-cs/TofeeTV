//
//  ItemByCategoryCollectionViewCell.h
//  GiftList
//
//  Created by Shehzad Bilal on 10/8/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemByCategoryCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) IBOutlet UILabel *lblItemName;

@property (weak, nonatomic) IBOutlet UILabel *lblItemBrand;

@property (weak, nonatomic) IBOutlet UILabel *lblPrice;

@end

NS_ASSUME_NONNULL_END

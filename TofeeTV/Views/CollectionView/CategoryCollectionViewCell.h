//
//  CategoryCollectionViewCell.h
//  GiftList
//
//  Created by Shehzad Bilal on 10/1/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoryCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImage;


@end

NS_ASSUME_NONNULL_END

//
//  BransListingCollectionViewCell.h
//  GiftList
//
//  Created by Shehzad Bilal on 10/1/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BransListingCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgVendor;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;

@property (weak, nonatomic) IBOutlet UIButton *btnLike;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (nonatomic,strong) NSString * imageCalling;
@end

NS_ASSUME_NONNULL_END

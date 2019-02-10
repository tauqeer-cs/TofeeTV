//
//  BrandSearchCollectionReusableView.h
//  GiftList
//
//  Created by Shehzad Bilal on 10/31/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BrandSearchCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *imgBrandImage;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;

@end

NS_ASSUME_NONNULL_END

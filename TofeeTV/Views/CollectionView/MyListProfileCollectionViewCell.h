//
//  MyListProfileCollectionViewCell.h
//  GiftList
//
//  Created by Shehzad Bilal on 10/11/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyListProfileCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *viewProfile;
@end

NS_ASSUME_NONNULL_END

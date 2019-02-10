//
//  MyListSectionHeaderCollectionReusableView.h
//  GiftList
//
//  Created by Shehzad Bilal on 10/11/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyListSectionHeaderCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@end

NS_ASSUME_NONNULL_END

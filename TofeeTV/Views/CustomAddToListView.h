//
//  CustomAddToListView.h
//  GiftList
//
//  Created by Shehzad Bilal on 11/16/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CustomAddToListViewDelegate


-(void)ForFriendsViewTapped;

@end
@interface CustomAddToListView : UIView
@property (weak, nonatomic) IBOutlet UIView *mainContainer;
@property (weak, nonatomic) IBOutlet UILabel *lblSaveTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UIScrollView *itemsSroll;

@property id<CustomAddToListViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *friendsButtonContainer;


@end

NS_ASSUME_NONNULL_END

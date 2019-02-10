//
//  ChaterDetailView.h
//  Rohi Hayot
//
//  Created by Shehzad Bilal on 7/4/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChaterDetailView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;

@property (weak, nonatomic) IBOutlet UIWebView *itemWebView;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewHeight;

@end

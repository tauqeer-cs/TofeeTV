//
//  CustomAddToListView.m
//  GiftList
//
//  Created by Shehzad Bilal on 11/16/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import "CustomAddToListView.h"

@interface CustomAddToListView()

@property (weak, nonatomic) IBOutlet UILabel *lblFriendLabel;

@property (weak, nonatomic) IBOutlet UILabel *lblMyListLabel;
@end
@implementation CustomAddToListView

-(void)awakeFromNib
{
    
    [super awakeFromNib];
    
    self.mainContainer.layer.cornerRadius = 20;
    [self.lblSaveTitle setFont:[UIFont fontWithName:FontRegular size:26.0]];
    [self.lblSaveTitle setTextColor:[UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1.0]];
    
    [self.lblFriendLabel setTextColor:DefaultRed];
    [self.lblFriendLabel setFont:[UIFont fontWithName:FontRegular size:21.0]];
    
    
    self.lblMyListLabel.font = self.lblSaveTitle.font;
    self.lblMyListLabel.textColor = self.lblSaveTitle.textColor;
    
    self.lblFriendLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer  * videoGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelFriendsTapped)];
    
    self.lblFriendLabel.userInteractionEnabled = YES;
    [self.lblFriendLabel addGestureRecognizer:videoGesture];
    
    
}

-(void)labelFriendsTapped
{
    
    if (self.delegate) {
        
        [self.delegate ForFriendsViewTapped];
        
    }
 
    NSLog(@"Friend Label Tapped");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

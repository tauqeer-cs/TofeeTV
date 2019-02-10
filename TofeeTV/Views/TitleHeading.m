//
//  TitleHeading.m
//  Rohi Hayot
//
//  Created by Shehzad Bilal on 6/27/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import "TitleHeading.h"

@implementation TitleHeading

-(void)awakeFromNib
{
    [super awakeFromNib];
    if (IS_IPHONE_5)
    {
    
        
        
        [self.lblTitle setFont:[UIFont fontWithName:self.lblTitle.font.fontName size:18]];
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

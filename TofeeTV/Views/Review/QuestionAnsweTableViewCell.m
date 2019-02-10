//
//  QuestionAnsweTableViewCell.m
//  #Gospel
//
//  Created by Shehzad Bilal on 22/01/2018.
//  Copyright © 2018 grappetite. All rights reserved.
//

#import "QuestionAnsweTableViewCell.h"

@implementation QuestionAnsweTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.lblQuestion = [self viewWithTag:1];
    
    for (UIView * tmpView in self.contentView.subviews) {
    
        if ([tmpView isKindOfClass:[UILabel class]]) {
           
            
            if (tmpView.tag == 1) {
                
            }
            else {
                
                self.lblAnswer1 = tmpView;
                
            }
        }
    }
    
    
    
    [self makeButtonRound:self.btnEdit];
    [self makeButtonRound:self.btnMainMenu];
    [self makeButtonRound:self.btnNextStory];
    
    
    NSLog(@"");
    
    //lblAnswerBox
}

-(void)makeButtonRound:(UIButton *)button
{
    button.layer.cornerRadius  = 20;
    button.layer.borderColor = [UIColor colorWithRed:0.9725490196 green:0.8980392157 blue:0.0 alpha:1.0].CGColor;
    button.layer.borderWidth = 1.0;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

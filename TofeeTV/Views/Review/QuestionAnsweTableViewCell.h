//
//  QuestionAnsweTableViewCell.h
//  #Gospel
//
//  Created by Shehzad Bilal on 22/01/2018.
//  Copyright © 2018 grappetite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionAnsweTableViewCell : UITableViewCell

@property (weak, nonatomic) UILabel *lblQuestion;


@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@property (weak, nonatomic) IBOutlet UILabel *lblAnswer1;

@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@property (weak, nonatomic) IBOutlet UIButton *btnMainMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnNextStory;
@end

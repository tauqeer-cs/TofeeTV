//
//  SymptomsDetailExplainationTableViewCell.h
//  Zoya
//
//  Created by Shehzad Bilal on 30/08/2017.
//  Copyright © 2017 grappetite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SymptomsDetailExplainationTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *lblExplaination;

-(void)setupView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSpace;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightSpacing;

@end

//
//  TitleViewLogin.h
//  #Gospel
//
//  Created by Shehzad Bilal on 05/01/2018.
//  Copyright © 2018 grappetite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleViewLogin : UIView
@property (weak, nonatomic) IBOutlet UILabel *lblText;

-(void)setupViewWithTitle:(NSString *)title;

@end

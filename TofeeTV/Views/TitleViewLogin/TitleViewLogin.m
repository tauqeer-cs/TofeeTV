//
//  TitleViewLogin.m
//  #Gospel
//
//  Created by Shehzad Bilal on 05/01/2018.
//  Copyright © 2018 grappetite. All rights reserved.
//

#import "TitleViewLogin.h"
#import "Config.h"

@implementation TitleViewLogin

-(void)awakeFromNib{
    
    for (NSString *familyName in [UIFont familyNames]){
        NSLog(@"Family name: %@", familyName);
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"--Font name: %@", fontName);
        }
    }
    
 
    //Maven Pro
    //MavenProBold
    //MavenProMedium
    //MavenProBlack
    ///MavenProRegular
    
   self.lblText.font =  [UIFont fontWithName:@"MavenProMedium" size:23];

    
}
-(void)setupViewWithTitle:(NSString *)title{
    
    
    
    [self.lblText setAttributedText: [[NSAttributedString alloc] initWithString:title
                                                                     attributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleThick),
                                                                                  NSUnderlineColorAttributeName:DefaultRed}]];
    
}

@end

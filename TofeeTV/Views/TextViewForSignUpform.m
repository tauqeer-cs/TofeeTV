//
//  TextViewForSignUpform.m
//  Filmer
//
//  Created by Tauqeer Ahmed on 3/16/16.
//  Copyright © 2016 Plego. All rights reserved.
//

#import "TextViewForSignUpform.h"


@interface TextViewForSignUpform()

@end

@implementation TextViewForSignUpform

-(void)awakeFromNib{
    
    [self.txtTextBox setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
   
}

-(void)setUpViewWithText:(NSString *)placeHolderText{
    
    
    self.lblName.text = placeHolderText;
    
    
}


@end

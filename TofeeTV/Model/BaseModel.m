//
//  BaseModel.m
//  Rohi Hayot
//
//  Created by Shehzad Bilal on 6/28/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+(NSString *)makeURLCompleteFromString:(NSString *)name
{
    
    
    return [NSString stringWithFormat:@"%@%@",baseServiceUrl,name];
}


+(BOOL)isSuccessFullWithDictionary:(id)result
{
    
    
    if([[result allKeys] containsObject:@"status"] )
    {
        
        
        if ([[result objectForKey:@"status"] isEqualToString:@"success"])
        {
            
            
            return true;
            
            
            
        }
        else
        {
            return false;
            
        }
        
        
        
        
    }
    else{
        
        return false;
        
        
    }
    return false;
    
}
@end

//
//  ModelBase.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 17/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "ModelBase.h"

@implementation ModelBase

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
